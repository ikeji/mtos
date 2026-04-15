#!/bin/bash
# test_common.sh — shared utilities for test scripts
# Usage: source this file from test scripts.

# ===== Paths =====
if [ -z "$SCRIPT_DIR" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
fi
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GOLDEN_DIR="$SCRIPT_DIR/golden"
TC_DIR="$ROOT_DIR/compiler"
COMPILER_DIR="$ROOT_DIR/bootstrap"

INTERP="$ROOT_DIR/interp"
PARSE="$ROOT_DIR/parse"
TYPECHECK="$ROOT_DIR/typecheck"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"

RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS=(-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000)
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"
QEMU="qemu-riscv32"

# ===== Counters =====
PASS=0
FAIL=0

# ===== Utilities =====
time_ms() { date +%s%3N; }

require_tools() {
    for tool in "$@"; do
        local path="$ROOT_DIR/$tool"
        if [ ! -x "$path" ]; then
            echo "Error: $tool not found. Build first (make)." >&2
            exit 1
        fi
    done
}

# ===== Test helpers =====

# check_output "name" "expected" "actual"
check_output() {
    local name="$1" expected="$2" actual="$3"
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $name"
        echo "  expected: $(echo "$expected" | head -3)"
        echo "  actual:   $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

# check_contains "name" "actual" "substring"
check_contains() {
    local name="$1" actual="$2" expected="$3"
    if echo "$actual" | grep -qF "$expected"; then
        echo "PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $name"
        echo "  expected to contain: $expected"
        echo "  actual: $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

# report_pass "name" elapsed_ms
report_pass() {
    local name="$1" elapsed="${2:-}"
    echo "PASS: $name${elapsed:+ [${elapsed}ms]}"
    PASS=$((PASS + 1))
}

# report_fail_diff "name" expected_file actual_file [msg] [elapsed_ms]
report_fail_diff() {
    local name="$1" expected="$2" actual="$3" msg="${4:-}" elapsed="${5:-}"
    echo "FAIL: $name${elapsed:+ [${elapsed}ms]}"
    [ -n "$msg" ] && echo "  $msg"
    echo "  --- diff (showing first 5 lines) ---"
    diff -u "$expected" "$actual" | head -n 10
    echo "  ------------------------------------"
    FAIL=$((FAIL + 1))
}

# report_fail_msg "name" "message"
report_fail_msg() {
    local name="$1" msg="$2"
    echo "FAIL: $name"
    [ -n "$msg" ] && echo "  $msg"
    FAIL=$((FAIL + 1))
}

# print_results — prints summary line, returns 0 if all passed
print_results() {
    echo ""
    echo "Results: $PASS passed, $FAIL failed"
    [ "$FAIL" -eq 0 ]
}

# ===== Recursive import collection =====

# _collect_imports file.tc — recursively collect all import file paths (deduped)
# Results appended to _COLLECTED_IMPORTS (newline-separated)
_COLLECTED_IMPORTS=""
_collect_imports() {
    local tc_file="$1"
    local tc_dir
    tc_dir=$(dirname "$tc_file")
    while IFS= read -r imp; do
        local full="$tc_dir/$imp"
        if [ -f "$full" ]; then
            local b
            b=$(basename "$full")
            if ! echo "$_COLLECTED_IMPORTS" | grep -qF "$b"; then
                _collect_imports "$full"
                _COLLECTED_IMPORTS="${_COLLECTED_IMPORTS}${full}
"
            fi
        fi
    done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
}

# collect_imports file.tc — returns newline-separated list of all import files
collect_imports() {
    _COLLECTED_IMPORTS=""
    _collect_imports "$1"
    printf '%s' "$_COLLECTED_IMPORTS"
}

# ===== compile_tc_to_bc (recursive import-resolving BC compilation) =====

compile_tc_to_bc() {
    local tc_file="$1"
    local all_bcs=()

    while IFS= read -r imp_file; do
        [ -z "$imp_file" ] && continue
        all_bcs+=("$("$CODEGEN" "$imp_file" 2>/dev/null)")
    done < <(collect_imports "$tc_file")

    all_bcs+=("$("$CODEGEN" "$tc_file" 2>/dev/null)")

    echo ".bc"
    for bc in "${all_bcs[@]}"; do
        printf '%s\n' "$bc" | sed '/^\.bc$/d; /^\.endbc$/d'
    done
    echo ".endbc"
}

# ===== Gen2 RISC-V native tools =====

_GEN2_TMP=""
_GEN2_READY=false

# build_gen2_tool "name" — compiles compiler/$name.tc to RISC-V ELF via compile-gen1.sh
build_gen2_tool() {
    local name="$1"
    "$ROOT_DIR/compile-gen1.sh" -o "$_GEN2_TMP/$name" "$TC_DIR/$name.tc"
}

# ensure_gen2_tools — builds Gen2 RISC-V binaries (once), sets USE_NATIVE.
# Builds the split pipeline (parse + sigscan + tcheck + codegen +
# bc2asm + bcrun + asm_pass1 + asm_pass2).
#
# If `SHARED_GEN2_DIR` is set and all expected binaries exist there,
# we reuse it instead of rebuilding. test_all.sh sets this so each
# sub-suite amortises the ~12 s compile-gen1.sh cost across the whole
# run instead of paying it 4x.
ensure_gen2_tools() {
    if [ "$_GEN2_READY" = true ]; then return; fi
    _GEN2_READY=true
    USE_NATIVE=false
    if ! command -v "$QEMU" >/dev/null 2>&1 || ! command -v "$RISCV_CC" >/dev/null 2>&1; then
        return
    fi
    if [ -n "$SHARED_GEN2_DIR" ] \
       && [ -x "$SHARED_GEN2_DIR/parse" ] && [ -x "$SHARED_GEN2_DIR/sigscan" ] \
       && [ -x "$SHARED_GEN2_DIR/tcheck" ] && [ -x "$SHARED_GEN2_DIR/codegen" ] \
       && [ -x "$SHARED_GEN2_DIR/bc2asm" ] && [ -x "$SHARED_GEN2_DIR/bcrun" ] \
       && [ -x "$SHARED_GEN2_DIR/asm_pass1" ] && [ -x "$SHARED_GEN2_DIR/asm_pass2" ]; then
        _GEN2_TMP="$SHARED_GEN2_DIR"
        _GEN2_SHARED=1
        USE_NATIVE=true
        return
    fi
    _GEN2_TMP=$(mktemp -d)
    build_gen2_tool "parse"
    build_gen2_tool "sigscan"
    build_gen2_tool "tcheck"
    build_gen2_tool "codegen"
    build_gen2_tool "bc2asm"
    build_gen2_tool "bcrun"
    build_gen2_tool "asm_pass1"
    build_gen2_tool "asm_pass2"
    if [ -x "$_GEN2_TMP/parse" ] && [ -x "$_GEN2_TMP/sigscan" ] && \
       [ -x "$_GEN2_TMP/tcheck" ] && [ -x "$_GEN2_TMP/codegen" ] && \
       [ -x "$_GEN2_TMP/bc2asm" ] && [ -x "$_GEN2_TMP/bcrun" ] && \
       [ -x "$_GEN2_TMP/asm_pass1" ] && [ -x "$_GEN2_TMP/asm_pass2" ]; then
        USE_NATIVE=true
    fi
}

cleanup_gen2_tools() {
    # Don't clean up a dir owned by the parent harness.
    if [ "$_GEN2_SHARED" = 1 ]; then return; fi
    [ -n "$_GEN2_TMP" ] && rm -rf "$_GEN2_TMP"
}

# ===== Gen2 tool execution helpers =====

run_parse_tc() {
    local input="$1"
    "$QEMU" "$_GEN2_TMP/parse" < "$input" 2>/dev/null
}

# run_typecheck_tc — reads an .ast (program) from stdin and emits the
# .tast via the new sigscan + tcheck pipeline. Buffers stdin into a
# tmp file so sigscan can walk it first to produce the (self …) block.
# No imports are injected (callers that need imports construct the
# wrapped stdin themselves and call tcheck directly).
run_typecheck_tc() {
    local ast th wrap
    ast=$(mktemp)
    th=$(mktemp)
    wrap=$(mktemp)
    cat > "$ast"
    "$QEMU" "$_GEN2_TMP/sigscan" < "$ast" > "$th" 2>/dev/null
    {
        printf '(imports)\n'
        printf '(self\n'
        cat "$th"
        printf ')\n'
        cat "$ast"
    } > "$wrap"
    "$QEMU" "$_GEN2_TMP/tcheck" < "$wrap" 2>/dev/null
    rm -f "$ast" "$th" "$wrap"
}

run_codegen_tc() {
    "$QEMU" "$_GEN2_TMP/codegen" 2>/dev/null
}

run_bc2asm_tc() {
    "$QEMU" "$_GEN2_TMP/bc2asm" 2>/dev/null
}

# run_asm_tc — takes a .s (already concatenated with crt0 / runtime if
# needed) on stdin and emits the ELF or raw binary via the new
# asm_pass1 + asm_pass2 split. Buffers stdin into a tmp file so
# asm_pass1 and asm_pass2 can read it independently.
#
# Phase 5 stream-emit: asm_pass2 runs 3 section passes (text / rodata
# / data), each consuming one full copy of the source from stdin, so
# the caller must concatenate the source 3 times after the .lab.
run_asm_tc() {
    local src lab
    src=$(mktemp)
    lab=$(mktemp)
    cat > "$src"
    "$QEMU" "$_GEN2_TMP/asm_pass1" < "$src" > "$lab" 2>/dev/null
    cat "$lab" "$src" "$src" "$src" | "$QEMU" "$_GEN2_TMP/asm_pass2" 2>/dev/null
    rm -f "$src" "$lab"
}

# ===== Common test file lists =====

EXAMPLE_FILES=(
    "hello.tc" "hello2.tc" "fib.tc" "fizzbuzz.tc" "calc.tc"
    "elseif_test.tc" "charliteral_test.tc"
    "break_test.tc" "continue_test.tc" "nested_break_test.tc"
    "type_test.tc" "struct_basic.tc"
)

TC_FILES=("parse.tc" "codegen.tc" "bc2asm.tc" "bcrun.tc")

get_stdin() {
    case "$1" in
        "calc.tc") echo -n "12 + 34 * 56" ;;
        *) echo -n "" ;;
    esac
}

get_tc_exec_input_file() {
    case "$1" in
        "parse.tc") echo "$SCRIPT_DIR/hello.tc" ;;
        "codegen.tc") echo "$GOLDEN_DIR/hello.ast" ;;
        "bc2asm.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        "bcrun.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        *) echo "/dev/null" ;;
    esac
}
