#!/bin/bash

# =============================================================================
# Portfolio Thumbnail Generator
# Converts architectural diagrams to optimized thumbnails for better UX
# =============================================================================

echo "🎨 Generating optimized project thumbnails..."

# Create output directory
mkdir -p images/thumbnails/optimized

# Convert SVG thumbnails to properly sized PNGs for faster loading
# Ultimate DevOps Container - Most important project
convert images/thumbnails/ultimate-devops-container.svg -resize 400x300 -background white -alpha remove images/thumbnails/optimized/ultimate-devops-container.png

# Enterprise CI/CD Pipeline  
convert images/thumbnails/enterprise-cicd.svg -resize 400x300 -background white -alpha remove images/thumbnails/optimized/enterprise-cicd.png

# AWS Infrastructure
convert images/thumbnails/aws-infrastructure.svg -resize 400x300 -background white -alpha remove images/thumbnails/optimized/aws-infrastructure.png

# Kubernetes VPN
convert images/thumbnails/kubernetes-vpn.svg -resize 400x300 -background white -alpha remove images/thumbnails/optimized/kubernetes-vpn.png

# Monitoring Stack
convert images/thumbnails/monitoring-stack.svg -resize 400x300 -background white -alpha remove images/thumbnails/optimized/monitoring-stack.png

echo "✅ Thumbnails generated in images/thumbnails/optimized/"

# Create WebP versions for modern browsers
echo "🚀 Creating WebP versions for better performance..."

for png_file in images/thumbnails/optimized/*.png; do
    webp_file="${png_file%.png}.webp"
    cwebp -q 85 "$png_file" -o "$webp_file"
done

echo "✅ WebP thumbnails created for modern browsers"

# Generate Virtual Vacation Platform thumbnail (missing but needed)
echo "🌐 Creating Virtual Vacation Platform thumbnail..."
convert -size 400x300 xc:white \
    -fill "#764ba2" -draw "rectangle 0,0 400,100" \
    -fill white -pointsize 24 -gravity center -annotate +0-50 "Virtual Vacation" \
    -fill "#667eea" -pointsize 16 -annotate +0-20 "Cloud-Native Tourism" \
    -fill "#67ffcc" -pointsize 14 -annotate +0+10 "React • Node.js • Kubernetes" \
    -fill "#a6e22e" -draw "circle 50,250 70,250" \
    -fill "#66d9ef" -draw "circle 150,250 170,250" \
    -fill "#764ba2" -draw "circle 250,250 270,250" \
    -fill "#67ffcc" -draw "circle 350,250 370,250" \
    images/thumbnails/optimized/virtual-vacation-platform.png

cwebp -q 85 images/thumbnails/optimized/virtual-vacation-platform.png -o images/thumbnails/optimized/virtual-vacation-platform.webp

echo "🎉 All thumbnails generated successfully!"
echo "📁 Location: images/thumbnails/optimized/"
echo "📊 Formats: PNG (fallback) + WebP (modern browsers)"
