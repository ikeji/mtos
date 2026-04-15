#!/bin/bash
# test_split.sh — diff harness for the typecheck split (#52).
#
# Verifies that the new sigscan + tcheck pipeline produces .tast
# byte-identical to the legacy compiler/typecheck.tc on a battery of
# real .tc inputs:
#
#   parse < $TC > a.ast
#   sigscan < a.ast > a.th         (extended .th: all top-level decls)
#   { (imports …); (self <a.th>); a.ast } | tcheck > new.tast
#
#   { (imports …); a.ast } | typecheck > old.tast
#
#   diff old.tast new.tast
#
# (imports …) is built per-file by walking import "..." statements
# transitively and feeding each through Gen1 extract-sigs (NOT sigscan,
# so the legacy typecheck path stays on its native .th format).
#
# All inputs in compiler/*.tc and tests/*.tc / tests/import/*.tc are
# checked. Any mismatch prints the first 30 lines of diff and exits 1.
#
# NOT run by `make test` — it builds Gen1 binaries for sigscan,
# tcheck and typecheck.tc then runs each over many fixtures via
# qemu-riscv32, which adds ~30 seconds. Invoke manually:
#
#   tests/test_split.sh
#
# A successful run prints one "OK <file>" line per fixture and the
# final "All N inputs match." Any DIFF aborts with details.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$ROOT_DIR"

if ! command -v qemu-riscv32 >/dev/null 2>&1; then
    echo "SKIP: qemu-riscv32 not installed" >&2
    exit 0
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ----- Build the new and old binaries via compile-gen1.sh -----
#
# We use Gen1 (./compile-gen1.sh) for both sides because:
# - it's much faster than going through Gen2 (parse/typecheck/codegen
#   /bc2asm/asm) which would multiply build time by ~5x
# - bootstrap/runtime_syscall.c has the kmalloc__i32 stub that
#   tcheck.tc::ft_alloc needs, so the link works
# - typecheck.tc compiled via Gen1 is the "old" reference; it's
#   different from the bootstrap C ./typecheck (which prints bool
#   literals slightly differently — see tcheck commit history)

echo "Building reference (typecheck.tc) and new (sigscan + tcheck)..."
./compile-gen1.sh -o "$TMP/typecheck_tc" compiler/typecheck.tc 2>&1 | tail -3
./compile-gen1.sh -o "$TMP/sigscan"      compiler/sigscan.tc   2>&1 | tail -3
./compile-gen1.sh -o "$TMP/tcheck"       compiler/tcheck.tc    2>&1 | tail -3

if [ ! -x "$TMP/typecheck_tc" ] || [ ! -x "$TMP/sigscan" ] || [ ! -x "$TMP/tcheck" ]; then
    echo "FAIL: build" >&2
    exit 1
fi

# ----- Helper: collect transitive imports of a .tc file -----
collect_imports() {
    local file="$1"
    local dir
    dir=$(dirname "$file")
    grep -oE '^import "[^"]+";' "$file" 2>/dev/null \
        | sed 's/^import "\(.*\)";$/\1/' \
        | while read -r impfile; do
            local resolved=""
            if [ -f "$dir/$impfile" ]; then
                resolved="$dir/$impfile"
            elif [ -f "compiler/$impfile" ]; then
                resolved="compiler/$impfile"
            fi
            [ -z "$resolved" ] && continue
            echo "$resolved"
            collect_imports "$resolved"
        done
}

# ----- Helper: build the imports.txt block for one input -----
build_imports_block() {
    local tc="$1"
    local dst="$2"
    local imports
    imports=$(collect_imports "$tc" | sort -u)
    {
        printf '(imports\n'
        for imp in $imports; do
            ./parse "$imp" > "$TMP/i.ast" 2>/dev/null
            ./extract-sigs < "$TMP/i.ast" 2>/dev/null
        done
        printf ')\n'
    } > "$dst"
}

# ----- Per-file diff -----
PASS=0
FAIL=0
diff_one() {
    local tc="$1"
    ./parse "$tc" > "$TMP/main.ast" 2>/dev/null
    qemu-riscv32 "$TMP/sigscan" < "$TMP/main.ast" > "$TMP/main.th" 2>/dev/null

    build_imports_block "$tc" "$TMP/imports.txt"

    # Old: typecheck.tc (Gen1 build) reads (imports …) + .ast
    {
        cat "$TMP/imports.txt"
        cat "$TMP/main.ast"
    } | qemu-riscv32 "$TMP/typecheck_tc" > "$TMP/old.tast" 2>/dev/null

    # New: tcheck reads (imports …) + (self …) + (program …)
    {
        cat "$TMP/imports.txt"
        printf '(self\n'
        cat "$TMP/main.th"
        printf ')\n'
        cat "$TMP/main.ast"
    } | qemu-riscv32 "$TMP/tcheck" > "$TMP/new.tast" 2>/dev/null

    if diff -q "$TMP/old.tast" "$TMP/new.tast" > /dev/null; then
        printf 'OK   %s\n' "$tc"
        PASS=$((PASS + 1))
    else
        printf 'DIFF %s\n' "$tc"
        diff "$TMP/old.tast" "$TMP/new.tast" | head -30
        FAIL=$((FAIL + 1))
    fi
}

# ----- Fixture set -----
echo ""
echo "=== compiler/*.tc ==="
for f in compiler/strlib.tc compiler/source_reader.tc compiler/string_buffer.tc \
         compiler/ast_node.tc compiler/extract_sigs.tc compiler/sigscan.tc \
         compiler/runtime.tc compiler/codegen.tc compiler/typecheck.tc \
         compiler/parse.tc compiler/bc2asm.tc compiler/bcrun.tc \
         compiler/asm.tc compiler/tcheck.tc; do
    diff_one "$f"
done

echo ""
echo "=== tests/*.tc ==="
for f in tests/*.tc; do
    [ -f "$f" ] || continue
    diff_one "$f"
done

echo ""
echo "=== tests/import/*.tc ==="
for f in tests/import/*.tc; do
    [ -f "$f" ] || continue
    # *_fail.tc fixtures are intentional typecheck-error cases (they
    # test error reporting, not happy-path output). Skip them — the
    # diff harness only verifies byte-equivalence on inputs both
    # tools accept.
    case "$f" in
        *_fail.tc) printf 'SKIP %s (intentional fail case)\n' "$f"; continue ;;
    esac
    diff_one "$f"
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
echo "All $PASS inputs match."
exit 0
