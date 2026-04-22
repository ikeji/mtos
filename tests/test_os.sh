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

# --- Kernel + mtfs disk image: the Make build owns these now
#     (build/kernel/virt_kernel.bin + build/kernel/disk.img). This
#     script is run via `make test`, which ensures they are up to
#     date. When someone invokes this script standalone without
#     the Make wrapper, fall back to building into a local tmp
#     directory. ---
KERNEL_BIN="$ROOT_DIR/build/kernel/virt_kernel.bin"
KERNEL_DISK="$ROOT_DIR/build/kernel/disk.img"
if [ ! -s "$KERNEL_BIN" ] || [ ! -s "$KERNEL_DISK" ]; then
    if command -v qemu-system-riscv32 >/dev/null 2>&1; then
        GEN2_DIR="$_GEN2_TMP" \
            "$ROOT_DIR/kernel/build.sh" --target virt \
            -o "$TMP/kernel_virt" --disk-out "$TMP/disk.img" 2>/dev/null
        KERNEL_BIN="$TMP/kernel_virt"
        KERNEL_DISK="$TMP/disk.img"
    fi
fi

# --- fs_virtio: attach the mtfs disk, boot kernel_virt, verify it
#     reads sector 0 (mtfs superblock), mounts mtfs, cats /hello.txt
#     via its in-kernel demo, loads /bin/sh from the FS and drives it
#     through a scripted command sequence to cover tmpfs / argv /
#     redirect + spawn/wait leak accounting. ---
if command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$KERNEL_BIN" ] && [ -s "$KERNEL_DISK" ]; then
    t0=$(time_ms)
    # Shell loop exercises all phase 7 A/B/D prereqs:
    #   - tmpdemo:                tmpfs write path (phase 7 A)
    #   - catfile:                default argv (kernel argv clone)
    #   - catfile /hello.txt:     explicit argv path
    #   - echo hi > /tmp/redir:   sh stdout redirection (phase 7 D)
    #   - catfile /tmp/redir:     reads redirected content back
    # then quit. Six spawn cycles are enough to exercise the loader's
    # kfree path for frame_buf / ram / stack / img / argv / stdio fds;
    # the kernel prints "KERN: live=N" at shutdown so the test asserts
    # the count stays bounded regardless of spawn iterations.
    fs_out=$(printf 'tmpdemo\ncatfile\ncatfile /hello.txt\necho hi > /tmp/redir\ncatfile /tmp/redir\nquit\n' \
        | timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$KERNEL_DISK,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$KERNEL_BIN,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    # We only check the mtfs magic bytes in SECTOR0: total_blocks varies
    # with how many files the image contains.
    expected="SECTOR0: 4d 54 46 53"
    # The shell prompt + catfile output interleave under preemption,
    # so check each piece separately rather than as a single substring.
    # catfile prints "CAT[<argc>]:" so we can distinguish default runs
    # (argc=1) from explicit-argv runs (argc=2).
    fs_cat_count=$(echo "$fs_out" | grep -c 'CAT\[')
    fs_cat1_count=$(echo "$fs_out" | grep -c 'CAT\[1\]:')
    fs_cat2_count=$(echo "$fs_out" | grep -c 'CAT\[2\]:')
    fs_has_mtfs_msg=$(echo "$fs_out" | grep -c "hello, mtfs")
    fs_has_tmpfs_ok=$(echo "$fs_out" | grep -c "TMPFS_OK")
    fs_has_tmpfs_payload=$(echo "$fs_out" | grep -c "TMP:hello tmpfs")
    # Redirect check: echo hi > /tmp/redir writes "hi\n" to tmpfs
    # (no CAT: prefix because the byte stream is redirected away
    # from the UART), and catfile /tmp/redir prints "CAT[2]:hi".
    fs_has_redir=$(echo "$fs_out" | grep -c 'CAT\[2\]:hi')
    fs_has_sh=$(echo "$fs_out" | grep -c "SH: ready")
    fs_has_bye=$(echo "$fs_out" | grep -c "SH: bye")
    # Leak canary: the kernel prints its kmalloc live count at the
    # end. With the K1 process-table fix in place, this stays bounded
    # by a small constant regardless of how many children sh spawns.
    fs_live=$(echo "$fs_out" | sed -n 's/.*KERN: live=\([0-9]*\).*/\1/p' | tail -1)
    case "$fs_out" in
        *"BLOCK: virtio-blk detected"*"$expected"*"MTFS: mounted"*"FILE:hello, mtfs"*"all tasks done"*)
            # The 5 catfile spawns mean we expect ≥5 CAT: outputs.
            # The live count must stay ≤ 96 — the current baseline
            # is ~67 (seeded tasks + VFS/block state + mtfs inode
            # cache + TmpFileArray(16)/TmpfsFDArray(8) struct slots
            # + the persistent /tmp/demo file + per-slot task name
            # U8Arrays). A per-spawn leak would push it up by ~4
            # per extra spawn, so 5 leaks would reach ~91 and a
            # regression would trip before 105.
            if [ "$fs_cat_count" -ge 3 ] && [ "$fs_cat1_count" -ge 1 ] \
                && [ "$fs_cat2_count" -ge 2 ] && [ "$fs_has_mtfs_msg" -gt 0 ] \
                && [ "$fs_has_tmpfs_ok" -gt 0 ] && [ "$fs_has_tmpfs_payload" -gt 0 ] \
                && [ "$fs_has_redir" -gt 0 ] \
                && [ "$fs_has_sh" -gt 0 ] && [ "$fs_has_bye" -gt 0 ] \
                && [ -n "$fs_live" ] && [ "$fs_live" -le 105 ]; then
                report_pass "fs_virtio: tmpdemo + catfile argv + redirect, live=$fs_live" "$elapsed"
            else
                report_fail_msg "fs_virtio" \
                    "cat=$fs_cat_count cat1=$fs_cat1_count cat2=$fs_cat2_count tmpok=$fs_has_tmpfs_ok tmppayload=$fs_has_tmpfs_payload redir=$fs_has_redir live=$fs_live mtfs=$fs_has_mtfs_msg sh=$fs_has_sh bye=$fs_has_bye; got: $(printf '%s' "$fs_out" | head -c 480)"
            fi
            ;;
        *)
            report_fail_msg "fs_virtio" \
                "expected detected + mtfs mounted + FILE: + all tasks done, got: $(printf '%s' "$fs_out" | head -c 240)"
            ;;
    esac
fi

print_results
