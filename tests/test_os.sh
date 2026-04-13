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

# --- Build kernel_virt once (shared by kernel_preempt + fs_virtio tests) ---
if command -v qemu-system-riscv32 >/dev/null 2>&1; then
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/kernel/build.sh" --target virt -o "$TMP/kernel_virt" 2>/dev/null
fi

# --- kernel_preempt: tasks run with no disk attached (FULL_TEST only).
#     The "with-disk + catfile" path is covered by fs_virtio below and
#     provides the primary preemption signal in make test. ---
if [ "${FULL_TEST:-0}" = "1" ] && command -v qemu-system-riscv32 >/dev/null 2>&1 \
    && [ -s "$TMP/kernel_virt" ]; then
    t0=$(time_ms)
    kv_out=$(timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    has_a=$(echo "$kv_out" | grep -c "A")
    has_b=$(echo "$kv_out" | grep -c "B")
    case "$kv_out" in
        *"all tasks done"*)
            if [ "$has_a" -gt 0 ] && [ "$has_b" -gt 0 ]; then
                report_pass "kernel_preempt: timer preempts tasks (no disk)" "$elapsed"
            else
                report_fail_msg "kernel_preempt" \
                    "expected interleaved A+B, got: $(printf '%s' "$kv_out" | head -c 120)"
            fi
            ;;
        *)
            report_fail_msg "kernel_preempt" \
                "expected 'all tasks done', got: $(printf '%s' "$kv_out" | head -c 120)"
            ;;
    esac
fi

# --- fs_virtio_sector0: reuse kernel build, attach a mtfs disk image,
#     check the kernel reads sector 0 (= mtfs superblock) via block_virtio.tc
if command -v qemu-system-riscv32 >/dev/null 2>&1 && [ -s "$TMP/kernel_virt" ]; then
    t0=$(time_ms)
    printf 'hello, mtfs\n' > "$TMP/hello.txt"
    python3 "$ROOT_DIR/tools/mkfs.py" "$TMP/disk.img" "$TMP/hello.txt" 2>/dev/null
    fs_out=$(timeout 10 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
        -device "virtio-blk-device,drive=blk0" \
        -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
    elapsed=$(( $(time_ms) - t0 ))
    # mkfs.py with one small file → total_blocks = 3 (sb + 1 inode block + 1 data block)
    expected="SECTOR0: 4d 54 46 53 01 00 00 00 00 02 00 00 03 00 00 00"
    # catfile's "CAT:<contents>" can be interleaved with A/B from the other
    # tasks under preemption, so check each piece separately rather than as
    # a single substring.
    fs_has_a=$(echo "$fs_out" | grep -c "A")
    fs_has_b=$(echo "$fs_out" | grep -c "B")
    fs_has_cat=$(echo "$fs_out" | grep -c "CAT:")
    fs_has_mtfs_msg=$(echo "$fs_out" | grep -c "hello, mtfs")
    case "$fs_out" in
        *"BLOCK: virtio-blk detected"*"$expected"*"MTFS: mounted"*"FILE:hello, mtfs"*"all tasks done"*)
            if [ "$fs_has_a" -gt 0 ] && [ "$fs_has_b" -gt 0 ] \
                && [ "$fs_has_cat" -gt 0 ] && [ "$fs_has_mtfs_msg" -gt 0 ]; then
                report_pass "fs_virtio: mtfs mount + read + preempt (hello/hello2/catfile)" "$elapsed"
            else
                report_fail_msg "fs_virtio" \
                    "missing CAT:/A/B/mtfs contents, got: $(printf '%s' "$fs_out" | head -c 240)"
            fi
            ;;
        *)
            report_fail_msg "fs_virtio" \
                "expected detected + mtfs mounted + FILE: + all tasks done, got: $(printf '%s' "$fs_out" | head -c 240)"
            ;;
    esac
fi

print_results
