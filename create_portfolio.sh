#!/bin/bash

# Create directory structure
mkdir -p devops-portfolio/projects
mkdir -p devops-portfolio/assets/diagrams
mkdir -p devops-portfolio/assets/screenshots
mkdir -p devops-portfolio/styles
mkdir -p devops-portfolio/.github/workflows

# CNAME for custom domain
cat > devops-portfolio/CNAME <<EOF
www.meetcharlie.live
EOF

# Export to PDF script
cat > devops-portfolio/export-to-pdf.sh <<EOF
#!/bin/bash
mkdir -p exports
for file in devops-portfolio/projects/*.html; do
  name=\$(basename "\$file" .html)
  wkhtmltopdf "\$file" "exports/\$name.pdf"
done
echo "✅ Exported all HTML project pages to PDF."
EOF

chmod +x devops-portfolio/export-to-pdf.sh

# Enhanced styling with animations
cat > devops-portfolio/styles/style.css <<EOF
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: #0f172a;
  color: #e2e8f0;
  padding: 40px;
  transition: background 0.5s ease;
}
main {
  max-width: 850px;
  margin: auto;
  background: #1e293b;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 0 30px rgba(0,0,0,0.4);
  animation: fadeIn 1.2s ease-in;
}
header h1 {
  font-size: 2em;
  color: #38bdf8;
  margin-bottom: 0.5em;
}
section h2 {
  border-bottom: 1px solid #475569;
  padding-bottom: 0.3em;
  margin-top: 2em;
}
a {
  color: #7dd3fc;
  text-decoration: none;
  transition: color 0.3s ease;
}
a:hover {
  text-decoration: underline;
  color: #bae6fd;
}
li {
  padding: 6px 0;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
EOF

# Keep the rest of your existing content untouched...
# (Paste the rest of your script here, starting from README.md creation and so on)

echo "✅ Portfolio upgraded with animations, PDF export, and custom domain setup."
