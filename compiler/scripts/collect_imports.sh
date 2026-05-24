#!/bin/bash
# collect_imports.sh — emit the transitive .tc import closure of a
# TinyC source file, newline-separated. Used to generate Makefile .d
# files so that `import "foo.tc";` edits trigger only the affected
# downstream targets to rebuild.
#
# Usage:
#   tools/collect_imports.sh compiler/parse.tc
#
# Output (one path per line, sorted, including the input itself):
#   compiler/parse.tc
#   compiler/source_reader.tc
#   compiler/string_buffer.tc
#   compiler/strlib.tc
#
# Rules:
#   - `import "foo.tc";` resolves relative to the importing file's dir
#   - Non-existent imports (stdlib-only stubs) are silently skipped
#   - Cycles are tolerated (visited set)
#   - Symlinks are resolved via readlink so
#     kernel/tasks/parse/parse.tc -> compiler/parse.tc produces deps
#     under compiler/ (same approach compile-gen2.sh uses)

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.tc>" >&2
    exit 1
fi

_ROOT="$1"
if [ -L "$_ROOT" ]; then
    _ROOT="$(readlink -f "$_ROOT")"
fi
if [ ! -f "$_ROOT" ]; then
    echo "$0: not a file: $1" >&2
    exit 1
fi

_VISITED=""

_walk() {
    local tc="$1" tc_dir
    tc_dir=$(dirname "$tc")
    # mark visited
    _VISITED="${_VISITED}${tc}
"
    # parse `import "..."` lines. Use a here-doc so we don't spawn
    # a subshell that would swallow _VISITED updates.
    local imports
    imports=$(grep '^import "' "$tc" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/' || true)
    local imp full
    while IFS= read -r imp; do
        [ -z "$imp" ] && continue
        full="$tc_dir/$imp"
        if [ -L "$full" ]; then
            full="$(readlink -f "$full")"
        fi
        if [ ! -f "$full" ]; then
            continue
        fi
        if echo "$_VISITED" | grep -qxF "$full"; then
            continue
        fi
        _walk "$full"
    done <<EOF
$imports
EOF
}

_walk "$_ROOT"

# Output sorted unique paths
printf '%s\n' "$_VISITED" | sed '/^$/d' | sort -u
