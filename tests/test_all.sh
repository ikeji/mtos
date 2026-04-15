#!/bin/bash
# test_all.sh — run all test suites and report overall results

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

TOTAL_PASS=0
TOTAL_FAIL=0
time_ms() { date +%s%3N; }
SUITE_TIME_START=$(time_ms)

# Build Gen2 tools once up-front so every sub-suite that sources
# test_common.sh can reuse the same binaries via SHARED_GEN2_DIR.
# Saves ~10 s per run (4 suites × 8 tools × compile-gen1.sh).
# Built in parallel to shave another second or two off the initial wait.
QEMU="${QEMU:-qemu-riscv32}"
RISCV_CC="riscv64-unknown-elf-gcc"
if command -v "$QEMU" >/dev/null 2>&1 && command -v "$RISCV_CC" >/dev/null 2>&1; then
    SHARED_GEN2_DIR=$(mktemp -d)
    export SHARED_GEN2_DIR
    trap 'rm -rf "$SHARED_GEN2_DIR"' EXIT
    for t in parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2; do
        "$ROOT_DIR/compile-gen1.sh" -o "$SHARED_GEN2_DIR/$t" \
            "$ROOT_DIR/compiler/$t.tc" 2>/dev/null &
    done
    wait
fi

run_suite() {
    local script="$1"
    if [ ! -x "$script" ]; then
        echo "SKIP: $script (not found)"
        return
    fi
    local t0 elapsed tmp_out
    t0=$(time_ms)
    tmp_out=$(mktemp)
    # Stream output to terminal while capturing for result parsing
    "$script" 2>&1 | tee "$tmp_out"
    elapsed=$(( $(time_ms) - t0 ))
    # Parse "Results: N passed, M failed" line
    local results
    results=$(grep "^Results:" "$tmp_out")
    if [ -n "$results" ]; then
        local p f
        p=$(echo "$results" | sed 's/Results: \([0-9]*\) passed.*/\1/')
        f=$(echo "$results" | sed 's/.*passed, \([0-9]*\) failed/\1/')
        TOTAL_PASS=$((TOTAL_PASS + p))
        TOTAL_FAIL=$((TOTAL_FAIL + f))
    fi
    rm -f "$tmp_out"
    echo "Suite time: ${elapsed}ms"
    echo ""
}

run_suite "$SCRIPT_DIR/test_unit.sh"
run_suite "$SCRIPT_DIR/test_pipeline.sh"
if [ "${FULL_TEST:-0}" = "1" ]; then
    run_suite "$SCRIPT_DIR/test_consistency.sh"
fi
run_suite "$SCRIPT_DIR/test_golden_examples.sh"
run_suite "$SCRIPT_DIR/test_gen3.sh"
run_suite "$SCRIPT_DIR/test_import.sh"
run_suite "$SCRIPT_DIR/test_asm.sh"
run_suite "$SCRIPT_DIR/test_os.sh"

ELAPSED=$(( $(time_ms) - SUITE_TIME_START ))

echo "=== All Suites ==="
echo "Total: $TOTAL_PASS passed, $TOTAL_FAIL failed (${ELAPSED}ms)"
[ "$TOTAL_FAIL" -eq 0 ] && exit 0 || exit 1
