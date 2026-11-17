/* Open external web links in a new tab across all rendered content. */
(() => {
  for (const link of document.querySelectorAll('a[href]')) {
    if ((link.protocol === 'https:' || link.protocol === 'http:') &&
        link.origin !== location.origin) {
      link.target = '_blank';
      link.relList.add('noopener', 'noreferrer');
    }
  }
})();
