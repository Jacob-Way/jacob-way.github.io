# frozen_string_literal: true

require_relative "../_plugins/math"

def render_math(source)
  Kramdown::Document.new(source, input: "GFMWithMath", math_engine: "mathjax",
                                hard_wrap: false).to_html
end

def check(name)
  raise "FAIL: #{name}" unless yield
  puts "PASS: #{name}"
end

check("inline subscripts survive Markdown") do
  html = render_math('$a_i + b_j$')
  html.include?('\(a_i + b_j\)') && !html.include?("<em>")
end

check("TeX braces, commands, and comparisons survive Markdown") do
  html = render_math('$S = \{v_i \in V : i < n\}$')
  html.include?('\(S = \{v_i \in V : i &lt; n\}\)')
end

check("display math uses display delimiters") do
  html = render_math("$$\nx_i + y_j = 0\n$$\n")
  html.include?('\[x_i + y_j = 0\]') && !html.include?("<em>")
end

check("double dollars inside a paragraph still display") do
  render_math('Before $$x_i + y_j$$ after.').include?('\[x_i + y_j\]')
end

check("matrix alignment and row breaks survive") do
  html = render_math(<<~'MARKDOWN')
    $$
    \begin{pmatrix} a & b \\ c & d \end{pmatrix}
    $$
  MARKDOWN
  html.include?('\begin{pmatrix}') && html.include?("&amp;") && html.include?(92.chr * 2)
end

check("math works inside Markdown lists") do
  html = render_math('- $a_i + b_j$')
  html.include?("<ul>") && html.include?('\(a_i + b_j\)')
end

check("inline code remains literal") do
  html = render_math('`$a_i + b_j$`')
  html.include?('<code>$a_i + b_j$</code>') && !html.include?('\(')
end

check("fenced code remains literal") do
  html = render_math("```\n$a_i + b_j$\n$$z$$\n```\n")
  html.include?("<pre>") && html.include?('$a_i + b_j$') && !html.include?('\(')
end

check("escaped dollars remain literal") do
  html = render_math('Costs \$5 and \$10.')
  html.scan('<span class="math-ignore">$</span>').size == 2 && !html.include?('\(')
end
