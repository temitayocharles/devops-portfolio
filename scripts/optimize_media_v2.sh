#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$PWD}"
IN_MOV_GLOB=("$ROOT"/*.mov)
IN_GIF_GLOB=("$ROOT"/*.gif)

OUTDIR="$ROOT/videos/optimized"
mkdir -p "$OUTDIR"

# ffmpeg filters:
# - scale down to <=1280x720 while preserving aspect
# - then force even dimensions so libx264/libvpx are happy
# - ensure square pixels (setsar=1) and faststart for web
vf_common="scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease,setsar=1,scale=trunc(iw/2)*2:trunc(ih/2)*2"

# Build a normalized base name compatible with our HTML rewriter:
# - NFKD unicode normalize
# - convert NBSP (U+00A0) and NARROW NBSP (U+202F) to normal space
# - insert dash before AM/PM tokens
# - strip anything not [\w\s\.\-]
# - collapse spaces to single dash
normalize() {
  python3 - "$1" <<'PY'
import sys, unicodedata, re, os
name = os.path.basename(sys.argv[1])
stem, _ = os.path.splitext(name)

stem = unicodedata.normalize('NFKD', stem)
stem = re.sub(r'[\u00A0\u202F]', ' ', stem)  # NBSP & NARROW NBSP -> space
stem = re.sub(r'\s*([AP]M)\b', r'-\1', stem)  # " AM" -> "-AM"
stem = re.sub(r'[^\w\s.\-]', '', stem)
stem = re.sub(r'\s+', '-', stem).strip('-')
print(stem)
PY
}

convert_mov() {
  local in="$1"
  local base; base="$(normalize "$in")"

  # MP4 (H.264)
  ffmpeg -y -hide_banner -loglevel error \
    -i "$in" \
    -vf "$vf_common" \
    -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart \
    -an \
    "$OUTDIR/$base.mp4"

  # WEBM (VP9)
  ffmpeg -y -hide_banner -loglevel error \
    -i "$in" \
    -vf "$vf_common" \
    -c:v libvpx-vp9 -crf 35 -b:v 0 -row-mt 1 \
    -an \
    "$OUTDIR/$base.webm"
}

convert_gif() {
  local in="$1"
  local base; base="$(normalize "$in")"

  # GIF -> MP4 (no audio). We keep simple pipeline; palette isn't needed here.
  ffmpeg -y -hide_banner -loglevel error \
    -i "$in" \
    -vf "$vf_common,fps=30" \
    -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart \
    -an \
    "$OUTDIR/$base.mp4"
}

shopt -s nullglob

# MOVs at repo root
for f in "${IN_MOV_GLOB[@]}"; do
  convert_mov "$f"
done

# GIFs at repo root
for f in "${IN_GIF_GLOB[@]}"; do
  convert_gif "$f"
done

# Also convert demo GIFs under images/demos (your HTML references them)
while IFS= read -r -d '' f; do
  convert_gif "$f"
done < <(find "$ROOT/images/demos" -type f -name '*.gif' -print0 2>/dev/null || true)

echo "OK: outputs in $OUTDIR"

