#!/bin/bash
# check-test-isolation.sh — verify make -C <subproject> test reads only
# its own + dependency subprojects' files.
#
# Usage: ./integration/check-test-isolation.sh <compiler|kernel|userland>
#
# Allowed read paths per sub-project:
#   compiler — compiler/**, build/**, system paths
#   userland — compiler/**, userland/**, build/**, system paths
#   kernel   — compiler/**, userland/**, kernel/**, build/**, system paths
#   (integration is forbidden in all)
#
# 違反検出: 隣のサブプロジェクトの .tc / .sh / .md などを open したら
# WARN として報告。Exit 0 if no violations, 1 otherwise.
#
# 注: cross-sub delegation のため compiler が userland/**/task.mk を
# wildcard で touch する。これは include/wildcard 上の metadata read で
# allowed list に明示的に含める。

set -e

SUBPROJ="${1:-}"
if [ -z "$SUBPROJ" ]; then
    echo "Usage: $0 <compiler|kernel|userland>" >&2
    exit 2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

case "$SUBPROJ" in
    compiler) ALLOWED_SUBS="compiler" ;;
    userland) ALLOWED_SUBS="compiler userland" ;;
    kernel)   ALLOWED_SUBS="compiler userland kernel" ;;
    *)
        echo "Error: unknown subproject '$SUBPROJ'" >&2
        exit 2
        ;;
esac

LOG="$(mktemp)"
trap "rm -f $LOG" EXIT

echo "=== Running 'make -C $SUBPROJ test' under strace ===" >&2
strace -f -e trace=openat -o "$LOG" make -C "$SUBPROJ" test >/dev/null 2>&1 || true

# Parse openat() calls. strace lines look like:
#   PID openat(AT_FDCWD, "/path", O_RDONLY) = N
# We want successful opens (= N where N >= 0).

# Extract paths under ROOT_DIR/ (project-internal) but not in
# allowed subprojects nor in shared dirs.
VIOLATIONS=$(
    grep 'openat(' "$LOG" \
        | grep -oP '"\K[^"]+' \
        | grep "^$ROOT_DIR/" \
        | sed "s|^$ROOT_DIR/||" \
        | sort -u \
        | awk -v allowed="$ALLOWED_SUBS" '
            BEGIN {
                n = split(allowed, a, " ")
                for (i = 1; i <= n; i++) allowed_arr[a[i]] = 1
            }
            {
                # Top-level dir or file in path
                slash = index($0, "/")
                if (slash > 0) top = substr($0, 1, slash - 1)
                else           top = $0
                # Allow non-subproject dirs (shared infra, build outputs)
                if (top == "build" || top == "tmp" || top == "docs" || \
                    top == "Makefile" || top == "README.md" || \
                    top == "CLAUDE.md" || top == ".git") next
                # Allow this subproject and its deps
                if (top in allowed_arr) next
                # Otherwise it is a violation
                print
            }
        '
)

if [ -z "$VIOLATIONS" ]; then
    echo "PASS: $SUBPROJ test reads stayed within $ALLOWED_SUBS + shared infra" >&2
    exit 0
fi

echo "FAIL: $SUBPROJ test read files outside $ALLOWED_SUBS:" >&2
echo "$VIOLATIONS" | head -30 | sed 's|^|  |' >&2
n=$(echo "$VIOLATIONS" | wc -l)
if [ "$n" -gt 30 ]; then
    echo "  ... ($((n - 30)) more)" >&2
fi
exit 1
