#!/bin/bash
# test_asm.sh — end-to-end virt machine test for the Gen2 asm pipeline.
#
# Compiles tests/hello2.tc through the full compile-gen2.sh pipeline
# with a virt-specific crt0 (UART at 16550 @ 0x10000000, no ecall)
# and `; raw` mode, then loads the resulting raw binary into
# qemu-system-riscv32 -M virt and asserts "Hello, World" is printed.
#
# This exercises:
#   - asm.tc PIC output + `; raw` mode
#   - compile-gen2.sh CRT0 / ASM_PROLOGUE env overrides
#   - Gen2 parse/typecheck/codegen/bc2asm/asm running under qemu-riscv32
#   - runtime.tc pool allocator on bare metal (no ecall)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "=== asm.tc Virt End-to-End Test (SKIPPED — need qemu + riscv-gcc) ==="
    echo ""
    print_results
    exit 0
fi

if ! command -v qemu-system-riscv32 >/dev/null 2>&1; then
    echo "=== asm.tc Virt End-to-End Test (SKIPPED — need qemu-system-riscv32) ==="
    echo ""
    print_results
    exit 0
fi

echo "=== asm.tc Virt End-to-End Test ==="
echo ""

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

VIRT_CRT0="$SCRIPT_DIR/virt_crt0.s"
HELLO_TC="$SCRIPT_DIR/hello2.tc"
BIN="$TMP/hello2_virt.bin"

t0=$(time_ms)
CRT0="$VIRT_CRT0" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$_GEN2_TMP" \
    "$ROOT_DIR/compile-gen2.sh" -o "$BIN" "$HELLO_TC" 2>/dev/null
compile_elapsed=$(( $(time_ms) - t0 ))

if [ ! -s "$BIN" ]; then
    report_fail_msg "asm[virt]: compile hello2.tc for virt" "compile-gen2.sh produced no output"
    print_results
    exit 1
fi

t0=$(time_ms)
timeout 5 qemu-system-riscv32 -smp 1 -nographic \
    -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -device "loader,file=$BIN,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0" >"$TMP/out.raw" 2>/dev/null
run_elapsed=$(( $(time_ms) - t0 ))
actual=$(tr -d '\0' < "$TMP/out.raw")

total=$((compile_elapsed + run_elapsed))
case "$actual" in
    *"Hello, World"*)
        report_pass "asm[virt]: hello2.tc prints Hello, World (compile ${compile_elapsed}ms, run ${run_elapsed}ms)" "$total"
        ;;
    *)
        report_fail_msg "asm[virt]: hello2.tc on virt" \
            "expected 'Hello, World', got: $(printf '%s' "$actual" | head -c 80)"
        ;;
esac

print_results
