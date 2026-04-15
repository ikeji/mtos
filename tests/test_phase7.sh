#!/bin/bash
# test_phase7.sh — phase 7 compiler-on-OS end-to-end test.
#
# Builds a kernel with EXTRA_TASKS set to ship /bin/parse, /bin/sigscan,
# /bin/tcheck, /bin/codegen, /bin/bc2asm, /bin/asm_pass1, /bin/asm_pass2
# and /bin/cat, then runs the full self-hosted compile pipeline from
# sh via intermediate files in /tmp. Two stages:
#
# Stage 1 (sigscan + tcheck): verifies that the typecheck split works
# end-to-end by compiling Hello World with the old (single-file) asm
# binary replaced by the asm_pass1 + asm_pass2 pair.
#
# Stage 2 (full split): same as stage 1 but also uses asm_pass1 +
# asm_pass2 instead of any legacy asm. (typecheck.tc and asm.tc no
# longer exist in the tree; see #61 cleanup.)
#
# NOT run by `make test` because it builds the compiler task binaries
# (adds ~12 seconds to the kernel build). Invoke manually:
#
#   GEN2_DIR=/tmp/gen2 tests/test_phase7.sh
#
# A successful run prints "OK (stage 1)" and "OK (stage 2)" and exits
# 0. Any missing stage prints the captured output and exits 1.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set (see tests/test_common.sh ensure_gen2_tools)" >&2
    exit 1
fi
if ! command -v qemu-system-riscv32 >/dev/null 2>&1; then
    echo "SKIP: qemu-system-riscv32 not installed" >&2
    exit 0
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "=== phase 7 compiler-on-OS ==="
echo "Building kernel with EXTRA_TASKS=parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat"
EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/kernel/build.sh" --target virt \
    -o "$TMP/kernel_virt" --disk-out "$TMP/disk.img" 2>&1 | tail -5

if [ ! -s "$TMP/kernel_virt" ] || [ ! -s "$TMP/disk.img" ]; then
    echo "FAIL: kernel build failed" >&2
    exit 1
fi

# -----------------------------------------------------------------------
# Stage 1: sigscan + tcheck pipeline with asm_pass1 + asm_pass2 linker.
# -----------------------------------------------------------------------
# parse → sigscan → cat-wrap → tcheck → codegen → bc2asm → cat prelude →
# asm_pass1 → cat lab → asm_pass2 → run.
#
# The (imports) / (self) / (program) wrapper is built on the OS side
# by cat'ing pre-staged tmpfs helper files (/empty_imports.txt,
# /self_open.txt, /wrap_close.txt) around the sigscan output and the
# parsed AST.
echo ""
echo "=== stage 1: compile + link + run Hello World ==="
out1=$(printf 'parse < /hw.tc > /tmp/1.ast\nsigscan < /tmp/1.ast > /tmp/1.th\ncat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap\ntcheck < /tmp/1.wrap > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s\nasm_pass1 < /tmp/full.s > /tmp/lab.s\ncat /tmp/lab.s /tmp/full.s > /tmp/p2.in\nasm_pass2 < /tmp/p2.in > /tmp/hw\n/tmp/hw\nquit\n' \
    | timeout 90 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

if ! echo "$out1" | grep -q "Hello, World!"; then
    echo "FAIL: OS-compiled Hello World (full split) did not print the expected greeting" >&2
    echo "--- output ---"
    echo "$out1"
    exit 1
fi

echo "OK (stage 1): full split pipeline (sigscan+tcheck+asm-pass1+asm-pass2) reached 'Hello, World!'"
exit 0
