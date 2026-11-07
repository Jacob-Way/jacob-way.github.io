# Jacob Way's website

A small Jekyll site: Markdown content, shared HTML layouts, and one stylesheet. No JavaScript build or Node installation is needed.

## Where to edit

| Content | File or folder |
| --- | --- |
| Home page research text | `_pages/about.md` |
| Home page awards, teaching, and conferences | `_data/home.yml` |
| Publications page | `_pages/publications.md` |
| Presentations page (Talks and Posters) | `_pages/presentations.md` |
| Articles page headings and Lecture Notes | `_includes/content/articles.md` |
| DC Articles and Other Articles | `_articles/` |
| CV content | `_includes/content/cv.md` |
| Teaching and blog pages | `_pages/teaching.md`, `_pages/blog.md` |
| Papers | `_publications/` |
| Author names and links | `_data/authors.yml` |
| Talk and poster entries | `_presentations/` |
| Navigation links and their order | `_data/navigation.yml` |
| Name, contact details, optional photo | `_data/profile.yml` |
| Site settings and publication categories | `_config.yml` |
| Appearance | `assets/css/site.css` |
| PDFs and other downloads | `files/` |

## Add a page

Create a Markdown file in `_pages/`. The shared layout is automatic; only a title and URL are needed:

```markdown
---
title: "Notes"
permalink: /notes/
---

Write your page here using normal Markdown.
```

To add it to the navigation, add an entry under `main:` in `_data/navigation.yml`:

```yaml
  - title: "Notes"
    url: /notes/
```

Removing a navigation entry hides the link while preserving the page's URL.

Home navigation includes Publications, Presentations, Articles, and CV. Blog, Portfolio, and Teaching remain accessible by URL without navigation links.

The home page opens in compressed view by default. The **compress** toggle beside the home-page name combines Publications and Presentations in the left column, Articles in the right column, and the CV below the home content. Those four navigation tabs are hidden while compressed; inline links jump to the combined sections. Press compress again to restore the usual layout. The choice is remembered in the visitor's browser. On narrow screens the columns stack. The combined sections are rendered during the Jekyll build and arrive in the initial HTML, so the layout does not wait for JavaScript or extra page requests. A small script in the page head reads the saved view before the first paint. Publications and Presentations reuse their existing includes; Articles and the CV each have one shared Markdown source in `_includes/content/`, used by both the home view and their standalone pages.

Five visual alternatives are available at `/style-samples/`: Typeset Paper (PDF-like), Oxford Ink, Swiss Grid, Soft Sage, and Midnight. The comparison page lets you switch styles and preview any main page, including both home layouts. The site uses the Paper layout with Source Sans 3 for text and headings, and normal capitalization for the name. The comparison controls show the original style samples and preserve the saved compression preference. Edit the shared themes in `assets/css/themes.css` and the comparison interface in `_pages/style-samples.html`.

Home-page awards, teaching, and conference details are Markdown fields in `_data/home.yml`. Indent each line by two spaces after the `|`. Empty fields leave the section heading available without showing sample claims. Teaching details also appear on `/teaching/`; add longer course material in `_pages/teaching.md`.

The main pages use `/publications/`, `/presentations/`, and `/articles/`. The old `/research/` address redirects to Publications, `/talks/` redirects to Presentations, and `/works/` redirects to Articles. DC Articles and Other Articles are listed automatically from `_articles/`; edit Lecture Notes in `_includes/content/articles.md`. Each `<!-- section -->` starts a new white panel. Any new Markdown page can use the same panel format by adding `sections: true` to its metadata.

## Write mathematics

All Markdown pages, posts, publications, presentations, articles, and fields rendered with `markdownify` support LaTeX math automatically. No per-page setting is needed:

```markdown
An inline bound is $T(n) = O(n \log n)$.

$$
\Pr[X \ge t] \le \frac{\mathbb{E}[X]}{t}.
$$
```

Use `$...$` for inline math and `$$...$$` for display equations. Code spans and fenced code blocks stay literal. Use `\$` for a literal dollar sign. MathJax loads from its CDN when a page opens.

The parser in `_plugins/math.rb` protects TeX commands from Markdown formatting. Restart an existing Jekyll server once after installing this update. Run `bundle exec ruby _tests/math.rb` to check the Markdown conversion; the deployment workflow runs it before building.

## Add a paper

Create `_publications/my-paper.md`:

```markdown
---
title: "My Paper"
date: 2026-11-06
category: manuscripts
authors:
  - jacob-way
paperurl: /files/my-paper.pdf
excerpt: "A short description of the result."
---

Optional longer description or abstract.
```

Upload the PDF to `files/`. The paper automatically appears on Publications with its full date and download link. Its default detail URL is `/publication/my-paper/`; add `permalink:` to preserve or choose another URL. An empty body uses the excerpt on the detail page.

The Publications page groups papers by year, with authors before each title. Each paper's detail page has linked authors above its PDF-linked title, resource buttons, an Abstract panel, and an optional Publication panel. The CV keeps the category grouping from `publication_category` in `_config.yml`.

Use `venue: "Under submission"` or `venue: "Unpublished manuscript"` when appropriate. Other optional fields include `venueurl`, `status`, `publisherurl`, `arxivurl`, `doi`, `slidesurl`, `bibtexurl`, and `video_url`. Add `abstract: |` for a separate Markdown abstract and `publication_details: |` for Markdown publication information, or use `citation` for an existing HTML citation. Empty panels and missing resource buttons are hidden. Use `#` for YAML comments.

## Author names and links

Edit `_data/authors.yml` to add an author or change a link everywhere:

```yaml
jacob-way:
  name: Jacob Way
  url: /
```

Each paper's `authors:` is a YAML list of these keys in the paper's author order. Leave an author's `url` empty to show their name without a link. A name or key missing from the directory is shown as plain text. These changes reload immediately; no server restart is needed.

The Near-Singularly Optimal APSP entry has its author list from the PDF. The other two entries have editable empty lists because their PDFs omit or anonymize the authors; fill these in when ready.

Set `published: false` to keep an unfinished entry out of the site. The two `energy-efficient-*.md` files are retained as drafts because their current metadata duplicates the APSP entry; replace that metadata before publishing them.

## Add a presentation

Create `_presentations/my-talk.md`:

```markdown
---
title: "My Talk"
date: 2026-11-06
type: Talk
venue: "University of Houston"
location: "Houston, TX"
slidesurl: /files/my-talk.pdf
---

Optional description.
```

Talks and posters share `_presentations/` and appear in separate sections at `/presentations/`. Use `type: Talk` or `type: Poster`; a missing type defaults to Talk. Both section headings remain visible when empty. The latest three presentations are previewed on the home page, and all presentations appear on the CV. The default detail URL is `/presentations/my-talk/`. The existing talk's old URL redirects to its new address.

For a poster, create `_presentations/my-poster.md`:

```markdown
---
title: "My Poster"
type: Poster
date: 2026-11-06
permalink: /presentations/my-poster/
venue: "Research Day"
posterurl: /files/my-poster.pdf
---

Optional description or abstract.
```

Add the poster PDF to `files/`. Its download link appears on the presentation page and next to its entry in the list.

## Add an article

Create `_articles/my-article.md`:

```markdown
---
title: "My Article"
category: dc
date: 2026-11-06
---

Write the article here using Markdown and LaTeX math.
```

Use `category: dc` for DC Articles or `category: other` for Other Articles. Each file appears automatically in the matching section, sorted newest first by its front-matter `date` (the article's creation date), and has a detail page at `/articles/my-article/`. Set `date: YYYY-MM-DD` explicitly; backdating it changes the article's position in both home and standalone lists. A `permalink:` field can override the address. Use `published: false` to hide an unfinished article. Titles, categories, and dates belong in the front matter; no layout or collection setting is needed.

Lecture Notes are editable in `_includes/content/articles.md`. Restart an existing Jekyll server once after this collection change; subsequent article and presentation edits rebuild automatically.

## Optional photo

Add your photo to `images/` and set `avatar` in `_data/profile.yml` to its filename, such as `portrait.jpg`. Leave it blank to show the home page without a photo. Profile changes reload automatically.

## Add a blog post

Create the `_posts/` folder if needed, then add a file named `YYYY-MM-DD-my-post.md`:

```markdown
---
title: "My Post"
---

Write the post in Markdown. Its date comes from the filename.
```

The post appears automatically at `/year-archive/`. Uncomment Blog in `_data/navigation.yml` to show the navigation link. Future-dated posts stay hidden until their date.

## Preview and publish

With Ruby and Bundler installed, run:

```sh
bundle install
bundle exec jekyll serve --livereload
```

Open <http://localhost:4000/>. Content and stylesheet changes rebuild automatically. Restart the server after changing `_config.yml`.

To check a production build:

```sh
bundle exec jekyll build
```

Commit and push changes to `master` to publish through the GitHub Pages workflow. In repository settings, Pages should use **GitHub Actions** as its source. The previous `/research/` URL redirects to `/publications/`.
