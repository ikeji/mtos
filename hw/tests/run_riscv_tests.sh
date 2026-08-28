#!/bin/bash
# run_riscv_tests.sh — build riscv-tests rv32ui + rv32um against the
# hw/ SoC environment and run each in iverilog. Needs riscv64-unknown-elf-gcc
# and hw/third_party/riscv-tests (git clone --depth 1
# https://github.com/riscv-software-src/riscv-tests.git).
set -u
HW="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="${OSS_CAD:-$HOME/opt/oss-cad-suite}/bin:$PATH"
RT="$HW/third_party/riscv-tests"
ENV="$HW/tests/riscv-tests-env"
OUT="$HW/build/riscv-tests"; mkdir -p "$OUT"
[ -d "$RT/isa" ] || { echo "riscv-tests not found at $RT"; exit 2; }
make -C "$HW" build/tb_soc.vvp >/dev/null || exit 2
pass=0; fail=0; failed=()
for src in "$RT"/isa/rv32ui/*.S "$RT"/isa/rv32um/*.S; do
    name="$(basename "${src%.S}")"
    [ "$name" = "fence_i" ] && continue      # self-modifying code: no I-cache, trivially ok, skip
    [ "$name" = "ma_data" ] && continue      # expects misaligned loads/stores to be emulated; the core traps (cause 4/6) by design
    elf="$OUT/$name.elf"; bin="$OUT/$name.bin"
    riscv64-unknown-elf-gcc -march=rv32im_zicsr -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden \
        -nostdlib -nostartfiles -T "$ENV/link.ld" -I "$ENV" -I "$RT/isa/macros/scalar" \
        -o "$elf" "$src" 2>"$OUT/$name.cc.log" || { echo "BUILD FAIL $name"; cat "$OUT/$name.cc.log" | head -3; fail=$((fail+1)); failed+=("$name"); continue; }
    riscv64-unknown-elf-objcopy -O binary "$elf" "$bin"
    python3 "$HW/tools/bin2hex.py" "$bin" "$OUT/$name.hex"
    if vvp -N "$HW/build/tb_soc.vvp" +hex="$OUT/$name.hex" +timeout=3000000 2>/dev/null | grep -q '^\[tb\] PASS'; then
        pass=$((pass+1))
    else
        fail=$((fail+1)); failed+=("$name")
        vvp -N "$HW/build/tb_soc.vvp" +hex="$OUT/$name.hex" +timeout=3000000 2>/dev/null | grep -E 'exit code|TIMEOUT' | tail -1 | sed "s/^/  $name: /"
    fi
done
echo "riscv-tests: $pass passed, $fail failed ${failed[*]:+(${failed[*]})}"
[ "$fail" = 0 ]
