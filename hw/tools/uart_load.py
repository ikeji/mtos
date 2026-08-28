#!/usr/bin/env python3
"""uart_load.py [-p PORT] [-b BAUD] [-t SECS] BIN — send a raw bin to the
hw/ boot ROM ([len][data][sum32] frame), wait for 'K', then relay the UART
to stdout for SECS seconds (default 5; 0 = exit right after 'K')."""
import argparse, os, sys, termios, time, struct
ap = argparse.ArgumentParser()
ap.add_argument('-p', '--port', default='/dev/ttyUSB1')
ap.add_argument('-b', '--baud', type=int, default=115200)
ap.add_argument('-t', '--tail', type=float, default=5.0)
ap.add_argument('bin')
a = ap.parse_args()
data = open(a.bin, 'rb').read()
fd = os.open(a.port, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
t = termios.tcgetattr(fd); t[0] = 0; t[1] = 0; t[2] = termios.CS8 | termios.CREAD | termios.CLOCAL; t[3] = 0
t[4] = t[5] = getattr(termios, 'B%d' % a.baud)
termios.tcsetattr(fd, termios.TCSANOW, t); termios.tcflush(fd, termios.TCIOFLUSH)
def rd(timeout):
    buf = b''; end = time.time() + timeout
    while time.time() < end:
        try: buf += os.read(fd, 4096)
        except BlockingIOError: time.sleep(0.01)
    return buf
frame = struct.pack('<I', len(data)) + data + struct.pack('<I', sum(data) & 0xffffffff)
t0 = time.time()
off = 0
while off < len(frame):
    try: off += os.write(fd, frame[off:off + 4096])
    except BlockingIOError: time.sleep(0.005)
resp = b''
while b'K' not in resp and b'E' not in resp and time.time() - t0 < len(frame) / (a.baud / 10) + 5:
    resp += rd(0.05)
dt = time.time() - t0
if b'K' in resp:
    print(f'[uart_load] {len(data)} bytes OK in {dt:.1f}s', file=sys.stderr)
    out = resp[resp.index(b'K') + 1:]
    sys.stdout.buffer.write(out); sys.stdout.flush()
    if a.tail > 0:
        end = time.time() + a.tail
        while time.time() < end:
            b = rd(0.05)
            if b: sys.stdout.buffer.write(b); sys.stdout.flush()
    sys.exit(0)
print(f'[uart_load] FAILED resp={resp[-80:]!r}', file=sys.stderr); sys.exit(1)
