#!/bin/bash
# pico2_test_compile_parse.sh — verify device can byte-exact rebuild
# its own parse.bin via the OS-side compile pipeline. Stages REFRESH
# (so /sd/runtime.s + libtc.s match host), then runs
# pico2_compile_compilers.sh which parses + tchecks + codegens +
# bc2asms + asm_pass1/2/3-links parse.tc on device, and md5sums the
# resulting /sd/parse.bin. Compare against build/kernel/tasks/parse.bin.
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/build/kernel/pico2_kernel_extra.uf2}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Compute expected host md5 of parse.bin (already built).
HOST_PARSE_MD5=$(md5sum "$ROOT/build/kernel/tasks/parse.bin" | awk '{print $1}')
echo "host parse.bin md5: $HOST_PARSE_MD5" >&2

# Extract UF2 -> raw bin for openocd.
python3 - "$KERNEL_UF2" "$TMP/kernel.bin" <<'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    b = data[i:i+512]
    if len(b) < 512: break
    m1, m2 = struct.unpack_from("<II", b, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    out += b[32:32+256]
with open(sys.argv[2], "wb") as f: f.write(bytes(out))
PY

flash_kernel() {
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset halt" \
        -c "program $TMP/kernel.bin 0x10000000 verify" \
        -c "exit" > "$TMP/oocd.log" 2>&1
    grep -q "Verified OK" "$TMP/oocd.log" || { tail -20 "$TMP/oocd.log" >&2; exit 1; }
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" \
        > /dev/null 2>&1
}

run_step() {
    local step_path="$1" deadline_marker="$2"
    local LOG="$TMP/uart_$(basename "$step_path" .sh).log"
    stty -F "$UART_PORT" 115200 raw -echo
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
    ( cat "$UART_PORT" > "$LOG" 2>&1 ) &
    CATPID=$!
    sleep 0.5
    python3 -c "
import os, sys, time
fd = os.open('$UART_PORT', os.O_WRONLY)
for ch in ('msh ' + sys.argv[1] + '\n').encode():
    os.write(fd, bytes([ch]))
    time.sleep(0.01)
os.close(fd)
" "$step_path"
    local deadline=$(( $(date +%s) + 1800 ))
    while [ "$(date +%s)" -lt "$deadline" ]; do
        if grep -q "$deadline_marker" "$LOG" 2>/dev/null; then break; fi
        if grep -q "msh: aborting" "$LOG" 2>/dev/null; then break; fi
        sleep 5
    done
    sleep 2
    kill -9 "$CATPID" 2>/dev/null || true
    cat "$LOG"
}

echo "=== Flash kernel ===" >&2
flash_kernel
sleep 6

echo "=== Cleanup /sd ===" >&2
run_step /pico2_cleanup_sd.sh CLEANUP_DONE

echo "=== REFRESH 0a: runtime.s ===" >&2
run_step /pico2_compile_runtime.sh COMPILE_RUNTIME_DONE
echo "=== REFRESH 0b: libtc.s ===" >&2
run_step /pico2_compile_libtc.sh COMPILE_LIBTC_DONE

echo "=== Compile parse on device ===" >&2
run_step /pico2_compile_compilers.sh COMPILE_PARSE_DONE

DEV_MD5=$(grep -oE '^[0-9a-f]{32}  /sd/parse\.bin' "$TMP"/uart_*compilers*.log | awk '{print $1}' | tail -1)
echo "host parse.bin md5: $HOST_PARSE_MD5"
echo "device parse.bin md5: $DEV_MD5"
if [ "$HOST_PARSE_MD5" = "$DEV_MD5" ]; then
    echo "parse.bin MATCH — Gen2→Gen3 self-host (parse) byte-exact"
    exit 0
else
    echo "parse.bin DIFFERS"
    exit 1
fi
