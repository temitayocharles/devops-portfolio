#!/bin/bash

PROJECTS_DIR="devops-portfolio/projects"
INDEX_FILE="$PROJECTS_DIR/index.html"

echo "Generating index.html for project pages..."

cat > "$INDEX_FILE" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Charles’ DevOps Portfolio</title>
  <link rel="stylesheet" href="../styles/style.css">
</head>
<body>
<nav>
  <a href="../index.html">Home</a>
  <a href="../contact.html">Contact</a>
</nav>
<main>
  <header>
    <h1>Projects Index</h1>
    <p>Browse all case studies and infrastructure modules below.</p>
  </header>
  <section>
    <ul>
EOF

for file in "$PROJECTS_DIR"/*.html; do
  fname=$(basename "$file")
  [[ "$fname" == "index.html" ]] && continue
  title=$(echo "$fname" | sed -E 's/-/ /g; s/\.html$//; s/\b./\U&/g')
  echo "    <li><a href=\"$fname\">$title</a></li>" >> "$INDEX_FILE"
done

cat >> "$INDEX_FILE" <<EOF
    </ul>
  </section>
</main>
</body>
</html>
EOF

echo "✅ $INDEX_FILE regenerated."

