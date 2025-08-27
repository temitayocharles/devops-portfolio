const fs = require('fs');
const path = require('path');
const glob = require('glob');
const cheerio = require('cheerio');

const ROOT = process.cwd();
const OPT = path.join(ROOT, 'videos', 'optimized');

const list = (ext) => glob.sync(path.join(OPT, `*.${ext}`)).map(p => path.basename(p));
const mp4s = new Set(list('mp4'));
const webms = new Set(list('webm'));

// Use a "known good" default base if we need a fallback mapping.
const fallbackBase = (() => {
  // Prefer the earliest Screen-Recording* found
  const cand = Array.from(mp4s).find(s => /^Screen-Recording-/.test(s));
  return cand ? cand.replace(/\.mp4$/,'') : null;
})();

const normBase = (name) => {
  // strip dir + ext, normalize unicode, keep word/space/.-, squash spaces to '-'
  let base = path.basename(name).replace(/\.[^.]+$/,'');
  base = base.normalize('NFKD')
             .replace(/[^\w\s.\-]/g, '')
             .replace(/\s+/g, '-')
             .replace(/-?([AP]M)$/,'-$1')
             .replace(/--+/g,'-')
             .replace(/^-|-$/g,'');
  return base;
};
const exists = (p) => fs.existsSync(path.join(ROOT, p));
const optHas = (b, ext) => (ext === 'mp4' ? mp4s.has(`${b}.mp4`) : webms.has(`${b}.webm`));
const optUrl = (b, ext) => `videos/optimized/${b}.${ext}`;

const htmlFiles = glob.sync('{*.html,images/demos/*.html}', { dot:false });

let changed = 0;

for (const f of htmlFiles) {
  const raw = fs.readFileSync(f, 'utf8');
  const $ = cheerio.load(raw, { decodeEntities: false });
  let mutated = false;

  // Utility to test if a local url exists (repo-root or relative to file)
  const urlExists = (u) => {
    if (!u) return false;
    if (/^(https?:|mailto:|tel:|#)/i.test(u)) return true; // treat external as "ok"
    const clean = u.split('#')[0].split('?')[0].replace(/^\.\//, '');
    if (exists(clean)) return true;
    const rel = path.resolve(path.dirname(f), clean);
    return fs.existsSync(rel);
  };

  // Try to rewrite a missing media url to an optimized one
  const rewriteMedia = ($el, attr) => {
    const val = $el.attr(attr);
    if (!val || /^(https?:|mailto:|tel:|#)/i.test(val)) return false;

    // Already exists? nothing to do
    if (urlExists(val)) return false;

    const base = normBase(val);
    // Special mapping for old placeholders like "container-startup.*"
    const placeholderBases = new Set(['container-startup', 'demo-01-docker-pull','demo-02-container-startup','demo-03-tools-showcase','demo-04-environment-setup','demo-05-full-workflow','extra-demo-1','extra-demo-2']);
    let targetBase = base;
    if (placeholderBases.has(base) && fallbackBase) {
      targetBase = fallbackBase;
    }

    // Decide extension preference
    const tag = $el[0].tagName.toLowerCase();
    const typeAttr = ($el.attr('type') || '').toLowerCase();
    const wantWebm = typeAttr.includes('webm');
    const wantMp4  = typeAttr.includes('mp4') || (!wantWebm);

    // Try webm/mp4 that actually exist
    if (wantWebm && optHas(targetBase, 'webm')) {
      $el.attr(attr, optUrl(targetBase, 'webm'));
      return true;
    }
    if (wantMp4 && optHas(targetBase, 'mp4')) {
      $el.attr(attr, optUrl(targetBase, 'mp4'));
      return true;
    }
    // Fallback: mp4 if webm missing
    if (optHas(targetBase, 'mp4')) {
      $el.attr(attr, optUrl(targetBase, 'mp4'));
      return true;
    }
    // Last resort: try original normalized name in repo (maybe user placed file later)
    const candidates = [
      `videos/optimized/${base}.mp4`,
      `videos/optimized/${base}.webm`,
      base + '.mp4',
      base + '.webm'
    ];
    for (const c of candidates) {
      if (urlExists(c)) { $el.attr(attr, c); return true; }
    }

    // Could not fix. If it's a <source>, drop it; if it's an <a>, disable; if <img>, remove.
    if (tag === 'source') {
      $el.remove();
      return true;
    } else if (tag === 'a') {
      $el.attr('href', '#').attr('data-missing', 'true').attr('rel','nofollow noopener');
      return true;
    } else if (tag === 'img') {
      $el.remove();
      return true;
    }
    return false;
  };

  // Pass 1: fix all src/href that are missing
  $('[src], [href]').each((_, el) => {
    const $el = $(el);
    const fixedSrc  = $el.attr('src')  && !urlExists($el.attr('src'))  && rewriteMedia($el, 'src');
    const fixedHref = $el.attr('href') && !urlExists($el.attr('href')) && rewriteMedia($el, 'href');
    if (fixedSrc || fixedHref) mutated = true;
  });

  // Pass 2: for each <video>, ensure both optimized sources are present if on disk
  $('video').each((_, v) => {
    const $v = $(v);
    const srcs = $v.find('source');
    // infer a base from any present optimized source
    let base = null;
    srcs.each((i, s) => {
      const p = ($(s).attr('src') || '').split('#')[0].split('?')[0];
      const b = normBase(p);
      if (mp4s.has(`${b}.mp4`) || webms.has(`${b}.webm`)) { base = b; return false; }
    });
    if (!base && fallbackBase) base = fallbackBase;
    if (!base) return;

    const hasMp4Node  = srcs.toArray().some(s => /video\/mp4/i.test($(s).attr('type')||''));
    const hasWebmNode = srcs.toArray().some(s => /video\/webm/i.test($(s).attr('type')||''));

    if (webms.has(`${base}.webm`) && !hasWebmNode) {
      $v.prepend(`<source src="videos/optimized/${base}.webm" type="video/webm">`);
      mutated = true;
    }
    if (mp4s.has(`${base}.mp4`) && !hasMp4Node) {
      $v.append(`<source src="videos/optimized/${base}.mp4" type="video/mp4">`);
      mutated = true;
    }
  });

  if (mutated) {
    fs.writeFileSync(f, $.html());
    console.log('Fixed:', f);
    changed++;
  }
}

console.log(`Done. Files changed: ${changed}`);
