# Jacob's website

Personal academic website.

| Component | Location and purpose |
| --- | --- |
| Pages | `_pages/` contains the home page and section pages. |
| Research content | `_publications/`, `_presentations/`, and `_articles/` contain Markdown entries and their metadata. |
| Shared data | `_data/` holds profile details, navigation, authors, and home-page information. |
| Templates | `_layouts/` and `_includes/` render pages, content lists, and shared article and CV content. |
| Appearance and interactions | `assets/css/` contains styles and themes; `assets/js/` handles the home view toggle and style previews. |
| Downloads and images | `files/` holds PDFs and other downloads; `images/` holds site imagery. |
| Markdown extensions | `_plugins/` provides LaTeX math parsing and unpublished article listings. |
| Checks | `_tests/` checks math rendering and unpublished article behavior. |
| Build and deployment | `_config.yml` configures Jekyll, `Gemfile` declares Ruby dependencies, and `.github/workflows/jekyll.yml` builds and deploys to GitHub Pages. |

Content is rendered during the Jekyll build. MathJax displays equations in the browser; no Node or JavaScript build step is required.
