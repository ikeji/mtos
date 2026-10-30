#!/bin/bash
# test_boot.sh — boot kernel/build/tn20k_kernel.bin headless on the JS
# emulator and run the same checks as hw/tests/test_kernel_hw.sh. The
# commands are queued in the UART RX FIFO before boot; sh reads them one
# line at a time. SKIPs (exit 0) when the kernel bin is not built.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_boot: SKIP ($KERNEL_BIN missing; make -C kernel tn20k)"; exit 0; }
OUT="$WEB/build"; mkdir -p "$OUT"
printf 'echo hello from tn20k\ncat /hello.txt\nls /bin\nneofetch\ndate 2030-01-02 03:04:05\ndate\n' > "$OUT/boot_cmds.txt"
node "$WEB/src/node_run.js" "$KERNEL_BIN" --max 200000000 --stdin "$OUT/boot_cmds.txt" > "$OUT/boot_log.txt" 2> "$OUT/boot_emu.txt"
rc=$?
fails=0
check() {
    if grep -q -- "$2" "$OUT/boot_log.txt"; then echo "[test] $1: PASS"; else echo "[test] $1: FAIL (want '$2')"; fails=$((fails+1)); fi
}
check "boot to sh"   'sh\$'
check "echo"         'hello from tn20k'
check "cat"          'hello, mtfs'
check "ls /bin"      'neofetch'
check "neofetch"     'RV32IM'
# goldfish-rtc at 0x101000 (soc.js): date sets it and reads it back, and the
# write must not land on the exit device that shares the 0x0010 page.
[ "$(grep -c '^2030-01-02 03:04:0' "$OUT/boot_log.txt")" -ge 2 ] && echo "[test] date set/get: PASS" || { echo "[test] date set/get: FAIL"; fails=$((fails+1)); }
[ $rc = 1 ] && { echo "[test] emulator error:"; cat "$OUT/boot_emu.txt"; fails=$((fails+1)); }
grep -h "MIPS" "$OUT/boot_emu.txt" | sed 's/^/[test] /'
if [ $fails = 0 ]; then echo "test_boot: PASS"; else echo "test_boot: FAIL ($fails)"; tail -20 "$OUT/boot_log.txt"; exit 1; fi
