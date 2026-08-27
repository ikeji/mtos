#!/bin/bash
# test_blink.sh — flash top_blink into SRAM and verify the UART echo.
# Needs the board on USB (BL616 bridge → /dev/ttyUSB1 is the UART,
# /dev/ttyUSB0 is JTAG). Override with UART_PORT.
set -euo pipefail
HW_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="${OSS_CAD:-$HOME/opt/oss-cad-suite}/bin:$PATH"
UART_PORT="${UART_PORT:-/dev/ttyUSB1}"

make -C "$HW_DIR" bit >/dev/null
openFPGALoader -b tangnano20k "$HW_DIR/build/top_blink.fs"
sleep 0.5

stty -F "$UART_PORT" 115200 raw -echo -echoe -echok -crtscts
exec 3<>"$UART_PORT"
# drain
timeout 0.3 cat <&3 >/dev/null || true
printf 'hello tn20k\n' >&3
got="$(timeout 1 head -c 12 <&3 || true)"
exec 3>&-
if [ "$got" = $'hello tn20k\n' ]; then
    echo "test_blink: PASS (uart echo ok)"
else
    echo "test_blink: FAIL got=$(printf '%q' "$got")"; exit 1
fi
