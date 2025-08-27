// Rewrite HTML media refs to videos/optimized/* where optimized files exist.
// Usage: node scripts/rewrite_media_refs.js
const fs = require('fs');
const path = require('path');
const glob = require('glob');
const cheerio = require('cheerio');

const ROOT = process.cwd();
const OPT_DIR = path.join(ROOT, 'videos', 'optimized');

function normalizeBase(name) {
  // Normalize like the optimizer: replace spaces with dashes, transliterate punctuation lightly
  return name
    .replace(/\.[^.]+$/,'')
    .normalize('NFKD').replace(/[^\w\s.-]/g,'')
    .replace(/\s+/g,'-');
}

function optimizedExists(base) {
  const mp4 = path.join(OPT_DIR, `${base}.mp4`);
  const webm = path.join(OPT_DIR, `${base}.webm`);
  return { mp4: fs.existsSync(mp4), webm: fs.existsSync(webm) };
}

function toOptimizedSrc(base, ext) {
  return `videos/optimized/${base}.${ext}`;
}

const htmlFiles = glob.sync('**/*.html', { cwd: ROOT, nodir: true, ignore: ['node_modules/**'] });
let changes = 0;

for (const rel of htmlFiles) {
  const abs = path.join(ROOT, rel);
  const html = fs.readFileSync(abs, 'utf8');
  const $ = cheerio.load(html, { decodeEntities: false });

  let fileChanged = false;

  // 1) <source src="...">
  $('source[src]').each((_, el) => {
    const $el = $(el);
    const src = ($el.attr('src') || '').trim();
    if (!src) return;
    if (!/\.(mov|mp4|webm)$/i.test(src)) return;

    const filename = path.basename(src);
    const base = normalizeBase(filename);
    const have = optimizedExists(base);

    // If optimized exists, point to it based on type
    if (/\.mov$/i.test(src) || /\.mp4$/i.test(src)) {
      if (have.mp4) {
        $el.attr('src', toOptimizedSrc(base, 'mp4'));
        $el.attr('type', 'video/mp4');
        fileChanged = true;
      }
    }
    if (/\.mov$/i.test(src) || /\.webm$/i.test(src)) {
      if ($el.attr('type') === 'video/webm' || /\.webm$/i.test(src)) {
        if (have.webm) {
          $el.attr('src', toOptimizedSrc(base, 'webm'));
          $el.attr('type', 'video/webm');
          fileChanged = true;
        }
      }
    }
  });

  // 2) <video> blocks lacking webm/mp4 pairs — add webm if available
  $('video').each((_, v) => {
    const $v = $(v);
    const sources = $v.find('source');
    // Derive a base from any existing source
    let pickedBase = null;
    sources.each((__, s) => {
      const src = $(s).attr('src') || '';
      const filename = path.basename(src);
      if (/\.(mp4|mov|webm)$/i.test(filename)) {
        pickedBase = normalizeBase(filename);
        return false;
      }
    });
    if (pickedBase) {
      const have = optimizedExists(pickedBase);
      // Ensure we have both types if present on disk
      if (have.webm && !sources.filter((__, s) => /video\/webm/i.test($(s).attr('type')||'')).length) {
        $v.prepend(`<source src="${toOptimizedSrc(pickedBase,'webm')}" type="video/webm">`);
        fileChanged = true;
      }
      if (have.mp4 && !sources.filter((__, s) => /video\/mp4/i.test($(s).attr('type')||'')).length) {
        $v.append(`<source src="${toOptimizedSrc(pickedBase,'mp4')}" type="video/mp4">`);
        fileChanged = true;
      }
    }
  });

  if (fileChanged) {
    fs.writeFileSync(abs, $.html());
    console.log('Rewrote refs:', rel);
    changes++;
  }
}

console.log(`Done. Files changed: ${changes}`);

