#!/usr/bin/env python3
# mx_frame.py — host-side mx encoder. Counterpart of mr.tc on the
# device. Reads a file, writes len-prefixed 256-byte frames to stdout
# plus a trailing 0-length end marker.
#
# Wire format (per mx.tc):
#   [size_lo][size_hi][data * size] × N ... [0x00][0x00]
#
# Usage:
#   mx_frame.py disk-extra.img > /dev/ttyACM0
#
# Optional throttling: --chunk-sleep MS inserts a fixed sleep after
# each frame so the device-side mr can drain the PL011 RX FIFO during
# SD writes (workaround for K11 overflow with large uploads).

import argparse
import sys
import time


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("file", help="raw bytes to send")
    p.add_argument("--chunk-size", type=int, default=256,
                   help="bytes per frame (max 65535, default 256)")
    p.add_argument("--chunk-sleep", type=float, default=0.0,
                   help="seconds to sleep after each frame (default 0)")
    args = p.parse_args()

    with open(args.file, "rb") as f:
        data = f.read()

    cs = args.chunk_size
    if cs <= 0 or cs > 65535:
        print(f"chunk-size out of range: {cs}", file=sys.stderr)
        return 1

    out = sys.stdout.buffer
    i = 0
    while i < len(data):
        n = min(cs, len(data) - i)
        out.write(n.to_bytes(2, "little"))
        out.write(data[i:i + n])
        out.flush()
        i += n
        if args.chunk_sleep > 0:
            time.sleep(args.chunk_sleep)
    out.write(b"\x00\x00")
    out.flush()
    return 0


if __name__ == "__main__":
    sys.exit(main())
