#!/bin/bash
# test_os.sh — tests for OS/runtime components (uses Gen2 pipeline)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== OS Component Tests ==="

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "SKIP: OS tests (need qemu + riscv-gcc)"
    print_results
    exit $?
fi

# --- kmalloc: alloc/free/coalesce/buckets via array operations ---
TMP=$(mktemp -d)
trap "rm -rf '$TMP'" EXIT

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

# --- kernel1: single cooperative guest task on separate stack ---
if command -v qemu-system-riscv32 >/dev/null 2>&1; then
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

# --- kernel_ecall: embedded task binary with ecall syscalls ---
if command -v qemu-system-riscv32 >/dev/null 2>&1; then
    t0=$(time_ms)
    GEN2_DIR="$_GEN2_TMP" \
        "$ROOT_DIR/kernel/build_virt.sh" -o "$TMP/kernel_virt" 2>/dev/null
    if [ -s "$TMP/kernel_virt" ]; then
        kv_out=$(timeout 5 qemu-system-riscv32 -smp 1 -nographic \
            -serial mon:stdio --no-reboot -m 128 \
            -machine virt,aclint=on -bios none \
            -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
            -device "loader,addr=0x80000000,cpu-num=0" 2>/dev/null | tr -d '\0')
        elapsed=$(( $(time_ms) - t0 ))
        case "$kv_out" in
            *"HELLO"*"task 1 done"*"WORLD"*"task 2 done"*)
                report_pass "kernel_ecall: two embedded tasks run via ecall" "$elapsed"
                ;;
            *)
                report_fail_msg "kernel_ecall" \
                    "expected HELLO+WORLD+done, got: $(printf '%s' "$kv_out" | head -c 120)"
                ;;
        esac
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "kernel_ecall" "build failed"
    fi
fi

print_results
