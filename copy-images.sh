#!/bin/bash

# Script to help copy your images to the correct location
echo "Ultimate DevOps Portfolio - Image Setup"
echo "======================================"

# Create images directory if it doesn't exist
mkdir -p images

echo ""
echo "To add your images to the portfolio:"
echo ""
echo "1. Copy your comparison diagram to:"
echo "   images/devops-comparison.png"
echo ""
echo "2. For the other images, save them as:"
echo "   images/terminal-tools.png      - Terminal/CLI screenshots"
echo "   images/grafana-dashboard.png   - Grafana monitoring dashboard"
echo "   images/code-server.png         - VS Code Server interface"
echo "   images/network-view.png        - Docker network topology"
echo "   images/container-architecture.png - Architecture diagram"
echo "   images/ci-pipeline-example.png - CI/CD pipeline flow"
echo "   images/devops-frustration-vs-solution.png - Before/After comparison"
echo ""
echo "3. You can drag and drop files directly into the images/ folder"
echo ""
echo "Current images directory contents:"
ls -la images/ 2>/dev/null || echo "   (empty - no images yet)"
echo ""
echo "Once you've added images, your portfolio will display them automatically!"
