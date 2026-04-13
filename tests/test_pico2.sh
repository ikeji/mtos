#!/bin/bash
# test_pico2.sh — flash kernel_pico2 to real RP2350 hardware and verify
# the filesystem / preemption output on UART.
#
# NOT part of make test: requires a physically connected Pico 2 with a
# Debug Probe (SWD + UART via CDC-ACM). Run manually when you want to
# confirm that a change still works on hardware.
#
# Usage:
#   GEN2_DIR=/tmp/gen2 tests/test_pico2.sh
#
# Environment:
#   GEN2_DIR    — Gen2 tool directory (required, same as kernel/build.sh)
#   OPENOCD     — path to openocd binary (default ~/opt/openocd-rpi/bin/openocd)
#   OPENOCD_SCRIPTS — openocd scripts dir (default ~/opt/openocd-rpi/share/openocd/scripts)
#   UART_PORT   — UART device (default /dev/ttyACM0)
#   UART_WAIT   — seconds to wait after flashing for the kernel to finish (default 6)

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== Pico 2 Hardware Test ==="

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"
UART_WAIT="${UART_WAIT:-6}"

# ----- Preflight checks -----
if [ -z "$GEN2_DIR" ]; then
    echo "SKIP: GEN2_DIR not set" >&2
    exit 0
fi
if [ ! -x "$OPENOCD" ]; then
    echo "SKIP: openocd not found at $OPENOCD" >&2
    exit 0
fi
if [ ! -e "$UART_PORT" ]; then
    echo "SKIP: UART port not found at $UART_PORT (Debug Probe unplugged?)" >&2
    exit 0
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ----- Step 1: Build Pico 2 kernel UF2 -----
t0=$(time_ms)
GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/kernel/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | sed 's/^/    /' >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ]; then
    report_fail_msg "pico2: build" "kernel/build.sh --target pico2 produced no UF2"
    print_results
    exit $?
fi
elapsed=$(( $(time_ms) - t0 ))
report_pass "pico2: kernel/build.sh --target pico2" "$elapsed"

# ----- Step 2: Extract raw bin from UF2 -----
# picotool needs a UF2 on the output side too, so we do the extraction
# ourselves (same layout as kernel/run_pico2.sh's fallback).
python3 - "$TMP/kernel_pico2.uf2" "$TMP/kernel_pico2.bin" << 'PY'
import sys, struct
uf2_path, bin_path = sys.argv[1], sys.argv[2]
with open(uf2_path, "rb") as f:
    data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512:
        break
    magic1, magic2 = struct.unpack_from("<II", block, 0)
    if magic1 != 0x0A324655 or magic2 != 0x9E5D5157:
        continue
    _flags, _target_addr, payload_size = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32 + payload_size])
with open(bin_path, "wb") as f:
    f.write(out)
PY

if [ ! -s "$TMP/kernel_pico2.bin" ]; then
    report_fail_msg "pico2: UF2 extract" "empty bin after UF2 → raw extraction"
    print_results
    exit $?
fi

# ----- Step 3: Start background UART capture, then flash -----
stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo 2>/dev/null || true

t1=$(time_ms)
# Generous read window so we never cut the kernel off mid-output;
# we kill the reader ourselves once openocd + UART_WAIT have elapsed.
timeout 30 cat "$UART_PORT" > "$TMP/uart.log" 2>/dev/null &
CAT_PID=$!
sleep 0.3   # let cat open the device before reset

"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg \
    -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" \
    -c "init" \
    -c "reset halt" \
    -c "program $TMP/kernel_pico2.bin 0x10000000 verify" \
    -c "reset run" \
    -c "exit" > "$TMP/openocd.log" 2>&1

if ! grep -q "Verified OK" "$TMP/openocd.log"; then
    kill "$CAT_PID" 2>/dev/null || true
    wait "$CAT_PID" 2>/dev/null || true
    elapsed=$(( $(time_ms) - t1 ))
    report_fail_msg "pico2: flash" "openocd did not print 'Verified OK': $(tail -5 "$TMP/openocd.log" | tr '\n' ' ')"
    print_results
    exit $?
fi

# Wait for the kernel to finish running the 3 tasks
sleep "$UART_WAIT"
kill "$CAT_PID" 2>/dev/null || true
wait "$CAT_PID" 2>/dev/null || true

elapsed=$(( $(time_ms) - t1 ))

# ----- Step 4: Verify UART output contents -----
uart_out=$(tr -d '\0' < "$TMP/uart.log")

# Under preemption the catfile output may be interleaved with A/B, so
# check each piece separately (same approach as fs_virtio in test_os.sh).
pico_has_start=$(echo "$uart_out" | grep -c "KERN: starting")
pico_has_block=$(echo "$uart_out" | grep -c "BLOCK: flash backend ready")
pico_has_mtfs=$(echo "$uart_out" | grep -c "MTFS: mounted")
pico_has_cat=$(echo "$uart_out" | grep -c "CAT:")
pico_has_file=$(echo "$uart_out" | grep -c "hello, mtfs")
pico_has_done=$(echo "$uart_out" | grep -c "all tasks done")
pico_has_a=$(echo "$uart_out" | grep -c "A")
pico_has_b=$(echo "$uart_out" | grep -c "B")

missing=""
[ "$pico_has_start" -eq 0 ] && missing="$missing KERN:starting"
[ "$pico_has_block" -eq 0 ] && missing="$missing BLOCK:flash"
[ "$pico_has_mtfs"  -eq 0 ] && missing="$missing MTFS:mounted"
[ "$pico_has_cat"   -eq 0 ] && missing="$missing CAT:"
[ "$pico_has_file"  -eq 0 ] && missing="$missing hello,mtfs"
[ "$pico_has_done"  -eq 0 ] && missing="$missing all-tasks-done"
[ "$pico_has_a"     -eq 0 ] && missing="$missing A"
[ "$pico_has_b"     -eq 0 ] && missing="$missing B"

if [ -z "$missing" ]; then
    report_pass "pico2: flash + mtfs + catfile + preempt (hello/hello2/catfile)" "$elapsed"
else
    report_fail_msg "pico2: run" \
        "missing [$missing ], got: $(printf '%s' "$uart_out" | head -c 240)"
fi

print_results