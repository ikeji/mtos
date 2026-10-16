#!/bin/bash
# test_browser.sh — headless Chromium smoke test of the page. Needs the
# playwright package (npx cache or node_modules) and its Chromium; SKIPs
# otherwise. Serves the repository root on a local port for the test.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_browser: SKIP ($KERNEL_BIN missing; make -C kernel tn20k)"; exit 0; }
PW="${PLAYWRIGHT_DIR:-$(ls -d "$ROOT"/node_modules/playwright "$HOME"/.npm/_npx/*/node_modules/playwright 2>/dev/null | head -1)}"
[ -n "$PW" ] && [ -f "$PW/package.json" ] || { echo "test_browser: SKIP (playwright not found; npx playwright install chromium)"; exit 0; }
PORT="${PORT:-$((20000 + RANDOM % 10000))}"
python3 -m http.server "$PORT" --bind 127.0.0.1 -d "$ROOT" >/dev/null 2>&1 &
srv=$!
trap 'kill $srv 2>/dev/null' EXIT
for i in $(seq 50); do curl -sf "http://127.0.0.1:$PORT/web/" >/dev/null && break; sleep 0.1; done
CONSOLE=0; [ -s "$ROOT/kernel/build/tn20k_kernel_console_land.bin" ] && CONSOLE=1
node "$WEB/tests/test_browser.mjs" "$PW" "http://127.0.0.1:$PORT" "$CONSOLE"
