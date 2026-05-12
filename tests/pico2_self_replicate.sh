#!/bin/bash
# pico2_self_replicate.sh — end-to-end pico2 self-replication of
# its own UF2. Steps 1-3 link kernel.bin from on-device sources +
# /sd/dx.img (auto-dumped at boot from the running kernel's mtfs);
# step 4 wraps it into UF2. Compares the result to a fresh host
# build of pico2_kernel_extra.uf2 byte-for-byte.

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/build/kernel/pico2_kernel_extra.uf2}"
OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

TMP=$(mktemp -d)
echo "TMP=$TMP" >&2

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

# Freeze the host reference at orchestrator start: copy the current
# build/kernel/disk-extra.img + rebuild kernel.bin from current
# sources. The host disk-extra.img must match the one embedded in
# $KERNEL_UF2 (and therefore the /sd/dx.img the device dumps).
# That's true unless someone rebuilds the disk between flashing
# the UF2 and running this orchestrator — make sure your tree is
# clean before kicking it off.
cp "$ROOT/build/kernel/disk-extra.img" "$TMP/disk-extra.img"
# Use bin2s_incbin.sh (matches the on-device dumper's wrap.s shape)
# with `dx.img` as the literal incbin path. asm_pass2 emits the
# basename to the .lab, asm_pass3 resolves relative to the .lab's
# dir — so we also have to drop a sibling `dx.img` next to the lab
# in compile-gen2's intermediate dir (see HOST_LAB_DIR below).
"$ROOT/kernel/bin2s_incbin.sh" "$TMP/disk-extra.img" _mtfs_image dx.img > "$TMP/wrap.s" 2>/dev/null
cat "$ROOT/kernel/platform_pico2.s" "$ROOT/kernel/trap_common.s" > "$TMP/host_crt0.s"
cat "$ROOT/kernel/crt0_pico2_data.s" "$TMP/wrap.s" > "$TMP/host_data.s"
# Where compile-gen2.sh keeps its intermediates for this .tc.
HOST_LAB_DIR="$ROOT/build/intermediate/gen2/kernel_pico2"
mkdir -p "$HOST_LAB_DIR"
cp "$TMP/disk-extra.img" "$HOST_LAB_DIR/dx.img"
# INPUT_NAMES + PRELUDE_NAME align the host intermediate basenames
# (prelude.tx, in_0.tx, ...) with the on-device fixture names
# (p.tx, kc.tx, pp.tx, bf.tx, ...) so the resulting .lab is byte-
# identical between host and device.
CRT0="$TMP/host_crt0.s" CRT0_DATA="$TMP/host_data.s" ASM_PROLOGUE="; raw" \
    GEN2_DIR="$ROOT/build/gen2" \
    CACHED_S_DIR="$ROOT/build/kernel/shared" \
    PRELUDE_NAME="p" \
    INPUT_NAMES="kc pp bf bs ff mf tf pf vf ld kp pt" \
    "$ROOT/compile-gen2.sh" -o "$TMP/host_k.bin" \
    "$ROOT/kernel/kernel_pico2.tc" 2>/dev/null
# Phase 8: TC port runs via qemu-riscv32 instead of python3.
qemu-riscv32 "$ROOT/build/gen2/bin2uf2" "$TMP/host_k.bin" "$TMP/host_k.uf2" >/dev/null
HOST_BIN_MD5=$(md5sum "$TMP/host_k.bin" | awk '{print $1}')
HOST_UF2_MD5=$(md5sum "$TMP/host_k.uf2" | awk '{print $1}')
echo "frozen host kernel.bin md5: $HOST_BIN_MD5" >&2
echo "frozen host kernel.uf2 md5: $HOST_UF2_MD5" >&2

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
sleep 6  # extra time for boot-time dumper to write /sd/dx.img

# Optional Step 0: refresh the on-/sd kernel-module .s files.
# Needed when kernel/*.tc has changed since /sd was last seeded
# — otherwise the link mixes new dumper code with stale fatfs.s
# etc and the resulting kernel.bin won't match the host build.
# REFRESH_KERN_MODS=1 to enable; default off (assumes /sd is fresh).
if [ "${REFRESH_KERN_MODS:-0}" = "1" ]; then
    echo "=== Step 0a: refresh runtime.s on /sd ===" >&2
    run_step /pico2_compile_runtime.sh COMPILE_RUNTIME_DONE
    echo "=== Reset + Step 0b: refresh libtc.s on /sd ===" >&2
    reset_only; sleep 4
    run_step /pico2_compile_libtc.sh COMPILE_LIBTC_DONE
    echo "=== Reset + Step 0c: refresh kernel-leaf .s on /sd ===" >&2
    reset_only; sleep 4
    run_step /pico2_compile_kern.sh COMPILE_KERN_LEAVES_DONE
    echo "=== Reset + Step 0d: refresh platform_pico2.s on /sd ===" >&2
    reset_only; sleep 4
    run_step /pico2_compile_platform.sh COMPILE_PLATFORM_DONE
    echo "=== Reset + Step 0e: refresh kernel-import .s on /sd ===" >&2
    reset_only; sleep 4
    run_step /pico2_compile_kern2.sh COMPILE_KERN2_DONE
    echo "=== Reset before Step 1 ===" >&2
    reset_only; sleep 4
fi

echo "=== Step 1: cat → /sd/full.s (with /sd/dx.img blob) ===" >&2
run_step /pico2_self_step1.sh SELF_STEP1_DONE

echo "=== Reset + Step 2: asm_pass2 → /sd/full.lab ===" >&2
reset_only
sleep 4
# Per-file pre-encode (asm_pass1 per .s + asm_pass2 merge), matching
# compile-gen2.sh's host pipeline shape. Walked-source mode was
# retired 2026-05-11 when K14 finished — see docs/solved.md.
run_step /pico2_self_step2.sh SELF_STEP2_DONE

echo "=== Reset + Step 3: asm_pass3 → /sd/k.bin ===" >&2
reset_only
sleep 4
run_step /pico2_self_step3.sh SELF_STEP3_DONE

echo "=== Reset + Step 4: bin2uf2 → /sd/k.uf2 ===" >&2
reset_only
sleep 4
run_step /pico2_self_step4.sh SELF_STEP4_DONE

DEV_BIN_MD5=$(grep -oE '^[0-9a-f]{32}  /sd/k\.bin' "$TMP"/uart_*step3*.log | awk '{print $1}' | tail -1)
DEV_UF2_MD5=$(grep -oE '^[0-9a-f]{32}  /sd/k\.uf2' "$TMP"/uart_*step4*.log | awk '{print $1}' | tail -1)

echo
echo "host kernel.bin md5: $HOST_BIN_MD5"
echo "device k.bin md5:    ${DEV_BIN_MD5:-<missing>}"
echo "host kernel.uf2 md5: $HOST_UF2_MD5"
echo "device k.uf2 md5:    ${DEV_UF2_MD5:-<missing>}"
status=0
if [ "$DEV_BIN_MD5" != "$HOST_BIN_MD5" ]; then
    echo "kernel.bin DIFFERS"; status=1
else
    echo "kernel.bin MATCH"
fi
if [ "$DEV_UF2_MD5" != "$HOST_UF2_MD5" ]; then
    echo "kernel.uf2 DIFFERS"; status=1
else
    echo "kernel.uf2 MATCH — pico2 self-replicated its own UF2."
fi
exit $status
