#!/bin/bash
# test_phase7.sh — phase 7 compiler-on-OS end-to-end test.
#
# Builds a kernel with EXTRA_TASKS set to ship /bin/parse,
# /bin/typecheck, /bin/codegen, /bin/bc2asm and runs the full
# compilation pipeline from sh via intermediate files in /tmp:
#
#   parse     < /phase7.tc > /tmp/1.ast
#   typecheck < /tmp/1.ast > /tmp/2.tast
#   codegen   < /tmp/2.tast > /tmp/3.bc
#   bc2asm    < /tmp/3.bc > /tmp/4.s
#   catfile /tmp/4.s
#
# Asserts that each stage writes non-zero bytes (via the kernel's
# [w slot:len] trace) and that the final .s starts with the
# expected assembly prelude (`.text` + `.globl main`).
#
# NOT run by `make test` because it builds four extra compiler task
# binaries (adds ~12 seconds to the kernel build). Invoke manually:
#
#   GEN2_DIR=/tmp/gen2 tests/test_phase7.sh
#
# A successful run prints "OK: compiler pipeline reached bc2asm" and
# exits 0. Any missing stage prints the captured output and exits 1.

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
echo "Building kernel with EXTRA_TASKS=parse sigscan typecheck tcheck codegen bc2asm asm asm_pass1 asm_pass2 cat"
EXTRA_TASKS="parse sigscan typecheck tcheck codegen bc2asm asm asm_pass1 asm_pass2 cat" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/kernel/build.sh" --target virt \
    -o "$TMP/kernel_virt" --disk-out "$TMP/disk.img" 2>&1 | tail -5

if [ ! -s "$TMP/kernel_virt" ] || [ ! -s "$TMP/disk.img" ]; then
    echo "FAIL: kernel build failed" >&2
    exit 1
fi

echo "Running 4-stage pipeline under qemu virt"
out=$(printf 'parse < /phase7.tc > /tmp/1.ast\ntypecheck < /tmp/1.ast > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncatfile /tmp/4.s\nquit\n' \
    | timeout 30 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

# Every stage logs [w slot:N] via the kdbg_write tracer and [x slot=0]
# on clean exit. Count them to verify all four stages ran and
# succeeded.
write_markers=$(echo "$out" | grep -oE '\[w [0-9]+:[0-9]+\]' | wc -l)
clean_exits=$(echo "$out" | grep -oE '\[x [0-9]+=0\]' | wc -l)
has_text_dir=$(echo "$out" | grep -c '\.text')
has_globl_main=$(echo "$out" | grep -c '\.globl main')

# parse + typecheck + codegen + bc2asm each write once.
if [ "$write_markers" -lt 4 ]; then
    echo "FAIL: expected ≥ 4 [w slot:len] markers, got $write_markers" >&2
    echo "--- output ---"
    echo "$out"
    exit 1
fi
# parse + typecheck + codegen + bc2asm + catfile + sh + seeded
# hello/hello2 all exit cleanly → at least 7 clean exits.
if [ "$clean_exits" -lt 7 ]; then
    echo "FAIL: expected ≥ 7 clean exits, got $clean_exits" >&2
    echo "--- output ---"
    echo "$out"
    exit 1
fi
if [ "$has_text_dir" -lt 1 ] || [ "$has_globl_main" -lt 1 ]; then
    echo "FAIL: bc2asm output missing .text / .globl main" >&2
    echo "--- output ---"
    echo "$out"
    exit 1
fi

echo "OK (stage 1): compiler pipeline reached bc2asm"
echo "  writes:       $write_markers"
echo "  clean exits:  $clean_exits"

echo ""
echo "=== phase 7 M6: compile + link + run Hello World ==="
# Runs the full 6-stage pipeline on the OS — parse → typecheck →
# codegen → bc2asm → cat (link with prelude) → asm — producing a
# loader-ready raw binary in /tmp/hw, then sh executes /tmp/hw via
# its absolute-path support and the Hello World line lands on UART.
out2=$(printf 'parse < /hw.tc > /tmp/1.ast\ntypecheck < /tmp/1.ast > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s\nasm < /tmp/full.s > /tmp/hw\n/tmp/hw\nquit\n' \
    | timeout 60 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

if ! echo "$out2" | grep -q "Hello, World!"; then
    echo "FAIL: OS-compiled Hello World did not print the expected greeting" >&2
    echo "--- output ---"
    echo "$out2"
    exit 1
fi

echo "OK (stage 2): self-hosted compile+link+run reached 'Hello, World!'"

echo ""
echo "=== phase 7 stage 3: typecheck split (sigscan + tcheck) ==="
# Same Hello World pipeline as stage 2, but with the new typecheck
# split path: parse → sigscan → cat-wrap → tcheck → codegen → bc2asm
# → cat (prelude) → asm. The (imports) / (self) / (program) wrapper
# is built on the OS side by cat'ing pre-staged tmpfs helper files
# (/empty_imports.txt, /self_open.txt, /wrap_close.txt) around the
# sigscan output and the parsed AST.
out3=$(printf 'parse < /hw.tc > /tmp/1.ast\nsigscan < /tmp/1.ast > /tmp/1.th\ncat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap\ntcheck < /tmp/1.wrap > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s\nasm < /tmp/full.s > /tmp/hw\n/tmp/hw\nquit\n' \
    | timeout 60 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

if ! echo "$out3" | grep -q "Hello, World!"; then
    echo "FAIL: split-typecheck Hello World did not print the expected greeting" >&2
    echo "--- output ---"
    echo "$out3"
    exit 1
fi

echo "OK (stage 3): sigscan + tcheck pipeline reached 'Hello, World!'"

echo ""
echo "=== phase 7 stage 4: typecheck + asm split (sigscan + tcheck + asm-pass1 + asm-pass2) ==="
# Same Hello World pipeline as stage 3, but ALSO swaps the single
# asm.tc for the asm-pass1 + asm-pass2 split:
#
#   parse → sigscan → cat-wrap → tcheck → codegen → bc2asm → cat
#         → asm-pass1 (.lab) → cat → asm-pass2 (ELF)
#
# All 11 steps run from sh via tmpfs intermediate files.
out4=$(printf 'parse < /hw.tc > /tmp/1.ast\nsigscan < /tmp/1.ast > /tmp/1.th\ncat /empty_imports.txt /self_open.txt /tmp/1.th /wrap_close.txt /tmp/1.ast > /tmp/1.wrap\ntcheck < /tmp/1.wrap > /tmp/2.tast\ncodegen < /tmp/2.tast > /tmp/3.bc\nbc2asm < /tmp/3.bc > /tmp/4.s\ncat /prelude.s /tmp/4.s /prelude_tail.s > /tmp/full.s\nasm_pass1 < /tmp/full.s > /tmp/lab.s\ncat /tmp/lab.s /tmp/full.s > /tmp/p2.in\nasm_pass2 < /tmp/p2.in > /tmp/hw\n/tmp/hw\nquit\n' \
    | timeout 90 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -drive "file=$TMP/disk.img,format=raw,if=none,id=blk0" \
    -device "virtio-blk-device,drive=blk0" \
    -device "loader,file=$TMP/kernel_virt,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" 2>&1 | tr -d '\0')

if ! echo "$out4" | grep -q "Hello, World!"; then
    echo "FAIL: full split (sigscan+tcheck+asm-pass1+asm-pass2) Hello World did not print" >&2
    echo "--- output ---"
    echo "$out4"
    exit 1
fi

echo "OK (stage 4): full split pipeline (sigscan+tcheck+asm-pass1+asm-pass2) reached 'Hello, World!'"
exit 0
