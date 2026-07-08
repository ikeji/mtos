#!/bin/bash
# test_pico2_hw.sh — compile & run Hello World on pico2 using a
# host-mediated UART pipeline.
#
# The pico2 480 KB kernel arena can't hold the full linker input
# (/tmp/full.s = 224 KB prelude + user .s, and /tmp/p2.in would be
# ~700 KB). We work around this by streaming the big files through
# UART instead of storing them in tmpfs:
#
#   1. Pico2 runs parse/sigscan/tcheck/codegen/bc2asm on /hw.tc
#      (inputs small, fit in tmpfs). Result: /tmp/4.s (few KB).
#   2. Pico2 `cat /tmp/4.s` — UART dump to host.
#   3. Pico2 link stages on-device:
#        cat /tmp/4.s /prelude_tail.s > /tmp/u.s
#        asm_pass1 /tmp/u.s --idx-out … --reloc-out …
#        asm_pass2 --add /prelude.idx --add /tmp/u.idx --lab-out /tmp/full.lab
#        asm_pass3 --lab /tmp/full.lab --out /tmp/hw
#      No UART-streamed assembly bundles — pre-staged /prelude.*
#      artefacts (built by kernel/build.sh) supply the prelude side.
#   4. Pico2 `/tmp/hw` — runs the compiled binary. "Hello, World!"
#      comes back via UART.
#
# Requires a Pico 2 + Debug Probe + /dev/ttyACM0, same as test_pico2.sh.
# Not part of `make test`; run manually:
#
#   GEN2_DIR=compiler/build/gen2 tests/test_pico2_hw.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
source "$ROOT_DIR/integration/lib/pico2_hw.sh"

if [ -z "$GEN2_DIR" ]; then
    echo "SKIP: GEN2_DIR not set" >&2; exit 0
fi
if [ ! -x "$OPENOCD" ]; then
    echo "SKIP: openocd not found at $OPENOCD" >&2; exit 0
fi
if [ ! -e "$UART_PORT" ]; then
    echo "SKIP: UART port not found at $UART_PORT (Debug Probe unplugged?)" >&2; exit 0
fi

TMP=$(mktemp -d)
# Keep logs for post-mortem; /tmp gets wiped on reboot anyway.
echo "[info] logs/intermediates kept in $TMP"

echo "=== Pico 2 OS-Hosted Hello World ==="

# Step 1: Build pico2 kernel with EXTRA_TASKS, export prelude.s.
echo "[build] pico2 kernel (EXTRA_TASKS=parse sigscan tcheck codegen bc2asm asm_pass2 asm_pass3 cat)"
EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3 cat" \
PRELUDE_OUT_DIR="$TMP" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/kernel/scripts/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | tail -2 >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ] || [ ! -s "$TMP/prelude.s" ]; then
    echo "FAIL: kernel/build.sh did not produce UF2 or prelude.s" >&2; exit 1
fi

# Step 2: Extract raw bin from UF2.
uf2_to_bin "$TMP/kernel_pico2.uf2" "$TMP/kernel_pico2.bin"

# Step 3: Flash (halted; the Python driver does the reset).
pico2_uart_setup
pico2_uart_drain

echo "[flash] programming kernel"
if ! pico2_flash_halt "$TMP/kernel_pico2.bin" "$TMP/openocd.log" 2>/dev/null; then
    echo "FAIL: flash verify" >&2; tail -5 "$TMP/openocd.log"; exit 1
fi

# Step 4: Hand off to the Python driver. It does reset + the full
# UART-mediated pipeline.
echo "[run] driving pico2 UART pipeline"
python3 "$ROOT_DIR/integration/pico2_hw_driver.py" \
    --port "$UART_PORT" \
    --prelude "$TMP/prelude.s" \
    --prelude-tail "$TMP/prelude_tail.s" \
    --openocd "$OPENOCD" \
    --openocd-scripts "$OPENOCD_SCRIPTS" \
    --log-dir "$TMP" \
    --run-link
status=$?
echo "[run] driver exit $status"
[ "$status" -ne 0 ] && { echo "FAIL: driver returned $status"; exit 1; }
echo "PASS: pico2 self-compiled Hello World"
