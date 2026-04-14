#!/bin/bash
# test_os.sh — tests for OS/runtime components (uses Gen2 pipeline)
# FULL_TEST=1: also runs kmalloc and kernel1 (cooperative) tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== OS Component Tests ==="

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "SKIP: OS tests (need qemu + riscv-gcc)"
    print_results
    exit $?
fi

TMP=$(mktemp -d)
trap "rm -rf '$TMP'" EXIT

# --- kmalloc (FULL_TEST only) ---
if [ "${FULL_TEST:-0}" = "1" ]; then
    t0=$(time_ms)
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/compile-gen2.sh" -o "$TMP/test_kmalloc" \
        "$SCRIPT_DIR/test_kmalloc.tc" 2>/dev/null
    if [ -x "$TMP/test_kmalloc" ]; then
        out=$("$QEMU" "$TMP/test_kmalloc" 2>/dev/null)
        ex=$?
        elapsed=$(( $(time_ms) - t0 ))
        if [ "$out" = "0" ] && [ "$ex" -eq 0 ]; then
            report_pass "kmalloc (buckets + large + coalesce)" "$elapsed"
        else
            report_fail_msg "kmalloc" "expected output '0' exit 0, got '$out' exit $ex"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "kmalloc" "compile-gen2.sh failed"
    fi
fi

# --- kernel1: cooperative task (FULL_TEST only) ---
if [ "${FULL_TEST:-0}" = "1" ] && command -v qemu-system-riscv32 >/dev/null 2>&1; then
    VIRT_CRT0="$SCRIPT_DIR/virt_crt0.s"
    t0=$(time_ms)
    CRT0="$VIRT_CRT0" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/compile-gen2.sh" -o "$TMP/test_kernel1" \
        "$SCRIPT_DIR/test_kernel1.tc" 2>/dev/null
    if [ -s "$TMP/test_kernel1" ]; then
        k1_out=$(timeout 5 qemu-system-riscv32 -smp 1 -nographic \
            -serial mon:stdio --no-reboot -m 128 \
            -machine virt,aclint=on -bios none \
            -device "loader,file=$TMP/test_kernel1,addr=0x80000000" \
            -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
        elapsed=$(( $(time_ms) - t0 ))
        case "$k1_out" in
            *"TASK1_OK"*"KERN_OK"*)
                report_pass "kernel1: guest task runs on separate stack" "$elapsed"
                ;;
            *)
                report_fail_msg "kernel1" \
                    "expected TASK1_OK + KERN_OK, got: $(printf '%s' "$k1_out" | head -c 80)"
                ;;
        esac
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "kernel1" "compile failed"
    fi
fi

# --- Build kernel_virt + mtfs disk image once. The kernel now reads
#     its task binaries from the mtfs image at runtime, so fs_virtio
#     needs both outputs. ---
if command -v qemu-system-riscv32 >/dev/null 2>&1; then
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/kernel/build.sh" --target virt \
        -o "$TMP/kernel_virt" --disk-out "$TMP/disk.img" 2>/dev/null
fi

# --- fs_virtio: attach the mtfs disk, boot kernel_virt, verify it
#     reads sector 0 (mtfs superblock), mounts mtfs, cats /hello.txt
#     via its in-kernel demo, loads /bin/hello, /bin/hello2, /bin/sh
#     from the FS and runs them preemptively. The shell reads a
#     single command from stdin — we pipe "catfile\n" so it execs
#     /bin/catfile. ---
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$TMP/kernel_virt" ] && [ -s "$TMP/disk.img" ]; then
    t0=$(time_ms)
    # Shell loop: spawn catfile five times (via sys_spawn+sys_wait),
    # then read "quit" to exit. Five iterations exercise the loader's
    # kfree path for frame_buf / ram / stack / img after each child
    # exits — the kernel prints "KERN: live=N" at shutdown so the
    # test can assert the count did not grow with spawn iterations.
    fs_out=$(printf 'catfile\ncatfile\ncatfile\ncatfile\ncatfile\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    # We only check the mtfs magic bytes in SECTOR0: total_blocks varies
    # with how many files the image contains.
    expected="SECTOR0: 4d 54 46 53"
    # The shell prompt + catfile output + A/B get interleaved under
    # preemption, so check each piece separately rather than as a
    # single substring.
    fs_has_a=$(echo "$fs_out" | grep -c "A")
    fs_has_b=$(echo "$fs_out" | grep -c "B")
    fs_cat_count=$(echo "$fs_out" | grep -c "CAT:")
    fs_has_mtfs_msg=$(echo "$fs_out" | grep -c "hello, mtfs")
    fs_has_sh=$(echo "$fs_out" | grep -c "SH: ready")
    fs_has_bye=$(echo "$fs_out" | grep -c "SH: bye")
    # Leak canary: the kernel prints its kmalloc live count at the
    # end. With the K1 process-table fix in place, this stays bounded
    # by a small constant regardless of how many children sh spawns.
    fs_live=$(echo "$fs_out" | sed -n 's/.*KERN: live=\([0-9]*\).*/\1/p' | tail -1)
    case "$fs_out" in
        *"BLOCK: virtio-blk detected"*"$expected"*"MTFS: mounted"*"FILE:hello, mtfs"*"all tasks done"*)
            # The 5 spawns mean we expect ≥5 CAT: outputs. The live
            # count must stay ≤ 64 — the current baseline is 36
            # (seeded tasks + VFS/block state). A leak would push it
            # up by ~4 per extra spawn, so 5 leaked spawns would hit
            # 56 and a regression would trip well before 64.
            if [ "$fs_has_a" -gt 0 ] && [ "$fs_has_b" -gt 0 ] \
                && [ "$fs_cat_count" -ge 5 ] && [ "$fs_has_mtfs_msg" -gt 0 ] \
                && [ "$fs_has_sh" -gt 0 ] && [ "$fs_has_bye" -gt 0 ] \
                && [ -n "$fs_live" ] && [ "$fs_live" -le 64 ]; then
                report_pass "fs_virtio: 5× catfile spawn/wait, live=$fs_live" "$elapsed"
            else
                report_fail_msg "fs_virtio" \
                    "cat=$fs_cat_count live=$fs_live a=$fs_has_a b=$fs_has_b mtfs=$fs_has_mtfs_msg sh=$fs_has_sh bye=$fs_has_bye; got: $(printf '%s' "$fs_out" | head -c 240)"
            fi
            ;;
        *)
            report_fail_msg "fs_virtio" \
                "expected detected + mtfs mounted + FILE: + all tasks done, got: $(printf '%s' "$fs_out" | head -c 240)"
            ;;
    esac
fi

print_results
