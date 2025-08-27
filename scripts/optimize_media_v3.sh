#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   scripts/optimize_media_v3.sh "$PWD"
#
# What it does:
#   - Converts root-level *.mov -> MP4 (H.264) + WEBM (VP9)
#   - Converts root-level *.gif and images/demos/*.gif -> MP4
#   - Forces even dimensions for codec compliance
#   - Normalizes Unicode spaces and inserts "-" before AM/PM in output basenames
#   - Shows a live progress bar with ETA for each file
#
# Security/operational notes:
#   - No audio in outputs (-an)
#   - Web-ready (faststart), square pixels (setsar=1)
#   - Idempotent: re-running overwrites existing outputs for same base

ROOT="${1:-$PWD}"
OUTDIR="$ROOT/videos/optimized"
mkdir -p "$OUTDIR"

# Ensure dependencies exist
command -v ffmpeg >/dev/null 2>&1 || { echo "ERROR: ffmpeg not found"; exit 1; }
command -v ffprobe >/dev/null 2>&1 || { echo "ERROR: ffprobe not found"; exit 1; }

# Common video filter: scale to <= 1280x720, maintain aspect, square pixels, force even dims
VF_COMMON="scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease,setsar=1,scale=trunc(iw/2)*2:trunc(ih/2)*2"

# Normalize base filename so HTML rewriter agrees (NBSP/NARROW-NBSP -> space, "-AM"/"-PM")
normalize_base() {
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

# Draw a simple progress bar
# Args: current_seconds total_seconds label
draw_bar() {
  local cur=$1 total=$2 label=$3
  local cols=$(tput cols 2>/dev/null || echo 100)
  local barw=$(( cols > 40 ? cols - 40 : 40 ))

  # Avoid division by zero
  if [[ "$total" -le 0 ]]; then total=1; fi
  local pct=$(( cur * 100 / total ))
  (( pct > 100 )) && pct=100
  local filled=$(( pct * barw / 100 ))
  local empty=$(( barw - filled ))
  local remain=$(( total - cur ))
  # rough ETA
  local eta="--:--"
  if (( cur > 0 )); then
    local rate=$(( cur * 100 / (pct == 0 ? 1 : pct) ))  # seconds per 100%
    local left=$(( rate - cur ))
    eta=$(printf "%02d:%02d" $((remain/60)) $((remain%60)))
  fi
  printf "\r[%-*s] %3d%%  %s  ETA %s" "$barw" "$(printf '%*s' "$filled" | tr ' ' '#')" "$pct" "$label" "$eta"
}

# Run ffmpeg with progress parsing to stdout
# Args: input output args...
run_with_progress() {
  local in="$1"; shift
  local out="$1"; shift
  local total_ms
  total_ms=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of default=nw=1:nk=1 "$in" | awk '{printf "%.0f", $1*1000}' 2>/dev/null || echo 0)

  # Start ffmpeg with -progress pipe and parse out_time_ms
  # We suppress normal stats; we display our own bar.
  ffmpeg -y -hide_banner -loglevel error \
    -progress pipe:1 "$@" -i "$in" "$out" 2>/dev/null | \
  awk -v total="$total_ms" -v label="$(basename "$out")" '
    BEGIN { cur=0; lastprint=0; }
    /^out_time_ms=/ {
      split($0,a,"=");
      cur = int(a[2]/1000000); # seconds
      if (total > 0) {
        pct = int((a[2]*100)/total);
        if (pct>100) pct=100;
      } else {
        pct = 0 + cur; # best-effort
      }
      # print minimal to avoid flicker; we print once per 0.2s or pct change
      now = systime();
      if (pct != lastpct || now-lastprint >= 1) {
        # Render bar in shell (we can’t call draw_bar here), so print a single line
        # Format: PROG cur total label
        printf("PROG %d %d %s\n", cur, int(total/1000), label);
        lastprint = now; lastpct = pct;
        fflush(stdout);
      }
    }
    END { printf("DONE %s\n", label); fflush(stdout); }
  ' | while read -r typ a b lbl; do
    if [[ "$typ" == "PROG" ]]; then
      draw_bar "$a" "$b" "$lbl"
    elif [[ "$typ" == "DONE" ]]; then
      draw_bar 1 1 "$lbl"
      printf "\n"
    fi
  done
}

convert_mov() {
  local in="$1"
  local base; base="$(normalize_base "$in")"
  local mp4="$OUTDIR/$base.mp4"
  local webm="$OUTDIR/$base.webm"

  # MP4
  run_with_progress "$in" "$mp4" -vf "$VF_COMMON" -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart -an
  # WEBM
  run_with_progress "$in" "$webm" -vf "$VF_COMMON" -c:v libvpx-vp9 -crf 35 -b:v 0 -row-mt 1 -an
}

convert_gif() {
  local in="$1"
  local base; base="$(normalize_base "$in")"
  local mp4="$OUTDIR/$base.mp4"
  run_with_progress "$in" "$mp4" -vf "$VF_COMMON,fps=30" -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart -an
}

# Ctrl-C handling: finish current file and exit non-zero
trap 'echo; echo "Interrupted."; exit 130' INT TERM

shopt -s nullglob

echo "Scanning media under: $ROOT"
declare -a MOVS GIFS DEMOGIFS
MOVS=( "$ROOT"/*.mov )
GIFS=( "$ROOT"/*.gif )
if [[ -d "$ROOT/images/demos" ]]; then
  # shellcheck disable=SC2207
  DEMOGIFS=( $(find "$ROOT/images/demos" -type f -name '*.gif' -print0 | xargs -0 -I{} echo "{}") )
else
  DEMOGIFS=()
fi

echo "Found MOV: ${#MOVS[@]}  | root GIF: ${#GIFS[@]}  | demo GIF: ${#DEMOGIFS[@]}"
echo

for f in "${MOVS[@]}"; do
  echo ">> MOV: $(basename "$f")"
  convert_mov "$f"
done

for f in "${GIFS[@]}"; do
  echo ">> GIF: $(basename "$f")"
  convert_gif "$f"
done

for f in "${DEMOGIFS[@]}"; do
  echo ">> DEMO GIF: ${f#"$ROOT/"}"
  convert_gif "$f"
done

echo
echo "OK: outputs in $OUTDIR"

