#!/usr/bin/env python3
"""pico2_k11_reproduce.py — exercise K11 (mr large UART upload wedge)
on real pico2 hardware.

For each upload size, we:
  1. send `mr > /sd/k11_<n>.bin\n` to msh
  2. stream `n` bytes as 64-byte mx frames followed by an EOS frame
  3. wait briefly for mr to close + msh to return
  4. send `echo K11_OK_<n>\n` and look for the echoed marker

If the marker comes back, msh / sh are alive after the upload — K11
not reproducing on this kernel. If not, K11 is still wedging.

The pico2 must be running pico2_kernel_extra.uf2 (msh as seed) with a
mounted /sd. This script does not flash; flash before running.

Usage:
  tests/pico2_k11_reproduce.py [TTY] [SIZES...]
  tests/pico2_k11_reproduce.py /dev/ttyACM0 256 1024 4096
"""

import fcntl, os, struct, sys, termios, time

CHUNK = 64

def tty_open(dev: str) -> int:
    fd = os.open(dev, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
    attr = termios.tcgetattr(fd)
    attr[0] = 0
    attr[1] = 0
    attr[2] = (termios.CS8 | termios.CREAD | termios.CLOCAL | termios.HUPCL)
    attr[3] = 0
    attr[4] = termios.B115200
    attr[5] = termios.B115200
    attr[6][termios.VMIN] = 0
    attr[6][termios.VTIME] = 0
    termios.tcsetattr(fd, termios.TCSANOW, attr)
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return fd

def write_all(fd: int, data: bytes) -> None:
    pos = 0
    while pos < len(data):
        try:
            n = os.write(fd, data[pos:pos + 4096])
        except BlockingIOError:
            time.sleep(0.01); continue
        if n <= 0:
            time.sleep(0.01); continue
        pos += n

def read_until(fd: int, needle: bytes, deadline: float) -> bytes:
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
    out = bytearray()
    try:
        while time.time() < deadline:
            try:
                buf = os.read(fd, 4096)
            except BlockingIOError:
                buf = b""
            if buf:
                out.extend(buf)
                if needle in bytes(out):
                    break
            else:
                time.sleep(0.02)
    finally:
        fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return bytes(out)

def upload(fd: int, size: int, remote: str) -> float:
    payload = bytes(((i % 26) + ord('A')) for i in range(size))
    write_all(fd, f"mr > {remote}\n".encode())
    time.sleep(0.5)  # mr spawn settle
    t0 = time.time()
    for off in range(0, size, CHUNK):
        chunk = payload[off:off + CHUNK]
        write_all(fd, struct.pack("<H", len(chunk)) + chunk)
        time.sleep(0.020)  # 20 ms pace per 64-byte frame
    write_all(fd, b"\x00\x00")
    return time.time() - t0

def main() -> int:
    args = sys.argv[1:]
    tty = args[0] if args and args[0].startswith("/dev/") else "/dev/ttyACM0"
    if args and args[0].startswith("/dev/"):
        args = args[1:]
    sizes = [int(s) for s in args] if args else [256, 1024, 4096]
    fd = tty_open(tty)
    # Quiet the line — read-and-discard whatever boot/prompt noise is pending.
    read_until(fd, b"____never____", time.time() + 1.0)
    failures = 0
    for n in sizes:
        remote = f"/sd/k11_{n}.bin"
        sys.stderr.write(f"\n=== upload {n} bytes -> {remote} ===\n")
        sys.stderr.flush()
        t = upload(fd, n, remote)
        sys.stderr.write(f"  upload sent in {t:.1f}s\n")
        # Wait for mr to drop / msh to be ready, then probe.
        time.sleep(2.0)
        marker = f"K11_OK_{n}"
        write_all(fd, f"echo {marker}\n".encode())
        out = read_until(fd, marker.encode(), time.time() + 8.0)
        if marker.encode() in out:
            sys.stderr.write(f"  PASS — sh responsive after {n} byte upload\n")
        else:
            sys.stderr.write(f"  FAIL — no echo response (last 200 bytes: {out[-200:]!r})\n")
            failures += 1
            break  # don't pile up wedged uploads
    return 1 if failures else 0

if __name__ == "__main__":
    sys.exit(main())
