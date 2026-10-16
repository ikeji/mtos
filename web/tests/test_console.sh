#!/bin/bash
# test_console.sh — the LCD console kernels on the JS emulator: boot each
# tn20k_kernel_console*.bin headless, type `cat /hello.txt` on the matrix
# keyboard (GPIO scan) and check that the LCD, read back through ocr.js,
# shows the file's contents. Covers the lcd_spi path (portrait with
# hardware scroll, landscape with the desktop chrome), the vram_lcd
# refresh engine and the text_lcd character engine. SKIPs a variant whose
# bin is not built (make -C kernel tn20k-console{,-land,-vram,-text}).
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
OUT="$WEB/build"; mkdir -p "$OUT"
fails=0; ran=0
for v in console console_land console_vram console_text; do
    bin="$ROOT/kernel/build/tn20k_kernel_$v.bin"
    if [ ! -s "$bin" ]; then echo "[test] $v: SKIP ($bin missing)"; continue; fi
    ran=$((ran+1))
    node "$WEB/src/node_run.js" "$bin" --max 400000000 --kbd 'cat /hello.txt\n' \
        --expect-screen 'hello, mtfs' --screen-text --screen-out "$OUT/$v.ppm" \
        > "$OUT/${v}_log.txt" 2> "$OUT/${v}_emu.txt"
    rc=$?
    ok=1
    grep -q "CONSOLE: LCD ready" "$OUT/${v}_log.txt" || { echo "[test] $v: console never reported LCD ready"; ok=0; }
    grep -q '^\[sc=.*=c\]' "$OUT/${v}_log.txt" || { echo "[test] $v: kernel did not see the matrix key press"; ok=0; }
    [ $rc = 0 ] || { echo "[test] $v: LCD never showed 'hello, mtfs' (rc=$rc)"; ok=0; }
    # Regression (docs/solved.md #49): with a UART sh alongside the console,
    # a key typed at an idle prompt must show up on the LCD by itself — the
    # two -2-yielding shells used to ping-pong and rearm the timer forever,
    # so the console's nanosleep never woke until the next key. Type one
    # key once the login banner is long done and expect it within ~0.7 s
    # of guest time (70M insns).
    if [ $ok = 1 ] && [ "$v" = console_land ]; then
        node "$WEB/src/node_run.js" "$bin" --max 420000000 --kbd 'l' --kbd-at 350000000 \
            --expect-screen 'sh$ l' --quiet > /dev/null 2> "$OUT/${v}_late_emu.txt" \
            || { echo "[test] $v: a lone key at the idle prompt never reached the LCD (sleeper wakeup)"; ok=0; }
    fi
    if [ $ok = 1 ]; then
        echo "[test] $v: PASS $(grep -o 'matched after.*' "$OUT/${v}_emu.txt")"
    else
        echo "[test] $v: FAIL"; fails=$((fails+1))
        sed -n '/\[emu\] screen/,$p' "$OUT/${v}_emu.txt" | head -40
        tail -5 "$OUT/${v}_log.txt"
    fi
done
[ $ran = 0 ] && { echo "test_console: SKIP (no console kernel built)"; exit 0; }
if [ $fails = 0 ]; then echo "test_console: PASS ($ran variants)"; else echo "test_console: FAIL ($fails)"; exit 1; fi
