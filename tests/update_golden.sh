#!/bin/bash
# Update golden files for parser, codegen, bc2asm, and execution

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

# Build Gen2 tools (native or bcrun fallback)
ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    ensure_tc_bcs
fi

echo "Updating golden files in $GOLDEN_DIR..."

for f in "${EXAMPLE_FILES[@]}"; do
    input="$SCRIPT_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping $f (not found)..."
        continue
    fi

    echo "Processing $f..."

    "$PARSE" "$input" > "$GOLDEN_DIR/$base.ast" 2>/dev/null
    run_parse_tc "$input" > "$GOLDEN_DIR/$base.ast.tc" 2>/dev/null

    bc=$("$PARSE" "$input" 2>/dev/null | "$CODEGEN" 2>/dev/null)
    printf '%s\n' "$bc" >"$GOLDEN_DIR/$base.bc"

    printf '%s\n' "$bc" | "$BC2ASM" > "$GOLDEN_DIR/$base.s" 2>/dev/null

    stdin=$(get_stdin "$f")
    { printf '%s\n' "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$GOLDEN_DIR/$base.out" 2>/dev/null
    echo $? > "$GOLDEN_DIR/$base.exit"
done

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

    "$PARSE" "$input" > "$GOLDEN_DIR/tc/$base.ast" 2>/dev/null
    run_parse_tc "$input" > "$GOLDEN_DIR/tc/$base.ast.tc" 2>/dev/null

    "$CODEGEN" "$input" >"$GOLDEN_DIR/tc/$base.bc" 2>/dev/null
    bc=$(cat "$GOLDEN_DIR/tc/$base.bc")

    "$PARSE" "$input" 2>/dev/null | run_typecheck_tc | run_codegen_tc > "$GOLDEN_DIR/tc/$base.bc.tc" 2>/dev/null

    printf '%s\n' "$bc" | "$BC2ASM" > "$GOLDEN_DIR/tc/$base.s" 2>/dev/null

    exec_input=$(get_tc_exec_input_file "$f")
    { printf '%s\n' "$bc"; cat "$exec_input"; } | "$BCRUN" > "$GOLDEN_DIR/tc/$base.out" 2>/dev/null
    echo $? > "$GOLDEN_DIR/tc/$base.exit"
done

cleanup_gen2_tools
echo "Done."
