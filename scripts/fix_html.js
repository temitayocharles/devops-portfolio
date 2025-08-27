// scripts/fix_html.js
// Usage: SITE_URL="https://example.com" node scripts/fix_html.js
const fs = require('fs'); const path = require('path'); const glob = require('glob');
const cheerio = require('cheerio'); const { minify } = require('html-minifier-terser');
const ROOT = process.cwd(); const SITE = (process.env.SITE_URL || 'https://example.com').replace(/\/+$/,'');
(async () => {
  const files = glob.sync('**/*.html', { cwd: ROOT, nodir: true, ignore: ['node_modules/**'] });
  for (const rel of files) {
    const abs = path.join(ROOT, rel);
    let html = fs.readFileSync(abs, 'utf8');
    const $ = cheerio.load(html);
    if ($('head').length === 0) $('html').prepend('<head></head>');
    if ($('meta[name="viewport"]').length === 0) $('head').prepend('<meta name="viewport" content="width=device-width, initial-scale=1.0">');
    let title = $('title').first().text().trim();
    if (!title) { title = path.basename(rel).replace(/[-_]/g,' ').replace(/\.html$/i,''); $('head').prepend(`<title>${title}</title>`); }
    if ($('meta[name="description"]').length === 0) {
      $('head').append(`<meta name="description" content="${title} — page details pending curation.">`);
    }
    if ($('link[rel="canonical"]').length === 0) {
      const canonical = new URL(rel, SITE).toString(); $('head').append(`<link rel="canonical" href="${canonical}">`);
    }
    const hasOG = $('meta[property^="og:"]').length > 0;
    if (!hasOG) {
      const canonical = $('link[rel="canonical"]').attr('href');
      const desc = $('meta[name="description"]').attr('content') || title;
      $('head').append([
        `<meta property="og:type" content="website">`,
        `<meta property="og:title" content="${title}">`,
        `<meta property="og:description" content="${desc}">`,
        `<meta property="og:url" content="${canonical}">`
      ].join('\n'));
    }
    if ($('meta[name^="twitter:"]').length === 0) {
      $('head').append([
        `<meta name="twitter:card" content="summary_large_image">`,
        `<meta name="twitter:title" content="${title}">`
      ].join('\n'));
    }
    $('a[target="_blank"]').each((_, a) => {
      const el = $(a); const relAttr = (el.attr('rel') || '').toLowerCase();
      if (!relAttr.includes('noopener')) el.attr('rel', (relAttr ? relAttr + ' ' : '') + 'noopener');
      if (!relAttr.includes('noreferrer')) el.attr('rel', (el.attr('rel') + ' noreferrer').trim());
    });
    $('img').each((_, img) => {
      const el = $(img);
      if (!el.attr('loading')) el.attr('loading', 'lazy');
      if (!el.attr('decoding')) el.attr('decoding', 'async');
    });
    const out = await minify($.html(), { collapseWhitespace:true, removeComments:true, minifyCSS:true, minifyJS:false });
    fs.writeFileSync(abs, out);
    console.log('Updated:', rel);
  }
})();