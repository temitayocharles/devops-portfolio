#!/bin/bash

# =============================================================================
# Video Optimization Script for DevOps Container Demos
# Converts .mov files to web-optimized MP4 and WebM formats
# =============================================================================

echo "🎬 Optimizing screen recording videos for web..."

# Create output directory
mkdir -p videos/optimized

# Convert each screen recording to web-optimized formats
echo "📹 Converting Screen Recording videos..."

# Video 1: Container Startup
ffmpeg -i "Screen Recording 2025-07-31 at 3.49.59 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/container-startup.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 3.49.59 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/container-startup.webm

# Video 2: VS Code Integration  
ffmpeg -i "Screen Recording 2025-07-31 at 3.54.47 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/vscode-integration.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 3.54.47 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/vscode-integration.webm

# Video 3: Monitoring Stack
ffmpeg -i "Screen Recording 2025-07-31 at 3.55.03 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/monitoring-stack.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 3.55.03 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/monitoring-stack.webm

# Video 4: Security & Vault
ffmpeg -i "Screen Recording 2025-07-31 at 3.56.08 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/security-vault.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 3.56.08 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/security-vault.webm

# Video 5: Multi-Cloud Tools
ffmpeg -i "Screen Recording 2025-07-31 at 4.00.38 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/multicloud-tools.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 4.00.38 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/multicloud-tools.webm

# Video 6: Complete Workflow
ffmpeg -i "Screen Recording 2025-07-31 at 4.06.04 AM.mov" \
    -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k \
    -movflags +faststart videos/optimized/complete-workflow.mp4

ffmpeg -i "Screen Recording 2025-07-31 at 4.06.04 AM.mov" \
    -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus \
    videos/optimized/complete-workflow.webm

echo "✅ Video optimization complete!"
echo "📁 Optimized videos saved to: videos/optimized/"
echo "📊 Formats: MP4 (universal) + WebM (modern browsers)"

# Generate video thumbnails
echo "🖼️ Generating video thumbnails..."
mkdir -p videos/thumbnails

ffmpeg -i videos/optimized/container-startup.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/container-startup.jpg
ffmpeg -i videos/optimized/vscode-integration.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/vscode-integration.jpg
ffmpeg -i videos/optimized/monitoring-stack.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/monitoring-stack.jpg
ffmpeg -i videos/optimized/security-vault.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/security-vault.jpg
ffmpeg -i videos/optimized/multicloud-tools.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/multicloud-tools.jpg
ffmpeg -i videos/optimized/complete-workflow.mp4 -ss 00:00:05 -vframes 1 videos/thumbnails/complete-workflow.jpg

echo "🎉 Video thumbnails generated!"
