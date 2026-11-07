# frozen_string_literal: true

require "kramdown"
require "kramdown/parser/gfm"

module Kramdown
  module Parser
    # Parse math before Markdown can consume TeX escapes or underscore pairs.
    # The shared parser also covers content passed through Liquid's markdownify.
    class GFMWithMath < GFM
      def initialize(source, options)
        super
        @span_parsers.delete(:inline_math)
        @span_parsers.unshift(:dollar_math, :escaped_math_dollar)
      end

      DOLLAR_MATH = /\$\$((?:\\.|[^\\])+?)\$\$|\$(?!\$)((?:\\.|[^\\$])+?)\$(?!\$)/m

      def parse_dollar_math
        line = @src.current_line_number
        display = !@src[1].nil?
        tex = (@src[1] || @src[2]).strip
        @src.pos += @src.matched_size
        @tree.children << Element.new(:math, tex, nil,
                                     category: display ? :block : :span, location: line)
      end
      define_parser(:dollar_math, DOLLAR_MATH, '\$')

      # Markdown normally removes this escape. Keep literal dollars out of MathJax.
      def parse_escaped_math_dollar
        @src.pos += @src.matched_size
        @tree.children << Element.new(:raw, '<span class="math-ignore">$</span>')
      end
      define_parser(:escaped_math_dollar, /\\\$/, '\\\\')
    end
  end
end
