#!/bin/bash
# Update golden files for parser, codegen, bc2asm, and execution

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

# Ensure binaries exist
if [ ! -x "$PARSE" ] || [ ! -x "$CODEGEN" ] || [ ! -x "$BCRUN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: basic tools (parse, codegen, bcrun, bc2asm) not found. Build them first." >&2
    exit 1
fi

source "$SCRIPT_DIR/compile_tc.sh"

# Build Gen2 RISC-V binaries for fast self-hosted execution
USE_NATIVE=false
GEN2_TMP=""
if command -v "$RISCV_CC" >/dev/null 2>&1 && command -v "$QEMU" >/dev/null 2>&1; then
    GEN2_TMP=$(mktemp -d)

    build_gen2_tool() {
        local name="$1"
        local tc_file="$TC_DIR/$name.tc"
        local tc_dir
        tc_dir=$(dirname "$tc_file")
        local imports=() asm_files=()
        while IFS= read -r imp; do
            imports+=("$tc_dir/$imp")
        done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
        for imp_file in "${imports[@]}"; do
            local base=$(basename "$imp_file" .tc)
            "$CODEGEN" "$imp_file" 2>/dev/null | "$BC2ASM" > "$GEN2_TMP/${name}_dep_${base}.s" 2>/dev/null
            asm_files+=("$GEN2_TMP/${name}_dep_${base}.s")
        done
        "$CODEGEN" "$tc_file" 2>/dev/null | "$BC2ASM" > "$GEN2_TMP/$name.s" 2>/dev/null
        asm_files+=("$GEN2_TMP/$name.s")
        $RISCV_CC $RISCV_FLAGS "$CRT0" "$RUNTIME" "${asm_files[@]}" -o "$GEN2_TMP/$name" 2>/dev/null
    }

    build_gen2_tool "parse"
    build_gen2_tool "typecheck"
    build_gen2_tool "codegen"
    build_gen2_tool "bc2asm"

    if [ -x "$GEN2_TMP/parse" ] && [ -x "$GEN2_TMP/typecheck" ] && \
       [ -x "$GEN2_TMP/codegen" ] && [ -x "$GEN2_TMP/bc2asm" ]; then
        USE_NATIVE=true
    fi
fi

# Fallback: compile Gen2 BCs for bcrun
if [ "$USE_NATIVE" = false ]; then
    PARSE_TC_BC=$(compile_tc_to_bc "$TC_DIR/parse.tc")
    TYPECHECK_TC_BC=$(compile_tc_to_bc "$TC_DIR/typecheck.tc")
    CODEGEN_TC_BC=$(compile_tc_to_bc "$TC_DIR/codegen.tc")
fi

# Helpers for self-hosted tool execution
run_parse_tc() {
    local input="$1"
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/parse" < "$input" 2>/dev/null
    else
        { printf '%s\n' "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" 2>/dev/null
    fi
}

run_typecheck_tc() {
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/typecheck" 2>/dev/null
    else
        { printf '%s\n' "$TYPECHECK_TC_BC"; cat; } | "$BCRUN" 2>/dev/null
    fi
}

run_codegen_tc() {
    if [ "$USE_NATIVE" = true ]; then
        "$QEMU" "$GEN2_TMP/codegen" 2>/dev/null
    else
        { printf '%s\n' "$CODEGEN_TC_BC"; cat; } | "$BCRUN" 2>/dev/null
    fi
}

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
    "type_test.tc"
    "struct_basic.tc"
)

# Define stdin for specific tests
get_stdin() {
    case "$1" in
        "calc.tc") echo -n "12 + 34 * 56" ;;
        *) echo -n "" ;;
    esac
}

echo "Updating golden files in $GOLDEN_DIR..."

for f in "${FILES[@]}"; do
    input="$SCRIPT_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping $f (not found)..."
        continue
    fi

    echo "Processing $f..."

    # 1. Update AST (C impl)
    "$PARSE" "$input" > "$GOLDEN_DIR/$base.ast" 2>/dev/null
    # 1b. Update AST (parse.tc self-hosted)
    run_parse_tc "$input" > "$GOLDEN_DIR/$base.ast.tc" 2>/dev/null

    # 2. Update Bytecode
    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    printf '%s\n' "$bc" >"$GOLDEN_DIR/$base.bc"

    # 3. Update Assembly
    printf '%s\n' "$bc" | "$BC2ASM" > "$GOLDEN_DIR/$base.s" 2>/dev/null

    # 4. Update Execution Output and Exit Code (via bcrun)
    stdin=$(get_stdin "$f")
    { printf '%s\n' "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$GOLDEN_DIR/$base.out" 2>/dev/null
    echo $? > "$GOLDEN_DIR/$base.exit"
done

TC_FILES=(
    "parse.tc"
    "codegen.tc"
    "bc2asm.tc"
    "bcrun.tc"
)

# Return the file to pipe as stdin when executing each compiled tc file
get_tc_exec_input_file() {
    case "$1" in
        "parse.tc") echo "$SCRIPT_DIR/hello.tc" ;;
        "codegen.tc") echo "$GOLDEN_DIR/hello.ast" ;;
        "bc2asm.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        "bcrun.tc") echo "$GOLDEN_DIR/hello.bc" ;;
        *) echo "/dev/null" ;;
    esac
}

mkdir -p "$GOLDEN_DIR/tc"

echo "Updating golden files for tc/ compiler source files..."

for f in "${TC_FILES[@]}"; do
    input="$TC_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping tc/$f (not found)..."
        continue
    fi

    echo "Processing tc/$f..."

    # 1. Update AST (C impl)
    "$PARSE" "$input" > "$GOLDEN_DIR/tc/$base.ast" 2>/dev/null
    # 1b. Update AST (parse.tc self-hosted)
    run_parse_tc "$input" > "$GOLDEN_DIR/tc/$base.ast.tc" 2>/dev/null

    # 2. Update Bytecode (use file arg so import is resolved)
    "$CODEGEN" "$input" >"$GOLDEN_DIR/tc/$base.bc" 2>/dev/null
    bc=$(cat "$GOLDEN_DIR/tc/$base.bc")
    # 2b. Update Bytecode (codegen.tc self-hosted — no source comments)
    "$PARSE" "$input" 2>/dev/null | run_typecheck_tc | run_codegen_tc > "$GOLDEN_DIR/tc/$base.bc.tc" 2>/dev/null

    # 3. Update Assembly
    printf '%s\n' "$bc" | "$BC2ASM" > "$GOLDEN_DIR/tc/$base.s" 2>/dev/null

    # 4. Update Execution Output and Exit Code (via bcrun)
    exec_input=$(get_tc_exec_input_file "$f")
    { printf '%s\n' "$bc"; cat "$exec_input"; } | "$BCRUN" > "$GOLDEN_DIR/tc/$base.out" 2>/dev/null
    echo $? > "$GOLDEN_DIR/tc/$base.exit"
done

[ -n "$GEN2_TMP" ] && rm -rf "$GEN2_TMP"

echo "Done."
