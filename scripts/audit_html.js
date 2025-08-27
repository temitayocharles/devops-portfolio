// scripts/audit_html.js
// Usage: node scripts/audit_html.js > audit-report.json
const fs = require('fs'); const path = require('path'); const glob = require('glob');
const cheerio = require('cheerio');
const ROOT = process.cwd();
function isExternal(u){ return /^(?:[a-z]+:)?\/\//i.test(u) || u.startsWith('mailto:') || u.startsWith('tel:') || u.startsWith('#') || u.startsWith('data:') || u.startsWith('javascript:'); }
const report = [];
const files = glob.sync('**/*.html', { cwd: ROOT, nodir: true, ignore: ['node_modules/**'] });
for (const rel of files) {
  const abs = path.join(ROOT, rel); const html = fs.readFileSync(abs,'utf8');
  const $ = cheerio.load(html);
  const imgs = $('img').toArray(); const anchors = $('a[target="_blank"]').toArray();
  const refs = $('*[src], *[href]').toArray().map(el => $(el).attr('src') || $(el).attr('href') || '').filter(Boolean);
  let missing = 0, checked = 0;
  for (let ref of refs) {
    ref = ref.trim(); if (!ref || isExternal(ref)) continue;
    const refPath = ref.split('#')[0].split('?')[0];
    const candidate = path.resolve(path.dirname(abs), refPath);
    checked++;
    if (!candidate.startsWith(path.resolve(ROOT))) { missing++; continue; }
    if (!fs.existsSync(candidate)) { missing++; }
  }
  let missingNoopener = 0;
  anchors.forEach(a => {
    const relAttr = ($(a).attr('rel') || '').toLowerCase();
    const hasNoopener = relAttr.includes('noopener'); const hasNoreferrer = relAttr.includes('noreferrer');
    if (!(hasNoopener && hasNoreferrer)) missingNoopener++;
  });
  const row = {
    html_path: rel,
    has_meta_description: $('meta[name="description"]').length>0,
    has_viewport: $('meta[name="viewport"]').length>0,
    has_canonical: $('link[rel="canonical"]').length>0,
    has_og_tags: $('meta[property^="og:"]').length>0,
    has_twitter_tags: $('meta[name^="twitter:"]').length>0,
    has_h1: $('h1').length>0,
    img_count: imgs.length,
    imgs_missing_alt: imgs.filter(i => !$(i).attr('alt')).length,
    target_blank_count: anchors.length,
    blank_missing_noopener: missingNoopener,
    local_refs_checked: checked,
    local_refs_missing: missing
  };
  report.push(row);
}
console.log(JSON.stringify(report,null,2));