#!/bin/bash

# Define the base directory
PROJECTS_DIR="./devops-portfolio/projects"
STYLE="../styles/style.css"

# Header & footer HTML fragments
read -r -d '' HTML_HEAD <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Charles DevOps Portfolio</title>
  <link rel="stylesheet" href="$STYLE" />
</head>
<body>
<nav>
  <a href="../index.html">Home</a>
  <a href="../contact.html">Contact</a>
</nav>
<main>
EOF

read -r -d '' HTML_FOOT <<EOF
</main>
<footer>
  <div class="tech-strip">
    <img class="logo" src="../assets/logos/aws.svg" alt="AWS" />
    <img class="logo" src="../assets/logos/k8s.svg" alt="Kubernetes" />
    <img class="logo" src="../assets/logos/docker.svg" alt="Docker" />
    <img class="logo" src="../assets/logos/terraform.svg" alt="Terraform" />
    <img class="logo" src="../assets/logos/github-actions.svg" alt="GitHub Actions" />
    <img class="logo" src="../assets/logos/argocd.svg" alt="ArgoCD" />
  </div>
  <p>&copy; 2025 Charles | Built with GitHub Pages & Markdown</p>
</footer>
</body>
</html>
EOF

# Loop through all .md files in the projects directory
for md_file in "$PROJECTS_DIR"/*.md; do
  [ -f "$md_file" ] || continue

  base_name=$(basename "$md_file" .md)
  html_file="$PROJECTS_DIR/$base_name.html"

  echo "Converting $base_name.md → $base_name.html"

  {
    echo "$HTML_HEAD"
    pandoc "$md_file"
    echo "$HTML_FOOT"
  } > "$html_file"
done

echo "✅ Markdown-to-HTML conversion complete. All pages styled and animated."
