#!/bin/bash
# run_pico2.sh — flash and run kernel on RP2350 via Debug Probe, capture UART
#
# Usage:
#   ./kernel/run_pico2.sh [kernel.uf2]
#
# Requires:
#   - ~/opt/openocd-rpi/bin/openocd (Raspberry Pi fork with RP2350 support)
#   - Debug Probe connected via SWD + UART (GPIO0/1) to RP2350
#   - /dev/ttyACM0 = Debug Probe UART

set -e
KERN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$KERN_DIR")"

OPENOCD="$HOME/opt/openocd-rpi/bin/openocd"
OPENOCD_SCRIPTS="$HOME/opt/openocd-rpi/share/openocd/scripts"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

UF2="${1:-$KERN_DIR/kernel_pico2.uf2}"

if [ ! -f "$UF2" ]; then
    echo "Error: UF2 not found: $UF2" >&2
    exit 1
fi

# Convert UF2 → ELF-like bin for openocd
# Actually openocd can load UF2 directly via `program` command on RP2350
# But let's extract the raw bin from the UF2 for flexibility.
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

BIN="$TMP/kernel.bin"
picotool uf2 convert "$UF2" "$BIN" -t bin 2>&1 >/dev/null || {
    # Fallback: use picotool's UF2 tools differently
    # Actually picotool may not have this command; use our own extraction
    python3 - "$UF2" "$BIN" << 'PY'
import sys, struct
uf2_path, bin_path = sys.argv[1], sys.argv[2]
with open(uf2_path, "rb") as f:
    data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512: break
    magic1, magic2 = struct.unpack_from("<II", block, 0)
    if magic1 != 0x0A324655 or magic2 != 0x9E5D5157:
        continue
    flags, target_addr, payload_size = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32+payload_size])
with open(bin_path, "wb") as f:
    f.write(out)
PY
}

echo "Flashing $UF2 → RP2350 via Debug Probe..." >&2

# Use openocd to flash and run
# Load base address for RP2350 Flash: 0x10000000
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg \
    -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" \
    -c "init" \
    -c "reset halt" \
    -c "program $BIN 0x10000000 verify" \
    -c "reset run" \
    -c "exit" 2>&1

echo "" >&2
echo "Flashed. Reading UART from $UART_PORT (Ctrl-C to stop)..." >&2
echo "" >&2

# Open UART with stty + cat
stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo 2>&1 || true
exec cat "$UART_PORT"
