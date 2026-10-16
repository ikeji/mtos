#!/bin/bash
# test_pages_live.sh — open the published GitHub Pages site in headless
# Chromium and check it boots, echoes, and the landscape console kernel
# takes keys on the LCD. Needs network + playwright (SKIPs otherwise).
# Not part of `make -C web test`; run after `make -C web deploy-pages`
# (Pages takes ~1 min to publish; PAGES_URL overrides the site).
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
URL="${PAGES_URL:-https://ikeji.github.io/mtos/}"
PW="${PLAYWRIGHT_DIR:-$(ls -d "$ROOT"/node_modules/playwright "$HOME"/.npm/_npx/*/node_modules/playwright 2>/dev/null | head -1)}"
[ -n "$PW" ] && [ -f "$PW/package.json" ] || { echo "test_pages_live: SKIP (playwright not found)"; exit 0; }
mkdir -p "$WEB/build"
if node "$WEB/tests/test_pages_live.mjs" "$PW" "$URL" "$WEB/build/pages_live.png"; then
    echo "test_pages_live: PASS ($URL, screenshot web/build/pages_live.png)"
else
    echo "test_pages_live: FAIL ($URL)"; exit 1
fi
