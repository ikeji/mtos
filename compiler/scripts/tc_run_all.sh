#!/bin/bash
# tc_run_all.sh — run a .tc program with all execution methods and compare results
#
# Usage: tc_run_all.sh <file.tc> [stdin]
#
#   [stdin]  string passed as program stdin; prefix '@' to read from file

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TC_RUN="$ROOT_DIR/compiler/scripts/tc_run.sh"

TC_FILE="${1:-}"
STDIN_ARG="${2:-}"

if [ -z "$TC_FILE" ]; then
    echo "Usage: tc_run_all.sh <file.tc> [stdin]"
    exit 1
fi
if [ ! -f "$TC_FILE" ]; then echo "Error: not found: $TC_FILE" >&2; exit 1; fi

METHODS=(interp bcrun rv32 pipeline bc2asm_tc)

run_method() {
    local method="$1"
    local output exit_code
    if [ -n "$STDIN_ARG" ]; then
        output=$("$TC_RUN" "$method" "$TC_FILE" "$STDIN_ARG" 2>/dev/null)
    else
        output=$("$TC_RUN" "$method" "$TC_FILE" 2>/dev/null)
    fi
    exit_code=$?
    printf '%s\n' "$output"
    return $exit_code
}

FIRST_OUTPUT=""
FIRST_SET=false
ALL_SAME=true

for method in "${METHODS[@]}"; do
    printf '=== %-12s ' "$method"
    output=$(run_method "$method")
    ec=$?
    printf '(exit %d) ===\n' "$ec"
    printf '%s\n' "$output"
    echo ""

    # A method that fails to launch must not count as "agreeing" (a
    # stale TC_RUN path once made every method exit 127 with empty
    # output, which the old empty-string sentinel scored as a pass).
    # Other exit codes are part of the program result (fib.tc returns
    # 55) and must agree across methods like the output does.
    if [ $ec -eq 126 ] || [ $ec -eq 127 ]; then
        ALL_SAME=false
        continue
    fi
    combined="exit=$ec
$output"
    if ! $FIRST_SET; then
        FIRST_OUTPUT="$combined"
        FIRST_SET=true
    elif [ "$combined" != "$FIRST_OUTPUT" ]; then
        ALL_SAME=false
    fi
done

if $ALL_SAME; then
    echo ">>> All methods produced identical output."
else
    echo ">>> WARNING: methods produced different output."
fi
