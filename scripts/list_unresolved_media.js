const fs = require('fs'); const path = require('path'); const glob = require('glob');
const cheerio = require('cheerio');
const ROOT = process.cwd(); const OPT = path.join(ROOT,'videos','optimized');

function normBase(p){
  return path.basename(p).replace(/\.[^.]+$/,'')
    .normalize('NFKD').replace(/[^\w\s.-]/g,'')
    .replace(/\s+/g,'-');
}
function exists(base,ext){ return fs.existsSync(path.join(OPT, `${base}.${ext}`)); }

const files = glob.sync('**/*.html',{cwd:ROOT,nodir:true,ignore:['node_modules/**']});
const rows = [];
for(const rel of files){
  const abs = path.join(ROOT,rel);
  const $ = cheerio.load(fs.readFileSync(abs,'utf8'));
  const refs = [];
  $('source[src], img[src]').each((_,el)=>{
    const src = ($(el).attr('src')||'').trim();
    if(/\.(mov|mp4|webm|gif)$/i.test(src)) refs.push(src);
  });
  for(const r of refs){
    const base = normBase(r);
    rows.push({
      html: rel,
      ref: r,
      normalized_base: base,
      has_mp4: exists(base,'mp4'),
      has_webm: exists(base,'webm')
    });
  }
}
rows.forEach(r=>{
  if(/\.(mov|mp4|webm)$/i.test(r.ref)){
    if(!r.has_mp4 && !r.has_webm){
      console.log(`[MISSING-OPT] ${r.html} -> ${r.ref}  (expected: videos/optimized/${r.normalized_base}.{mp4,webm})`);
    }
  }
  if(/\.gif$/i.test(r.ref)){
    if(!r.has_mp4){ // we only produce mp4 for gifs
      console.log(`[GIF-UNOPT] ${r.html} -> ${r.ref}  (expected: videos/optimized/${r.normalized_base}.mp4)`);
    }
  }
});

