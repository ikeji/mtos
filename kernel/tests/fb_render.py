#!/usr/bin/env python3
# fb_render.py — replay /dev/fb framed-blit dumps into a BMP image.
#
# The stub /dev/fb driver (kernel/devfs.tc) prints every blit request
# it receives as a line:
#
#   FB: mode=N x=.. y=.. w=.. h=.. n=.. [color=..|scroll=..|data=..]
#
# This script parses those lines out of a UART capture and replays
# them onto a 320x480 framebuffer (portrait ILI9488), then writes a
# 24-bit BMP so the rendered result can be eyeballed or regression-
# checked. It is a faithful replay: a mode-1 fill paints the rect with
# the RGB565 colour the command carried; a mode-0 blit paints each
# pixel from the `data=` RGB565 payload; the 1-bpp glyph modes 4
# (single glyph) and 5 (same-row glyph batch, what /bin/console emits)
# are expanded from their `data=` payload with the fg/bg colours they
# carry, so the BMP shows the actual rendered text.
#
# Usage: fb_render.py <fb-dump.txt> <out.bmp> [WIDTHxHEIGHT]
#        WIDTHxHEIGHT defaults to 320x480 (portrait); pass 480x320 for
#        a landscape console capture.
# Exit:  0 if at least one blit was rendered, 1 otherwise.

import sys
import re


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
    if len(sys.argv) not in (3, 4):
        sys.stderr.write(
            "usage: fb_render.py <fb-dump.txt> <out.bmp> [WIDTHxHEIGHT]\n")
        return 1
    W, H = 320, 480
    if len(sys.argv) == 4:
        ws, hs = sys.argv[3].lower().split('x')
        W, H = int(ws), int(hs)

    fb = [(0, 0, 0)] * (W * H)
    fills = blits = scrolls = 0
    scroll = 0   # current ILI9488 VSCRSADD value (mode-2)
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
                blits += 1
                dm = re.search(r'data=([0-9a-fA-F]+)', tail)
                if dm:
                    # RGB565 LE, 2 bytes/pixel, w*h pixels row-major.
                    hexs = dm.group(1)
                    for idx in range(w * h):
                        o = idx * 4
                        if o + 4 > len(hexs):
                            break
                        lo = int(hexs[o:o + 2], 16)
                        hi = int(hexs[o + 2:o + 4], 16)
                        px, py = x + idx % w, y + idx // w
                        if 0 <= px < W and 0 <= py < H:
                            fb[py * W + px] = rgb565_to_rgb(lo | (hi << 8))
                else:
                    # No payload — mark the region so the blit still
                    # shows up in the BMP.
                    for yy in range(y, min(y + h, H)):
                        rowbase = yy * W
                        for xx in range(x, min(x + w, W)):
                            fb[rowbase + xx] = (128, 128, 128)
            elif mode in (4, 5):
                # 1-bpp glyphs. Payload (after the 10-byte header):
                #   mode 4: [fg u16][bg u16][bitmap (w+7)/8 * h bytes]
                #   mode 5: [fg u16][bg u16][count u16] then per glyph
                #           [gw u8][bitmap (gw+7)/8 * h bytes], drawn left
                #           to right from x.
                # Rows are big-endian across the row's bytes, MSB = leftmost
                # pixel (kernel display_ili9488.tc lcd_glyph).
                blits += 1
                dm = re.search(r'data=([0-9a-fA-F]+)', tail)
                if not dm:
                    continue
                data = bytes.fromhex(dm.group(1)[:len(dm.group(1)) // 2 * 2])
                def u16(o):
                    return data[o] | (data[o + 1] << 8)
                fg = rgb565_to_rgb(u16(0))
                bg = rgb565_to_rgb(u16(2))

                def glyph(gx, gy, gw, gh, off):
                    bpr = (gw + 7) // 8
                    for ry in range(gh):
                        bits = 0
                        for k in range(bpr):
                            bits = (bits << 8) | data[off + ry * bpr + k]
                        py = gy + ry
                        if not (0 <= py < H):
                            continue
                        for cx in range(gw):
                            px = gx + cx
                            if 0 <= px < W:
                                on = (bits >> (gw - 1 - cx)) & 1
                                fb[py * W + px] = fg if on else bg
                    return off + bpr * gh

                if mode == 4:
                    if len(data) >= 4 + ((w + 7) // 8) * h:
                        glyph(x, y, w, h, 4)
                else:
                    count = u16(4)
                    off = 6
                    gx = x
                    for _ in range(count):
                        if off >= len(data):
                            break
                        gw = data[off]
                        if off + 1 + ((gw + 7) // 8) * h > len(data):
                            break
                        off = glyph(gx, y, gw, h, off + 1)
                        gx += gw
            elif mode == 2:
                # Hardware vertical scroll: VSCRSADD picks the physical
                # line shown at the top of the panel.
                sm = re.search(r'scroll=(\d+)', tail)
                if sm:
                    scroll = int(sm.group(1)) % H
                scrolls += 1

    # Apply the final scroll offset: display row dy shows physical
    # framebuffer row (scroll + dy) mod H.
    disp = [(0, 0, 0)] * (W * H)
    for dy in range(H):
        py = (scroll + dy) % H
        disp[dy * W:(dy + 1) * W] = fb[py * W:(py + 1) * W]
    write_bmp(sys.argv[2], W, H, disp)
    nonblack = sum(1 for p in fb if p != (0, 0, 0))
    sys.stderr.write(
        "fb_render: fills=%d blits=%d scrolls=%d nonblack_px=%d -> %s\n"
        % (fills, blits, scrolls, nonblack, sys.argv[2]))
    return 0 if (fills + blits) > 0 else 1


if __name__ == '__main__':
    sys.exit(main())
