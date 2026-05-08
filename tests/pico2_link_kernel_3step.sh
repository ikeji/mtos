#!/bin/bash
# pico2_link_kernel_3step.sh — drive the 3-step pico2 self-build
# of the no-disk kernel.bin variant, verifying the result matches
# the host gen2 reference byte-exact.
#
# Each step needs a fresh-boot kernel arena to allocate the 288 KB
# contiguous block asm_pass2/asm_pass3 need. We reset (not re-flash)
# between steps via openocd; /sd persists.

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/build/kernel/pico2_kernel_extra.uf2}"
OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"
# If unset, compute the host reference kernel.bin md5 by running
# the same compile pipeline locally with an empty mtfs blob (matches
# what the on-device step3 produces). Allows the orchestrator to
# stay correct even when fatfs.tc / kernel modules change.
if [ -z "${HOST_REF_MD5:-}" ]; then
    _hbtmp=$(mktemp -d)
    cat "$ROOT/kernel/platform_pico2.s" "$ROOT/kernel/trap_common.s" \
        > "$_hbtmp/crt0.s"
    printf '    .rodata\n    .align 4\n    .globl _mtfs_image_start\n_mtfs_image_start:\n    .globl _mtfs_image_end\n_mtfs_image_end:\n    .globl _mtfs_image_size\n_mtfs_image_size:\n    .word 0\n    .text\n    .globl _mtfs_image_addr\n_mtfs_image_addr:\n    la   a0, _mtfs_image_start\n    ret\n' \
        > "$_hbtmp/wrap.s"
    cat "$ROOT/kernel/crt0_pico2_data.s" "$_hbtmp/wrap.s" \
        > "$_hbtmp/data.s"
    CRT0="$_hbtmp/crt0.s" CRT0_DATA="$_hbtmp/data.s" ASM_PROLOGUE="; raw" \
    GEN2_DIR="$ROOT/build/gen2" \
    CACHED_S_DIR="$ROOT/build/kernel/shared" \
        "$ROOT/compile-gen2.sh" -o "$_hbtmp/kernel.bin" \
        "$ROOT/kernel/kernel_pico2.tc" 2>/dev/null
    HOST_REF_MD5=$(md5sum "$_hbtmp/kernel.bin" | awk '{print $1}')
    rm -rf "$_hbtmp"
    echo "host reference (computed): $HOST_REF_MD5" >&2
fi

TMP=$(mktemp -d)
echo "TMP=$TMP" >&2

# uf2 -> bin (for initial flash)
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

flash_kernel() {
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset halt" \
        -c "program $TMP/kernel.bin 0x10000000 verify" \
        -c "exit" > "$TMP/oocd.log" 2>&1
    grep -q "Verified OK" "$TMP/oocd.log" || { tail -20 "$TMP/oocd.log" >&2; exit 1; }
    # programming halts the cores; we need a separate reset run to
    # actually start the kernel.
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" \
        > /dev/null 2>&1
}

reset_only() {
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" \
        > /dev/null 2>&1
}

run_step() {
    local step_path="$1" deadline_marker="$2"
    local LOG="$TMP/uart_$(basename "$step_path" .sh).log"
    stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
    (cat "$UART_PORT" > "$LOG" 2>&1) &
    local CATPID=$!
    sleep 0.5
    python3 -c "
import sys, os, time
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
        if grep -q "msh: spawn failed" "$LOG" 2>/dev/null; then break; fi
        sleep 5
    done
    sleep 2
    kill -9 "$CATPID" 2>/dev/null || true
    cat "$LOG"
}

echo "=== Initial flash ===" >&2
flash_kernel
sleep 4

# Step 0: optional — refresh /sd/{runtime,libtc,kc,bf,bs,tf,ff,
# mf,pf,vf,ld,kp}.s by recompiling each module on the device. Run
# when any of the upstream .tc changes invalidate /sd cache (e.g.
# fatfs.tc grow fix shipped in commit 773b746); skip otherwise to
# save ~25 min. Pass REFRESH_KERN_MODS=1 to enable.
if [ "${REFRESH_KERN_MODS:-0}" = "1" ]; then
    echo "=== Step 0a: refresh runtime.s on /sd ===" >&2
    run_step /pico2_compile_runtime.sh COMPILE_RUNTIME_DONE
    echo "=== Reset + Step 0b: refresh libtc.s on /sd ===" >&2
    reset_only
    sleep 4
    run_step /pico2_compile_libtc.sh COMPILE_LIBTC_DONE
    echo "=== Reset + Step 0c: refresh kernel-leaf .s on /sd ===" >&2
    reset_only
    sleep 4
    run_step /pico2_compile_kern.sh COMPILE_KERN_LEAVES_DONE
    echo "=== Reset + Step 0d: refresh kernel-import .s on /sd ===" >&2
    reset_only
    sleep 4
    run_step /pico2_compile_kern2.sh COMPILE_KERN2_DONE
    echo "=== Reset before Step 1 ===" >&2
    reset_only
    sleep 4
fi

echo "=== Step 1: cat → /sd/full.s ===" >&2
run_step /pico2_link_kernel_step1.sh STEP1_DONE

echo "=== Reset + Step 2: asm_pass2 → /sd/full.lab ===" >&2
reset_only
sleep 4
run_step /pico2_link_kernel_step2.sh STEP2_DONE

echo "=== Reset + Step 3: asm_pass3 → /sd/kernel_nodisk.bin ===" >&2
reset_only
sleep 4
run_step /pico2_link_kernel_step3.sh STEP3_DONE

DEV_MD5=$(grep -oE '^[0-9a-f]{32}  /sd/knod\.bin' "$TMP"/uart_*step3*.log | awk '{print $1}' | tail -1)
echo
echo "host reference md5: $HOST_REF_MD5"
echo "device produced md5: ${DEV_MD5:-<missing>}"
if [ "$DEV_MD5" = "$HOST_REF_MD5" ]; then
    echo "MATCH — pico2 self-built kernel.bin (no-disk) is byte-exact."
    exit 0
else
    echo "DIFFER — see $TMP/uart_*.log"
    exit 1
fi
