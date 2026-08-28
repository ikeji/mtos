#!/bin/bash
# test_kernel_hw.sh — board test for the MTOS kernel on the tn20k SoC:
# flash top_soc_sdram, load kernel/build/tn20k_kernel.bin through the boot
# ROM (~25 s at 921600), wait for the sh prompt and drive a few
# commands. Set KERNEL_BIN to test another image (e.g. tn20k_kernel_extra.bin).
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
export PATH="${OSS_CAD:-$HOME/opt/oss-cad-suite}/bin:$PATH"
UART_PORT="${UART_PORT:-/dev/ttyUSB1}"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_kernel_hw: $KERNEL_BIN missing (make -C kernel tn20k)"; exit 2; }
make -C "$ROOT/hw" TOP=top_soc_sdram bit >/dev/null 2>&1 || { echo "test_kernel_hw: bitstream build failed"; exit 2; }
openFPGALoader -b tangnano20k "$ROOT/hw/build/top_soc_sdram.fs" >/dev/null 2>&1
sleep 0.5
python3 - "$UART_PORT" "$KERNEL_BIN" <<'PY'
import os, sys, termios, time, struct
port, path = sys.argv[1], sys.argv[2]
data = open(path, 'rb').read()
fd = os.open(port, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
t = termios.tcgetattr(fd); t[0]=0; t[1]=0; t[2]=termios.CS8|termios.CREAD|termios.CLOCAL; t[3]=0; t[4]=t[5]=termios.B921600
termios.tcsetattr(fd, termios.TCSANOW, t); termios.tcflush(fd, termios.TCIOFLUSH)
def rd(timeout, until=None):
    buf=b''; end=time.time()+timeout
    while time.time()<end:
        try: buf+=os.read(fd,4096)
        except BlockingIOError: time.sleep(0.01)
        if until and until in buf: break
    return buf
frame = struct.pack('<I', len(data)) + data + struct.pack('<I', sum(data) & 0xffffffff)
t0=time.time(); off=0
while off < len(frame):
    try: off += os.write(fd, frame[off:off+4096])
    except BlockingIOError: time.sleep(0.005)
boot = rd(30, b'sh$ ')
print(f'[test] loaded {len(data)} bytes in {time.time()-t0:.0f}s; boot log:\n' + boot.decode('latin1','replace'))
fails = 0
def check(cmd, want):
    global fails
    os.write(fd, cmd + b'\n'); out = rd(6, b'sh$ ')
    ok = want in out
    print(f'[test] {cmd.decode()!r:32} {"PASS" if ok else "FAIL"}')
    if not ok: fails += 1; print(out.decode('latin1','replace')[-300:])
check(b'echo hello from tn20k', b'hello from tn20k')
check(b'cat /hello.txt', b'hello, mtfs')
check(b'ls /bin', b'neofetch')
check(b'neofetch', b'RV32IM')
sys.exit(1 if fails or b'sh$ ' not in boot else 0)
PY
rc=$?
[ $rc = 0 ] && echo "test_kernel_hw: PASS" || echo "test_kernel_hw: FAIL (rc=$rc)"
exit $rc
