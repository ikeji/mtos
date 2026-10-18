#!/bin/bash
# test_dist.sh — run the headless Chromium smoke test (test_browser.mjs)
# against the static site in build/dist/ instead of the repository root,
# i.e. the exact files GitHub Pages serves: kernels come from kernels/,
# nothing from ../kernel/build/. Builds dist if missing. Not part of
# `make -C web test` (deploy-pages runs it as a gate); SKIPs without playwright.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
DIST="$WEB/build/dist"
[ -s "$DIST/index.html" ] || "$WEB/tools/pages.sh" dist || exit 1
PW="${PLAYWRIGHT_DIR:-$(ls -d "$ROOT"/node_modules/playwright "$HOME"/.npm/_npx/*/node_modules/playwright 2>/dev/null | head -1)}"
[ -n "$PW" ] && [ -f "$PW/package.json" ] || { echo "test_dist: SKIP (playwright not found; npx playwright install chromium)"; exit 0; }
# test_browser.mjs opens <base>/web/, so serve a directory whose only entry is web -> dist
SITE="$WEB/build/dist_site"; rm -rf "$SITE"; mkdir -p "$SITE"; ln -s "$DIST" "$SITE/web"
PORT="${PORT:-$((20000 + RANDOM % 10000))}"
python3 -m http.server "$PORT" --bind 127.0.0.1 -d "$SITE" >/dev/null 2>&1 &
srv=$!
trap 'kill $srv 2>/dev/null; rm -rf "$SITE"' EXIT
for i in $(seq 50); do curl -sf "http://127.0.0.1:$PORT/web/" >/dev/null && break; sleep 0.1; done
CONSOLE=0; [ -s "$DIST/kernels/tn20k_kernel_console_vram.bin" ] && CONSOLE=1
node "$WEB/tests/test_browser.mjs" "$PW" "http://127.0.0.1:$PORT" "$CONSOLE" | sed 's/^test_browser:/test_dist:/'
exit "${PIPESTATUS[0]}"
