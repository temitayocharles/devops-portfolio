#!/bin/bash

# Screenshot extraction script for DevOps container demos
echo "DevOps Container Screenshot Extraction Utility"
echo "=============================================="

# Create screenshots directory
mkdir -p images/screenshots

echo "📂 Available demo files:"
ls -la images/demos/

echo ""
echo "💡 To extract screenshots from your GIFs:"
echo "   1. Install ffmpeg: brew install ffmpeg"
echo "   2. Run commands like:"
echo "      ffmpeg -i images/demos/demo-01-docker-pull.gif -vf 'select=eq(n\,10)' images/screenshots/docker-pull.png"
echo ""
echo "✅ Gallery setup complete!"
