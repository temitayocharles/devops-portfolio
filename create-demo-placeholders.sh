#!/bin/bash

# Create placeholder GIF files for DevOps container demos
# These are 1x1 pixel transparent GIFs that serve as placeholders

echo "Creating demo placeholder GIFs..."

# Create the base64 encoded 1x1 transparent GIF
TRANSPARENT_GIF="R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"

# Create all demo GIF files
echo "$TRANSPARENT_GIF" | base64 -d > images/demos/demo-01-docker-pull.gif
echo "$TRANSPARENT_GIF" | base64 -d > images/demos/demo-02-container-startup.gif
echo "$TRANSPARENT_GIF" | base64 -d > images/demos/demo-03-tools-showcase.gif
echo "$TRANSPARENT_GIF" | base64 -d > images/demos/demo-04-environment-setup.gif
echo "$TRANSPARENT_GIF" | base64 -d > images/demos/demo-05-full-workflow.gif

echo "Demo GIF placeholders created successfully!"
echo "Files created:"
ls -la images/demos/*.gif
