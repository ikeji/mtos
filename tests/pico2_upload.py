#!/usr/bin/env python3
"""
pico2_upload.py — push a binary file from host to /sd/<name> on pico2.

Usage: tests/pico2_upload.py LOCAL_FILE REMOTE_PATH [/dev/ttyACM0]

The pico2 must be running pico2_kernel_extra.uf2 with msh as the
seed task and a writable /sd. We send `mr > REMOTE_PATH` to msh,
then chunk LOCAL_FILE into 256-byte mx frames (`[len:u16 LE]
[bytes]…` terminated by `[0:u16]`) and write them to the UART.
mr decodes and forwards to stdout, which sh redirects to the file.

For a 1.4 MB disk image the upload takes ~140 s at 115200 baud.
"""

import os, struct, sys, time
import termios, fcntl

CHUNK = 256

def tty_open(dev: str):
    fd = os.open(dev, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
    attr = termios.tcgetattr(fd)
    attr[0] = 0  # iflag
    attr[1] = 0  # oflag
    attr[2] = (termios.CS8 | termios.CREAD | termios.CLOCAL | termios.HUPCL)
    attr[3] = 0  # lflag (no canon, no echo)
    attr[4] = termios.B115200  # ispeed
    attr[5] = termios.B115200  # ospeed
    attr[6][termios.VMIN] = 0
    attr[6][termios.VTIME] = 0
    termios.tcsetattr(fd, termios.TCSANOW, attr)
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return fd

def write_all(fd: int, data: bytes):
    pos = 0
    while pos < len(data):
        try:
            n = os.write(fd, data[pos:pos + 4096])
        except BlockingIOError:
            time.sleep(0.01)
            continue
        if n <= 0:
            time.sleep(0.01)
            continue
        pos += n

def drain(fd: int, deadline: float):
    """Read whatever the device has emitted up to deadline (best-effort)."""
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
    out = bytearray()
    try:
        while time.time() < deadline:
            try:
                buf = os.read(fd, 4096)
                if buf:
                    out.extend(buf)
                else:
                    time.sleep(0.05)
            except BlockingIOError:
                time.sleep(0.05)
    finally:
        fcntl.fcntl(fd, fcntl.F_SETFL, flags & ~os.O_NONBLOCK)
    return bytes(out)

def main():
    if len(sys.argv) < 3:
        print("usage: pico2_upload.py LOCAL REMOTE [TTY]", file=sys.stderr)
        sys.exit(2)
    local, remote = sys.argv[1], sys.argv[2]
    tty = sys.argv[3] if len(sys.argv) > 3 else "/dev/ttyACM0"
    with open(local, "rb") as f:
        data = f.read()
    print(f"upload: {len(data)} bytes -> {remote} via {tty}", file=sys.stderr)
    fd = tty_open(tty)
    # Drain any pending output, then prime the shell.
    drain(fd, time.time() + 0.5)
    cmd = f"mr > {remote}\n".encode()
    write_all(fd, cmd)
    # Wait for sh to spawn mr (mr issues no banner; give it a moment).
    drain(fd, time.time() + 1.0)
    # Stream framed payload.
    t0 = time.time()
    sent = 0
    for off in range(0, len(data), CHUNK):
        chunk = data[off:off + CHUNK]
        write_all(fd, struct.pack("<H", len(chunk)) + chunk)
        sent += len(chunk)
        if (off // CHUNK) % 64 == 0:
            elapsed = time.time() - t0
            rate = sent / elapsed if elapsed > 0 else 0
            print(f"  {sent}/{len(data)} bytes ({rate/1024:.1f} KiB/s)",
                  file=sys.stderr)
    # End-of-stream marker.
    write_all(fd, b"\x00\x00")
    elapsed = time.time() - t0
    print(f"  done in {elapsed:.1f}s ({len(data)/elapsed/1024:.1f} KiB/s)",
          file=sys.stderr)
    # Let mr finish + sh print the prompt back.
    tail = drain(fd, time.time() + 5.0)
    sys.stderr.buffer.write(tail)
    sys.stderr.flush()

if __name__ == "__main__":
    main()
