#!/bin/bash
# Golden test suite — runs all three sub-test scripts and reports overall result.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OVERALL_FAIL=0

run_suite() {
    local script="$1"
    if "$SCRIPT_DIR/$script"; then
        return 0
    else
        OVERALL_FAIL=$((OVERALL_FAIL + 1))
        return 1
    fi
}

run_suite run_example_tests.sh
echo ""
run_suite run_compiler_tests.sh
echo ""
run_suite run_gen3_tests.sh

echo ""
if [ $OVERALL_FAIL -eq 0 ]; then
    echo "All golden test suites passed."
    exit 0
else
    echo "$OVERALL_FAIL suite(s) failed."
    exit 1
fi
