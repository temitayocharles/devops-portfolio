#!/bin/bash

projects_dir="devops-portfolio/projects"
index_file="devops-portfolio/index.html"

cat > "$index_file" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Charles | DevOps Projects</title>
  <link rel="stylesheet" href="styles/style.css">
</head>
<body>
  <nav>
    <a href="index.html">Home</a>
    <a href="contact.html">Contact</a>
  </nav>
  <main>
    <h1>Project Portfolio</h1>
    <ul>
EOF

for html_file in "$projects_dir"/*.html; do
  name=$(basename "$html_file" .html)
  display_name=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) substr($i,2)}}1')
  echo "      <li><a href=\"projects/$name.html\">$display_name</a></li>" >> "$index_file"
done

cat >> "$index_file" <<EOF
    </ul>
  </main>
</body>
</html>
EOF
