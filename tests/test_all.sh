#!/bin/bash
# test_all.sh — run all test suites and report overall results

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

TOTAL_PASS=0
TOTAL_FAIL=0
time_ms() { date +%s%3N; }
SUITE_TIME_START=$(time_ms)

# Use the Make-managed Gen2 tool directory so sub-suites don't each
# build their own copy. Phase A: Makefile ensures build/gen2/ is up
# to date (via `test: $(GEN2_TOOLS)` in the top Makefile) before
# this script runs, so we simply point SHARED_GEN2_DIR at it.
QEMU="${QEMU:-qemu-riscv32}"
RISCV_CC="riscv64-unknown-elf-gcc"
if command -v "$QEMU" >/dev/null 2>&1 && command -v "$RISCV_CC" >/dev/null 2>&1; then
    SHARED_GEN2_DIR="$ROOT_DIR/build/gen2"
    export SHARED_GEN2_DIR
    # Fallback: if someone ran test_all.sh directly without going
    # through `make test`, build the tools on the spot so the suite
    # still works standalone. Gen1 tools (build/gen1/*) must exist
    # first since compile-gen1.sh calls them — bounce through `make`
    # which is the single source of truth for the Gen1 build rules.
    _need_gen1=0
    for t in parse typecheck interp codegen bcrun bc2asm; do
        if [ ! -x "$ROOT_DIR/build/gen1/$t" ]; then _need_gen1=1; break; fi
    done
    if [ "$_need_gen1" = 1 ]; then
        (cd "$ROOT_DIR" && make all >/dev/null)
    fi
    _need_build=0
    for t in parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2; do
        if [ ! -x "$SHARED_GEN2_DIR/$t" ]; then _need_build=1; break; fi
    done
    if [ "$_need_build" = 1 ]; then
        mkdir -p "$SHARED_GEN2_DIR"
        for t in parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2; do
            if [ ! -x "$SHARED_GEN2_DIR/$t" ]; then
                "$ROOT_DIR/compile-gen1.sh" -o "$SHARED_GEN2_DIR/$t" \
                    "$ROOT_DIR/compiler/$t.tc" 2>/dev/null
            fi
        done
    fi
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
# Phase E: consistency is now part of the default run. It adds ~12 s
# but the warm make test budget (with kernel / Gen2 tools cached) is
# well under 60 s so we include it unconditionally.
run_suite "$SCRIPT_DIR/test_consistency.sh"
run_suite "$SCRIPT_DIR/test_golden_examples.sh"
run_suite "$SCRIPT_DIR/test_gen3.sh"
run_suite "$SCRIPT_DIR/test_import.sh"
run_suite "$SCRIPT_DIR/test_asm.sh"
run_suite "$SCRIPT_DIR/test_os.sh"

ELAPSED=$(( $(time_ms) - SUITE_TIME_START ))

echo "=== All Suites ==="
echo "Total: $TOTAL_PASS passed, $TOTAL_FAIL failed (${ELAPSED}ms)"
[ "$TOTAL_FAIL" -eq 0 ] && exit 0 || exit 1
