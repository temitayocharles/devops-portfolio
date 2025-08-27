const fs = require('fs');
const path = require('path');
const glob = require('glob');
const cheerio = require('cheerio');

const ROOT = process.cwd();
const OPT = path.join(ROOT, 'videos', 'optimized');

const norm = (name) => {
  // strip dir, drop ext, normalize unicode, squash spaces to '-'
  let base = path.basename(name).replace(/\.[^.]+$/, '');
  base = base.normalize('NFKD')
             .replace(/[^\w\s.\-]/g, '') // keep word, space, dot, hyphen
             .replace(/\s+/g, '-')
             .replace(/-?([AP]M)$/,'-$1') // ensure "-AM"/"-PM" suffix
             .replace(/--+/g,'-')
             .replace(/^-|-$/g,'');
  return base;
};
const optHas = (b, ext) => fs.existsSync(path.join(OPT, `${b}.${ext}`));
const optUrl = (b, ext) => `videos/optimized/${b}.${ext}`;

const htmlFiles = glob.sync('{*.html,images/demos/*.html}', {dot:false});

let changed = 0;
for (const f of htmlFiles) {
  const html = fs.readFileSync(f, 'utf8');
  const $ = cheerio.load(html, { decodeEntities: false });
  let fileChanged = false;

  // 1) Replace any <source src="... .mov"> with optimized MP4/WEBM if present
  $('source[src$=".mov"], source[src$=".MOV"]').each((_, el) => {
    const $el = $(el);
    const src = $el.attr('src');
    const b = norm(src);
    const hasMp4 = optHas(b, 'mp4');
    const hasWebm = optHas(b, 'webm');
    if (hasMp4 || hasWebm) {
      const $video = $el.closest('video');
      // remove the .mov source
      $el.remove();
      // ensure both optimized sources are in place (webm first is fine)
      const existing = new Set($video.find('source').map((i, s) => $(s).attr('type')).get());
      if (hasWebm && !existing.has('video/webm')) {
        $video.prepend(`<source src="${optUrl(b, 'webm')}" type="video/webm">`);
      }
      if (hasMp4 && !existing.has('video/mp4')) {
        $video.append(`<source src="${optUrl(b, 'mp4')}" type="video/mp4">`);
      }
      fileChanged = true;
    }
  });

  // 2) If a <video> has neither mp4 nor webm but we can infer from its poster or data,
  //    derive a base from any child source and fill missing ones.
  $('video').each((_, v) => {
    const $v = $(v);
    const sources = $v.find('source[src]');
    let base = null;
    sources.each((i, s) => {
      const src = $(s).attr('src') || '';
      if (!src) return;
      const fname = path.basename(src).replace(/\.[^.]+$/, '');
      if (fname) { base = fname; return false; }
    });
    if (!base) return;
    const hasMp4 = sources.toArray().some(s => /video\/mp4/i.test($(s).attr('type')||''));
    const hasWebm = sources.toArray().some(s => /video\/webm/i.test($(s).attr('type')||''));
    const hasMp4Disk = fs.existsSync(path.join(OPT, `${base}.mp4`));
    const hasWebmDisk = fs.existsSync(path.join(OPT, `${base}.webm`));
    if (hasWebmDisk && !hasWebm) {
      $v.prepend(`<source src="videos/optimized/${base}.webm" type="video/webm">`);
      fileChanged = true;
    }
    if (hasMp4Disk && !hasMp4) {
      $v.append(`<source src="videos/optimized/${base}.mp4" type="video/mp4">`);
      fileChanged = true;
    }
  });

  // 3) Tidy: if any <source> points to a local file that doesn't exist, drop it.
  $('source[src]').each((_, el) => {
    const $el = $(el);
    const p = ($el.attr('src')||'').split('#')[0].split('?')[0].replace(/^\.\//,'');
    if (!p || /^https?:\/\//i.test(p)) return;
    if (!fs.existsSync(path.join(ROOT, p))) {
      $el.remove(); fileChanged = true;
    }
  });

  if (fileChanged) {
    fs.writeFileSync(f, $.html());
    console.log('Fixed:', f);
    changed++;
  }
}

console.log(`Done. Files changed: ${changed}`);
