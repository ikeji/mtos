#!/bin/bash
# compile_tc.sh — compile a .tc file to BC, resolving imports
# Sources this file and call: compile_tc_to_bc <file.tc>
# Returns merged BC on stdout (all imports + main file, single .endbc)
#
# Requires: PARSE, CODEGEN variables to be set by the caller.

# Compile a single .tc file to BC (with import resolution)
# Outputs merged BC to stdout
compile_tc_to_bc() {
    local tc_file="$1"
    local tc_dir
    tc_dir=$(dirname "$tc_file")

    # Extract import filenames (shallow: only direct imports)
    local imports=()
    while IFS= read -r imp; do
        imports+=("$tc_dir/$imp")
    done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')

    # Compile each import to BC, then the main file
    local all_bcs=()
    for imp_file in "${imports[@]}"; do
        if [ -f "$imp_file" ]; then
            all_bcs+=("$("$CODEGEN" "$imp_file" 2>/dev/null)")
        fi
    done
    all_bcs+=("$("$CODEGEN" "$tc_file" 2>/dev/null)")

    # Merge: strip .bc headers and .endbc, add single .endbc
    for bc in "${all_bcs[@]}"; do
        printf '%s\n' "$bc" | grep -v '^\.\(bc\|endbc\)$'
    done
    echo ".endbc"
}
