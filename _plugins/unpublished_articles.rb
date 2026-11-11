# frozen_string_literal: true

# Jekyll omits unpublished documents from site.articles. Expose only the metadata
# needed for the coming-soon list, without adding their pages to the output.
Jekyll::Hooks.register :site, :post_read do |site|
  site.data["unpublished_articles"] = []
  collection = site.collections["articles"]
  next unless collection

  collection.filtered_entries.each do |entry|
    path = collection.collection_dir(entry)
    next unless Jekyll::Utils.has_yaml_header?(path)

    article = Jekyll::Document.new(path, site: site, collection: collection)
    article.read
    next unless article.data["published"] == false && article.data["status"] == "soon"

    site.data["unpublished_articles"] << {
      "title" => article.data["title"],
      "category" => article.data["category"],
      "date" => article.date,
    }
  end

  # Incremental builds do not track collection metadata used by Liquid lists.
  # These pages must refresh even when only an unpublished article changes.
  site.pages.each do |page|
    if page.data["layout"] == "home" ||
        page.content.include?("articles-list.html") ||
        page.content.include?("content/articles.md")
      page.data["regenerate"] = true
    end
  end
end
