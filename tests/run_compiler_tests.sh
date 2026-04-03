#!/bin/bash
# Golden tests for tc/ compiler source files (parse.tc, codegen.tc, bc2asm.tc, bcrun.tc)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GOLDEN_DIR="$SCRIPT_DIR/golden"
TC_DIR="$ROOT_DIR/tc"
COMPILER_DIR="$ROOT_DIR/compiler"

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
    echo "FAIL: $name"
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

PARSE_TC_BC=$("$PARSE" "$TC_DIR/parse.tc" | "$CODEGEN" 2>/dev/null)
CODEGEN_TC_BC=$("$PARSE" "$TC_DIR/codegen.tc" | "$CODEGEN" 2>/dev/null)
BC2ASM_TC_BC=$("$PARSE" "$TC_DIR/bc2asm.tc" | "$CODEGEN" 2>/dev/null)

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
    "$PARSE" "$input" > "$actual_ast" 2>/dev/null
    if diff -u "$golden_ast" "$actual_ast" > /dev/null; then
        echo "PASS: tc/$f (AST - C)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (AST - C)" "$golden_ast" "$actual_ast"
    fi

    golden_ast_tc="$GOLDEN_DIR/tc/$base.ast.tc"
    [ -f "$golden_ast_tc" ] || golden_ast_tc="$golden_ast"
    { echo "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" > "$actual_ast" 2>/dev/null
    if diff -u "$golden_ast_tc" "$actual_ast" > /dev/null; then
        echo "PASS: tc/$f (AST - parse.tc)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (AST - parse.tc)" "$golden_ast_tc" "$actual_ast"
    fi
    rm -f "$actual_ast"

    # --- 2. BC Checks ---
    actual_bc=$(mktemp)
    "$PARSE" "$input" 2>/dev/null | "$CODEGEN" > "$actual_bc" 2>/dev/null
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: tc/$f (BC - C)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (BC - C)" "$golden_bc" "$actual_bc"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    { echo "$CODEGEN_TC_BC"; echo "$AST"; } | "$BCRUN" > "$actual_bc" 2>/dev/null
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: tc/$f (BC - codegen.tc)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (BC - codegen.tc)" "$golden_bc" "$actual_bc"
    fi
    rm -f "$actual_bc"

    # --- 3. ASM Checks ---
    actual_s=$(mktemp)
    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    echo "$bc" | "$BC2ASM" > "$actual_s" 2>/dev/null
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: tc/$f (ASM - C)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (ASM - C)" "$golden_s" "$actual_s"
    fi

    { echo "$BC2ASM_TC_BC"; echo "$bc"; } | "$BCRUN" > "$actual_s" 2>/dev/null
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: tc/$f (ASM - bc2asm.tc)"
        PASS=$((PASS + 1))
    else
        report_fail "tc/$f (ASM - bc2asm.tc)" "$golden_s" "$actual_s"
    fi
    rm -f "$actual_s"

    # --- 4. Execution Checks (bcrun) ---
    expected_exit=$(cat "$golden_exit")
    actual_out=$(mktemp)
    exec_input_file=$(get_tc_exec_input_file "$f")

    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    { echo "$bc"; cat "$exec_input_file"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit=$?
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        echo "PASS: tc/$f (Exec - bcrun C)"
        PASS=$((PASS + 1))
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail "tc/$f (Exec - bcrun C)" "$golden_out" "$actual_out" "$msg"
    fi
    rm -f "$actual_out"
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
