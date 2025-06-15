#!/bin/bash
mkdir -p exports
for file in devops-portfolio/projects/*.html; do
  name=$(basename "$file" .html)
  wkhtmltopdf "$file" "exports/$name.pdf"
done
echo "✅ Exported all HTML project pages to PDF."
