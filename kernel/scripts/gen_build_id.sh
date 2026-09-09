#!/bin/sh
# gen_build_id.sh OUT.s — emit the kernel's build stamp as an assembly blob
# that the kernel links in, so /proc/kernel can report which kernel binary is
# actually running (see kernel/src/procfs.tc).
#
# The stamp is "<git short hash>[+dirty] <src md5>":
#   * the git hash says which commit,
#   * the md5 of the kernel sources says which *content* — that one still
#     changes while the tree is dirty, which the git hash alone does not.
# There is deliberately no timestamp: the stamp has to be stable across a
# no-op rebuild, otherwise every `make` would relink the whole kernel.
#
# OUT.s is only rewritten when the stamp actually changes, for the same reason.
set -e

out="$1"
if [ -z "$out" ]; then echo "usage: gen_build_id.sh OUT.s" >&2; exit 1; fi
root="$(cd "$(dirname "$0")/../.." && pwd)"

hash=$(git -C "$root" rev-parse --short=8 HEAD 2>/dev/null || echo unknown)
if ! git -C "$root" diff --quiet HEAD 2>/dev/null; then hash="$hash+dirty"; fi
src=$(cat "$root"/kernel/src/*.tc "$root"/kernel/src/*.s \
          "$root"/kernel/platform/*/*.tc "$root"/kernel/platform/*/*.s 2>/dev/null \
      | md5sum | cut -c1-8)

tmp="$out.tmp"
cat > "$tmp" <<EOF
    .rodata
    .align 4
    .globl kernel_build_str
kernel_build_str:
    .string "$hash $src"
    .text
    .globl kernel_build_str_addr
kernel_build_str_addr:
    la   a0, kernel_build_str
    ret
EOF

if [ -f "$out" ] && cmp -s "$tmp" "$out"; then
    rm -f "$tmp"          # unchanged — leave the old file (and its mtime) alone
else
    mv "$tmp" "$out"
fi
