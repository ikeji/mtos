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
#   3. Host assembles full.s locally = prelude + 4.s + tail.
#   4. Host sends full.s via UART to pico2 stdin. Pico2 runs
#      `asm_pass1 > /tmp/lab`. asm_pass1 consumes stdin until 0x04
#      EOT (source_reader treats it as EOF).
#   5. Pico2 `cat /tmp/lab` — UART dump to host.
#   6. Host sends lab + full.s + full.s + full.s via UART. Pico2
#      runs `asm_pass2 > /tmp/hw`. /tmp/hw is ~44 KB, fits in tmpfs.
#   7. Pico2 `/tmp/hw` — runs the compiled binary. "Hello, World!"
#      comes back via UART.
#
# Requires a Pico 2 + Debug Probe + /dev/ttyACM0, same as test_pico2.sh.
# Not part of `make test`; run manually:
#
#   GEN2_DIR=build/gen2 tests/test_pico2_hw.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

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
echo "[build] pico2 kernel (EXTRA_TASKS=parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat)"
EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat" \
PRELUDE_OUT_DIR="$TMP" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/kernel/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | tail -2 >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ] || [ ! -s "$TMP/prelude.s" ]; then
    echo "FAIL: kernel/build.sh did not produce UF2 or prelude.s" >&2; exit 1
fi

# Step 2: Extract raw bin from UF2.
python3 - "$TMP/kernel_pico2.uf2" "$TMP/kernel_pico2.bin" << 'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512: break
    m1, m2 = struct.unpack_from("<II", block, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    _, _, ps = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32+ps])
with open(sys.argv[2], "wb") as f: f.write(out)
PY

# Step 3: Flash.
stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null || true
cat "$UART_PORT" > /dev/null 2>&1 & FLUSH=$!
sleep 0.3
kill "$FLUSH" 2>/dev/null || true; wait "$FLUSH" 2>/dev/null || true

echo "[flash] programming kernel"
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset halt" \
    -c "program $TMP/kernel_pico2.bin 0x10000000 verify" \
    -c "reset init" -c "exit" > "$TMP/openocd.log" 2>&1 || true
if ! grep -q "Verified OK" "$TMP/openocd.log"; then
    echo "FAIL: flash verify" >&2; tail -5 "$TMP/openocd.log"; exit 1
fi

# Step 4: Hand off to the Python driver. It does reset + the full
# UART-mediated pipeline.
echo "[run] driving pico2 UART pipeline"
python3 "$SCRIPT_DIR/pico2_hw_driver.py" \
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
