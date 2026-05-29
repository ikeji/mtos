#!/bin/bash
# pico2_self_replicate.sh — end-to-end pico2 self-replication of
# its own UF2. Steps 1-3 link kernel.bin from on-device sources +
# /sd/dx.img (auto-dumped at boot from the running kernel's mtfs);
# step 4 wraps it into UF2. Compares the result to a fresh host
# build of pico2_kernel_extra.uf2 byte-for-byte.

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Source the manifest so INPUT_NAMES and (eventually) the device
# fixtures share a single source of truth. See
# integration/scripts/self_replicate_modules.sh.
# shellcheck source=scripts/self_replicate_modules.sh
source "$ROOT/integration/scripts/self_replicate_modules.sh"
KERNEL_UF2="${KERNEL_UF2:-$ROOT/kernel/build/pico2_kernel_extra.uf2}"
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
# kernel/build/disk-extra.img + rebuild kernel.bin from current
# sources. The host disk-extra.img must match the one embedded in
# $KERNEL_UF2 (and therefore the /sd/dx.img the device dumps).
# That's true unless someone rebuilds the disk between flashing
# the UF2 and running this orchestrator — make sure your tree is
# clean before kicking it off.
cp "$ROOT/kernel/build/disk-extra.img" "$TMP/disk-extra.img"
# Use bin2s_incbin.sh (matches the on-device dumper's wrap.s shape)
# with `dx.img` as the literal incbin path. asm_pass2 emits the
# basename to the .lab, asm_pass3 resolves relative to the .lab's
# dir — so we also have to drop a sibling `dx.img` next to the lab
# in compile-gen2's intermediate dir (see HOST_LAB_DIR below).
"$ROOT/userland/scripts/bin2s_incbin.sh" "$TMP/disk-extra.img" _mtfs_image dx.img > "$TMP/wrap.s" 2>/dev/null
# Mirror the on-device per-file layout: device step2 uses raw,
# platform, trap, runtime, kc, pp, ..., kp, cd, wrap as separate
# asm_pass1 inputs (17 total). compile-gen2.sh names each idx after
# the basename of the source file, so we have to drop short-named
# copies into $TMP and feed those to CRT0 / CRT0_DATA. Concatenating
# into host_crt0.s / host_data.s used to be fine but breaks
# byte-exactness now that asm_pass2's .lab emits per-input src lines.
cp "$ROOT/kernel/platform/pico2/platform_pico2.s"  "$TMP/platform.s"
cp "$ROOT/kernel/src/trap_common.s"                "$TMP/trap.s"
cp "$ROOT/kernel/platform/pico2/crt0_pico2_data.s" "$TMP/cd.s"
# Where compile-gen2.sh keeps its intermediates for this .tc.
HOST_LAB_DIR="$ROOT/build/intermediate/gen2/kernel_pico2"
mkdir -p "$HOST_LAB_DIR"
cp "$TMP/disk-extra.img" "$HOST_LAB_DIR/dx.img"
# INPUT_NAMES + PRELUDE_NAME align the host intermediate basenames
# (p.tx, kc.tx, pp.tx, bf.tx, ...) with the on-device fixture names
# so the resulting .lab is byte-identical between host and device.
CRT0="$TMP/platform.s $TMP/trap.s" \
    CRT0_DATA="$TMP/cd.s $TMP/wrap.s" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$ROOT/compiler/build/gen2" \
    CACHED_S_DIR="$ROOT/userland/build/shared" \
    PRELUDE_NAME="p" \
    INPUT_NAMES="$(module_short_names)" \
    "$ROOT/compiler/scripts/compile-gen2.sh" -o "$TMP/host_k.bin" \
    "$ROOT/kernel/src/kernel_pico2.tc" 2>/dev/null
# Phase 8: TC port runs via qemu-riscv32 instead of python3.
qemu-riscv32 "$ROOT/compiler/build/gen2/bin2uf2" "$TMP/host_k.bin" "$TMP/host_k.uf2" >/dev/null
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
sleep 4  # boot to sh ready

# Stage /sd/dx.img via mr -a (ACK mode) over UART. Replaces the
# boot-time dump_mtfs_to_sd path that used to run inside the kernel
# (removed for boot speed — boot is now < 1 s).
# The host's $TMP/disk-extra.img matches the .incbin in the running
# kernel, so dx.img + the kernel agree byte-for-byte.
# ~6 min for the full 3.5 MB at 10.9 KB/s. Skip when /sd/dx.img md5
# already matches.
echo "=== Stage /sd/dx.img via mr -a ===" >&2
HOST_DX_MD5=$(md5sum "$TMP/disk-extra.img" | awk '{print $1}')
HOST_DX_SIZE=$(stat -c%s "$TMP/disk-extra.img")
echo "host dx.img md5=$HOST_DX_MD5 size=$HOST_DX_SIZE" >&2

# Run a UART command via sh and capture the output. Stops the
# capture as soon as `done_marker` appears, so a fast no-op
# (e.g. ls on a missing file) doesn't block on a hardcoded sleep.
run_sh_cmd() {
    local cmd="$1" done_marker="$2" timeout_s="${3:-30}"
    local LOG="$TMP/uart_$(echo "$cmd" | tr -c '[:alnum:]' '_').log"
    stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
    (cat "$UART_PORT" > "$LOG" 2>&1) &
    local CATPID=$!
    sleep 0.5
    python3 -c "
import os, time
fd = os.open('$UART_PORT', os.O_WRONLY)
for c in (\"$cmd\" + '\n').encode():
    os.write(fd, bytes([c]))
    time.sleep(0.01)
os.close(fd)
"
    local deadline=$(( $(date +%s) + timeout_s ))
    while [ "$(date +%s)" -lt "$deadline" ]; do
        if grep -qF "$done_marker" "$LOG" 2>/dev/null; then break; fi
        sleep 1
    done
    sleep 0.5
    kill -9 "$CATPID" 2>/dev/null || true
    cat "$LOG"
}

# Always re-upload (~6 min). Previously tried to skip when
# /sd/dx.img matched, but probing via wc / md5sum walks the entire
# 3.5 MB at SD speed (100+ s) — slower than just re-uploading, AND
# leaves the wc task running in sh which then blocks our mr spawn.
# SKIP_DX_UPLOAD=1 lets the user opt out when they know /sd/dx.img
# is already current (e.g. immediately after a successful run).
if [ "${SKIP_DX_UPLOAD:-0}" = "1" ]; then
    echo "SKIP_DX_UPLOAD=1 — assuming /sd/dx.img already matches" >&2
else
    echo "uploading dx.img (~$((HOST_DX_SIZE / 1024)) KB at ~10.9 KB/s, ~6 min)" >&2
    # mr_upload.py spawns `mr -a > /sd/dx.img` itself, waits for the
    # startup ACK, then sends ACK-gated 512-byte frames. The ACK
    # handshake stops the host streaming during mr's M-mode
    # fatfs_write window, sidestepping K11 (PL011 RX FIFO overflow).
    python3 "$ROOT/integration/scripts/mr_upload.py" \
        --port "$UART_PORT" \
        --chunk-size 512 --ack-timeout 60 \
        --spawn-cmd "mr -a > /sd/dx.img" \
        "$TMP/disk-extra.img"
    # mr_upload.py reports "upload complete: N bytes" only after all
    # ACK-gated frames + the end-marker ACK have round-tripped, so a
    # silent corruption is unlikely. Skipping the post-upload wc/md5
    # check on purpose — both walk the full 3.5 MB at SD speed (100+
    # s) and reliably time out the run_sh_cmd window. The byte-exact
    # .lab/.bin checks at Step 2/3 will catch any content drift with
    # a precise error.
    echo "mr upload reported success (trust mr_upload's ACK count)" >&2
fi

# Optional /sd cleanup. After multiple bench / self_replicate runs
# the SD card accumulates ~30+ transient intermediate files in the
# root directory; with REFRESH_KERN_MODS=1 NORESET=1 this can saturate
# fatfs's root-dir capacity and break Step 2 with "cannot open bin/
# reloc output". CLEAN_SD=1 runs pico2_cleanup_sd.sh first which
# `rm -f`s all known transient names but keeps /sd/dx.img + /sd/wrap.s
# (boot regenerates them) and kernel module .s files (REFRESH replaces
# them).
if [ "${CLEAN_SD:-0}" = "1" ]; then
    echo "=== Cleanup: rm transient files from /sd ===" >&2
    run_step /pico2_cleanup_sd.sh CLEANUP_DONE
    if [ "${NORESET:-0}" != "1" ]; then
        reset_only; sleep 4
    fi
fi

# Optional Step 0: refresh the on-/sd kernel-module .s files.
# Needed when kernel/*.tc has changed since /sd was last seeded
# — otherwise the link mixes new dumper code with stale fatfs.s
# etc and the resulting kernel.bin won't match the host build.
# REFRESH_KERN_MODS=1 to enable; default off (assumes /sd is fresh).
# NORESET=1: skip the `reset_only` calls between steps. Verifies that
# the kernel can run the entire self_replicate pipeline in a single
# boot. Possible after commits 688e4ef/49ae455/0c1b800/afbf12a
# eliminated kernel arena fragmentation + freed ~48 KB of sh/msh
# headroom (see docs/scaling.md Q1). Falls back to per-step resets
# when unset (the historical default).
maybe_reset() {
    if [ "${NORESET:-0}" != "1" ]; then
        reset_only
        sleep 4
    fi
}

if [ "${REFRESH_KERN_MODS:-0}" = "1" ]; then
    echo "=== Step 0a: refresh runtime.s on /sd ===" >&2
    run_step /pico2_compile_runtime.sh COMPILE_RUNTIME_DONE
    echo "=== Step 0b: refresh libtc.s on /sd ===" >&2
    maybe_reset
    run_step /pico2_compile_libtc.sh COMPILE_LIBTC_DONE
    echo "=== Step 0c: refresh kernel-leaf .s on /sd ===" >&2
    maybe_reset
    run_step /pico2_compile_kern.sh COMPILE_KERN_LEAVES_DONE
    echo "=== Step 0d: refresh platform_pico2.s on /sd ===" >&2
    maybe_reset
    run_step /pico2_compile_platform.sh COMPILE_PLATFORM_DONE
    echo "=== Step 0e: refresh kernel-import .s on /sd ===" >&2
    maybe_reset
    run_step /pico2_compile_kern2.sh COMPILE_KERN2_DONE
    echo "=== Before Step 1 ===" >&2
    maybe_reset
fi

echo "=== Step 1: cat → /sd/full.s (with /sd/dx.img blob) ===" >&2
run_step /pico2_self_step1.sh SELF_STEP1_DONE

echo "=== Step 2: asm_pass2 → /sd/full.lab ===" >&2
maybe_reset
# Per-file pre-encode (asm_pass1 per .s + asm_pass2 merge), matching
# compile-gen2.sh's host pipeline shape. Walked-source mode was
# retired 2026-05-11 when K14 finished — see docs/solved.md.
run_step /pico2_self_step2.sh SELF_STEP2_DONE

echo "=== Step 3: asm_pass3 → /sd/k.bin ===" >&2
maybe_reset
run_step /pico2_self_step3.sh SELF_STEP3_DONE

echo "=== Step 4: bin2uf2 → /sd/k.uf2 ===" >&2
maybe_reset
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
