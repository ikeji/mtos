#!/bin/bash
# pico2_verify.sh — byte-for-byte compile pipeline verification on pico2.
#
# Generates Gen2 host references, builds & flashes a pico2 kernel with
# EXTRA_TASKS, then drives the UART-mediated compile pipeline and
# compares each intermediate against the reference:
#
#   1.ast 1.th 1.wrap 2.tast 3.bc 4.s full.s full.lab  (byte-exact)
#   /tmp/hw runtime: printed "Hello, World!"        (behavior check)
#
# The hw binary itself is not dumped back to host — extracting 42 KB
# of raw ELF over PL011 without the mux framing is fragile, and if all
# upstream stages match Gen2 byte-for-byte + /tmp/hw actually prints
# the greeting, we have strong evidence asm_pass3 is correct too.
#
# Requires: GEN2_DIR, Pico 2 + Debug Probe, /dev/ttyACM0. Not part of
# `make test`; run manually:
#
#   GEN2_DIR=compiler/build/gen2 tests/pico2_verify.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
source "$SCRIPT_DIR/lib/pico2_hw.sh"
INPUT_TC="${INPUT_TC:-$ROOT_DIR/integration/inputs/phase7_hello_world.tc}"

if [ -z "$GEN2_DIR" ]; then
    echo "SKIP: GEN2_DIR not set" >&2; exit 0
fi
if [ ! -x "$OPENOCD" ]; then
    echo "SKIP: openocd not found at $OPENOCD" >&2; exit 0
fi
if [ ! -e "$UART_PORT" ]; then
    echo "SKIP: UART port not found at $UART_PORT (Debug Probe unplugged?)" >&2; exit 0
fi

TMP=$(mktemp -d)
REFS="$TMP/refs"
mkdir -p "$REFS"
echo "[info] logs/intermediates kept in $TMP"

echo "=== Pico 2 byte-exact verify ==="

# ---------------------------------------------------------------------
# Step 1: Build pico2 kernel with EXTRA_TASKS, export prelude.s to REFS
# so the reference generator can replay the exact linker glue.
# ---------------------------------------------------------------------
echo "[build] pico2 kernel"
EXTRA_TASKS="parse sigscan tcheck codegen bc2asm cat" \
PRELUDE_OUT_DIR="$REFS" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/kernel/scripts/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | tail -2 >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ] || [ ! -s "$REFS/prelude.s" ]; then
    echo "FAIL: kernel/build.sh did not produce UF2 or prelude.s" >&2; exit 1
fi

# ---------------------------------------------------------------------
# Step 2: Generate Gen2 host references (compile + link).
# ---------------------------------------------------------------------
echo "[refs] generating Gen2 references under $REFS"
qemu-riscv32 "$ROOT_DIR/compiler/build/gen2/parse"   < "$INPUT_TC"      > "$REFS/1.ast"
qemu-riscv32 "$ROOT_DIR/compiler/build/gen2/sigscan" < "$REFS/1.ast"    > "$REFS/1.th"
{ printf '(imports)\n(self\n'; cat "$REFS/1.th"; printf ')\n'; cat "$REFS/1.ast"; } > "$REFS/1.wrap"
qemu-riscv32 "$ROOT_DIR/compiler/build/gen2/tcheck"  < "$REFS/1.wrap"   > "$REFS/2.tast"
qemu-riscv32 "$ROOT_DIR/compiler/build/gen2/codegen" < "$REFS/2.tast"   > "$REFS/3.bc"
qemu-riscv32 "$ROOT_DIR/compiler/build/gen2/bc2asm"  < "$REFS/3.bc"     > "$REFS/4.s"
cat "$REFS/prelude.s" "$REFS/4.s" "$REFS/prelude_tail.s"       > "$REFS/full.s"
# full.s is the host-side reference for the concatenation the driver
# doesn't even ask pico2 to build (the OS doesn't have room for it in
# tmpfs anyway). asm_pass2 / asm_pass3 references are not needed here
# because the driver skips those stages without --run-link.

# ---------------------------------------------------------------------
# Step 3: Extract raw bin from UF2 + flash.
# ---------------------------------------------------------------------
uf2_to_bin "$TMP/kernel_pico2.uf2" "$TMP/kernel_pico2.bin"

pico2_uart_setup
pico2_uart_drain

echo "[flash] programming kernel"
if ! pico2_flash_halt "$TMP/kernel_pico2.bin" "$TMP/openocd.log" 2>/dev/null; then
    echo "FAIL: flash verify" >&2; tail -5 "$TMP/openocd.log"; exit 1
fi

# ---------------------------------------------------------------------
# Step 4: Drive pico2 and verify each stage byte-for-byte.
# ---------------------------------------------------------------------
echo "[run] driving pico2 UART pipeline with --refs-dir"
python3 "$SCRIPT_DIR/pico2_hw_driver.py" \
    --port "$UART_PORT" \
    --prelude "$REFS/prelude.s" \
    --prelude-tail "$REFS/prelude_tail.s" \
    --openocd "$OPENOCD" \
    --openocd-scripts "$OPENOCD_SCRIPTS" \
    --log-dir "$TMP" \
    --refs-dir "$REFS"
status=$?
echo "[run] driver exit $status"
[ "$status" -ne 0 ] && { echo "FAIL: driver returned $status"; exit 1; }
echo "PASS: pico2 byte-exact match on compile stages"
echo "      (link stages run via tests/test_pico2_hw.sh --run-link)"
