#!/bin/bash
# run_riscv_tests.sh — build riscv-tests rv32ui + rv32um with the hw/ SoC
# environment (same gcc line as hw/tests/run_riscv_tests.sh) and run each
# on the JS emulator with Node. Needs riscv64-unknown-elf-gcc and
# hw/third_party/riscv-tests. Bins are cached in web/build/riscv-tests.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
RT="$ROOT/hw/third_party/riscv-tests"
ENV="$ROOT/hw/tests/riscv-tests-env"
OUT="$WEB/build/riscv-tests"; mkdir -p "$OUT"
[ -d "$RT/isa" ] || { echo "riscv-tests not found at $RT"; exit 2; }
command -v riscv64-unknown-elf-gcc >/dev/null || { echo "riscv64-unknown-elf-gcc not found"; exit 2; }
pass=0; fail=0; failed=()
for src in "$RT"/isa/rv32ui/*.S "$RT"/isa/rv32um/*.S; do
    name="$(basename "${src%.S}")"
    [ "$name" = "ma_data" ] && continue      # expects misaligned loads/stores to be emulated; we trap (cause 4/6) like the hw core
    # fence_i is kept: no I-cache in the emulator, so it is trivially correct
    elf="$OUT/$name.elf"; bin="$OUT/$name.bin"
    if [ ! -f "$bin" ] || [ "$src" -nt "$bin" ] || [ "$ENV/riscv_test.h" -nt "$bin" ]; then
        riscv64-unknown-elf-gcc -march=rv32im_zicsr_zifencei -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden \
            -nostdlib -nostartfiles -T "$ENV/link.ld" -I "$ENV" -I "$RT/isa/macros/scalar" \
            -o "$elf" "$src" 2>"$OUT/$name.cc.log" || { echo "BUILD FAIL $name"; head -3 "$OUT/$name.cc.log"; fail=$((fail+1)); failed+=("$name"); continue; }
        riscv64-unknown-elf-objcopy -O binary "$elf" "$bin"
    fi
    if out=$(node "$WEB/src/node_run.js" "$bin" --max 10000000 2>&1 >/dev/null); then
        pass=$((pass+1))
    else
        fail=$((fail+1)); failed+=("$name")
        echo "$out" | grep -E 'exit code|limit|error' | head -1 | sed "s/^/  $name: /"
    fi
done
echo "riscv-tests (js): $pass passed, $fail failed ${failed[*]:+(${failed[*]})}"
[ "$fail" = 0 ]
