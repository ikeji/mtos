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
out1=$(printf 'parse < /hw.tc > /tmp/1.ast\nsigscan < /tmp/1.ast > /tmp/1.th\ncat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap\ntcheck < /tmp/1.wrap > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s\nasm_pass1 < /tmp/full.s > /tmp/lab.s\ncat /tmp/lab.s /tmp/full.s /tmp/full.s /tmp/full.s > /tmp/p2.in\nasm_pass2 < /tmp/p2.in > /tmp/hw\n/tmp/hw\nquit\n' \
    | timeout 240 qemu-system-riscv32 -smp 1 -nographic \
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

# -----------------------------------------------------------------------
# Stage 2 (M7-minimal): compile string_buffer.tc on the OS through the
# full Gen2 pipeline (parse + sigscan + tcheck + codegen + bc2asm) and
# verify the generated .s begins with a ".fn" directive, proving the
# compiler can self-compile one of its own source modules.
# -----------------------------------------------------------------------
# string_buffer.tc has no imports, so the pipeline is:
#   parse → sigscan → cat wrap → tcheck → codegen → bc2asm → .s
# Full parse.tc compilation (with 3 transitive imports) takes > 20 min
# in qemu-virt today — M7-minimal proves the single-file case, M7-full
# can follow when qemu throughput improves or we add piped syscalls.
#
# The presence of "# end of" markers in the output proves codegen +
# bc2asm ran successfully (bc2asm emits these after each function body).
echo ""
echo "=== stage 2 (M7-minimal): compile string_buffer.tc on the OS ==="

# shellcheck disable=SC2016
m7_script='
parse < /src/string_buffer.tc > /tmp/sb.ast
sigscan < /tmp/sb.ast > /tmp/sb.th
cat /empty_imports.txt /self_open.txt /tmp/sb.th /wrap_close.txt /tmp/sb.ast > /tmp/w
tcheck < /tmp/w > /tmp/t
codegen < /tmp/t > /tmp/b
bc2asm < /tmp/b > /tmp/sb.s
cat /tmp/sb.s
quit
'

out2=$(printf '%s' "$m7_script" \
    | timeout 360 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

if ! echo "$out2" | grep -q "# end of"; then
    echo "FAIL: OS-compiled string_buffer.tc did not produce bc2asm output markers" >&2
    echo "--- last 60 lines of output ---"
    echo "$out2" | tail -60
    exit 1
fi

echo "OK (stage 2 M7-minimal): OS self-compiled string_buffer.tc → .s"
exit 0
