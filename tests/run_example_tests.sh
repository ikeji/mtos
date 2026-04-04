#!/bin/bash
# Golden tests for example .tc files (hello, fib, fizzbuzz, etc.)

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

FILES=(
    "hello.tc"
    "hello2.tc"
    "fib.tc"
    "fizzbuzz.tc"
    "calc.tc"
    "elseif_test.tc"
    "charliteral_test.tc"
    "break_test.tc"
    "continue_test.tc"
    "nested_break_test.tc"
)

get_stdin() {
    case "$1" in
        "calc.tc") echo -n "12 + 34 * 56" ;;
        *) echo -n "" ;;
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

PARSE_TC_BC=$("$PARSE" "$TC_DIR/parse.tc" | "$CODEGEN" 2>/dev/null)
TYPECHECK_TC_BC=$("$PARSE" "$TC_DIR/typecheck.tc" | "$CODEGEN" 2>/dev/null)
CODEGEN_TC_BC=$("$PARSE" "$TC_DIR/codegen.tc" | "$CODEGEN" 2>/dev/null)
BC2ASM_TC_BC=$("$PARSE" "$TC_DIR/bc2asm.tc" | "$CODEGEN" 2>/dev/null)

echo "=== Golden Tests: Example Files ==="

for f in "${FILES[@]}"; do
    input="$SCRIPT_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping $f (not found)..."
        continue
    fi

    golden_ast="$GOLDEN_DIR/$base.ast"
    golden_bc="$GOLDEN_DIR/$base.bc"
    golden_s="$GOLDEN_DIR/$base.s"
    golden_out="$GOLDEN_DIR/$base.out"
    golden_exit="$GOLDEN_DIR/$base.exit"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ] || [ ! -f "$golden_out" ] || [ ! -f "$golden_exit" ]; then
        echo "FAIL: $f (Golden files missing)"
        FAIL=$((FAIL + 1))
        continue
    fi

    # --- 1. AST Checks ---
    actual_ast=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual_ast" > /dev/null; then
        echo "PASS: $f (AST - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (AST - C)" "$golden_ast" "$actual_ast" "" "$elapsed"
    fi

    golden_ast_tc="$GOLDEN_DIR/$base.ast.tc"
    [ -f "$golden_ast_tc" ] || golden_ast_tc="$golden_ast"
    t0=$(time_ms)
    { printf '%s\n' "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast_tc" "$actual_ast" > /dev/null; then
        echo "PASS: $f (AST - parse.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (AST - parse.tc)" "$golden_ast_tc" "$actual_ast" "" "$elapsed"
    fi
    rm -f "$actual_ast"

    # --- 2. BC Checks ---
    actual_bc=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" 2>/dev/null | "$CODEGEN" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: $f (BC - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (BC - C)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$AST"; } | "$BCRUN" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$TAST"; } | "$BCRUN" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        echo "PASS: $f (BC - codegen.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (BC - codegen.tc)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi
    rm -f "$actual_bc"

    # --- 3. ASM Checks ---
    actual_s=$(mktemp)
    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: $f (ASM - C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (ASM - C)" "$golden_s" "$actual_s" "" "$elapsed"
    fi

    t0=$(time_ms)
    { printf '%s\n' "$BC2ASM_TC_BC"; printf '%s\n' "$bc"; } | "$BCRUN" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        echo "PASS: $f (ASM - bc2asm.tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        report_fail "$f (ASM - bc2asm.tc)" "$golden_s" "$actual_s" "" "$elapsed"
    fi
    rm -f "$actual_s"

    # --- 4. Execution Checks (bcrun) ---
    stdin=$(get_stdin "$f")
    expected_exit=$(cat "$golden_exit")
    actual_out=$(mktemp)

    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        echo "PASS: $f (Exec - bcrun C) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail "$f (Exec - bcrun C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$AST"; } | "$BCRUN" 2>/dev/null)
    bc_tc=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$TAST"; } | "$BCRUN" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc_tc"; echo -n "$stdin"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit_tc=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit_tc" -eq "$expected_exit" ]; then
        echo "PASS: $f (Exec - bcrun tc) [${elapsed}ms]"
        PASS=$((PASS + 1))
    else
        msg=""
        [ "$actual_exit_tc" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit_tc"
        report_fail "$f (Exec - bcrun tc)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi
    rm -f "$actual_out"

    # --- 5. Execution Checks (RISC-V) ---
    if command -v "$RISCV_CC" >/dev/null && command -v "$QEMU" >/dev/null; then
        asm_file=$(mktemp --suffix=.s)
        elf_file=$(mktemp)

        bc=$("$CODEGEN" "$input" 2>/dev/null)
        printf '%s\n' "$bc" | "$BC2ASM" > "$asm_file" 2>/dev/null
        if "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
            actual_out=$(mktemp)
            t0=$(time_ms)
            echo -n "$stdin" | "$QEMU" "$elf_file" > "$actual_out" 2>/dev/null
            actual_exit=$?
            elapsed=$(( $(time_ms) - t0 ))
            if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
                echo "PASS: $f (Exec - rv32 C) [${elapsed}ms]"
                PASS=$((PASS + 1))
            else
                msg=""
                [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
                report_fail "$f (Exec - rv32 C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
            fi
            rm -f "$actual_out"
        else
            echo "FAIL: $f (Exec - rv32 C compilation error)"
            FAIL=$((FAIL + 1))
        fi

        bc=$("$CODEGEN" "$input" 2>/dev/null)
        { printf '%s\n' "$BC2ASM_TC_BC"; printf '%s\n' "$bc"; } | "$BCRUN" > "$asm_file" 2>/dev/null
        if "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
            actual_out=$(mktemp)
            t0=$(time_ms)
            echo -n "$stdin" | "$QEMU" "$elf_file" > "$actual_out" 2>/dev/null
            actual_exit=$?
            elapsed=$(( $(time_ms) - t0 ))
            if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
                echo "PASS: $f (Exec - rv32 tc) [${elapsed}ms]"
                PASS=$((PASS + 1))
            else
                msg=""
                [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
                report_fail "$f (Exec - rv32 tc)" "$golden_out" "$actual_out" "$msg" "$elapsed"
            fi
            rm -f "$actual_out"
        else
            echo "FAIL: $f (Exec - rv32 tc compilation error)"
            FAIL=$((FAIL + 1))
        fi
        rm -f "$asm_file" "$elf_file"
    else
        echo "SKIP: $f (RISC-V toolchain not found)"
    fi
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
