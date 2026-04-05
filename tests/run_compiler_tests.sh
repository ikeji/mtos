#!/bin/bash
# Golden tests for tc/ compiler source files (parse.tc, codegen.tc, bc2asm.tc, bcrun.tc)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GOLDEN_DIR="$SCRIPT_DIR/golden"
TC_DIR="$ROOT_DIR/compiler"
COMPILER_DIR="$ROOT_DIR/bootstrap"

PARSE="$ROOT_DIR/parse"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"

RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"
QEMU="qemu-riscv32"

PASS=0
FAIL=0

time_ms() { date +%s%3N; }

TC_FILES=(
    "parse.tc"
    "codegen.tc"
    "bc2asm.tc"
    "bcrun.tc"
)

get_tc_exec_input_file() {
    case "$1" in
        "parse.tc") echo "$SCRIPT_DIR/hello.tc" ;;
        "codegen.tc") echo "$GOLDEN_DIR/hello.ast" ;;
        "bc2asm.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        "bcrun.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        *) echo "/dev/null" ;;
    esac
}

report_fail() {
    local name="$1"
    local expected="$2"
    local actual="$3"
    local msg="${4:-}"
    local elapsed="${5:-}"
    echo "FAIL: $name${elapsed:+ [${elapsed}ms]}"
    [ -n "$msg" ] && echo "  $msg"
    echo "  --- diff (showing first 5 lines) ---"
    diff -u "$expected" "$actual" | head -n 10
    echo "  ------------------------------------"
    FAIL=$((FAIL + 1))
}

if [ ! -x "$PARSE" ] || [ ! -x "$CODEGEN" ] || [ ! -x "$BCRUN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: basic tools (parse, codegen, bcrun, bc2asm) not found. Build them first." >&2
    exit 1
fi

# Build Gen2 RISC-V binaries for fast self-hosted execution (if toolchain available)
USE_NATIVE=false
GEN2_TMP=""
if command -v "$RISCV_CC" >/dev/null 2>&1 && command -v "$QEMU" >/dev/null 2>&1; then
    GEN2_TMP=$(mktemp -d)

    # Compile Gen2 tools to BC, then to RISC-V ELF (with import support)
    build_gen2_tool() {
        local name="$1"
        local tc_file="$TC_DIR/$name.tc"
        local tc_dir
        tc_dir=$(dirname "$tc_file")
        # Collect import files
        local imports=() asm_files=()
        while IFS= read -r imp; do
            imports+=("$tc_dir/$imp")
        done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
        # Compile imports to .s
        for imp_file in "${imports[@]}"; do
            local base=$(basename "$imp_file" .tc)
            "$CODEGEN" "$imp_file" 2>/dev/null | "$BC2ASM" > "$GEN2_TMP/${name}_dep_${base}.s" 2>/dev/null
            asm_files+=("$GEN2_TMP/${name}_dep_${base}.s")
        done
        # Compile main file to .s
        "$CODEGEN" "$tc_file" 2>/dev/null | "$BC2ASM" > "$GEN2_TMP/$name.s" 2>/dev/null
        asm_files+=("$GEN2_TMP/$name.s")
        # Link
        $RISCV_CC $RISCV_FLAGS "$CRT0" "$RUNTIME" "${asm_files[@]}" -o "$GEN2_TMP/$name" 2>/dev/null
    }

    build_gen2_tool "parse"
    build_gen2_tool "typecheck"
    build_gen2_tool "codegen"
    build_gen2_tool "bc2asm"

    # Verify all binaries were built
    if [ -x "$GEN2_TMP/parse" ] && [ -x "$GEN2_TMP/typecheck" ] && \
       [ -x "$GEN2_TMP/codegen" ] && [ -x "$GEN2_TMP/bc2asm" ]; then
        USE_NATIVE=true
        echo "Using RISC-V native execution for self-hosted tests (fast mode)"
    else
        echo "Warning: Failed to build Gen2 RISC-V binaries, falling back to bcrun"
    fi
else
    echo "Note: RISC-V toolchain not found, using bcrun for self-hosted tests (slow)"
fi

# Fallback: compile Gen2 BCs for bcrun if native not available
source "$SCRIPT_DIR/compile_tc.sh"
if [ "$USE_NATIVE" = false ]; then
    PARSE_TC_BC=$(compile_tc_to_bc "$TC_DIR/parse.tc")
    TYPECHECK_TC_BC=$(compile_tc_to_bc "$TC_DIR/typecheck.tc")
    CODEGEN_TC_BC=$(compile_tc_to_bc "$TC_DIR/codegen.tc")
    BC2ASM_TC_BC=$(compile_tc_to_bc "$TC_DIR/bc2asm.tc")
fi

# Helper: run self-hosted parse.tc on input file, write AST to stdout
run_parse_tc() {
    local input="$1"
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/parse" < "$input" 2>/dev/null
    else
        { printf '%s\n' "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" 2>/dev/null
    fi
}

# Helper: run self-hosted typecheck.tc on AST (from stdin), write typed AST to stdout
run_typecheck_tc() {
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/typecheck" 2>/dev/null
    else
        { printf '%s\n' "$TYPECHECK_TC_BC"; cat; } | "$BCRUN" 2>/dev/null
    fi
}

# Helper: run self-hosted codegen.tc on typed AST (from stdin), write BC to stdout
run_codegen_tc() {
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/codegen" 2>/dev/null
    else
        { printf '%s\n' "$CODEGEN_TC_BC"; cat; } | "$BCRUN" 2>/dev/null
    fi
}

# Helper: run self-hosted bc2asm.tc on BC (from stdin), write ASM to stdout
run_bc2asm_tc() {
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/bc2asm" 2>/dev/null
    else
        { printf '%s\n' "$BC2ASM_TC_BC"; cat; } | "$BCRUN" 2>/dev/null
    fi
}

echo "=== Golden Tests: tc/ Compiler Source Files ==="

for f in "${TC_FILES[@]}"; do
    input="$TC_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping tc/$f (not found)..."
        continue
    fi

    golden_ast="$GOLDEN_DIR/tc/$base.ast"
    golden_bc="$GOLDEN_DIR/tc/$base.bc"
    golden_s="$GOLDEN_DIR/tc/$base.s"
    golden_out="$GOLDEN_DIR/tc/$base.out"
    golden_exit="$GOLDEN_DIR/tc/$base.exit"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ] || [ ! -f "$golden_out" ] || [ ! -f "$golden_exit" ]; then
        echo "FAIL: tc/$f (Golden files missing)"
        FAIL=$((FAIL + 1))
        continue
    fi

    # --- 1. AST Checks ---
    actual_ast=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual_ast" > /dev/null; then
        echo "PASS: tc/$f (AST - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (AST - C)" "$golden_ast" "$actual_ast" "" "$elapsed"
    fi

    golden_ast_tc="$GOLDEN_DIR/tc/$base.ast.tc"
    [ -f "$golden_ast_tc" ] || golden_ast_tc="$golden_ast"
    t0=$(time_ms)
    run_parse_tc "$input" > "$actual_ast"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast_tc" "$actual_ast" > /dev/null; then
        echo "PASS: tc/$f (AST - parse.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (AST - parse.tc)" "$golden_ast_tc" "$actual_ast" "" "$elapsed"
    fi
    rm -f "$actual_ast"

    # --- 2. BC Checks ---
    actual_bc=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" 2>/dev/null | "$CODEGEN" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: tc/$f (BC - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (BC - C)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$AST" | run_typecheck_tc | run_codegen_tc > "$actual_bc"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: tc/$f (BC - codegen.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (BC - codegen.tc)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi
    rm -f "$actual_bc"

    # --- 3. ASM Checks ---
    actual_s=$(mktemp)
    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: tc/$f (ASM - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (ASM - C)" "$golden_s" "$actual_s" "" "$elapsed"
    fi

    t0=$(time_ms)
    printf '%s\n' "$bc" | run_bc2asm_tc > "$actual_s"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: tc/$f (ASM - bc2asm.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (ASM - bc2asm.tc)" "$golden_s" "$actual_s" "" "$elapsed"
    fi
    rm -f "$actual_s"

    # --- 4. Execution Checks (bcrun) ---
    expected_exit=$(cat "$golden_exit")
    actual_out=$(mktemp)
    exec_input_file=$(get_tc_exec_input_file "$f")

    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc"; cat "$exec_input_file"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        echo "PASS: tc/$f (Exec - bcrun C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail "tc/$f (Exec - bcrun C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi
    rm -f "$actual_out"
done

# Cleanup Gen2 temp directory
[ -n "$GEN2_TMP" ] && rm -rf "$GEN2_TMP"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
