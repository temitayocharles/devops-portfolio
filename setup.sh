#!/bin/bash

# Create directory structure
mkdir -p devops-portfolio/projects
mkdir -p devops-portfolio/assets/diagrams
mkdir -p devops-portfolio/assets/screenshots
mkdir -p devops-portfolio/assets/icons
mkdir -p devops-portfolio/styles
mkdir -p devops-portfolio/.github/workflows

# Move animations and logos to assets/icons
cp ./a4043a67-135a-4ca8-a13b-b6f623d0a673.png devops-portfolio/assets/icons/aws-logo.png
cp ./96367cb4-d438-4fd6-a511-527530f8136a.png devops-portfolio/assets/icons/k8s-logo.png

# Create CNAME file for custom domain
cat > devops-portfolio/CNAME <<EOF
www.meetcharlie.live
EOF

# Create script to export HTML to PDF
cat > devops-portfolio/export-to-pdf.sh <<EOF
#!/bin/bash
mkdir -p exports
for file in devops-portfolio/projects/*.html; do
  name=$(basename "$file" .html)
  wkhtmltopdf "$file" "exports/\$name.pdf"
done
echo "✅ Exported all HTML project pages to PDF."
EOF
chmod +x devops-portfolio/export-to-pdf.sh

# Animation styles and project styling
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
.logo-strip {
  display: flex;
  gap: 12px;
  justify-content: flex-start;
  margin-top: 30px;
}
.logo-strip img {
  height: 42px;
  animation: bounceIn 1s ease-in-out;
  transition: transform 0.3s;
}
.logo-strip img:hover {
  transform: scale(1.1);
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

# Footer component for project pages
for htmlfile in devops-portfolio/projects/*.html; do
  sed -i '' -e '/<\/body>/i\
<div class="logo-strip">\
  <img src="../assets/icons/aws-logo.png" alt="AWS">\
  <img src="../assets/icons/k8s-logo.png" alt="Kubernetes">\
</div>' "$htmlfile"
  sed -i '' -e '/<\/head>/i\
<link rel="stylesheet" href="../styles/style.css">' "$htmlfile"
done

# Namecheap DNS Configuration Guide
cat > devops-portfolio/README-DOMAIN-SETUP.md <<EOF
# Connecting meetcharlie.live to GitHub Pages (Namecheap Guide)

## Step 1: Add CNAME to your repo
- Already added in this script: `CNAME` contains `www.meetcharlie.live`

## Step 2: Login to Namecheap
- Visit: https://www.namecheap.com/myaccount/

## Step 3: Go to Domain List
- Click `Manage` beside `meetcharlie.live`

## Step 4: Set Nameservers to "Namecheap Basic DNS"

## Step 5: Add Advanced DNS Records:
- **Type:** CNAME Record
  - **Host:** `www`
  - **Value:** `temitayocharles.github.io`
  - **TTL:** Automatic

- **Optional redirect:**
  - **Type:** URL Redirect Record
  - **Host:** `@`
  - **Value:** `https://www.meetcharlie.live`
  - **Type:** Permanent (301)

## Step 6: GitHub Settings
- Go to your GitHub repo > Settings > Pages
- Ensure the source is `main` and root
- GitHub will detect and publish `https://www.meetcharlie.live`

## DNS Propagation
- Changes can take 15 mins to 24 hrs to fully propagate.
- Test: `ping www.meetcharlie.live` or visit directly in browser.
EOF

echo "✅ Portfolio subpages now styled and animated with logos. PDF + domain support intact."
