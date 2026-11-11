# frozen_string_literal: true

require "jekyll"
require "tmpdir"
require "fileutils"
require_relative "../_plugins/unpublished_articles"

Dir.mktmpdir("article-list") do |source|
  FileUtils.mkdir_p(File.join(source, "_articles"))
  FileUtils.mkdir_p(File.join(source, "_includes"))
  FileUtils.cp(File.expand_path("../_includes/articles-list.html", __dir__),
               File.join(source, "_includes/articles-list.html"))
  FileUtils.mkdir_p(File.join(source, "_layouts"))
  FileUtils.mkdir_p(File.join(source, "_includes", "content"))
  FileUtils.cp(File.expand_path("../_layouts/home.html", __dir__),
               File.join(source, "_layouts/home.html"))
  FileUtils.cp(File.expand_path("../_includes/content/articles.md", __dir__),
               File.join(source, "_includes/content/articles.md"))
  FileUtils.cp(File.expand_path("../_includes/sections.html", __dir__),
               File.join(source, "_includes/sections.html"))
  File.write(File.join(source, "_layouts/default.html"), "{{ content }}")
  %w(navigation.html publications-index.html presentations-index.html content/cv.md).each do |include|
    File.write(File.join(source, "_includes", include), "")
  end
  File.write(File.join(source, "index.html"), "---\nlayout: home\n---\n")
  File.write(File.join(source, "listings.html"), <<~LIQUID)
    ---
    ---
    {% include articles-list.html category='results' %}
    <hr>
    {% include articles-list.html category='tutorials' %}
  LIQUID
  {
    "public" => ["Public article", "results", true, "2026-01-01"],
    "draft" => ["Draft <article>", "results", false, "2026-02-01", "soon"],
    "older-draft" => ["Older draft", "results", false, "2026-01-01", "soon"],
    "hidden-draft" => ["Hidden draft", "results", false, "2026-03-01"],
    "in-progress" => ["In-progress draft", "tutorials", false, "2026-03-01", "in-progress"],
  }.each do |name, (title, category, published, date, status)|
    File.write(File.join(source, "_articles", "#{name}.md"), <<~MARKDOWN)
      ---
      title: "#{title}"
      category: #{category}
      published: #{published}
      date: #{date}
      status: #{status}
      ---
      Unpublished body must stay out of the output.
    MARKDOWN
  end

  site = Jekyll::Site.new(Jekyll.configuration(
    "source" => source,
    "destination" => File.join(source, "_site"),
    "collections" => { "articles" => { "output" => true }, "presentations" => {} },
    "quiet" => true,
    "incremental" => true
  ))
  site.process
  html = File.read(File.join(source, "_site", "listings.html"))
  raise "Published article is missing its link" unless html.match?(%r{<a [^>]+>Public article</a>})
  raise "Coming-soon heading missing or repeated for empty category" unless html.scan("<h3>Coming soon</h3>").size == 1
  raise "Draft title is missing or not escaped" unless html.include?("<li>Draft &lt;article&gt;</li>")
  raise "Drafts are not sorted newest first" unless html.index("Draft &lt;article&gt;") < html.index("Older draft")
  raise "Draft pages were published" unless site.collections["articles"].docs.all?(&:published?)
  raise "Draft page exists" if File.exist?(File.join(source, "_site", "articles", "draft.html"))
  raise "Draft body leaked into the listing" if html.include?("Unpublished body")

  home = File.read(File.join(source, "_site", "index.html"))
  sidebar = home[/<aside[^>]+id="home-right".*?<\/aside>/m]
  raise "Home article sidebar is missing" unless sidebar
  raise "Coming soon is missing from home sidebar" unless sidebar.include?("<h3>Coming soon</h3>")
  raise "Draft title is missing from home sidebar" unless sidebar.include?("<li>Draft &lt;article&gt;</li>")
  raise "Draft body leaked into home sidebar" if sidebar.include?("Unpublished body")
  [html, sidebar].each do |listing|
    raise "Draft without status soon is listed" if listing.include?("Hidden draft") || listing.include?("In-progress draft")
  end

  hidden_path = File.join(source, "_articles", "hidden-draft.md")
  File.write(hidden_path, File.read(hidden_path).sub("status: \n", "status: soon\n"))
  site.process
  ["index.html", "listings.html"].each do |page|
    updated = File.read(File.join(source, "_site", page))
    raise "Status change did not refresh #{page}" unless updated.include?("<li>Hidden draft</li>")
  end

  puts "PASS: published links, coming-soon filtering, home sidebar, and status changes during incremental rebuilds"
end
