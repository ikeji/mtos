#!/bin/bash
# test_split.sh — diff harness for the Phase 1 + Phase 2 splits.
#
# Two halves:
#
# 1. typecheck split (#52):
#      parse < $TC > a.ast
#      sigscan < a.ast > a.th     (extended .th: all top-level decls)
#      { (imports); (self <a.th>); a.ast } | tcheck > new.tast
#      { (imports); a.ast }        | typecheck > old.tast
#      diff old.tast new.tast
#
# 2. asm split (#57):
#      compile-gen2.sh ... > old.bin       (uses single-process asm.tc)
#      cat $TMP/full.s | asm-pass1 > a.lab
#      cat a.lab $TMP/full.s | asm-pass2 > new.bin
#      cmp old.bin new.bin
#
# (imports …) is built per-file by walking import statements
# transitively and feeding each through Gen1 extract-sigs (NOT
# sigscan, so the legacy typecheck path stays on its native .th
# format).
#
# All happy-path inputs in compiler/*.tc and tests/*.tc /
# tests/import/*.tc are checked for the typecheck split; the asm
# split runs over a smaller set of binary-producing inputs because
# each one needs a full compile-gen2.sh round-trip.
#
# NOT run by `make test` — builds Gen1 binaries for sigscan, tcheck,
# typecheck.tc, asm_pass1, asm_pass2 then runs each over many
# fixtures via qemu-riscv32. Invoke manually:
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

echo "Building reference (typecheck.tc) and new (sigscan + tcheck + asm_pass1 + asm_pass2)..."
./compile-gen1.sh -o "$TMP/typecheck_tc" compiler/typecheck.tc 2>&1 | tail -3
./compile-gen1.sh -o "$TMP/sigscan"      compiler/sigscan.tc   2>&1 | tail -3
./compile-gen1.sh -o "$TMP/tcheck"       compiler/tcheck.tc    2>&1 | tail -3
./compile-gen1.sh -o "$TMP/asm_pass1"    compiler/asm_pass1.tc 2>&1 | tail -3
./compile-gen1.sh -o "$TMP/asm_pass2"    compiler/asm_pass2.tc 2>&1 | tail -3

if [ ! -x "$TMP/typecheck_tc" ] || [ ! -x "$TMP/sigscan" ] || [ ! -x "$TMP/tcheck" ] \
   || [ ! -x "$TMP/asm_pass1" ] || [ ! -x "$TMP/asm_pass2" ]; then
    echo "FAIL: build" >&2
    exit 1
fi

# The asm half also needs a Gen2 toolchain ($GEN2_DIR) so compile-gen2.sh
# can produce the reference ELF and the intermediate full.s. Skip the
# asm half (with a notice) when it isn't available — the typecheck half
# still runs.
HAS_GEN2=0
if [ -n "$GEN2_DIR" ] && [ -x "$GEN2_DIR/asm" ]; then
    HAS_GEN2=1
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
         compiler/ast_node.tc compiler/sigscan.tc \
         compiler/runtime.tc compiler/codegen.tc compiler/typecheck.tc \
         compiler/parse.tc compiler/bc2asm.tc compiler/bcrun.tc \
         compiler/asm.tc compiler/tcheck.tc \
         compiler/asm_common.tc compiler/asm_pass1.tc compiler/asm_pass2.tc; do
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

# =====================================================================
# asm split (#57)
# =====================================================================
#
# For each input we re-run compile-gen2.sh with KEEP_TMP=1 so it keeps
# its tmp dir and writes the assembled .s to $TMP_GEN2/full.s before
# invoking the (old) asm. We then take the same full.s through
# asm_pass1 + asm_pass2 and cmp the resulting binaries.

asm_diff_one() {
    local tc="$1"
    local subtmp
    subtmp=$(mktemp -d)
    KEEP_TMP=1 GEN2_DIR="$GEN2_DIR" ./compile-gen2.sh -o "$subtmp/old.bin" "$tc" \
        2>"$subtmp/cg2.err" >/dev/null || true

    # compile-gen2.sh wrote its tmp to a fresh /tmp/tmp.* dir. Find the
    # most recently created /tmp/tmp.*/full.s.
    local cg2_tmp
    cg2_tmp=$(ls -td /tmp/tmp.*/full.s 2>/dev/null | head -1)
    if [ -z "$cg2_tmp" ] || [ ! -f "$cg2_tmp" ]; then
        printf 'SKIP %s (no full.s emitted by compile-gen2.sh)\n' "$tc"
        rm -rf "$subtmp"
        return
    fi
    if [ ! -s "$subtmp/old.bin" ]; then
        printf 'SKIP %s (compile-gen2.sh produced no binary)\n' "$tc"
        rm -rf "$subtmp"
        rm -rf "$(dirname "$cg2_tmp")"
        return
    fi

    qemu-riscv32 "$TMP/asm_pass1" < "$cg2_tmp" > "$subtmp/x.lab" 2>/dev/null
    cat "$subtmp/x.lab" "$cg2_tmp" | qemu-riscv32 "$TMP/asm_pass2" \
        > "$subtmp/new.bin" 2>/dev/null

    if cmp -s "$subtmp/old.bin" "$subtmp/new.bin"; then
        printf 'OK   %-30s %d bytes\n' "$tc" "$(stat -c%s "$subtmp/old.bin")"
        PASS=$((PASS + 1))
    else
        printf 'DIFF %-30s old=%d new=%d\n' "$tc" \
            "$(stat -c%s "$subtmp/old.bin")" \
            "$(stat -c%s "$subtmp/new.bin")"
        FAIL=$((FAIL + 1))
    fi
    rm -rf "$subtmp"
    rm -rf "$(dirname "$cg2_tmp")"
}

if [ "$HAS_GEN2" = "1" ]; then
    echo ""
    echo "=== asm split: compiler/*.tc via compile-gen2.sh ==="
    for f in compiler/parse.tc compiler/typecheck.tc compiler/codegen.tc \
             compiler/bc2asm.tc compiler/asm.tc compiler/sigscan.tc \
             compiler/tcheck.tc \
             compiler/asm_pass1.tc compiler/asm_pass2.tc; do
        asm_diff_one "$f"
    done
else
    echo ""
    echo "=== asm split ==="
    echo "SKIP: GEN2_DIR not set or \$GEN2_DIR/asm missing — re-run with"
    echo "      GEN2_DIR=/path/to/gen2 tests/test_split.sh"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
echo "All $PASS inputs match."
exit 0
