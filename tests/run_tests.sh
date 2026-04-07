#!/bin/bash
# Test runner for ToyC interpreter

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
INTERP="$ROOT_DIR/interp"
PARSE="$ROOT_DIR/parse"
TYPECHECK="$ROOT_DIR/typecheck"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"
RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$ROOT_DIR/bootstrap/runtime_syscall.c"
CRT0="$ROOT_DIR/bootstrap/crt0.s"
QEMU="qemu-riscv32"

# Helper: compile .tc → rv32 ELF and run with qemu
run_rv32() {
    local name="$1" tc="$2" expected="$3"
    local asm="/tmp/tc_rv32_$$.s" elf="/tmp/tc_rv32_$$"
    $BC2ASM <($CODEGEN "$tc") > "$asm" 2>/dev/null || { echo "FAIL: $name (codegen/bc2asm)"; FAIL=$((FAIL+1)); return; }
    $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm" "$RUNTIME" -o "$elf" 2>/dev/null || { echo "FAIL: $name (compile)"; FAIL=$((FAIL+1)); rm -f "$asm" "$elf"; return; }
    actual=$($QEMU "$elf" 2>/dev/null)
    rm -f "$asm" "$elf"
    if [ "$actual" = "$expected" ]; then echo "PASS: $name"; PASS=$((PASS+1));
    else echo "FAIL: $name"; echo "  expected: $(echo "$expected" | head -2)"; echo "  actual:   $(echo "$actual" | head -2)"; FAIL=$((FAIL+1)); fi
}

PASS=0
FAIL=0

run_test() {
    local name="$1"
    local cmd="$2"
    local expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected: $(echo "$expected" | head -3)"
        echo "  actual:   $(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

run_test_exit() {
    local name="$1"
    local cmd="$2"
    local expected_exit="$3"
    eval "$cmd" > /dev/null 2>&1
    local actual_exit=$?
    if [ "$actual_exit" = "$expected_exit" ]; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected exit: $expected_exit, got: $actual_exit"
        FAIL=$((FAIL+1))
    fi
}

run_test_contains() {
    local name="$1"
    local cmd="$2"
    local expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    if echo "$actual" | grep -qF "$expected"; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected to contain: $expected"
        echo "  actual: $(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

echo "=== ToyC Test Suite ==="
echo ""

# Test: parse hello.tc produces a program node
run_test_contains "parse hello.tc produces program" \
    "$PARSE $SCRIPT_DIR/hello.tc" \
    "(program"

# Test: parse hello.tc contains fn main
run_test_contains "parse hello.tc has fn main" \
    "$PARSE $SCRIPT_DIR/hello.tc" \
    "(fn main"

# Test: typecheck hello.tc produces typed annotations
run_test_contains "typecheck hello.tc has :U8Array annotation" \
    "$TYPECHECK $SCRIPT_DIR/hello.tc" \
    ":U8Array"

# Test: typecheck fib.tc has :i32 annotations
run_test_contains "typecheck fib.tc has :i32 annotations" \
    "$TYPECHECK $SCRIPT_DIR/fib.tc" \
    ":i32"

# Test: hello world output
run_test "hello world output" \
    "$INTERP $SCRIPT_DIR/hello.tc" \
    "Hello, World"

# Test: fib(10) = 55
run_test "fib(10) prints 55" \
    "$INTERP $SCRIPT_DIR/fib.tc" \
    "55"

# Test: fib exit code
run_test_exit "fib exit code 55" \
    "$INTERP $SCRIPT_DIR/fib.tc" \
    55

# Test: codegen fib.tc produces .fn directive
run_test_contains "codegen fib.tc has .fn fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" \
    ".fn fib i32 i32"

# Test: codegen fib.tc has call instruction
run_test_contains "codegen fib.tc has call fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" \
    "call fib i32"

# Test: codegen hello.tc produces .fn main
run_test_contains "codegen hello.tc has .fn main" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" \
    ".fn main i32"

# Test: codegen hello.tc has call sys_write
run_test_contains "codegen hello.tc has call sys_write" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" \
    "call sys_write i32 U8Array i32"

# Test: codegen | bcrun pipeline — hello world
run_test "bcrun hello world" \
    "$CODEGEN $SCRIPT_DIR/hello.tc | $BCRUN" \
    "Hello, World"

# Test: codegen | bcrun pipeline — fib(10) = 55
run_test "bcrun fib(10) prints 55" \
    "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" \
    "55"

# Test: bcrun fib exit code
run_test_exit "bcrun fib exit code 55" \
    "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" \
    55

# Test: bc2asm pipeline — fib(10) = 55 on real RISC-V
run_rv32 "rv32 fib(10) prints 55" \
    "$SCRIPT_DIR/fib.tc" \
    "55"

# Test: bc2asm pipeline — FizzBuzz on real RISC-V
run_rv32 "rv32 FizzBuzz(15)" \
    "$SCRIPT_DIR/fizzbuzz.tc" \
    "1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz"


# ===== else if tests =====

run_test "interp else if chain (classify)" \
    "$INTERP $SCRIPT_DIR/elseif_test.tc" \
    "0
1
2
3"

run_test "bcrun else if chain (classify)" \
    "$CODEGEN $SCRIPT_DIR/elseif_test.tc | $BCRUN" \
    "0
1
2
3"

# ===== character literal tests =====

run_test "interp character literals (A=65 Z=90 \\n=10 \\t=9 '=39)" \
    "$INTERP $SCRIPT_DIR/charliteral_test.tc" \
    "65
90
10
9
39"

run_test "bcrun character literals (A=65 Z=90 \\n=10 \\t=9 '=39)" \
    "$CODEGEN $SCRIPT_DIR/charliteral_test.tc | $BCRUN" \
    "65
90
10
9
39"

# ===== break / continue テスト =====

run_test_exit "interp break exits loop at i==5" \
    "$INTERP $SCRIPT_DIR/break_test.tc" 5

run_test_exit "interp continue sums odd 1-9 = 25" \
    "$INTERP $SCRIPT_DIR/continue_test.tc" 25

run_test_exit "interp nested break only exits inner loop (result=6)" \
    "$INTERP $SCRIPT_DIR/nested_break_test.tc" 6

run_test_exit "bcrun break exits loop at i==5" \
    "$CODEGEN $SCRIPT_DIR/break_test.tc | $BCRUN" 5

run_test_exit "bcrun continue sums odd 1-9 = 25" \
    "$CODEGEN $SCRIPT_DIR/continue_test.tc | $BCRUN" 25

run_test_exit "bcrun nested break only exits inner loop (result=6)" \
    "$CODEGEN $SCRIPT_DIR/nested_break_test.tc | $BCRUN" 6

# ===== tinyc パイプラインテスト (parse.tc + codegen.tc を bcrun 上で動かす) =====
echo "=== Pipeline Tests ==="
echo ""

SRC_DIR="$ROOT_DIR/compiler"

# パイプライン用チェックヘルパー
check_output() {
    local name="$1" expected="$2" actual="$3"
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"; PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        printf "  expected: %s\n" "$(echo "$expected" | head -3)"
        printf "  actual:   %s\n" "$(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

check_contains() {
    local name="$1" needle="$2" actual="$3"
    if echo "$actual" | grep -qF "$needle"; then
        echo "PASS: $name"; PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected to contain: $needle"
        printf "  actual: %s\n" "$(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

# parse.tc のバイトコードを一度生成（後続テストで再利用）
source "$SCRIPT_DIR/compile_tc.sh"
PARSE_TC_BC=$(compile_tc_to_bc "$SRC_DIR/parse.tc")
TYPECHECK_TC_BC=$(compile_tc_to_bc "$SRC_DIR/typecheck.tc")
CODEGEN_TC_BC=$(compile_tc_to_bc "$SRC_DIR/codegen.tc")

# parse.tc を bcrun 上で動かして fib.tc を構文解析する
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>&1)
check_contains "pipeline[1]: parse.tc parses fib.tc → (program" "(program" "$actual"
check_contains "pipeline[1]: parse.tc parses fib.tc → (fn fib" "(fn fib" "$actual"

# parse.tc を bcrun 上で動かして calc.tc を構文解析する
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>&1)
check_contains "pipeline[1]: parse.tc parses calc.tc → (fn main" "(fn main" "$actual"

# codegen.tc を bcrun 上で動かして fib.tc の AST からバイトコードを生成する
FIB_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null)
FIB_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$FIB_AST"; } | "$BCRUN" 2>/dev/null)
actual=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>&1)
check_contains "pipeline[2]: codegen.tc generates .fn fib" ".fn fib i32 i32" "$actual"
check_contains "pipeline[2]: codegen.tc generates .endbc" ".endbc" "$actual"

# フルパイプライン: parse.tc → typecheck.tc → codegen.tc → bcrun で fib.tc をコンパイル・実行
FIB_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>/dev/null)
actual=$(printf '%s\n' "$FIB_BC" | "$BCRUN" 2>&1)
check_output "pipeline[3]: tinyc compile+run fib(10) = 55" "55" "$actual"

# フルパイプライン: calc.tc をコンパイルして stdin 付きで実行
CALC_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>/dev/null)
CALC_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CALC_AST"; } | "$BCRUN" 2>/dev/null)
CALC_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CALC_TAST"; } | "$BCRUN" 2>/dev/null)
actual=$({ printf '%s\n' "$CALC_BC"; printf '12 + 34 * 56'; } | "$BCRUN" 2>&1)
check_output "pipeline[3]: tinyc compile+run calc.tc (12+34*56=1916)" "1916" "$actual"

# フルパイプライン: break_test.tc
BREAK_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/break_test.tc"; } | "$BCRUN" 2>/dev/null)
BREAK_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$BREAK_AST"; } | "$BCRUN" 2>/dev/null)
BREAK_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$BREAK_TAST"; } | "$BCRUN" 2>/dev/null)
printf '%s\n' "$BREAK_BC" | "$BCRUN" > /dev/null 2>&1
check_output "pipeline[3]: break exits loop at i==5" "5" "$?"

# フルパイプライン: continue_test.tc
CONT_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/continue_test.tc"; } | "$BCRUN" 2>/dev/null)
CONT_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CONT_AST"; } | "$BCRUN" 2>/dev/null)
CONT_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CONT_TAST"; } | "$BCRUN" 2>/dev/null)
printf '%s\n' "$CONT_BC" | "$BCRUN" > /dev/null 2>&1
check_output "pipeline[3]: continue sums odd 1-9 = 25" "25" "$?"

# ===== bc2asm.tc パイプラインテスト =====
echo "=== bc2asm.tc Pipeline Tests ==="
echo ""

source "$SCRIPT_DIR/compile_tc.sh"
BC2ASM_TC_BC=$(compile_tc_to_bc "$ROOT_DIR/compiler/bc2asm.tc" 2>/dev/null)

# bc2asm.tc で fib.tc バイトコードを RISC-V アセンブリに変換して実行
FIB_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIB_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fib_$$.s"
    elf_file="/tmp/tc_bc2asm_fib_$$"
    printf '%s\n' "$FIB_ASM_S" > "$asm_file"
    if $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        rm -f "$asm_file" "$elf_file"
        check_output "bc2asm.tc: fib(10) = 55 via rv32" "55" "$actual"
    else
        echo "FAIL: bc2asm.tc: fib(10) rv32 (compile error)"; FAIL=$((FAIL+1)); rm -f "$asm_file"
    fi
else
    echo "FAIL: bc2asm.tc: fib(10) rv32 (no asm output)"; FAIL=$((FAIL+1))
fi

# bc2asm.tc で fizzbuzz.tc バイトコードを変換して実行
FIZZ_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fizzbuzz.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIZZ_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fizz_$$.s"
    elf_file="/tmp/tc_bc2asm_fizz_$$"
    printf '%s\n' "$FIZZ_ASM_S" > "$asm_file"
    if $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        rm -f "$asm_file" "$elf_file"
        expected="1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz"
        check_output "bc2asm.tc: FizzBuzz(15) via rv32" "$expected" "$actual"
    else
        echo "FAIL: bc2asm.tc: FizzBuzz rv32 (compile error)"; FAIL=$((FAIL+1)); rm -f "$asm_file"
    fi
else
    echo "FAIL: bc2asm.tc: FizzBuzz rv32 (no asm output)"; FAIL=$((FAIL+1))
fi

# ===== tc_run_all.sh 全方式一致テスト =====
echo "=== tc_run_all.sh Consistency Tests ==="
echo ""

TC_RUN_ALL="$ROOT_DIR/tc_run_all.sh"
ALL_AGREE=">>> All methods produced identical output."

run_test_contains "tc_run_all hello.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/hello.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all fib.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/fib.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all fizzbuzz.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/fizzbuzz.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all calc.tc all methods agree (12+34*56)" \
    "$TC_RUN_ALL $SCRIPT_DIR/calc.tc '12 + 34 * 56'" \
    "$ALL_AGREE"

run_test_contains "tc_run_all elseif_test.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/elseif_test.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all charliteral_test.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/charliteral_test.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all break_test.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/break_test.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all continue_test.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/continue_test.tc" \
    "$ALL_AGREE"

run_test_contains "tc_run_all nested_break_test.tc all methods agree" \
    "$TC_RUN_ALL $SCRIPT_DIR/nested_break_test.tc" \
    "$ALL_AGREE"

# ===== Golden Tests =====
echo ""
if "$SCRIPT_DIR/run_golden_tests.sh"; then
    echo "Golden tests passed."
else
    echo "Golden tests failed."
    FAIL=$((FAIL+1))
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
