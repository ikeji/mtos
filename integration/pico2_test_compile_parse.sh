#!/bin/bash
# pico2_test_compile_parse.sh — verify device can byte-exact rebuild
# its own parse.bin via the OS-side compile pipeline. Stages REFRESH
# (so /sd/runtime.s + libtc.s match host), then runs
# pico2_compile_compilers.sh which parses + tchecks + codegens +
# bc2asms + asm_pass1/2/3-links parse.tc on device, and md5sums the
# resulting /sd/parse.bin. Compare against userland/build/tasks/parse.bin.
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT/integration/lib/pico2_hw.sh"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/kernel/build/pico2_kernel_extra.uf2}"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Compute expected host md5 of parse.bin (already built).
HOST_PARSE_MD5=$(md5sum "$ROOT/userland/build/tasks/parse.bin" | awk '{print $1}')
echo "host parse.bin md5: $HOST_PARSE_MD5" >&2

# Extract UF2 -> raw bin for openocd.
uf2_to_bin "$KERNEL_UF2" "$TMP/kernel.bin"

flash_kernel() {
    pico2_flash_halt "$TMP/kernel.bin" "$TMP/oocd.log" || exit 1
    pico2_reset_run
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
