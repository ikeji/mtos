#!/bin/bash
# test_pico2.sh — flash kernel_pico2 to real RP2350 hardware and verify
# the filesystem, preemption, sh + spawn/wait via UART.
#
# Now that K7 part 2 (2026-04-15) is in, the pico2 kernel seeds sh as
# slot 2 and reads commands from the Debug Probe's CDC-ACM UART. This
# test flashes, waits for the sh$ prompt, sends a few commands over
# /dev/ttyACM0, then verifies the captured UART output:
#
#   1. "catfile" → sh spawns /bin/catfile with argv=["catfile"],
#                  catfile opens /hello.txt and prints "CAT[1]:hello, mtfs"
#   2. "launcher" → sh spawns /bin/launcher, which in turn do_spawn's
#                   /bin/hello2, do_wait's it, then do_exec's
#                   /bin/catfile. Exercises the full dynamic-spawn +
#                   wait + exec chain on real hardware.
#   3. "quit" → sh prints SH: bye and exits, kernel drains seeded
#               hello/hello2 tasks, prints "all tasks done"
#
# NOT part of make test: requires a physically connected Pico 2 with a
# Debug Probe (SWD + UART via CDC-ACM). Run manually when you want to
# confirm that a change still works on hardware.
#
# Usage:
#   GEN2_DIR=/tmp/gen2 tests/test_pico2.sh
#
# Environment:
#   GEN2_DIR    — Gen2 tool directory (required, same as kernel/build.sh)
#   OPENOCD     — path to openocd binary (default ~/opt/openocd-rpi/bin/openocd)
#   OPENOCD_SCRIPTS — openocd scripts dir (default ~/opt/openocd-rpi/share/openocd/scripts)
#   UART_PORT   — UART device (default /dev/ttyACM0)

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"

echo "=== Pico 2 Hardware Test ==="

OPENOCD="${OPENOCD:-$HOME/opt/openocd-rpi/bin/openocd}"
OPENOCD_SCRIPTS="${OPENOCD_SCRIPTS:-$HOME/opt/openocd-rpi/share/openocd/scripts}"
UART_PORT="${UART_PORT:-/dev/ttyACM0}"

# ----- Preflight checks -----
if [ -z "$GEN2_DIR" ]; then
    echo "SKIP: GEN2_DIR not set" >&2
    exit 0
fi
if [ ! -x "$OPENOCD" ]; then
    echo "SKIP: openocd not found at $OPENOCD" >&2
    exit 0
fi
if [ ! -e "$UART_PORT" ]; then
    echo "SKIP: UART port not found at $UART_PORT (Debug Probe unplugged?)" >&2
    exit 0
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# ----- Step 1: Build Pico 2 kernel UF2 -----
t0=$(time_ms)
GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/kernel/build.sh" --target pico2 \
    -o "$TMP/kernel_pico2.uf2" 2>&1 | sed 's/^/    /' >&2
if [ ! -s "$TMP/kernel_pico2.uf2" ]; then
    report_fail_msg "pico2: build" "kernel/build.sh --target pico2 produced no UF2"
    print_results
    exit $?
fi
elapsed=$(( $(time_ms) - t0 ))
report_pass "pico2: kernel/build.sh --target pico2" "$elapsed"

# ----- Step 2: Extract raw bin from UF2 -----
# picotool needs a UF2 on the output side too, so we do the extraction
# ourselves (same layout as kernel/run_pico2.sh's fallback).
python3 - "$TMP/kernel_pico2.uf2" "$TMP/kernel_pico2.bin" << 'PY'
import sys, struct
uf2_path, bin_path = sys.argv[1], sys.argv[2]
with open(uf2_path, "rb") as f:
    data = f.read()
out = bytearray()
for i in range(0, len(data), 512):
    block = data[i:i+512]
    if len(block) < 512:
        break
    magic1, magic2 = struct.unpack_from("<II", block, 0)
    if magic1 != 0x0A324655 or magic2 != 0x9E5D5157:
        continue
    _flags, _target_addr, payload_size = struct.unpack_from("<III", block, 8)
    out.extend(block[32:32 + payload_size])
with open(bin_path, "wb") as f:
    f.write(out)
PY

if [ ! -s "$TMP/kernel_pico2.bin" ]; then
    report_fail_msg "pico2: UF2 extract" "empty bin after UF2 → raw extraction"
    print_results
    exit $?
fi

# ----- Step 3: Flash the new kernel -----
stty -F "$UART_PORT" 115200 cs8 -cstopb -parenb raw -echo -crtscts 2>/dev/null || true

# Drain any stale UART bytes from a previous run before we start the
# real capture. Otherwise the last run's "SH: bye" / leftover prompt
# bytes can bleed into this run's verification.
cat "$UART_PORT" > /dev/null 2>&1 &
FLUSH_PID=$!
sleep 0.3
kill "$FLUSH_PID" 2>/dev/null || true
wait "$FLUSH_PID" 2>/dev/null || true

t1=$(time_ms)

"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg \
    -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" \
    -c "init" \
    -c "reset halt" \
    -c "program $TMP/kernel_pico2.bin 0x10000000 verify" \
    -c "reset init" \
    -c "exit" > "$TMP/openocd.log" 2>&1 || true

if ! grep -q "Verified OK" "$TMP/openocd.log"; then
    elapsed=$(( $(time_ms) - t1 ))
    report_fail_msg "pico2: flash" "openocd did not print 'Verified OK': $(tail -5 "$TMP/openocd.log" | tr '\n' ' ')"
    print_results
    exit $?
fi

# ----- Step 4: Start background UART capture, trigger reset, drive sh -----
#
# Start the cat reader BEFORE releasing the CPU from halt. Without an
# active reader the first ~16 bytes of KERN: starting end up in the
# CDC-ACM ring buffer and we race against the kernel's early prints.
timeout 40 cat "$UART_PORT" > "$TMP/uart.log" 2>/dev/null &
CAT_PID=$!
sleep 0.8

"$OPENOCD" -s "$OPENOCD_SCRIPTS" \
    -f interface/cmsis-dap.cfg \
    -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" \
    -c "init" \
    -c "reset run" \
    -c "exit" > /dev/null 2>&1 || true

# Wait for the kernel's early prints (KERN/BLOCK/MTFS/SH: ready) and
# the first sh$ prompt to land.
sleep 4

# Drive /bin/sh over the Debug Probe's CDC-ACM TX line:
#   "catfile\n"  → spawns /bin/catfile with argv=["catfile"], prints CAT[1]:hello, mtfs
#   "launcher\n" → spawns /bin/launcher which do_spawn's /bin/hello2,
#                  do_wait's it, then do_exec's /bin/catfile
#                  (LAUNCHER: spawned slot ok / LAUNCHER: wait returned / CAT[0]:)
#   "quit\n"     → sh breaks its loop, prints SH: bye, returns 0
printf 'catfile\n'  > "$UART_PORT"
sleep 4
printf 'launcher\n' > "$UART_PORT"
sleep 6
printf 'quit\n'     > "$UART_PORT"
sleep 6

kill "$CAT_PID" 2>/dev/null || true
wait "$CAT_PID" 2>/dev/null || true

elapsed=$(( $(time_ms) - t1 ))

# ----- Step 5: Verify UART output contents -----
# The task's print output (kputs) is byte-streamed through the UART one
# (or a few) bytes at a time, and the preemption tracer sprays
# "[sw A>B]" / "[x N=M]" / "[w N:M]" markers in between. That chops
# tokens like "CAT[1]:hello, mtfs" across multiple lines, so we
# strip the scheduler markers BEFORE running the grep checks.
uart_out=$(tr -d '\0' < "$TMP/uart.log" \
    | sed -E 's/\[sw [0-9]+>[0-9]+\]//g' \
    | sed -E 's/\[x [0-9]+=[0-9]+\]//g' \
    | sed -E 's/\[w [0-9]+:[0-9]+\]//g' \
    | sed -E 's/\[kmem peak=[0-9]+ live=[0-9]+\]//g' \
    | tr -d '\n' | tr -s ' ')

# uart_out is a single joined line after scheduler-marker stripping, so
# use `grep -o | wc -l` for repeat counts and plain `grep -c` for
# single-occurrence checks.
count_occ() { echo "$uart_out" | grep -o "$1" | wc -l; }

pico_has_start=$(count_occ "KERN: starting")
pico_has_block=$(count_occ "BLOCK: flash backend ready")
pico_has_mtfs=$(count_occ "MTFS: mounted")
pico_has_sh_ready=$(count_occ "SH: ready")
# sh$ prompt is printed before each command. With "catfile" +
# "launcher" + "quit" inputs we expect ≥ 3 prompts.
pico_prompt_n=$(count_occ "sh\\\$ ")
# "catfile" → CAT[1]:hello, mtfs (argc=1 because sh put argv=["catfile"])
pico_has_cat1=$(count_occ "CAT\\[1\\]:")
# "launcher" → LAUNCHER: spawned slot ok / wait returned, then CAT[0]:
pico_has_spawn=$(count_occ "LAUNCHER: spawned slot ok")
pico_has_wait=$(count_occ "LAUNCHER: wait returned")
pico_has_cat0=$(count_occ "CAT\\[0\\]:")
pico_has_file=$(count_occ "hello, mtfs")
pico_has_bye=$(count_occ "SH: bye")
pico_has_done=$(count_occ "all tasks done")

missing=""
[ "$pico_has_start"    -eq 0 ] && missing="$missing KERN:starting"
[ "$pico_has_block"    -eq 0 ] && missing="$missing BLOCK:flash"
[ "$pico_has_mtfs"     -eq 0 ] && missing="$missing MTFS:mounted"
[ "$pico_has_sh_ready" -eq 0 ] && missing="$missing SH:ready"
[ "$pico_prompt_n"     -lt 3 ] && missing="$missing sh\$prompt(got=$pico_prompt_n)"
[ "$pico_has_cat1"     -eq 0 ] && missing="$missing CAT[1]:"
[ "$pico_has_spawn"    -eq 0 ] && missing="$missing LAUNCHER:spawned"
[ "$pico_has_wait"     -eq 0 ] && missing="$missing LAUNCHER:wait"
[ "$pico_has_cat0"     -eq 0 ] && missing="$missing CAT[0]:"
[ "$pico_has_file"     -eq 0 ] && missing="$missing hello,mtfs"
[ "$pico_has_bye"      -eq 0 ] && missing="$missing SH:bye"
[ "$pico_has_done"     -eq 0 ] && missing="$missing all-tasks-done"

if [ -z "$missing" ]; then
    report_pass "pico2: sh + catfile + launcher(spawn/wait/exec) + quit" "$elapsed"
else
    report_fail_msg "pico2: run" \
        "missing [$missing ], got: $(printf '%s' "$uart_out" | head -c 320)"
fi

print_results