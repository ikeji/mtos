#!/bin/bash
# run_pico2.sh — flash and run kernel on RP2350 via Debug Probe, capture UART
#
# Usage:
#   ./kernel/scripts/run_pico2.sh [kernel.uf2]
#
# Requires:
#   - ~/opt/openocd-rpi/bin/openocd (Raspberry Pi fork with RP2350 support)
#     (override with OPENOCD / OPENOCD_SCRIPTS)
#   - Debug Probe connected via SWD + UART (GPIO0/1) to RP2350
#   - /dev/ttyACM0 = Debug Probe UART (override with UART_PORT)

set -e
KERN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT_DIR="$(dirname "$KERN_DIR")"
source "$ROOT_DIR/integration/lib/pico2_hw.sh"

UF2="${1:-$KERN_DIR/kernel_pico2.uf2}"

if [ ! -f "$UF2" ]; then
    echo "Error: UF2 not found: $UF2" >&2
    exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

BIN="$TMP/kernel.bin"
uf2_to_bin "$UF2" "$BIN"

echo "Flashing $UF2 → RP2350 via Debug Probe..." >&2
pico2_flash_run "$BIN" "$TMP/openocd.log"

echo "" >&2
echo "Flashed. Reading UART from $UART_PORT (Ctrl-C to stop)..." >&2
echo "" >&2

pico2_uart_setup
exec cat "$UART_PORT"
