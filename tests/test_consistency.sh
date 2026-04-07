#!/bin/bash
# test_consistency.sh — verify all execution methods produce identical output
# Tools: tc_run_all.sh (interp/bcrun/rv32/pipeline/bc2asm_tc)
# Tests: each .tc file run via all 5 methods, output must match

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm interp

echo "=== Consistency Tests (all 5 methods must agree via tc_run_all.sh) ==="
echo ""

TC_RUN_ALL="$ROOT_DIR/tc_run_all.sh"
ALL_AGREE=">>> All methods produced identical output."

run_consistency() {
    local name="$1" tc="$2" stdin="${3:-}"
    local t0 actual elapsed
    t0=$(time_ms)
    if [ -n "$stdin" ]; then
        actual=$("$TC_RUN_ALL" "$tc" "$stdin" 2>&1)
    else
        actual=$("$TC_RUN_ALL" "$tc" 2>&1)
    fi
    elapsed=$(( $(time_ms) - t0 ))
    if echo "$actual" | grep -qF "$ALL_AGREE"; then
        report_pass "tc_run_all $name" "$elapsed"
    else
        echo "FAIL: tc_run_all $name [${elapsed}ms]"
        echo "  expected: $ALL_AGREE"
        echo "  actual (last 3 lines):"
        echo "$actual" | tail -3 | sed 's/^/    /'
        FAIL=$((FAIL + 1))
    fi
}

run_consistency "hello.tc" "$SCRIPT_DIR/hello.tc"
run_consistency "fib.tc" "$SCRIPT_DIR/fib.tc"
run_consistency "fizzbuzz.tc" "$SCRIPT_DIR/fizzbuzz.tc"
run_consistency "calc.tc" "$SCRIPT_DIR/calc.tc" "12 + 34 * 56"
run_consistency "elseif_test.tc" "$SCRIPT_DIR/elseif_test.tc"
run_consistency "charliteral_test.tc" "$SCRIPT_DIR/charliteral_test.tc"
run_consistency "break_test.tc" "$SCRIPT_DIR/break_test.tc"
run_consistency "continue_test.tc" "$SCRIPT_DIR/continue_test.tc"
run_consistency "nested_break_test.tc" "$SCRIPT_DIR/nested_break_test.tc"

print_results
