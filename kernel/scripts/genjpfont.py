#!/usr/bin/env python3
# genjpfont.py — convert the np21w PC-98 font.bmp into jpfont.dat, the
# Japanese font asset /bin/console loads for hankaku + zenkaku display.
#
# font.bmp is a 2048x2048 1-bit BMP (the np21w font file). Its layout,
# per tmp/convert.rb:
#   - hankaku (8x16):  glyph for byte `c` at pixel (c*8, 0)
#   - zenkaku (16x16): glyph for JIS kuten (ku,ten) at (ku*16,(ten+32)*16)
# A set BMP bit is background, so a lit pixel is the inverted bit.
#
# font.bmp is NOT committed. If it is missing, download it from
#   https://simk98.github.io/np21w/download.html
#
# Usage: genjpfont.py <font.bmp> <out.dat> [--preview]
#
# jpfont.dat layout (all multi-byte little-endian unless noted):
#   "JPF1"                       magic (4 bytes)
#   u32  u2k_count               Unicode->kuten entry count
#   hankaku[256][16]             256 glyphs, 16 rows x 1 byte (bit7=left)
#   zenkaku[94*94][32]           glyph (ku,ten) at index (ku-1)*94+(ten-1),
#                                16 rows x 2 bytes big-endian (bit15=left)
#   u2k[u2k_count]               4 bytes each, sorted by unicode asc:
#                                u16 unicode, u16 kuten ((ku<<8)|ten)

import sys

IMAGE = 2048


def load_bmp(path):
    with open(path, 'rb') as f:
        if f.read(2) != b'BM':
            raise SystemExit('not a BMP: ' + path)
        f.read(8)
        off = int.from_bytes(f.read(4), 'little')
        f.read(4)  # biSize
        w = int.from_bytes(f.read(4), 'little', signed=True)
        h = int.from_bytes(f.read(4), 'little', signed=True)
        f.read(2)  # planes
        bpp = int.from_bytes(f.read(2), 'little')
        if bpp != 1:
            raise SystemExit('1-bit BMP only (got %d-bit)' % bpp)
        if w != IMAGE or abs(h) != IMAGE:
            raise SystemExit('expected %dx%d' % (IMAGE, IMAGE))
        rb = ((w + 31) // 32) * 4
        f.seek(off)
        data = f.read(rb * abs(h))
    return data, w, h, rb


def make_get_pixel(data, w, h, rb):
    ah = abs(h)

    def get_pixel(x, y):
        if x < 0 or y < 0 or x >= w or y >= ah:
            return 0
        by = (h - 1 - y) if h > 0 else y
        b = data[by * rb + (x >> 3)]
        return ((b >> (7 - (x & 7))) & 1) ^ 1
    return get_pixel


def kuten_to_sjis(ku, ten):
    if ku <= 62:
        s1 = (ku - 1) // 2 + 0x81
    else:
        s1 = (ku - 1) // 2 + 0xC1
    if ku % 2 == 1:
        s2 = ten + (0x3F if ten <= 63 else 0x40)
    else:
        s2 = ten + 0x9E
    return s1, s2


def main():
    preview = '--preview' in sys.argv
    args = [a for a in sys.argv[1:] if a != '--preview']
    if len(args) != 2:
        sys.stderr.write('usage: genjpfont.py <font.bmp> <out.dat> [--preview]\n')
        return 1
    src, dst = args[0], args[1]
    data, w, h, rb = load_bmp(src)
    gp = make_get_pixel(data, w, h, rb)

    # hankaku: 256 glyphs, 8x16, one byte per row.
    hankaku = bytearray()
    for c in range(256):
        x0 = c * 8
        for y in range(16):
            v = 0
            for x in range(8):
                v = (v << 1) | gp(x0 + x, y)
            hankaku.append(v)

    # zenkaku: 94x94 kuten grid, 16x16, two bytes per row.
    zenkaku = bytearray()
    for ku in range(1, 95):
        for ten in range(1, 95):
            x0 = ku * 16
            y0 = (ten + 32) * 16
            for y in range(16):
                v = 0
                for x in range(16):
                    v = (v << 1) | gp(x0 + x, y0 + y)
                zenkaku.append((v >> 8) & 0xFF)
                zenkaku.append(v & 0xFF)

    # Unicode -> kuten, via the shift_jis codec.
    pairs = []
    for ku in range(1, 95):
        for ten in range(1, 95):
            s1, s2 = kuten_to_sjis(ku, ten)
            try:
                ch = bytes([s1, s2]).decode('shift_jis')
            except UnicodeDecodeError:
                continue
            if len(ch) != 1:
                continue
            cp = ord(ch)
            if cp <= 0xFFFF:
                pairs.append((cp, (ku << 8) | ten))
    pairs.sort()
    # de-dup by unicode
    seen = set()
    uniq = []
    for cp, kt in pairs:
        if cp not in seen:
            seen.add(cp)
            uniq.append((cp, kt))

    out = bytearray()
    out += b'JPF1'
    out += len(uniq).to_bytes(4, 'little')
    out += hankaku
    out += zenkaku
    for cp, kt in uniq:
        out += cp.to_bytes(2, 'little')
        out += kt.to_bytes(2, 'little')
    with open(dst, 'wb') as f:
        f.write(out)

    sys.stderr.write(
        'genjpfont: hankaku=256 zenkaku=%d u2k=%d total=%d bytes -> %s\n'
        % (94 * 94, len(uniq), len(out), dst))

    if not preview:
        return 0

    # --- ASCII-art preview to verify the layout ---
    def show_h(c):
        sys.stderr.write('hankaku 0x%02X:\n' % c)
        for y in range(16):
            b = hankaku[c * 16 + y]
            sys.stderr.write('  ' + ''.join(
                '#' if (b >> (7 - x)) & 1 else '.' for x in range(8)) + '\n')

    def show_z(ku, ten):
        sys.stderr.write('zenkaku ku=%d ten=%d:\n' % (ku, ten))
        base = ((ku - 1) * 94 + (ten - 1)) * 32
        for y in range(16):
            hi = zenkaku[base + y * 2]
            lo = zenkaku[base + y * 2 + 1]
            v = (hi << 8) | lo
            sys.stderr.write('  ' + ''.join(
                '#' if (v >> (15 - x)) & 1 else '.' for x in range(16)) + '\n')

    show_h(0x41)   # 'A'
    show_h(0x61)   # 'a'
    show_z(4, 2)   # あ
    show_z(16, 1)  # 亜 (first level-1 kanji)
    return 0


if __name__ == '__main__':
    sys.exit(main())
