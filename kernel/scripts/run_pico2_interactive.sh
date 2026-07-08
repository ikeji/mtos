#!/bin/bash
# run_pico2_interactive.sh — flash pico2 kernel and drop into an
# interactive UART console, the pico2 counterpart of `make run`.
#
# Usage:
#   ./kernel/scripts/run_pico2_interactive.sh              (pristine kernel)
#   ./kernel/scripts/run_pico2_interactive.sh --extra      (with EXTRA_TASKS)
#   UF2=path/to/kernel.uf2 ./kernel/scripts/run_pico2_interactive.sh --no-build
#
# Requires:
#   - ~/opt/openocd-rpi/bin/openocd (Raspberry Pi fork with RP2350 support)
#   - Debug Probe on /dev/ttyACM0
#   - GEN2_DIR set (or compiler/build/gen2 present) when building

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
source "$ROOT_DIR/integration/lib/pico2_hw.sh"

EXTRA_TASKS_DEFAULT="parse sigscan tcheck codegen bc2asm asm_pass2 asm_pass3 cat muxon muxoff mx mr"
USE_EXTRA=0
BUILD=1
for arg in "$@"; do
    case "$arg" in
        --extra)    USE_EXTRA=1 ;;
        --no-build) BUILD=0 ;;
        *) echo "run_pico2_interactive: unknown flag $arg" >&2; exit 2 ;;
    esac
done

# Build (unless the caller provides their own UF2).
if [ "$BUILD" = "1" ]; then
    : "${GEN2_DIR:=$ROOT_DIR/compiler/build/gen2}"
    export GEN2_DIR
    UF2="$ROOT_DIR/kernel/build/pico2_kernel.uf2"
    if [ "$USE_EXTRA" = "1" ]; then
        EXTRA_TASKS="$EXTRA_TASKS_DEFAULT" \
            "$SCRIPT_DIR/build.sh" --target pico2 -o "$UF2" >&2
    else
        # No EXTRA_TASKS → Make-cached path is fine.
        (cd "$ROOT_DIR" && make -C kernel pico2) >&2
    fi
else
    : "${UF2:=$ROOT_DIR/kernel/build/pico2_kernel.uf2}"
fi

if [ ! -s "$UF2" ]; then
    echo "run_pico2_interactive: UF2 not present at $UF2" >&2; exit 1
fi

# Extract raw bin from UF2 (openocd wants a raw image).
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
BIN="$TMP/kernel.bin"
uf2_to_bin "$UF2" "$BIN"

# Drain any stale UART bytes so the first keystroke isn't swallowed.
if [ -e "$UART_PORT" ]; then
    pico2_uart_setup
    pico2_uart_drain
fi

echo "[flash] $UF2 → RP2350" >&2
pico2_flash_run "$BIN" "$TMP/openocd.log"
echo "[flash] verified OK" >&2

# Hand off to the Python bidi forwarder.
exec python3 "$ROOT_DIR/integration/pico2_tty.py" "$UART_PORT" 115200
