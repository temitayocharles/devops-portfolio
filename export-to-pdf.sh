#!/bin/bash
mkdir -p exports
for file in devops-portfolio/projects/*.html; do
  name=
  wkhtmltopdf "$file" "exports/$name.pdf"
done
