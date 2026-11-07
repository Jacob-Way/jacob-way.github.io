(() => {
  const cards = [...document.querySelectorAll('.style-card')];
  const frame = document.getElementById('site-preview');
  const themeSelect = document.getElementById('theme-select');
  const pageSelect = document.getElementById('page-select');
  const status = document.querySelector('.preview-status');
  const expand = document.getElementById('expand-preview');
  const descriptions = {
    paper: ['01 / Typeset Paper', 'A white sheet on a gray desk, with serif typography, fine rules, and continuous paper surfaces. The closest to reading a typeset PDF.'],
    oxford: ['02 / Oxford Ink', 'An editorial academic style: warm ivory, burgundy links, substantial serif headings, and a larger, more relaxed reading scale.'],
    swiss: ['03 / Swiss Grid', 'A crisp modern style with Inter, cobalt accents, strong horizontal rules, and bold headings. Clear hierarchy with very little ornament.'],
    sage: ['04 / Soft Sage', 'A quieter, welcoming style: DM Sans, green accents, rounded cards, soft shadows, and comfortable line spacing.'],
    midnight: ['05 / Midnight', 'A dark technical style: deep slate surfaces, mint links, IBM Plex Sans text, and compact monospace headings and labels.']
  };
  const params = new URLSearchParams(location.search);
  let theme = Object.prototype.hasOwnProperty.call(descriptions, params.get('theme')) ? params.get('theme') : 'paper';
  if ([...pageSelect.options].some(option => option.value === params.get('view'))) pageSelect.value = params.get('view');

  function updateAddress() {
    const url = new URL(location.href);
    url.searchParams.set('theme', theme);
    url.searchParams.set('view', pageSelect.value);
    history.replaceState(null, '', url);
  }

  function applyTheme() {
    const doc = frame.contentDocument;
    if (!doc?.body || !doc.querySelector('.site')) return;
    doc.documentElement.dataset.siteStyle = theme;
    doc.documentElement.removeAttribute('data-site-font');
    let sheet = doc.getElementById('style-preview-fonts');
    if (!sheet) {
      sheet = doc.createElement('link');
      sheet.id = 'style-preview-fonts';
      sheet.rel = 'stylesheet';
      sheet.href = document.body.dataset.previewFonts;
      doc.head.append(sheet);
    }
    frame.title = `${descriptions[theme][0].slice(5)} style preview`;
    status.hidden = true;
  }

  function chooseTheme(value) {
    theme = value;
    themeSelect.value = value;
    cards.forEach(card => card.setAttribute('aria-pressed', String(card.dataset.style === value)));
    document.getElementById('style-name').textContent = descriptions[value][0];
    document.getElementById('style-description').textContent = descriptions[value][1];
    applyTheme();
    updateAddress();
  }

  function loadPage() {
    status.hidden = false;
    status.textContent = 'Loading the sample…';
    const url = new URL(pageSelect.selectedOptions[0].dataset.url, location.href);
    url.searchParams.set('style-preview', '1');
    url.searchParams.set('compressed', String(pageSelect.value === 'combined'));
    frame.src = url.href;
    updateAddress();
  }

  cards.forEach(card => card.addEventListener('click', () => chooseTheme(card.dataset.style)));
  themeSelect.addEventListener('change', () => chooseTheme(themeSelect.value));
  pageSelect.addEventListener('change', loadPage);
  expand.addEventListener('click', () => {
    const focused = document.body.classList.toggle('preview-focused');
    expand.setAttribute('aria-pressed', String(focused));
    expand.textContent = focused ? 'Show comparison' : 'Expand preview';
    window.scrollTo({top: 0});
  });
  frame.addEventListener('load', applyTheme);
  chooseTheme(theme);
  loadPage();
})();
