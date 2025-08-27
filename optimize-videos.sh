#!/usr/bin/env bash
# v4.2 — resilient media optimizer with progress + per-file logs.
# Fixes: option ordering (-i before output opts), keeps progress bar, never aborts,
# logs stderr per-file, handles odd dimensions & Unicode filenames.

set -uo pipefail

ROOT="${1:-$PWD}"
OUTDIR="$ROOT/videos/optimized"
LOGDIR="$OUTDIR/logs"
mkdir -p "$OUTDIR" "$LOGDIR"

command -v ffmpeg >/dev/null 2>&1 || { echo "ERROR: ffmpeg not found"; exit 1; }
command -v ffprobe >/dev/null 2>&1 || { echo "ERROR: ffprobe not found"; exit 1; }

# Common scaling: clamp to 1280x720, force even dims, square pixels
VF_COMMON="scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease,setsar=1,scale=trunc(iw/2)*2:trunc(ih/2)*2"

normalize_base() {
  python3 - "$1" <<'PY'
import sys, unicodedata, re, os
name = os.path.basename(sys.argv[1])
stem, _ = os.path.splitext(name)
stem = unicodedata.normalize('NFKD', stem)
stem = re.sub(r'[\u00A0\u202F]', ' ', stem)       # NBSP/NARROW NBSP -> space
stem = re.sub(r'\s*([AP]M)\b', r'-\1', stem)     # " AM" -> "-AM"
stem = re.sub(r'[^\w\s.\-]', '', stem)           # strip unsafe
stem = re.sub(r'\s+', '-', stem).strip('-')      # collapse ws -> hyphens
print(stem)
PY
}

draw_bar() {
  local cur=$1 total=$2 label=$3
  local cols=$(tput cols 2>/dev/null || echo 100)
  local barw=$(( cols > 40 ? cols - 40 : 40 ))
  (( total <= 0 )) && total=1
  local pct=$(( cur * 100 / total )); (( pct > 100 )) && pct=100
  local filled=$(( pct * barw / 100 ))
  local remain=$(( total - cur )); (( remain < 0 )) && remain=0
  local eta=$(printf "%02d:%02d" $((remain/60)) $((remain%60)))
  printf "\r[%-*s] %3d%%  %s  ETA %s" "$barw" "$(printf '%*s' "$filled" | tr ' ' '#')" "$pct" "$label" "$eta"
}

run_with_progress() {
  local in="$1" out="$2"; shift 2
  local log="$LOGDIR/$(basename "$out").log"
  : > "$log"

  # Duration in seconds for progress
  local total_s
  total_s=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$in" 2>>"$log" | awk '{printf "%.0f",$1}')
  total_s=${total_s:-0}

  # IMPORTANT: put -i *before* the output options; keep -progress global
  ffmpeg -nostdin -y -hide_banner -loglevel error \
         -progress pipe:1 \
         -i "$in" \
         "$@" \
         "$out" 2>>"$log" | \
  awk -v total="$total_s" -v label="$(basename "$out")" '
    /^out_time_ms=/ {
      split($0,a,"=");
      cur = int(a[2]/1000000);
      printf("PROG %d %d %s\n", cur, total, label); fflush(stdout);
    }
    END { print "DONE " label; fflush(stdout); }
  ' | while read -r typ a b lbl; do
        if [[ "$typ" == "PROG" ]]; then draw_bar "$a" "$b" "$lbl"; fi
        if [[ "$typ" == "DONE" ]]; then draw_bar 1 1 "$lbl"; printf "\n"; fi
      done

  local rc=$?
  [[ $rc -ne 0 ]] && echo "----- ffmpeg error ($out) -----" >>"$log"
  return $rc
}

newer_or_missing() {
  local in="$1" out="$2"
  [[ ! -s "$out" ]] && return 0
  [[ "$out" -ot "$in" ]] && return 0
  return 1
}

convert_mov() {
  local in="$1"
  local base; base="$(normalize_base "$in")"
  local mp4="$OUTDIR/$base.mp4"
  local webm="$OUTDIR/$base.webm"

  echo ">> MOV: $(basename "$in")"
  if newer_or_missing "$in" "$mp4"; then
    if ! run_with_progress "$in" "$mp4" \
         -vf "$VF_COMMON" \
         -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart \
         -an ; then
      echo "FAIL (mp4): $in  — see $LOGDIR/$(basename "$mp4").log" >&2
    fi
  fi
  if newer_or_missing "$in" "$webm"; then
    if ! run_with_progress "$in" "$webm" \
         -vf "$VF_COMMON" \
         -c:v libvpx-vp9 -crf 35 -b:v 0 -row-mt 1 -deadline good -cpu-used 4 \
         -an ; then
      echo "FAIL (webm): $in — see $LOGDIR/$(basename "$webm").log" >&2
    fi
  fi
}

convert_gif() {
  local in="$1"
  local base; base="$(normalize_base "$in")"
  local mp4="$OUTDIR/$base.mp4"

  echo ">> GIF: ${in#"$ROOT/"}"
  if newer_or_missing "$in" "$mp4"; then
    if ! run_with_progress "$in" "$mp4" \
         -vf "$VF_COMMON,fps=30" \
         -c:v libx264 -crf 28 -preset veryfast -pix_fmt yuv420p -movflags +faststart \
         -an ; then
      echo "FAIL (gif->mp4): $in — see $LOGDIR/$(basename "$mp4").log" >&2
    fi
  fi
}

trap 'echo; echo "Interrupted."; exit 130' INT TERM
shopt -s nullglob

declare -a MOVS GIFS DEMOGIFS
MOVS=( "$ROOT"/*.mov )
GIFS=( "$ROOT"/*.gif )
if [[ -d "$ROOT/images/demos" ]]; then
  while IFS= read -r -d '' f; do DEMOGIFS+=( "$f" ); done < <(find "$ROOT/images/demos" -type f -name '*.gif' -print0)
fi

echo "Scanning media under: $ROOT"
echo "Found MOV: ${#MOVS[@]}  | root GIF: ${#GIFS[@]}  | demo GIF: ${#DEMOGIFS[@]}"
echo

for f in "${MOVS[@]}";     do convert_mov  "$f"; done
for f in "${GIFS[@]}";     do convert_gif  "$f"; done
for f in "${DEMOGIFS[@]}"; do convert_gif  "$f"; done

echo
echo "OK: outputs in $OUTDIR"
echo "If something failed, check logs in: $LOGDIR"
exit 0
