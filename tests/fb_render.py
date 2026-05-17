#!/usr/bin/env python3
# fb_render.py — replay /dev/fb framed-blit dumps into a BMP image.
#
# The stub /dev/fb driver (kernel/devfs.tc) prints every blit request
# it receives as a line:
#
#   FB: mode=N x=.. y=.. w=.. h=.. n=.. [color=..|scroll=..]
#
# This script parses those lines out of a UART capture and replays
# them onto a 320x480 framebuffer (portrait ILI9488), then writes a
# 24-bit BMP so the rendered result can be eyeballed or regression-
# checked. It is a faithful replay: a mode-1 fill paints the rect with
# the RGB565 colour the command carried (with the current /bin/console
# stub renderer that colour is the character code, so the BMP shows a
# grid of char-code-coloured cells — real font glyphs land when S6's
# renderer is finished).
#
# Usage: fb_render.py <fb-dump.txt> <out.bmp>
# Exit:  0 if at least one blit was rendered, 1 otherwise.

import sys
import re

W, H = 320, 480


def rgb565_to_rgb(c):
    return (((c >> 11) & 0x1F) << 3,
            ((c >> 5) & 0x3F) << 2,
            (c & 0x1F) << 3)


def write_bmp(path, width, height, pixels):
    row_bytes = width * 3
    pad = (4 - row_bytes % 4) % 4
    img_size = (row_bytes + pad) * height
    with open(path, 'wb') as f:
        # BITMAPFILEHEADER (14 bytes)
        f.write(b'BM')
        f.write((54 + img_size).to_bytes(4, 'little'))
        f.write(b'\x00\x00\x00\x00')
        f.write((54).to_bytes(4, 'little'))
        # BITMAPINFOHEADER (40 bytes)
        f.write((40).to_bytes(4, 'little'))
        f.write(width.to_bytes(4, 'little'))
        f.write(height.to_bytes(4, 'little'))
        f.write((1).to_bytes(2, 'little'))    # planes
        f.write((24).to_bytes(2, 'little'))   # bpp
        f.write(b'\x00' * 24)                 # rest of the header
        # Pixel data: BGR, rows bottom-up.
        padb = b'\x00' * pad
        for y in range(height - 1, -1, -1):
            base = y * width
            f.write(b''.join(bytes((p[2], p[1], p[0]))
                             for p in pixels[base:base + width]))
            f.write(padb)


def main():
    if len(sys.argv) != 3:
        sys.stderr.write("usage: fb_render.py <fb-dump.txt> <out.bmp>\n")
        return 1

    fb = [(0, 0, 0)] * (W * H)
    fills = blits = scrolls = 0
    hdr = re.compile(
        r'FB: mode=(\d+) x=(\d+) y=(\d+) w=(\d+) h=(\d+) n=(\d+)(.*)')

    with open(sys.argv[1], 'r', errors='replace') as f:
        for line in f:
            m = hdr.search(line)
            if not m:
                continue
            mode, x, y, w, h, _n, tail = m.groups()
            mode, x, y, w, h = int(mode), int(x), int(y), int(w), int(h)
            if mode == 1:
                cm = re.search(r'color=(\d+)', tail)
                col = rgb565_to_rgb(int(cm.group(1))) if cm else (255, 255, 255)
                fills += 1
                for yy in range(y, min(y + h, H)):
                    rowbase = yy * W
                    for xx in range(x, min(x + w, W)):
                        fb[rowbase + xx] = col
            elif mode == 0:
                # The dump carries no pixel payload; mark the region
                # so a mode-0 blit is still visible in the BMP.
                blits += 1
                for yy in range(y, min(y + h, H)):
                    rowbase = yy * W
                    for xx in range(x, min(x + w, W)):
                        fb[rowbase + xx] = (128, 128, 128)
            elif mode == 2:
                # Hardware vertical scroll — no pixel effect to replay
                # for a short capture; just counted.
                scrolls += 1

    write_bmp(sys.argv[2], W, H, fb)
    nonblack = sum(1 for p in fb if p != (0, 0, 0))
    sys.stderr.write(
        "fb_render: fills=%d blits=%d scrolls=%d nonblack_px=%d -> %s\n"
        % (fills, blits, scrolls, nonblack, sys.argv[2]))
    return 0 if (fills + blits) > 0 else 1


if __name__ == '__main__':
    sys.exit(main())
