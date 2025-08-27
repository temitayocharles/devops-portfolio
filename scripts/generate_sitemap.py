#!/usr/bin/env python3
# scripts/generate_sitemap.py
import os, sys, time
SITE = os.environ.get("SITE_URL","https://example.com").rstrip("/")
ROOT = sys.argv[1] if len(sys.argv)>1 else "."
urls=[]
for dirpath, _, files in os.walk(ROOT):
    for f in files:
        if f.lower().endswith(".html"):
            rel = os.path.relpath(os.path.join(dirpath,f), ROOT).replace("\\","/")
            urls.append(f"{SITE}/{rel}")
ts = time.strftime("%Y-%m-%d")
print('<?xml version="1.0" encoding="UTF-8"?>')
print('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
for u in sorted(urls):
    print("  <url>")
    print(f"    <loc>{u}</loc>")
    print(f"    <lastmod>{ts}</lastmod>")
    print("    <changefreq>weekly</changefreq>")
    print("  </url>")
print("</urlset>")
