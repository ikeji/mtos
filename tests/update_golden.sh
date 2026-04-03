#!/bin/bash
# Update golden files for parser, codegen, bc2asm, and execution

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GOLDEN_DIR="$SCRIPT_DIR/golden"
TC_DIR="$ROOT_DIR/tc"

PARSE="$ROOT_DIR/parse"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"

# Ensure binaries exist
if [ ! -x "$PARSE" ] || [ ! -x "$CODEGEN" ] || [ ! -x "$BCRUN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: basic tools (parse, codegen, bcrun, bc2asm) not found. Build them first." >&2
    exit 1
fi

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

# Define stdin for specific tests
get_stdin() {
    case "$1" in
        "calc.tc") echo -n "12 + 34 * 56" ;;
        *) echo -n "" ;;
    esac
}

PARSE_TC_BC=$("$PARSE" "$TC_DIR/parse.tc" | "$CODEGEN" 2>/dev/null)

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
    { echo "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" > "$GOLDEN_DIR/$base.ast.tc" 2>/dev/null
    
    # 2. Update Bytecode
    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    echo "$bc" > "$GOLDEN_DIR/$base.bc"

    # 3. Update Assembly
    echo "$bc" | "$BC2ASM" > "$GOLDEN_DIR/$base.s" 2>/dev/null

    # 4. Update Execution Output and Exit Code (via bcrun)
    stdin=$(get_stdin "$f")
    { echo "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$GOLDEN_DIR/$base.out" 2>/dev/null
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
    { echo "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" > "$GOLDEN_DIR/tc/$base.ast.tc" 2>/dev/null

    # 2. Update Bytecode
    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    echo "$bc" > "$GOLDEN_DIR/tc/$base.bc"

    # 3. Update Assembly
    echo "$bc" | "$BC2ASM" > "$GOLDEN_DIR/tc/$base.s" 2>/dev/null

    # 4. Update Execution Output and Exit Code (via bcrun)
    exec_input=$(get_tc_exec_input_file "$f")
    { echo "$bc"; cat "$exec_input"; } | "$BCRUN" > "$GOLDEN_DIR/tc/$base.out" 2>/dev/null
    echo $? > "$GOLDEN_DIR/tc/$base.exit"
done

echo "Done."
