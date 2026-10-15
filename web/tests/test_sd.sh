#!/bin/bash
# test_sd.sh — SD card emulation end to end: build a FAT32 image with
# tools/fatimg.py, boot the tn20k kernel with it attached, read a file,
# write a file from the OS, then check the written image with fatimg.py.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_sd: SKIP ($KERNEL_BIN missing; make -C kernel tn20k)"; exit 0; }
OUT="$WEB/build"; mkdir -p "$OUT"
printf 'hello from the SD image\n' > "$OUT/sd_hello.txt"
python3 "$WEB/tools/fatimg.py" mkfs "$OUT/sd_test.img" 8 && python3 "$WEB/tools/fatimg.py" add "$OUT/sd_test.img" HELLO.TXT="$OUT/sd_hello.txt" || { echo "test_sd: FAIL (fatimg.py)"; exit 1; }
printf 'cat /sd/HELLO.TXT\necho written by emu > /sd/out.txt\ncat /sd/out.txt\nls /sd\nquit\n' > "$OUT/sd_cmds.txt"
node "$WEB/src/node_run.js" "$KERNEL_BIN" --max 400000000 --stdin "$OUT/sd_cmds.txt" --sd "$OUT/sd_test.img" --sd-out "$OUT/sd_test_out.img" > "$OUT/sd_log.txt" 2> "$OUT/sd_emu.txt"
rc=$?
fails=0
check() { if grep -q -- "$2" "$OUT/sd_log.txt"; then echo "[test] $1: PASS"; else echo "[test] $1: FAIL (want '$2')"; fails=$((fails+1)); fi; }
check "SD card init"        'SD: card ready'
check "FAT mount"           'FATFS: mounted'
check "read file from /sd"  'hello from the SD image'
check "write + read back"   'written by emu'
check "ls /sd shows file"   'out.txt'
back=$(python3 "$WEB/tools/fatimg.py" cat "$OUT/sd_test_out.img" out.txt 2>&1)
if [ "$back" = "written by emu" ]; then echo "[test] written image readable on host: PASS"; else echo "[test] written image readable on host: FAIL ($back)"; fails=$((fails+1)); fi
[ $rc = 0 ] || { echo "[test] emulator rc=$rc:"; cat "$OUT/sd_emu.txt"; fails=$((fails+1)); }
grep -h "MIPS\|SD:" "$OUT/sd_emu.txt" | sed 's/^/[test] /'
if [ $fails = 0 ]; then echo "test_sd: PASS"; else echo "test_sd: FAIL ($fails)"; tail -20 "$OUT/sd_log.txt"; exit 1; fi
