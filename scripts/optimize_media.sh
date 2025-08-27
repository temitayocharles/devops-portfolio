#!/usr/bin/env bash
# scripts/optimize_media.sh
set -euo pipefail
ROOT="${1:-$PWD}"
OUT_DIR="$ROOT/videos/optimized"
mkdir -p "$OUT_DIR"
command -v ffmpeg >/dev/null || { echo "ffmpeg not found (brew install ffmpeg)"; exit 1; }
find "$ROOT" -type f \( -iname "*.mov" -o -iname "*.MOV" \) | while read -r mov; do
  base="$(basename "${mov%.*}" | tr ' ' '-' | tr -cd '[:alnum:]-_.')"
  mp4="$OUT_DIR/${base}.mp4"; webm="$OUT_DIR/${base}.webm"
  ffmpeg -y -i "$mov" -vf "scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease" -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart -c:a aac -b:a 128k "$mp4"
  ffmpeg -y -i "$mov" -vf "scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease" -c:v libvpx-vp9 -crf 35 -b:v 0 -c:a libopus "$webm"
  echo "Optimized: $mov -> $mp4 / $webm"
done
find "$ROOT" -type f -iname "*.gif" -size +4M | while read -r gif; do
  base="$(basename "${gif%.*}" | tr ' ' '-' | tr -cd '[:alnum:]-_.')"
  mp4="$OUT_DIR/${base}.mp4"
  ffmpeg -y -i "$gif" -movflags +faststart -pix_fmt yuv420p -c:v libx264 -crf 28 -preset veryfast "$mp4"
  echo "Optimized GIF: $gif -> $mp4"
done
echo "DONE. Update your <video> tags to use files in videos/optimized/."
