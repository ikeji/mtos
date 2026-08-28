#!/bin/bash
# test_soc_hw.sh — board test: flash top_soc_sdram (SDRAM + UART boot ROM),
# load build/hello2.bin through the boot ROM, expect "Hello, World".
# Needs the board on USB (UART = /dev/ttyUSB1) and the Gen2 toolchain.
set -euo pipefail
HW="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="${OSS_CAD:-$HOME/opt/oss-cad-suite}/bin:$PATH"
UART_PORT="${UART_PORT:-/dev/ttyUSB1}"
make -C "$HW" build/hello2.bin >/dev/null
make -C "$HW" TOP=top_soc_sdram bit >/dev/null 2>&1
openFPGALoader -b tangnano20k "$HW/build/top_soc_sdram.fs" >/dev/null 2>&1
sleep 0.5
out="$(python3 "$HW/tools/uart_load.py" -p "$UART_PORT" -t 1 "$HW/build/hello2.bin" 2>/dev/null || true)"
if printf '%s' "$out" | grep -q 'Hello, World'; then echo "test_soc_hw: PASS (boot ROM → SDRAM → Hello, World)"; else echo "test_soc_hw: FAIL out=$(printf '%q' "$out")"; exit 1; fi
