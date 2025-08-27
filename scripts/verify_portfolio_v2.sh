#!/usr/bin/env bash
# scripts/verify_portfolio_v2.sh
set -euo pipefail
ROOT="${1:-$PWD}"
cd "$ROOT"
echo "== Verify Portfolio (v2) =="
if ! command -v node >/dev/null; then echo "Node.js required"; exit 1; fi
if ! node -e "require('glob');require('cheerio')" 2>/dev/null; then
  npm init -y >/dev/null 2>&1 || true
  npm i glob cheerio html-minifier-terser >/dev/null
fi
node scripts/audit_html.js > audit-report.json
if command -v jq >/dev/null; then
  MISSING_CANONICAL=$(jq '[.[]|select(.has_canonical==false)]|length' audit-report.json)
  MISSING_DESC=$(jq '[.[]|select(.has_meta_description==false)]|length' audit-report.json)
  NOOPENER=$(jq '[.[]|.blank_missing_noopener]|add' audit-report.json)
  BROKEN=$(jq '[.[]|.local_refs_missing]|add' audit-report.json)
  echo "Missing canonical: $MISSING_CANONICAL, missing meta desc: $MISSING_DESC, noopener issues: $NOOPENER, broken refs: $BROKEN"
  if [ "${BROKEN:-0}" -gt 0 ]; then echo "FAIL: broken local references"; exit 2; fi
  if [ "${NOOPENER:-0}" -gt 0 ]; then echo "WARN: add rel=noopener noreferrer"; fi
  if [ "${MISSING_CANONICAL:-0}" -gt 0 ] || [ "${MISSING_DESC:-0}" -gt 0 ]; then echo "WARN: SEO tags incomplete"; fi
else
  echo "Install jq for summary. Raw report at audit-report.json"
fi
echo "OK"
