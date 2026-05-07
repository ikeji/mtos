#!/bin/bash
# test_pico2_bench.sh — per-stage timing baseline on pico2 hardware.
# Builds pico2_kernel_extra (kernel + parse/sigscan/tcheck/codegen/
# bc2asm/asm_pass2/asm_pass3 + cat + msh), flashes it, then drives
# `msh /pico2_bench.sh` over UART. The msh set -ex trace records
# [T.TTT] >> CMD before each spawn and [T.TTT] << exit=N dt=D.DDD
# after each wait, so we can extract per-stage wall time directly
# from the UART log.
#
# Reads stage timings into a TSV table on stdout:
#
#   stage         dt_sec
#   parse         31.456
#   sigscan        9.812
#   ...
#   /sd/HW         1.045
#   total_sec   123.456
#
# Manual test (not in `make test`): requires Debug Probe + SD card +
# pico2 hardware. Same env vars as test_pico2_phase7_sd.sh.
#
# Usage:
#   GEN2_DIR=build/gen2 tests/test_pico2_bench.sh
#
#   To skip the kernel rebuild + flash (e.g. iterating on the bench
#   script itself), set SKIP_FLASH=1.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

if [ -z "${GEN2_DIR:-}" ]; then echo "ERROR: GEN2_DIR not set" >&2; exit 1; fi
if [ ! -x "$OPENOCD" ];   then echo "ERROR: openocd missing at $OPENOCD" >&2; exit 1; fi
if [ ! -e "$UART_PORT" ]; then echo "ERROR: UART port $UART_PORT missing" >&2; exit 1; fi

TMP=$(mktemp -d)
# Keep TMP/uart.log around when KEEP_LOG=1 for post-mortem of slow
# runs; otherwise clean up.
if [ "${KEEP_LOG:-0}" != "1" ]; then
    trap 'rm -rf "$TMP"' EXIT
fi
echo "TMP=$TMP" >&2

if [ "${SKIP_FLASH:-0}" != "1" ]; then
    echo "[1/3] Building pico2_kernel_extra (with msh + compiler tasks)..." >&2
    EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3 cat" \
        GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/kernel/build.sh" --target pico2 \
        -o "$TMP/kernel.uf2" 2>&1 | tail -3 >&2
    if [ ! -s "$TMP/kernel.uf2" ]; then
        echo "ERROR: kernel.uf2 not produced" >&2; exit 1
    fi

    # uf2 → raw bin for openocd
    python3 - "$TMP/kernel.uf2" "$TMP/kernel.bin" << 'PY'
import sys, struct
with open(sys.argv[1], "rb") as f: data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    b = data[i:i+512]
    if len(b) < 512: break
    m1, m2 = struct.unpack_from("<II", b, 0)
    if m1 != 0x0A324655 or m2 != 0x9E5D5157: continue
    _, _, ps = struct.unpack_from("<III", b, 8)
    out.extend(b[32:32+ps])
open(sys.argv[2], "wb").write(out)
PY

    echo "[2/3] Flashing via openocd..." >&2
    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset halt" \
        -c "program $TMP/kernel.bin 0x10000000 verify" \
        -c "exit" > "$TMP/oocd.log" 2>&1
    if ! grep -q "Verified OK" "$TMP/oocd.log"; then
        echo "ERROR: flash verify failed" >&2
        tail -10 "$TMP/oocd.log" >&2
        exit 1
    fi

    stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
    timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true

    "$OPENOCD" -s "$OPENOCD_SCRIPTS" \
        -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
        -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" > /dev/null 2>&1
    sleep 4
fi

echo "[3/3] Running msh /pico2_bench.sh and capturing trace..." >&2

# Capture UART output in background, send the msh command via stdout.
LOG="$TMP/uart.log"
(cat "$UART_PORT" > "$LOG" 2>&1) &
CATPID=$!

# Give cat a moment to attach.
sleep 0.5

# Allow the caller to override which msh script to run (e.g., the
# pass1_phases breakdown).
SCRIPT="${BENCH_SCRIPT:-/pico2_bench.sh}"
# Send msh command. msh will read the script from disk and run
# the pipeline; per-command [T.TTT] traces flow back through stderr
# (UART) and end up in $LOG.
printf 'msh %s\n' "$SCRIPT" > "$UART_PORT"

# Wait for the pipeline to finish. A successful run prints
# "Hello, World!" from the executed /sd/HW. Poll for it with a
# generous timeout (the K7 baseline took ~125 s).
TERM_PATTERN="${BENCH_TERMINATE:-Hello, World!}"
deadline=$(( $(date +%s) + 900 ))
while [ "$(date +%s)" -lt "$deadline" ]; do
    if grep -q "$TERM_PATTERN" "$LOG" 2>/dev/null; then break; fi
    if grep -q "msh: aborting" "$LOG" 2>/dev/null; then break; fi
    sleep 2
done

# Wait an extra second for the trailing trace lines + sh prompt.
sleep 2
kill -9 "$CATPID" 2>/dev/null || true
wait "$CATPID" 2>/dev/null || true

# ----- Parse: extract <stage_name, dt_sec> pairs from msh's
# `[T.TTT] >> CMD` / `[T.TTT] << exit=N dt=D.DDD` lines -----
python3 - "$LOG" << 'PY'
import re, sys
log = open(sys.argv[1], "rb").read().decode("utf-8", errors="replace")
log = log.replace("\r", "")
lines = log.split("\n")

# Strip framing/scheduler trace noise that interleaves with stderr.
clean = []
for ln in lines:
    ln = re.sub(r"\[sw \d+>\d+\]", "", ln)
    ln = re.sub(r"\[x \d+=\d+\]", "", ln)
    ln = re.sub(r"\[w \d+:\d+\]", "", ln)
    ln = re.sub(r"\[kmem peak=\d+ live=\d+\]", "", ln)
    ln = re.sub(r"\[TRAP[^\]]*\]", "", ln)
    clean.append(ln)

# Pair up >> CMD ... << exit=N dt=D.DDD
last_cmd = None
rows = []
for ln in clean:
    m = re.search(r"^\[\s*[\d.]+\] >> (.+)$", ln)
    if m:
        last_cmd = m.group(1).strip()
        continue
    m = re.search(r"^\[\s*[\d.]+\] << exit=(-?\d+) dt=([\d.]+)$", ln)
    if m and last_cmd:
        rc = int(m.group(1)); dt = float(m.group(2))
        # Use the first whitespace-delimited token of the command as the
        # stage name (parse / cat / asm_pass3 / /sd/HW etc.).
        name = last_cmd.split()[0] if last_cmd.split() else last_cmd
        rows.append((name, rc, dt, last_cmd))
        last_cmd = None

print("stage\texit\tdt_sec\tcmd")
total = 0.0
for name, rc, dt, cmd in rows:
    print(f"{name}\t{rc}\t{dt:.3f}\t{cmd}")
    total += dt
print(f"TOTAL\t-\t{total:.3f}\t-")

if not rows:
    print("\n# (no stage lines parsed — log tail follows)", file=sys.stderr)
    print("\n".join(clean[-30:]), file=sys.stderr)
    sys.exit(2)
PY
