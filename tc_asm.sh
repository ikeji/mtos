#!/bin/bash
# tc_asm.sh — compile a .tc file using the asm.tc pipeline (no GCC linker)
# Usage: ./tc_asm.sh [-o output.elf] file.tc
#
# Pipeline: runtime.tc + file.tc → codegen → bc2asm → asm.tc → ELF

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEGEN="$ROOT_DIR/codegen"
BC2ASM="$ROOT_DIR/bc2asm"
BCRUN="$ROOT_DIR/bcrun"
CRT0="$ROOT_DIR/bootstrap/crt0_tc.s"
RUNTIME="$ROOT_DIR/compiler/runtime.tc"

SCRIPT_DIR="$ROOT_DIR/tests"
source "$ROOT_DIR/tests/test_common.sh"

OUTFILE="a.out"
TC_FILE=""

# Parse args
while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: tc_asm.sh [-o output.elf] file.tc" >&2
    exit 1
fi

# Compile runtime.tc (--no-builtins)
RUNTIME_BC=$("$CODEGEN" --no-builtins "$RUNTIME" 2>/dev/null)

# Compile user .tc file
USER_BC=$("$CODEGEN" "$TC_FILE" 2>/dev/null)

# Merge BCs and convert to assembly
MERGED_S=$(
    echo ".bc"
    printf '%s\n' "$RUNTIME_BC" | sed '/^\.bc$/d; /^\.endbc$/d'
    printf '%s\n' "$USER_BC" | sed '/^\.bc$/d; /^\.endbc$/d'
    echo ".endbc"
)
USER_S=$(printf '%s\n' "$MERGED_S" | "$BC2ASM" 2>/dev/null)

# Assemble: crt0_tc.s + user.s → ELF via asm.tc
ASM_BC=$(compile_tc_to_bc "$ROOT_DIR/compiler/asm.tc")
{ cat "$CRT0"; printf '%s\n' "$USER_S"; } | \
    { printf '%s\n' "$ASM_BC"; cat; } | "$BCRUN" > "$OUTFILE" 2>/dev/null

chmod +x "$OUTFILE"
echo "Output: $OUTFILE"
