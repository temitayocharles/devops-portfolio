#!/bin/bash

# Create required directories
mkdir -p assets/{images,icons,demos,diagrams,css,js}

# Move images to appropriate directories
mv *.{jpg,jpeg,png,gif,svg} assets/images/ 2>/dev/null || true
mv images/*.svg assets/diagrams/ 2>/dev/null || true
mv demos/* assets/demos/ 2>/dev/null || true
mv icons/* assets/icons/ 2>/dev/null || true

# Create placeholder SVG for missing profile image
cat > assets/icons/profile-placeholder.svg << EOL
<svg width="200" height="200" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
  <rect width="200" height="200" fill="#66d9ef"/>
  <text x="100" y="100" font-family="Arial" font-size="60" fill="#fff" text-anchor="middle" dominant-baseline="middle">TC</text>
</svg>
EOL

# Create default banner if missing
convert -size 1920x1080 xc:black -fill "#66d9ef" -pointsize 72 -gravity center -draw "text 0,0 'DevOps Portfolio'" assets/images/banner.jpg 2>/dev/null || true

# Create .gitkeep files to preserve empty directories
touch assets/{images,icons,demos,diagrams,css,js}/.gitkeep

echo "Asset directories reorganized successfully!"
