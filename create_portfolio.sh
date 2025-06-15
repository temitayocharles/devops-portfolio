#!/bin/bash

# Define project root
ROOT="devops-portfolio"

# Create folder structure
mkdir -p $ROOT/projects
mkdir -p $ROOT/assets/{diagrams,screenshots,icons}
mkdir -p $ROOT/styles
mkdir -p $ROOT/.github/workflows

# Ensure animated tech logos are in place (check local paths before use)
declare -A logos=(
  [aws]=./a4043a67-135a-4ca8-a13b-b6f623d0a673.png
  [k8s]=./96367cb4-d438-4fd6-a511-527530f8136a.png
  [docker]=./docker-logo.png
  [terraform]=./terraform-logo.png
  [github]=./github-actions-logo.png
  [argocd]=./argocd-logo.png
)
for key in "${!logos[@]}"; do
  [[ -f "${logos[$key]}" ]] && cp "${logos[$key]}" "$ROOT/assets/icons/${key}-logo.png"
done

# Create CNAME
cat > $ROOT/CNAME <<EOF
www.meetcharlie.live
EOF

# Create export-to-pdf script
cat > $ROOT/export-to-pdf.sh <<'EOF'
#!/bin/bash
mkdir -p exports
for file in devops-portfolio/projects/*.html; do
  name=$(basename "$file" .html)
  wkhtmltopdf "$file" "exports/$name.pdf"
done
echo "✅ Exported all HTML project pages to PDF."
EOF
chmod +x $ROOT/export-to-pdf.sh

# Full polished style.css
cat > $ROOT/styles/style.css <<'EOF'
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: #0f172a;
  color: #e2e8f0;
  margin: 0;
  padding: 0;
}
main {
  max-width: 900px;
  margin: 60px auto;
  background: #1e293b;
  padding: 40px;
  border-radius: 14px;
  box-shadow: 0 0 40px rgba(0,0,0,0.5);
  animation: fadeIn 1.2s ease-in;
  position: relative;
}
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
header img.profile-pic {
  width: 120px;
  border-radius: 10px;
  box-shadow: 0 0 20px rgba(0,0,0,0.6);
  transition: transform 0.4s;
}
header img.profile-pic:hover {
  transform: scale(1.05);
}
a {
  color: #7dd3fc;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
  color: #bae6fd;
}
section h2 {
  border-bottom: 1px solid #475569;
  padding-bottom: 0.3em;
  margin-top: 2em;
}
.logo-strip {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  margin-top: 40px;
  justify-content: flex-start;
}
.logo-strip img {
  height: 40px;
  animation: bounceIn 1s ease-in-out;
  transition: transform 0.3s;
}
.logo-strip img:hover {
  transform: scale(1.1);
}
.footer {
  margin-top: 40px;
  padding-top: 20px;
  border-top: 1px solid #334155;
  text-align: center;
  font-size: 0.9em;
  color: #64748b;
}
.contact {
  margin-top: 30px;
  text-align: center;
}
.contact a {
  margin: 0 10px;
  display: inline-block;
}
.contact img {
  height: 26px;
  vertical-align: middle;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
@keyframes bounceIn {
  from { opacity: 0; transform: scale(0.5); }
  to { opacity: 1; transform: scale(1); }
}
EOF

# Inject style and footer into each project page
for htmlfile in $ROOT/projects/*.html; do
  sed -i '' -e '/<\/head>/i\
<link rel="stylesheet" href="../styles/style.css">' "$htmlfile"
  sed -i '' -e '/<\/body>/i\
<div class="logo-strip">\
  <img src="../assets/icons/aws-logo.png" alt="AWS">\
  <img src="../assets/icons/k8s-logo.png" alt="Kubernetes">\
  <img src="../assets/icons/docker-logo.png" alt="Docker">\
  <img src="../assets/icons/terraform-logo.png" alt="Terraform">\
  <img src="../assets/icons/github-logo.png" alt="GitHub Actions">\
  <img src="../assets/icons/argocd-logo.png" alt="ArgoCD">\
</div>\
<div class="footer">\
  &copy; 2025 Charles | Built with GitHub Pages & Markdown\
</div>' "$htmlfile"
done

# Add domain setup instructions
cat > $ROOT/README-DOMAIN-SETUP.md <<'EOF'
# Connect www.meetcharlie.live to GitHub Pages

1. **CNAME File** – done ✅
2. **DNS Setup (Namecheap)**
   - `www` -> `temitayocharles.github.io` (CNAME)
   - Optional `@` -> `https://www.meetcharlie.live` (301 redirect)
3. **GitHub Pages**
   - Source: `main`, root
   - Domain: `www.meetcharlie.live`
   - Enforce HTTPS ✓
4. **Propagation**
   - Wait up to 30 minutes
   - Visit: https://www.meetcharlie.live
EOF

echo "✅ Portfolio fully polished: logos, footer, styling, contact prep. All subpages uniform."
