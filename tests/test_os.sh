#!/bin/bash
# test_os.sh — tests for os/ kernel components

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== OS Component Tests ==="

HAS_RV=false
if command -v "$RISCV_CC" >/dev/null 2>&1 && command -v "$QEMU" >/dev/null 2>&1; then
    HAS_RV=true
fi

if [ "$HAS_RV" != true ]; then
    echo "SKIP: OS tests (RISC-V toolchain not found)"
    print_results
    exit $?
fi

# --- kmalloc ---
t0=$(time_ms)
ELF=$(mktemp)
trap "rm -f '$ELF'" EXIT
if "$ROOT_DIR/compile-gen1.sh" -o "$ELF" "$SCRIPT_DIR/test_kmalloc.tc" 2>/dev/null; then
    out=$("$QEMU" "$ELF" 2>/dev/null)
    ex=$?
    elapsed=$(( $(time_ms) - t0 ))
    if [ "$out" = "0" ] && [ "$ex" -eq 0 ]; then
        report_pass "kmalloc basic" "$elapsed"
    else
        report_fail_msg "kmalloc basic" "expected output '0' exit 0, got '$out' exit $ex"
    fi
else
    elapsed=$(( $(time_ms) - t0 ))
    report_fail_msg "kmalloc basic" "compile failed"
fi

print_results
