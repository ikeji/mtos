#!/usr/bin/env python3
# mr_upload.py — xmodem-style ACK-handshaked uploader for `mr -a`.
#
# Counterpart of mr.tc's ACK mode: send a `[len:u16 LE][data:len]` frame,
# wait for one '.' byte from the device, repeat. The wait stops the host
# from streaming during the device's M-mode fatfs_write window, which is
# what triggers K11 (PL011 RX FIFO overflow during SD writes) when
# unbounded mx-streams hit ≥ 16 KB.
#
# Usage:
#   mr_upload.py disk-extra.img            # uses /dev/ttyACM0
#   mr_upload.py --port /dev/ttyACM1 file
#   mr_upload.py --chunk-size 4096 file
#
# Device side:
#   sh$ mr -a > /sd/dx.img         # spawns with stdin=UART, stdout=file
#                                  # ACKs ('.') go to stderr (= UART)
#
# The receiver emits one ACK on startup, one after every payload write,
# and one final ACK before exit. We expect (frame_count + 2) ACKs in
# total.

import argparse
import os
import select
import sys
import termios
import time


def open_serial(port: str) -> int:
    # Blocking I/O: writes are wrapped in write_all to keep the
    # protocol byte-tight; reads use select() with the caller's
    # timeout. O_NONBLOCK + os.write would silently truncate large
    # frames (saw 14 of 19 bytes go through on the spawn-cmd write).
    fd = os.open(port, os.O_RDWR | os.O_NOCTTY)
    # Configure 115200 8N1 raw.
    attrs = termios.tcgetattr(fd)
    iflag, oflag, cflag, lflag, ispeed, ospeed, cc = attrs
    iflag = 0
    oflag = 0
    lflag = 0
    cflag = (cflag & ~(termios.CSIZE | termios.PARENB)) | termios.CS8 | termios.CREAD | termios.CLOCAL
    if hasattr(termios, "CRTSCTS"):
        cflag &= ~termios.CRTSCTS
    cc = list(cc)
    # VMIN=0 + VTIME=0 → reads return immediately. We gate timing via
    # select() instead, which gives sub-decisecond resolution.
    cc[termios.VMIN] = 0
    cc[termios.VTIME] = 0
    termios.tcsetattr(fd, termios.TCSANOW,
                      [iflag, oflag, cflag, lflag, termios.B115200,
                       termios.B115200, cc])
    return fd


def write_all(fd: int, data: bytes) -> None:
    """Write data fully — loops past short writes (rare on a blocking
    serial fd but happens after large queued sends)."""
    view = memoryview(data)
    while view:
        n = os.write(fd, view)
        if n <= 0:
            raise RuntimeError(f"os.write returned {n}")
        view = view[n:]


def wait_ack(fd: int, timeout: float, label: str) -> None:
    """Read one '.' from fd. Raises on timeout."""
    deadline = time.monotonic() + timeout
    while True:
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            raise TimeoutError(f"no ACK ({label}) within {timeout}s")
        r, _, _ = select.select([fd], [], [], remaining)
        if not r:
            continue
        b = os.read(fd, 64)
        if not b:
            continue
        for byte in b:
            if byte == ord("."):
                return
            sys.stderr.write(chr(byte) if 32 <= byte < 127 else f"<{byte:02x}>")
            sys.stderr.flush()


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("file")
    p.add_argument("--port", default="/dev/ttyACM0")
    p.add_argument("--chunk-size", type=int, default=4096)
    p.add_argument("--ack-timeout", type=float, default=10.0,
                   help="seconds to wait for each chunk ACK")
    p.add_argument("--initial-ack-timeout", type=float, default=30.0,
                   help="seconds to wait for the startup ACK after `mr -a`")
    p.add_argument("--spawn-cmd", default="",
                   help="shell command to write to the port before waiting "
                        "for the startup ACK (e.g. 'mr -a > /sd/dx.img'). "
                        "When empty, assume mr is already running.")
    args = p.parse_args()

    if args.chunk_size <= 0 or args.chunk_size > 65535:
        print(f"chunk-size out of range: {args.chunk_size}", file=sys.stderr)
        return 1

    with open(args.file, "rb") as f:
        data = f.read()

    fd = open_serial(args.port)
    try:
        if args.spawn_cmd:
            # sh reads one byte at a time via sys_read(1); echoes each
            # byte back to UART. Sending the whole command at once
            # outraced sh's echo loop and dropped 2 chars consistently
            # at the same offset. Slow it down — 10 ms per byte is well
            # under sh's per-char processing time.
            for ch in (args.spawn_cmd + "\n").encode():
                write_all(fd, bytes([ch]))
                time.sleep(0.01)
        # Wait for mr's startup ACK so we know it's reading stdin
        # before we send anything.
        wait_ack(fd, args.initial_ack_timeout, "startup")

        cs = args.chunk_size
        total = len(data)
        i = 0
        chunks = 0
        t0 = time.monotonic()
        while i < total:
            n = min(cs, total - i)
            write_all(fd, n.to_bytes(2, "little"))
            write_all(fd, data[i:i + n])
            wait_ack(fd, args.ack_timeout, f"frame@{i}")
            i += n
            chunks += 1
            if chunks % 50 == 0:
                elapsed = time.monotonic() - t0
                rate = i / elapsed / 1024 if elapsed > 0 else 0
                sys.stderr.write(
                    f"\r[{i // 1024} KB / {total // 1024} KB, "
                    f"{rate:.1f} KB/s, {chunks} chunks]"
                )
                sys.stderr.flush()

        # End-of-stream marker.
        write_all(fd, b"\x00\x00")
        wait_ack(fd, args.ack_timeout, "end-marker")

        elapsed = time.monotonic() - t0
        sys.stderr.write(
            f"\nupload complete: {total} bytes in {elapsed:.1f}s "
            f"({total / elapsed / 1024:.1f} KB/s, {chunks} chunks)\n"
        )
    finally:
        os.close(fd)
    return 0


if __name__ == "__main__":
    sys.exit(main())
