#!/usr/bin/env python3
"""uart_demux.py — demux [tag:4][len:1][payload] frames from a UART stream.

Also supports pre-mux raw bytes at the beginning of the stream (before the
target kernel executes `muxon`) by treating any prefix that doesn't look like
a valid frame as `RAW ` tag.

Usage as a library:
    from uart_demux import FrameReader, FrameWriter

    reader = FrameReader(fd)       # async reader: returns (tag, payload) on recv()
    writer = FrameWriter(fd)       # writer: sends frames

Usage as CLI:
    python3 uart_demux.py --port /dev/ttyACM0 --out-dir /tmp/logs
        → tails UART, writes log.KERN / log.T000 / log.RAW_ files

    python3 uart_demux.py --decode input.bin
        → reads input.bin from stdin/file, writes per-tag files to ./logs/
"""

import argparse
import os
import select
import sys
import termios
import time

# A "tag" is 4 ASCII bytes. Printable 0x20-0x7E only. If the first four bytes
# don't look like a tag, we treat the stream as raw until we can resync.
def _looks_like_tag(b: bytes) -> bool:
    if len(b) < 4:
        return False
    for c in b:
        if c < 0x20 or c > 0x7E:
            return False
    return True


class FrameReader:
    """Stateful frame parser. Feed bytes in via .feed(), consume frames via
    .drain(). Unparsed tail is preserved for the next feed.

    Bytes that don't start with a printable-ASCII tag are emitted under the
    synthetic tag "RAW " (unmultiplexed boot chatter etc.)."""

    def __init__(self):
        self._buf = bytearray()
        self._frames = []

    def feed(self, data: bytes) -> None:
        self._buf.extend(data)
        self._parse()

    def _parse(self) -> None:
        while True:
            if len(self._buf) == 0:
                return
            # Attempt to parse a frame at buf[0].
            if len(self._buf) < 5:
                # Not enough bytes yet — but if the existing bytes are
                # clearly not a tag, flush them as RAW so callers see them
                # without waiting for more data.
                if not _looks_like_tag(bytes(self._buf[:4])) and len(self._buf) >= 1:
                    self._frames.append(("RAW ", bytes(self._buf[:1])))
                    del self._buf[:1]
                    continue
                return
            tag = bytes(self._buf[0:4])
            if not _looks_like_tag(tag):
                # Emit one byte as RAW, try again at buf[1].
                self._frames.append(("RAW ", bytes(self._buf[:1])))
                del self._buf[:1]
                continue
            n = self._buf[4]
            if len(self._buf) < 5 + n:
                # Header parsed, waiting for payload.
                return
            payload = bytes(self._buf[5:5 + n])
            self._frames.append((tag.decode("ascii"), payload))
            del self._buf[:5 + n]

    def drain(self):
        out = self._frames
        self._frames = []
        return out


class FrameWriter:
    def __init__(self, fd: int):
        self.fd = fd

    def send(self, tag: str, payload: bytes) -> None:
        if len(tag) != 4:
            raise ValueError(f"tag must be 4 chars, got {tag!r}")
        if len(payload) > 255:
            raise ValueError(f"payload too long ({len(payload)} > 255)")
        hdr = tag.encode("ascii") + bytes([len(payload)])
        os.write(self.fd, hdr + payload)

    def send_stream(self, tag: str, data: bytes, send_eof: bool = True) -> None:
        """Send `data` as multiple <=255-byte frames. When send_eof is True,
        a final len=0 frame with the same tag is emitted to signal EOF."""
        i = 0
        while i < len(data):
            chunk = data[i:i + 255]
            self.send(tag, chunk)
            i += 255
        if send_eof:
            self.send(tag, b"")


def _open_tty(path: str) -> int:
    fd = os.open(path, os.O_RDWR | os.O_NOCTTY)
    attr = termios.tcgetattr(fd)
    attr[0] &= ~(termios.BRKINT | termios.ICRNL | termios.INPCK |
                 termios.ISTRIP | termios.IXON)
    attr[2] &= ~(termios.CSIZE | termios.PARENB)
    attr[2] |= termios.CS8
    attr[3] &= ~(termios.ECHO | termios.ICANON | termios.IEXTEN | termios.ISIG)
    termios.tcsetattr(fd, termios.TCSANOW, attr)
    return fd


def _tag_to_safe_name(tag: str) -> str:
    # Keep printable chars, replace space/nonprintable with '_' for filename.
    out = []
    for c in tag:
        if c.isalnum():
            out.append(c)
        else:
            out.append("_")
    return "".join(out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", help="UART device (e.g. /dev/ttyACM0)")
    ap.add_argument("--input-file", help="Read raw stream from a file instead")
    ap.add_argument("--out-dir", default="/tmp/uart_logs",
                    help="Per-tag log files written here")
    ap.add_argument("--duration", type=float, default=0,
                    help="Tail duration in seconds (0 = until EOF / Ctrl-C)")
    ap.add_argument("--tee", action="append", default=[],
                    help="Also print this tag's payload to stdout (may repeat)")
    args = ap.parse_args()

    os.makedirs(args.out_dir, exist_ok=True)
    reader = FrameReader()
    log_files: dict[str, any] = {}

    def open_log(tag: str):
        if tag not in log_files:
            name = _tag_to_safe_name(tag)
            log_files[tag] = open(os.path.join(args.out_dir, f"log.{name}"),
                                  "ab")
        return log_files[tag]

    tee_tags = set(args.tee)

    def flush_frames():
        for tag, payload in reader.drain():
            f = open_log(tag)
            f.write(payload)
            f.flush()
            if tag in tee_tags:
                sys.stdout.buffer.write(payload)
                sys.stdout.buffer.flush()

    if args.port:
        fd = _open_tty(args.port)
        deadline = time.time() + args.duration if args.duration > 0 else None
        try:
            while True:
                if deadline is not None and time.time() >= deadline:
                    break
                r, _, _ = select.select([fd], [], [], 0.2)
                if r:
                    chunk = os.read(fd, 4096)
                    if chunk:
                        reader.feed(chunk)
                        flush_frames()
        except KeyboardInterrupt:
            pass
        os.close(fd)
    elif args.input_file:
        with open(args.input_file, "rb") as f:
            reader.feed(f.read())
            flush_frames()
    else:
        # Read from stdin
        data = sys.stdin.buffer.read()
        reader.feed(data)
        flush_frames()

    for f in log_files.values():
        f.close()
    print(f"\nWrote {len(log_files)} tag logs to {args.out_dir}")


if __name__ == "__main__":
    main()
