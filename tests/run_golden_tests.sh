#!/bin/bash
# Golden test suite — runs all three sub-test scripts and reports overall result.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OVERALL_FAIL=0
time_ms() { date +%s%3N; }

run_suite() {
    local script="$1"
    local t0
    t0=$(time_ms)
    if "$SCRIPT_DIR/$script"; then
        local elapsed=$(( $(time_ms) - t0 ))
        echo "Suite time: ${elapsed}ms"
        return 0
    else
        local elapsed=$(( $(time_ms) - t0 ))
        echo "Suite time: ${elapsed}ms"
        OVERALL_FAIL=$((OVERALL_FAIL + 1))
        return 1
    fi
}

TOTAL_START=$(time_ms)

run_suite run_example_tests.sh
echo ""
run_suite run_compiler_tests.sh
echo ""
run_suite run_gen3_tests.sh

TOTAL_ELAPSED=$(( $(time_ms) - TOTAL_START ))
echo ""
if [ $OVERALL_FAIL -eq 0 ]; then
    echo "All golden test suites passed. Total time: ${TOTAL_ELAPSED}ms"
    exit 0
else
    echo "$OVERALL_FAIL suite(s) failed. Total time: ${TOTAL_ELAPSED}ms"
    exit 1
fi
