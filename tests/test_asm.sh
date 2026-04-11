#!/bin/bash
# test_asm.sh — asm.tc output mode tests
# Verifies:
#   1. raw mode produces the same code bytes as ELF mode (minus the 84-byte header)
#   2. ; load_base 0xHHHH adjusts e_entry / p_vaddr / p_paddr in ELF output
#   3. raw-mode binary actually runs on qemu-system-riscv32 -M virt (if available)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "=== asm.tc Output Mode Tests (SKIPPED — need qemu + riscv-gcc) ==="
    echo ""
    print_results
    exit 0
fi

echo "=== asm.tc Output Mode Tests ==="
echo ""

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Helper: read a little-endian 32-bit integer at byte offset $2 from file $1
read_le32() {
    local file="$1" off="$2"
    od -An -v -tu4 -j"$off" -N4 --endian=little "$file" | tr -d ' \n'
}

# ===== Test 1: raw mode equals ELF body =====

cat > "$TMP/simple.s" << 'EOF'
.text
.globl _start
_start:
    li a0, 42
    li a7, 93
    ecall
EOF

t0=$(time_ms)
run_asm_tc < "$TMP/simple.s" > "$TMP/simple.elf"

{ echo "; raw"; cat "$TMP/simple.s"; } | run_asm_tc > "$TMP/simple.bin"
elapsed=$(( $(time_ms) - t0 ))

elf_size=$(stat -c%s "$TMP/simple.elf")
bin_size=$(stat -c%s "$TMP/simple.bin")
body_size=$((elf_size - 84))

if [ "$bin_size" -eq "$body_size" ] && tail -c +85 "$TMP/simple.elf" | cmp -s - "$TMP/simple.bin"; then
    report_pass "asm[1]: raw mode body == ELF[84:]" "$elapsed"
else
    report_fail_msg "asm[1]: raw mode body == ELF[84:]" \
        "elf_size=$elf_size bin_size=$bin_size body_size=$body_size"
fi

# ===== Test 2: default ELF has load base 0x10000, entry 0x10054 =====

t0=$(time_ms)
entry=$(read_le32 "$TMP/simple.elf" 24)
pvaddr=$(read_le32 "$TMP/simple.elf" 60)
ppaddr=$(read_le32 "$TMP/simple.elf" 64)
elapsed=$(( $(time_ms) - t0 ))

if [ "$entry" = "65620" ] && [ "$pvaddr" = "65536" ] && [ "$ppaddr" = "65536" ]; then
    # 65620 = 0x10054, 65536 = 0x10000
    report_pass "asm[2]: default ELF entry=0x10054 load=0x10000" "$elapsed"
else
    report_fail_msg "asm[2]: default ELF entry / load_base" \
        "entry=$entry pvaddr=$pvaddr ppaddr=$ppaddr (expected 65620 / 65536 / 65536)"
fi

# ===== Test 3: ; load_base 0x10000000 adjusts ELF headers =====

{ echo "; load_base 0x10000000"; cat "$TMP/simple.s"; } | run_asm_tc > "$TMP/lb.elf"
t0=$(time_ms)
entry=$(read_le32 "$TMP/lb.elf" 24)
pvaddr=$(read_le32 "$TMP/lb.elf" 60)
ppaddr=$(read_le32 "$TMP/lb.elf" 64)
elapsed=$(( $(time_ms) - t0 ))

# 0x10000054 = 268435540, 0x10000000 = 268435456
if [ "$entry" = "268435540" ] && [ "$pvaddr" = "268435456" ] && [ "$ppaddr" = "268435456" ]; then
    report_pass "asm[3]: ; load_base 0x10000000 → entry=0x10000054" "$elapsed"
else
    report_fail_msg "asm[3]: ; load_base override" \
        "entry=$entry pvaddr=$pvaddr ppaddr=$ppaddr (expected 268435540 / 268435456 / 268435456)"
fi

# ===== Test 4: ELF body unchanged by ; load_base (PIC) =====

t0=$(time_ms)
body_default=$(tail -c +85 "$TMP/simple.elf" | sha256sum | cut -d' ' -f1)
body_lb=$(tail -c +85 "$TMP/lb.elf" | sha256sum | cut -d' ' -f1)
elapsed=$(( $(time_ms) - t0 ))

if [ "$body_default" = "$body_lb" ]; then
    report_pass "asm[4]: ELF body is PIC (invariant under load_base)" "$elapsed"
else
    report_fail_msg "asm[4]: ELF body under load_base" \
        "body hashes differ (PIC violated)"
fi

# ===== Test 5: raw mode running on qemu-system-riscv32 -M virt =====

if command -v qemu-system-riscv32 >/dev/null 2>&1; then
    # 16550 UART @ 0x10000000 — write one byte, then infinite loop.
    # Loaded at 0x80000000 via -device loader.
    cat > "$TMP/virt.s" << 'EOF'
; raw
.text
.globl _start
_start:
    li   t0, 0x10000000
    la   t1, msg
    la   t2, msg_end
    sub  t2, t2, t1
loop:
    beqz t2, done
    lbu  t3, 0(t1)
    sb   t3, 0(t0)
    addi t1, t1, 1
    addi t2, t2, -1
    j    loop
done:
    j    done
.section .rodata
msg:
    .string "RAW_OK"
msg_end:
EOF
    run_asm_tc < "$TMP/virt.s" > "$TMP/virt.bin"
    t0=$(time_ms)
    timeout 3 qemu-system-riscv32 -smp 1 -nographic \
        -serial mon:stdio --no-reboot -m 128 \
        -machine virt,aclint=on -bios none \
        -device "loader,file=$TMP/virt.bin,addr=0x80000000" \
        -device "loader,addr=0x80000000,cpu-num=0" >"$TMP/virt.out" 2>/dev/null
    actual=$(tr -d '\0' < "$TMP/virt.out")
    elapsed=$(( $(time_ms) - t0 ))
    case "$actual" in
        *RAW_OK*) report_pass "asm[5]: raw bin runs on qemu-system-riscv32 virt" "$elapsed" ;;
        *)        report_fail_msg "asm[5]: raw bin on qemu-system-riscv32" \
                      "expected to contain RAW_OK, got: $(printf '%s' "$actual" | head -c 80)" ;;
    esac
else
    echo "SKIP: asm[5] qemu-system-riscv32 not installed"
fi

print_results
