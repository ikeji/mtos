#!/bin/bash
# pico2_link_kernel_run.sh — end-to-end host orchestrator for the
# pico2 self-build of kernel.bin.
#
# Steps:
#   1. flash pico2_kernel_extra.uf2 + reset
#   2. upload build/kernel/disk.img → /sd/disk.img via mr
#   3. run /pico2_link_kernel.sh under msh
#   4. grep the md5 of /sd/kernel.bin from the captured UART log
#   5. compare against host reference (709a6f8...)
#
# Requires Debug Probe + openocd-rpi to be reachable.
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/build/kernel/pico2_kernel_extra.uf2}"
DISK_IMG="${DISK_IMG:-$ROOT/build/kernel/disk.img}"
HOST_KERNEL_BIN="${HOST_KERNEL_BIN:-}"
OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

if [ -z "$HOST_KERNEL_BIN" ]; then
    HOST_KERNEL_BIN="$(mktemp /tmp/host_kernel_XXXX.bin)"
    _hbtmp=$(mktemp -d)
    "$ROOT/kernel/bin2s_incbin.sh" "$ROOT/build/kernel/disk.img" \
        _mtfs_image "$ROOT/build/kernel/disk.img" > "$_hbtmp/mtfs.s"
    cat "$ROOT/kernel/platform_pico2.s" "$ROOT/kernel/trap_common.s" \
        > "$_hbtmp/crt0.s"
    cat "$ROOT/kernel/crt0_pico2_data.s" "$_hbtmp/mtfs.s" \
        > "$_hbtmp/data.s"
    CRT0="$_hbtmp/crt0.s" CRT0_DATA="$_hbtmp/data.s" ASM_PROLOGUE="; raw" \
    GEN2_DIR="$ROOT/build/gen2" \
    CACHED_S_DIR="$ROOT/build/kernel/shared" \
        "$ROOT/compile-gen2.sh" -o "$HOST_KERNEL_BIN" \
        "$ROOT/kernel/kernel_pico2.tc" 2>/dev/null
    rm -rf "$_hbtmp"
fi
HOST_MD5=$(md5sum "$HOST_KERNEL_BIN" | awk '{print $1}')
echo "host kernel.bin md5: $HOST_MD5" >&2

TMP=$(mktemp -d)
echo "TMP=$TMP" >&2

# uf2 → bin for openocd flashing
python3 - "$KERNEL_UF2" "$TMP/kernel.bin" <<'PY'
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

echo "[1/4] Flashing $KERNEL_UF2..." >&2
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset halt" \
    -c "program $TMP/kernel.bin 0x10000000 verify" \
    -c "exit" > "$TMP/oocd.log" 2>&1
grep -q "Verified OK" "$TMP/oocd.log" || { tail -20 "$TMP/oocd.log" >&2; exit 1; }
stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" > /dev/null 2>&1
sleep 4

if [ "${SKIP_UPLOAD:-0}" = "1" ]; then
    echo "[2/4] Upload skipped (SKIP_UPLOAD=1) — assuming /sd/disk.img" >&2
    echo "      already matches build/kernel/disk.img on the device." >&2
elif [ "${UPLOAD_VIA_MR:-0}" = "1" ]; then
    echo "[2/4] Uploading disk.img to /sd/disk.img via mr..." >&2
    echo "      WARNING: large UART uploads (>~10 KB) have hung the device" >&2
    echo "      in testing. Prefer the SD-card swap path: power down pico2," >&2
    echo "      pull the SD into the host, cp the disk.img, reinsert, and" >&2
    echo "      re-run with SKIP_UPLOAD=1." >&2
    python3 "$ROOT/tests/pico2_upload.py" "$DISK_IMG" /sd/disk.img "$UART_PORT" 2>&1 | tail -5
    sleep 1
else
    cat <<EOF >&2
[2/4] Manual SD copy required:

  1. Unplug the pico2 USB cable.
  2. Pull the SD card and mount it on this host.
  3. cp $DISK_IMG /path/to/sd/disk.img
  4. (Optional) verify: md5sum /path/to/sd/disk.img — should be
     \$(md5sum "$DISK_IMG" | awk '{print \$1}').
  5. Eject the SD, reinsert into pico2, plug USB back in.
  6. Re-run this script with SKIP_UPLOAD=1.

(Pass UPLOAD_VIA_MR=1 to attempt mr upload anyway; not recommended.)
EOF
    exit 2
fi

echo "[3/4] Running pico2_link_kernel.sh under msh..." >&2
LOG="$TMP/uart.log"
(cat "$UART_PORT" > "$LOG" 2>&1) &
CATPID=$!
sleep 0.5
python3 -c "
import sys, os, time
fd = os.open('$UART_PORT', os.O_WRONLY)
for ch in ('msh /pico2_link_kernel.sh\n').encode():
    os.write(fd, bytes([ch]))
    time.sleep(0.01)
os.close(fd)
"
deadline=$(( $(date +%s) + 1800 ))
while [ "$(date +%s)" -lt "$deadline" ]; do
    if grep -q "LINK_KERNEL_DONE" "$LOG" 2>/dev/null; then break; fi
    if grep -q "msh: aborting" "$LOG" 2>/dev/null; then break; fi
    sleep 5
done
sleep 2
kill -9 "$CATPID" 2>/dev/null || true

cp "$LOG" /tmp/last_link_kernel.log
echo "[4/4] Result:" >&2
DEV_MD5=$(grep -oE '^[0-9a-f]{32}  /sd/kernel\.bin' "$LOG" | awk '{print $1}' | tail -1)
echo "device kernel.bin md5: $DEV_MD5" >&2
echo "host   kernel.bin md5: $HOST_MD5" >&2
if [ "$DEV_MD5" = "$HOST_MD5" ]; then
    echo "MATCH — pico2 self-build of kernel.bin is byte-exact." >&2
    exit 0
else
    echo "DIFFER — see $LOG" >&2
    exit 1
fi
