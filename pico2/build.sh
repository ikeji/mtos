#!/bin/bash
# pico2/build.sh — build pico2/hello.tc into pico2/hello.uf2 for RP2350 RISC-V.
#
# Pipeline: Gen1 parse + (Gen2 typecheck / codegen / bc2asm / asm via
# qemu-riscv32) + pico2/crt0_pico2.{s,_data.s} → raw bin → UF2.
# The Gen2 tools are cached under /tmp/gen2_pico2 so repeat runs are fast.
#
# Requires:
#   make                     — builds Gen1 tools if not already built
#   qemu-riscv32             — runs the Gen2 tools
#   riscv64-unknown-elf-gcc  — needed by compile-gen1.sh to link Gen2 binaries

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"
make -s all

GEN2_DIR="${GEN2_DIR:-/tmp/gen2_pico2}"
mkdir -p "$GEN2_DIR"
for tool in parse typecheck codegen bc2asm asm; do
    if [ ! -x "$GEN2_DIR/$tool" ] \
       || [ "$ROOT_DIR/compiler/$tool.tc" -nt "$GEN2_DIR/$tool" ]; then
        echo "  building Gen2 $tool …"
        "$ROOT_DIR/compile-gen1.sh" -o "$GEN2_DIR/$tool" \
            "$ROOT_DIR/compiler/$tool.tc"
    fi
done

echo "  compile-pico2.sh pico2/hello.tc → pico2/hello.uf2"
GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/compile-pico2.sh" \
    -o "$SCRIPT_DIR/hello.uf2" "$SCRIPT_DIR/hello.tc"
ls -la "$SCRIPT_DIR/hello.uf2"
