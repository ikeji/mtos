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
    # vi sizes itself from the COLS / ROWS env vars that /bin/console
    # exports (56 / 15 in landscape; docs/task/proc_env.md): the status
    # line must land on the last LCD row
    # and the file's first line must still be visible, i.e. no long
    # line wrapped and scrolled the top of the file away.
    if [ $ok = 1 ] && [ "$v" = console_vram ]; then
        node "$WEB/src/node_run.js" "$bin" --max 400000000 --kbd 'vi /etc/login\n' \
            --expect-screen '-- NORMAL' --screen-text > /dev/null 2> "$OUT/${v}_vi_emu.txt" \
            || { echo "[test] $v: vi never drew its status line on the LCD"; ok=0; }
        grep -q '^| .*/etc/login  runs at sh startup' "$OUT/${v}_vi_emu.txt" \
            || { echo "[test] $v: vi scrolled the first line of /etc/login off the LCD (env geometry)"; ok=0; }
        sed -n '/\[emu\] screen/,$p' "$OUT/${v}_vi_emu.txt" | grep '^| ' | grep -n 'NORMAL' | grep -q '^17:' \
            || { echo "[test] $v: vi status line is not on LCD row 15 (2 title rows + 15)"; ok=0; }
        # Enter in vi insert mode must split the line. The matrix keyboard's
        # ENT key used to emit LF, which vi takes as Ctrl+J (TUT-code toggle)
        # instead of a newline; it now emits CR like a UART terminal.
        node "$WEB/src/node_run.js" "$bin" --max 500000000 \
            --kbd 'vi /tmp/nl\nia\nb\n\e:wq\ncat /tmp/nl\necho nlok\n' \
            --expect-screen 'nlok' --screen-text > /dev/null 2> "$OUT/${v}_vi_nl_emu.txt" \
            || { echo "[test] $v: vi :wq round trip never finished (Enter in insert mode?)"; ok=0; }
        grep -A1 '^| *.a *.$' "$OUT/${v}_vi_nl_emu.txt" | grep -q '^| *.b *.$' \
            || { echo "[test] $v: Enter in vi insert mode did not insert a newline"; ok=0; }
        # Modifier layers: the matrix has no shifted / Ctrl / arrow keys of
        # its own; SFT / FN / CTL held with a key change its byte in the
        # kernel driver, and the browser sends such keys as chords. Upper
        # case, shifted symbols, FN symbols (- _ ;) and the up arrow (FN+k
        # -> ESC [ A -> sh history recall) must all come out on the LCD.
        node "$WEB/src/node_run.js" "$bin" --max 500000000 \
            --kbd 'echo Ab-1!_;\n\e[A\necho kdone\n' \
            --expect-screen 'kdone' --screen-text > /dev/null 2> "$OUT/${v}_mod_emu.txt" \
            || { echo "[test] $v: modifier / arrow typing never finished"; ok=0; }
        [ "$(grep -c '^| *.Ab-1!_; *.$' "$OUT/${v}_mod_emu.txt")" = 2 ] \
            || { echo "[test] $v: SFT / FN chords or up-arrow history recall did not reach sh (want 'Ab-1!_;' echoed twice)"; ok=0; }
        # vi: arrows move the cursor in insert mode (two lefts from "ab"
        # then x -> "xab"), Ctrl+J (CTL chord) enters TUT mode so the
        # following ESC only leaves TUT and z is still inserted -> "xzab".
        node "$WEB/src/node_run.js" "$bin" --max 600000000 \
            --kbd 'vi /tmp/ar\niab\e[D\e[Dx\^j\ez\e:wq\ncat /tmp/ar\necho ardone\n' \
            --expect-screen 'ardone' --screen-text > /dev/null 2> "$OUT/${v}_vi_ar_emu.txt" \
            || { echo "[test] $v: vi arrow / Ctrl+J round trip never finished"; ok=0; }
        grep -q '^| *.xzab' "$OUT/${v}_vi_ar_emu.txt" \
            || { echo "[test] $v: vi arrows / Ctrl+J on the matrix keyboard (want xzab)"; ok=0; }
        # UART side of the same kernel: the xterm sh is a kern.conf init
        # task with an empty env, so ROWS is unset there and vi must keep
        # 80x24 — 23 CRLF-terminated rows between its last ESC[H and the
        # status line (the LCD vi above draws 14).
        printf 'cat /proc/self/env/ROWS\nvi /etc/login\n' > "$OUT/${v}_uart_cmds.txt"
        node "$WEB/src/node_run.js" "$bin" --max 300000000 --stdin "$OUT/${v}_uart_cmds.txt" --quiet \
            > "$OUT/${v}_uart_log.txt" 2> "$OUT/${v}_uart_emu.txt"
        grep -q 'cat: /proc/self/env/ROWS: open failed' "$OUT/${v}_uart_log.txt" \
            || { echo "[test] $v: UART sh saw a ROWS env var (should be console-only)"; ok=0; }
        uart_rows=$(python3 -I - "$OUT/${v}_uart_log.txt" <<'PY'
import sys
d = open(sys.argv[1], 'rb').read()
i = d.rfind(b'\x1b[H'); j = d.find(b'-- NORMAL', i if i >= 0 else 0)
print(d[i:j].count(b'\r\n') if i >= 0 and j >= 0 else -1)
PY
)
        [ "$uart_rows" = 23 ] \
            || { echo "[test] $v: vi on the UART drew $uart_rows text rows, want 23 (80x24 default)"; ok=0; }
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
