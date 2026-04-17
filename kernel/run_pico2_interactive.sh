#!/bin/bash
# run_pico2_interactive.sh — flash pico2 kernel and drop into an
# interactive UART console, the pico2 counterpart of `make run`.
#
# Usage:
#   ./kernel/run_pico2_interactive.sh              (pristine kernel)
#   ./kernel/run_pico2_interactive.sh --extra      (with EXTRA_TASKS)
#   UF2=path/to/kernel.uf2 ./kernel/run_pico2_interactive.sh --no-build
#
# Requires:
#   - ~/opt/openocd-rpi/bin/openocd (Raspberry Pi fork with RP2350 support)
#   - Debug Probe on /dev/ttyACM0
#   - GEN2_DIR set (or build/gen2 present) when building

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

EXTRA_TASKS_DEFAULT="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat muxon muxoff mx mr"
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
    : "${GEN2_DIR:=$ROOT_DIR/build/gen2}"
    export GEN2_DIR
    UF2="$ROOT_DIR/build/kernel/pico2_kernel.uf2"
    if [ "$USE_EXTRA" = "1" ]; then
        EXTRA_TASKS="$EXTRA_TASKS_DEFAULT" \
            "$SCRIPT_DIR/build.sh" --target pico2 -o "$UF2" >&2
    else
        # No EXTRA_TASKS → Make-cached path is fine.
        (cd "$ROOT_DIR" && make pico2-kernel) >&2
    fi
else
    : "${UF2:=$ROOT_DIR/build/kernel/pico2_kernel.uf2}"
fi

if [ ! -s "$UF2" ]; then
    echo "run_pico2_interactive: UF2 not present at $UF2" >&2; exit 1
fi

# Extract raw bin from UF2 (openocd wants a raw image).
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
BIN="$TMP/kernel.bin"
python3 - "$UF2" "$BIN" << 'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512: break
    m1, m2 = struct.unpack_from("<II", block, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    _, _, ps = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32+ps])
with open(sys.argv[2], "wb") as f: f.write(out)
PY

# Drain any stale UART bytes so the first keystroke isn't swallowed.
if [ -e "$UART_PORT" ]; then
    stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null || true
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true
fi

echo "[flash] $UF2 → RP2350" >&2
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset halt" \
    -c "program $BIN 0x10000000 verify" \
    -c "reset run" -c "exit" > "$TMP/openocd.log" 2>&1 || {
        echo "[flash] openocd failed:" >&2
        tail -20 "$TMP/openocd.log" >&2
        exit 1
    }
if ! grep -q "Verified OK" "$TMP/openocd.log"; then
    echo "[flash] verify failed:" >&2
    tail -20 "$TMP/openocd.log" >&2
    exit 1
fi
echo "[flash] verified OK" >&2

# Hand off to the Python bidi forwarder.
exec python3 "$ROOT_DIR/tests/pico2_tty.py" "$UART_PORT" 115200
