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

print_results
