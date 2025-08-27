#!/bin/bash
set -euo pipefail

root="${1:-.}"

# Walk all HTML files in the repository
find "$root" -type f -name '*.html' | while read -r f; do
  # Extract line numbers and src/href values
  grep -nEo '(src|href)="[^"]+"' "$f" | sed -E 's/^([0-9]+):.*"(.*)".*/\1 \2/' | \
  while read -r ln url; do
    # Skip external links and anchors
    case "$url" in
      http://*|https://*|mailto:*|tel:*|#*) continue;;
    esac

    # Strip any #fragment or ?query and leading ./ 
    u="${url%%\#*}"
    u="${u%%\?*}"
    u="${u#./}"

    # Check if the referenced file exists (absolute or relative to HTML file)
    abs1="$root/$u"
    abs2="$(cd "$(dirname "$f")" && pwd)/$u"

    if [ ! -e "$abs1" ] && [ ! -e "$abs2" ]; then
      # Print HTML path (relative to repo root), line number, and bad URL
      printf "%-34s L%-5s %s\n" "${f#$root/}" "$ln" "$url"
    fi
  done
done | sort -u
