---
title: Blog
permalink: /year-archive/
redirect_from:
  - /blog/
  - /wordpress/blog-posts/
---

{% for post in site.posts %}
<article class="research-item">
  <h2><a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h2>
  <p class="item-meta"><time datetime="{{ post.date | date: '%Y-%m-%d' }}">{{ post.date | date: '%B %-d, %Y' }}</time></p>
  {{ post.excerpt }}
</article>
{% endfor %}
