#!/bin/bash
# test_pico2_phase7_sd.sh — Phase 7 self-hosted compile pipeline on
# real Pico 2 hardware, with intermediate files written to /sd/ (FAT
# on the physical SD card) instead of /tmp/ (tmpfs in 480 KB SRAM).
#
# This is the K7 milestone: the compiler can produce binaries whose
# intermediate-state working set exceeds the 480 KB SRAM arena, by
# off-loading 1.ast / 2.tast / 3.bc / etc. to mass storage.
#
# STATUS (2026-05-03): PASS. legacy phase 7 self-host pipeline runs
# end-to-end on real hardware via /sd/ intermediates (~125 s) and
# prints "Hello, World!". K7 was unblocked by PLL_SYS 150 MHz
# (commit cf22718) — asm_pass2 dropped from >5 min to 27 s.
#
# Manual test (not in `make test`): requires Debug Probe, Catalex SD
# breakout, and a FAT-formatted SD card. Builds pico2_kernel_extra
# (kernel + parse/sigscan/tcheck/codegen/bc2asm/asm_pass2/asm_pass3),
# flashes it, then drives sh through the pipeline and verifies that
# the final /sd/hw binary prints "Hello, World!".
#
# Usage:
#   GEN2_DIR=build/gen2 tests/test_pico2_phase7_sd.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== Pico 2 phase 7 self-hosted compile via /sd ==="

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

if [ -z "$GEN2_DIR" ]; then echo "SKIP: GEN2_DIR not set" >&2; exit 0; fi
if [ ! -x "$OPENOCD" ];   then echo "SKIP: openocd missing" >&2; exit 0; fi
if [ ! -e "$UART_PORT" ]; then echo "SKIP: UART port missing" >&2; exit 0; fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ----- Step 1: Build kernel with EXTRA tasks -----
t0=$(time_ms)
EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3 cat" \
    GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/kernel/build.sh" --target pico2 \
    -o "$TMP/kernel.uf2" 2>&1 | sed 's/^/    /' >&2
if [ ! -s "$TMP/kernel.uf2" ]; then
    report_fail_msg "p7sd: build" "kernel.uf2 not produced"
    print_results; exit $?
fi
report_pass "p7sd: kernel build (with EXTRA)" "$(( $(time_ms) - t0 ))"

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

# ----- Step 2: Flash + reset -----
t1=$(time_ms)
"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset halt" \
    -c "program $TMP/kernel.bin 0x10000000 verify" \
    -c "exit" > "$TMP/oocd.log" 2>&1
if ! grep -q "Verified OK" "$TMP/oocd.log"; then
    report_fail_msg "p7sd: flash" "verify failed"
    print_results; exit $?
fi

stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null
timeout 0.3 cat "$UART_PORT" > /dev/null 2>&1 || true

"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset run" -c "exit" > /dev/null 2>&1
sleep 4

# ----- Step 3: Drive the compile pipeline through sh, intermediates on /sd -----
# Use the Python prompt-driven driver — it waits for "sh$ " before
# sending the next line, so we never overrun the 32-byte PL011 RX
# FIFO while sh is in sys_wait. Per-char send delay keeps the FIFO
# from filling during a single long line either.
PIPE_FILE=$(mktemp)
cat > "$PIPE_FILE" <<'PIPE_EOF'
parse < /hw.tc > /sd/1.ast
sigscan < /sd/1.ast > /sd/1.th
cat /empty_imports.txt /self_open.txt /sd/1.th /wrap_close.txt /sd/1.ast > /sd/1.wr
tcheck < /sd/1.wr > /sd/2.tast
codegen < /sd/2.tast > /sd/3.bc
bc2asm < /sd/3.bc > /sd/4.s
cat /sd/4.s /prelude_tail.s > /sd/u.s
asm_pass1 /sd/u.s --idx-out /sd/u.idx --text-bin /sd/u.tx --rodata-bin /sd/u.ro --data-bin /sd/u.dt --reloc-out /sd/u.rl
asm_pass2 --add /prelude.idx --add /sd/u.idx --lab-out /sd/lab.s
asm_pass3 --lab /sd/lab.s --out /sd/HW
/sd/HW
PIPE_EOF
python3 "$SCRIPT_DIR/pico2_pipeline_drive.py" \
    --port "$UART_PORT" --initial-wait 2 --cmd-timeout 600 \
    --per-char-delay 0.005 \
    "$PIPE_FILE" > "$TMP/uart.log" 2>&1 || true
rm -f "$PIPE_FILE"
elapsed=$(( $(time_ms) - t1 ))

# ----- Step 4: Verify -----
out=$(tr -d '\0' < "$TMP/uart.log" \
    | sed -E 's/\[sw [0-9]+>[0-9]+\]//g' \
    | sed -E 's/\[x [0-9]+=[0-9]+\]//g' \
    | sed -E 's/\[w [0-9]+:[0-9]+\]//g' \
    | sed -E 's/\[kmem peak=[0-9]+ live=[0-9]+\]//g' \
    | tr -d '\r')

missing=""
# FATFS/SDinit messages happen before the python driver opens the UART
# (after openocd `reset run` + 4s sleep + driver init), so we don't grep
# for them here. Reaching "Hello, World!" already proves /sd/ writes
# worked (every intermediate file lives on the SD card).
echo "$out" | grep -q "Hello, World!"          || missing="$missing greeting"

if [ -z "$missing" ]; then
    report_pass "p7sd: parse→…→asm_pass3 via /sd → run /sd/HW prints Hello, World!" "$elapsed"
else
    report_fail_msg "p7sd: pipeline" \
        "missing [$missing ], log tail: $(printf '%s' "$out" | tail -c 320 | tr '\n' ' ')"
fi

print_results
