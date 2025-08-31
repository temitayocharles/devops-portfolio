#!/bin/bash

# Screenshot extraction script for DevOps container demos
# This script would extract key frames from the GIF demos to create static screenshots

echo "DevOps Container Screenshot Extraction Utility"
echo "=============================================="

# Create screenshots directory
mkdir -p images/screenshots

echo "ℹ️  This script would extract screenshots from your demo GIFs:"
echo ""
echo "📂 Available demo files:"
ls -la images/demos/

echo ""
echo "🎯 Extraction targets:"
echo "   • demo-01-docker-pull.gif → docker-pull-screenshot.png"
echo "   • demo-02-container-startup.gif → startup-services-screenshot.png"
echo "   • demo-03-tools-showcase.gif → tools-demo-screenshot.png"
echo "   • demo-04-environment-setup.gif → terminal-setup-screenshot.png"
echo "   • demo-05-full-workflow.gif → full-workflow-screenshot.png"

echo ""
echo "💡 To actually extract screenshots, you would need to:"
echo "   1. Install ffmpeg: brew install ffmpeg"
echo "   2. Run extraction commands like:"
echo "      ffmpeg -i images/demos/demo-01-docker-pull.gif -vf 'select=eq(n\,0)' -q:v 3 images/screenshots/docker-pull-screenshot.png"
echo ""
echo "🔧 For manual screenshot extraction:"
echo "   • Open the GIFs in a viewer"
echo "   • Capture key moments showing:"
echo "     - Container startup sequences"
echo "     - Tool execution results"
echo "     - Dashboard interfaces"
echo "     - Terminal with running commands"
echo ""
echo "📸 Recommended screenshot moments:"
echo "   • Docker pull completion"
echo "   • VS Code Server loading"
echo "   • Grafana dashboard with metrics"
echo "   • Terminal showing tool versions"
echo "   • Vault UI interface"

# Example commands (commented out since we don't want to run them automatically)
# ffmpeg -i images/demos/demo-01-docker-pull.gif -vf "select=eq(n\,10)" -q:v 3 images/screenshots/docker-pull.png
# ffmpeg -i images/demos/demo-02-container-startup.gif -vf "select=eq(n\,15)" -q:v 3 images/screenshots/startup.png
# ffmpeg -i images/demos/demo-03-tools-showcase.gif -vf "select=eq(n\,20)" -q:v 3 images/screenshots/tools.png
# ffmpeg -i images/demos/demo-04-environment-setup.gif -vf "select=eq(n\,10)" -q:v 3 images/screenshots/terminal.png
# ffmpeg -i images/demos/demo-05-full-workflow.gif -vf "select=eq(n\,30)" -q:v 3 images/screenshots/workflow.png

echo ""
echo "✅ Setup complete! The gallery page is ready to showcase your demos."
echo "🎬 Live demos are now embedded in the gallery at: gallery.html"
echo "🔗 Navigation links added to homepage and projects page"
