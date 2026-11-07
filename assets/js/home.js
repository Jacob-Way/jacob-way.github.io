/* Content is rendered by Jekyll; this script only switches views and scopes IDs. */
(() => {
  const grid = document.querySelector('.home-grid');
  if (!grid) return;

  const root = document.documentElement;
  const toggle = grid.querySelector('.compress-toggle');
  const navigation = grid.querySelector('nav[aria-label="Main navigation"]');
  const mounts = [...grid.querySelectorAll('[data-source]')];
  const destinations = new Map(mounts.map(mount => [
    new URL(mount.dataset.source, location.href).pathname, mount.id
  ]));
  const originalLinks = new Map();
  const isStylePreview = new URLSearchParams(location.search).get('style-preview') === '1';

  function prepareContent(mount) {
    const content = mount.querySelector('[data-combined-content]');
    const pageURL = new URL(mount.dataset.source, location.href);
    for (const heading of content.querySelectorAll('h1, h2, h3, h4, h5')) {
      const replacement = document.createElement('h' + (Number(heading.tagName[1]) + 1));
      for (const attribute of heading.attributes) replacement.setAttribute(attribute.name, attribute.value);
      replacement.append(...heading.childNodes);
      heading.replaceWith(replacement);
    }

    const ids = new Map();
    for (const element of content.querySelectorAll('[id]')) {
      const id = element.id;
      element.id = mount.id + '-' + id;
      ids.set(id, element.id);
    }
    for (const link of content.querySelectorAll('a[href]')) {
      const href = link.getAttribute('href');
      const target = href.startsWith('#') && ids.get(href.slice(1));
      link.setAttribute('href', target ? '#' + target : new URL(href, pageURL).href);
    }
    for (const image of content.querySelectorAll('img[src]')) {
      image.setAttribute('src', new URL(image.getAttribute('src'), pageURL).href);
    }
    for (const element of content.querySelectorAll('[aria-labelledby], [aria-describedby], [for]')) {
      for (const attribute of ['aria-labelledby', 'aria-describedby', 'for']) {
        if (!element.hasAttribute(attribute)) continue;
        element.setAttribute(attribute, element.getAttribute(attribute).split(/\s+/)
          .map(id => ids.get(id) || id).join(' '));
      }
    }
  }

  function typesetMath() {
    const math = window.MathJax;
    if (!math?.typesetPromise) return;
    Promise.resolve(math.startup?.promise)
      .then(() => math.typesetPromise(mounts))
      .catch(() => {});
  }

  function setCompressed(value, persist = true) {
    root.dataset.homeView = value ? 'compressed' : 'expanded';
    toggle?.setAttribute('aria-pressed', String(value));
    for (const [link, href] of originalLinks) {
      const url = new URL(href, location.href);
      const destination = destinations.get(url.pathname);
      const fragment = destination + '-' + url.hash.slice(1);
      link.setAttribute('href', value
        ? '#' + (url.hash && document.getElementById(fragment) ? fragment : destination)
        : href);
    }
    if (persist && !isStylePreview) {
      try { localStorage.setItem('homepage-compressed', String(value)); } catch (_) { /* Storage is optional. */ }
    }
    if (value) typesetMath();
  }

  mounts.forEach(prepareContent);
  for (const link of grid.querySelectorAll('a[href]')) {
    if (navigation?.contains(link)) continue;
    const href = link.getAttribute('href');
    const url = new URL(href, location.href);
    if (url.origin === location.origin && destinations.has(url.pathname)) originalLinks.set(link, href);
  }
  setCompressed(root.dataset.homeView !== 'expanded', false);
  if (toggle) toggle.hidden = false;
  toggle?.addEventListener('click', () => setCompressed(root.dataset.homeView !== 'compressed'));
  window.addEventListener('load', () => {
    if (root.dataset.homeView === 'compressed') typesetMath();
  }, {once: true});
})();
