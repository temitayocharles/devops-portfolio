#!/bin/bash
set -euo pipefail

root="${1:-.}"

find "$root" -type f -name '*.html' | while read -r f; do
  grep -nEo '(src|href)="[^"]+"' "$f" | sed -E 's/^([0-9]+):.*"(.*)".*/\1 \2/' |
  while read -r ln url; do
    case "$url" in
      http://*|https://*|mailto:*|tel:*|#*) continue ;;
    esac
    u="${url%%\#*}"; u="${u%%\?*}"; u="${u#./}"

    abs1="$root/$u"
    abs2="$(cd "$(dirname "$f")" && pwd)/$u"

    if [ ! -e "$abs1" ] && [ ! -e "$abs2" ]; then
      printf "%-34s L%-5s %s\n" "${f#$root/}" "$ln" "$url"
    fi
  done
done | sort -u
