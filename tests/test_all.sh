#!/bin/bash
# test_all.sh — run all test suites and report overall results

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TOTAL_PASS=0
TOTAL_FAIL=0
SUITE_TIME_START=$(date +%s%3N)

run_suite() {
    local script="$1"
    if [ ! -x "$script" ]; then
        echo "SKIP: $script (not found)"
        return
    fi
    local output
    output=$("$script" 2>&1)
    echo "$output"
    # Parse "Results: N passed, M failed" from last lines
    local results
    results=$(echo "$output" | grep "^Results:")
    if [ -n "$results" ]; then
        local p f
        p=$(echo "$results" | sed 's/Results: \([0-9]*\) passed.*/\1/')
        f=$(echo "$results" | sed 's/.*passed, \([0-9]*\) failed/\1/')
        TOTAL_PASS=$((TOTAL_PASS + p))
        TOTAL_FAIL=$((TOTAL_FAIL + f))
    fi
}

run_suite "$SCRIPT_DIR/test_unit.sh"
run_suite "$SCRIPT_DIR/test_pipeline.sh"
run_suite "$SCRIPT_DIR/test_consistency.sh"
run_suite "$SCRIPT_DIR/test_golden_examples.sh"
run_suite "$SCRIPT_DIR/test_golden_compiler.sh"
run_suite "$SCRIPT_DIR/test_gen3.sh"
run_suite "$SCRIPT_DIR/test_import.sh"

SUITE_TIME_END=$(date +%s%3N)
ELAPSED=$(( SUITE_TIME_END - SUITE_TIME_START ))

echo ""
echo "=== All Suites ==="
echo "Total: $TOTAL_PASS passed, $TOTAL_FAIL failed (${ELAPSED}ms)"
[ "$TOTAL_FAIL" -eq 0 ] && exit 0 || exit 1
