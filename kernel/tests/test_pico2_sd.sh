#!/bin/bash
# test_pico2_sd.sh — verify SD card SPI driver + fatfs end-to-end on
# real RP2350 hardware. Manual test (NOT part of `make test`): needs
# a Catalex-style SD breakout wired per docs/pico2_hardware.md and an
# SD card with a single FAT partition (MBR or superfloppy).
#
# Usage:
#   GEN2_DIR=compiler/build/gen2 tests/test_pico2_sd.sh
#
# Two-phase test:
#   Phase A: flash a fresh kernel, write /sd/T.TXT, read back via cat.
#   Phase B: reboot only (no re-flash), confirm /sd/T.TXT survives.
# Phase B exercises the non-volatile FAT path — block_sd write
# actually committed bytes to the card, not just an in-memory buffer.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$(dirname "$SCRIPT_DIR")/../compiler/tests/test_common.sh"

echo "=== Pico 2 SD card hardware test ==="

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

# Use a unique payload so we can be sure it's our write that landed
# on the card, not something left over from a previous run.
TAG="sd_$(date +%H%M%S)"

if [ -z "$GEN2_DIR" ]; then echo "SKIP: GEN2_DIR not set" >&2; exit 0; fi
if [ ! -x "$OPENOCD" ];   then echo "SKIP: openocd not found" >&2; exit 0; fi
if [ ! -e "$UART_PORT" ]; then echo "SKIP: UART port not found" >&2; exit 0; fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ----- Step 1: Build kernel -----
t0=$(time_ms)
GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/kernel/scripts/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | sed 's/^/    /' >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ]; then
    report_fail_msg "pico2-sd: build" "kernel.uf2 not produced"
    print_results; exit $?
fi
report_pass "pico2-sd: kernel build" "$(( $(time_ms) - t0 ))"

# Extract raw bin
python3 - "$TMP/kernel_pico2.uf2" "$TMP/kernel.bin" << 'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    b = data[i:i+512]
    if len(b) < 512: break
    m1, m2 = struct.unpack_from("<II", b, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    _, _, ps = struct.unpack_from("<III", b, 8)
    out.extend(b[32:32+ps])
open(sys.argv[2], "wb").write(out)
PY

# ----- Helpers -----
flash_kernel() {
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset halt" \
        -c "program $TMP/kernel.bin 0x10000000 verify" \
        -c "exit" > "$TMP/oocd.log" 2>&1
    grep -q "Verified OK" "$TMP/oocd.log"
}

reset_run() {
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" \
        > /dev/null 2>&1 || true
}

drain_uart() {
    stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
}

# ----- Phase A: write -----
t1=$(time_ms)
flash_kernel || {
    report_fail_msg "pico2-sd: flash" "openocd verify failed"
    print_results; exit $?
}
drain_uart
timeout 25 cat "$UART_PORT" > "$TMP/uartA.log" 2>/dev/null &
CAT=$!
sleep 0.8
reset_run
sleep 5
printf 'echo %s > /sd/T.TXT\n' "$TAG" > "$UART_PORT"
sleep 4
printf 'cat /sd/T.TXT\n' > "$UART_PORT"
sleep 4
printf 'ls /sd\n' > "$UART_PORT"
sleep 4
kill "$CAT" 2>/dev/null || true
wait "$CAT" 2>/dev/null || true
elapsedA=$(( $(time_ms) - t1 ))

uartA=$(tr -d '\0' < "$TMP/uartA.log" \
    | sed -E 's/\[sw [0-9]+>[0-9]+\]//g' \
    | sed -E 's/\[x [0-9]+=[0-9]+\]//g' \
    | sed -E 's/\[w [0-9]+:[0-9]+\]//g' \
    | sed -E 's/\[kmem peak=[0-9]+ live=[0-9]+\]//g' \
    | tr -d '\r')

# Required boot lines
missing=""
echo "$uartA" | grep -q "SD: card init OK" || missing="$missing SD-init"
echo "$uartA" | grep -q "FATFS: mounted"   || missing="$missing FATFS-mount"
echo "$uartA" | grep -q "$TAG"             || missing="$missing readback($TAG)"
echo "$uartA" | grep -q "t.txt"            || missing="$missing ls-output"

if [ -z "$missing" ]; then
    report_pass "pico2-sd: phase A (write+read /sd/T.TXT=$TAG)" "$elapsedA"
else
    report_fail_msg "pico2-sd: phase A" \
        "missing [$missing ], log tail: $(printf '%s' "$uartA" | tail -c 240 | tr '\n' ' ')"
fi

# ----- Phase B: persistence (reboot only, no re-flash) -----
t2=$(time_ms)
drain_uart
timeout 18 cat "$UART_PORT" > "$TMP/uartB.log" 2>/dev/null &
CAT=$!
sleep 0.8
reset_run
sleep 5
printf 'cat /sd/T.TXT\n' > "$UART_PORT"
sleep 6
kill "$CAT" 2>/dev/null || true
wait "$CAT" 2>/dev/null || true
elapsedB=$(( $(time_ms) - t2 ))

uartB=$(tr -d '\0' < "$TMP/uartB.log" \
    | sed -E 's/\[sw [0-9]+>[0-9]+\]//g' \
    | sed -E 's/\[x [0-9]+=[0-9]+\]//g' \
    | sed -E 's/\[w [0-9]+:[0-9]+\]//g' \
    | sed -E 's/\[kmem peak=[0-9]+ live=[0-9]+\]//g' \
    | tr -d '\r')

if echo "$uartB" | grep -q "$TAG"; then
    report_pass "pico2-sd: phase B (persistence across reboot)" "$elapsedB"
else
    report_fail_msg "pico2-sd: phase B" \
        "tag $TAG missing after reboot, tail: $(printf '%s' "$uartB" | tail -c 240 | tr '\n' ' ')"
fi

print_results
