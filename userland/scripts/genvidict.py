#!/usr/bin/env python3
# genvidict.py — convert an SKK dictionary (SKK-JISYO.S / M / ML, EUC-JP)
# into vidict.dat, the kana→kanji dictionary /bin/vi embeds in .rodata
# for its single-bunsetsu conversion (docs/task/vi_kanji_conv.md).
#
# Usage:
#   genvidict.py <SKK-JISYO> <out.dat> [--max-cands 8] [--max-read 8]
#   genvidict.py --empty <out.dat>          valid 0-entry dictionary
#   genvidict.py --dump <in.dat>            decode .dat back to text
#
# Only the okuri-nasi section is used. Readings must be hiragana
# (U+3041..U+3096) or ー (U+30FC) with a hiragana first character;
# candidates must be representable in JIS X 0208 (what the console
# font jpfont.dat covers) or ASCII, so nothing the LCD cannot draw is
# offered. Annotations (`;...`) are dropped and `(concat ...)`
# candidates are skipped.
#
# vidict.dat layout (little-endian, every field 2-byte aligned because
# the tn20k core and the web emulator cannot do misaligned lh):
#   u32  magic "VDC1"
#   u32  n_entries
#   u32  total_bytes
#   u32  bucket[97]       start offset of the entries whose reading
#                         begins with U+3041+i (i = 0..95); bucket[96]
#                         is the end of the last bucket. Entries inside
#                         a bucket are sorted by reading codepoints.
#   entry*:
#     u8   rlen           reading length in codepoints (1..max-read)
#     u8   ncand
#     u16  reading[rlen]
#     ncand x { u8 clen; u8 flags (0); u16 cand[clen] }

import struct
import sys

MAGIC = b'VDC1'
N_BUCKETS = 96
HIRA_FIRST = 0x3041
HIRA_LAST = 0x3096
CHOON = 0x30FC
HEADER_SIZE = 12 + 4 * (N_BUCKETS + 1)


def is_reading(s):
    if not s or not (HIRA_FIRST <= ord(s[0]) <= HIRA_LAST):
        return False
    return all(HIRA_FIRST <= ord(c) <= HIRA_LAST or ord(c) == CHOON
               for c in s)


def is_drawable(c):
    cp = ord(c)
    if 0x20 <= cp < 0x7F:
        return True
    if cp > 0xFFFF:
        return False
    try:
        b = c.encode('euc_jp')
    except UnicodeEncodeError:
        return False
    # 2 bytes both >= 0xA1 is JIS X 0208; 0x8E xx is half-width kana,
    # 0x8F xx xx is JIS X 0212 — neither is in jpfont.
    return len(b) == 2 and b[0] >= 0xA1 and b[1] >= 0xA1


def parse_skk(path, max_cands, max_read):
    entries = {}
    with open(path, 'rb') as f:
        raw = f.read()
    text = raw.decode('euc_jp', errors='replace')
    in_nasi = False
    for line in text.split('\n'):
        if line.startswith(';;'):
            if 'okuri-nasi' in line:
                in_nasi = True
            elif 'okuri-ari' in line:
                in_nasi = False
            continue
        if not in_nasi or not line.strip():
            continue
        sp = line.find(' ')
        if sp < 0:
            continue
        reading = line[:sp]
        body = line[sp + 1:].strip()
        if not is_reading(reading) or len(reading) > max_read:
            continue
        if not (body.startswith('/') and body.endswith('/')):
            continue
        cands = []
        for c in body[1:-1].split('/'):
            c = c.split(';', 1)[0]
            if not c or c.startswith('(concat'):
                continue
            if not all(is_drawable(ch) for ch in c):
                continue
            if len(c) > 255 or c in cands:
                continue
            cands.append(c)
        if not cands:
            continue
        lst = entries.setdefault(reading, [])
        for c in cands:
            if c not in lst:
                lst.append(c)
    out = []
    for r in sorted(entries, key=lambda s: [ord(ch) for ch in s]):
        out.append((r, entries[r][:max_cands]))
    return out


def encode(entries):
    # entries: list of (reading, [cands]) sorted by reading codepoints
    body = bytearray()
    bucket = [0] * (N_BUCKETS + 1)
    cur = 0
    for r, cands in entries:
        b = ord(r[0]) - HIRA_FIRST
        assert 0 <= b < N_BUCKETS
        while cur <= b:
            bucket[cur] = HEADER_SIZE + len(body)
            cur += 1
        body += struct.pack('<BB', len(r), len(cands))
        body += b''.join(struct.pack('<H', ord(c)) for c in r)
        for c in cands:
            body += struct.pack('<BB', len(c), 0)
            body += b''.join(struct.pack('<H', ord(ch)) for ch in c)
        assert len(body) % 2 == 0
    while cur <= N_BUCKETS:
        bucket[cur] = HEADER_SIZE + len(body)
        cur += 1
    total = HEADER_SIZE + len(body)
    hdr = MAGIC + struct.pack('<II', len(entries), total)
    hdr += b''.join(struct.pack('<I', o) for o in bucket)
    assert len(hdr) == HEADER_SIZE
    return bytes(hdr) + bytes(body)


def decode(data):
    if data[:4] != MAGIC:
        raise SystemExit('bad magic')
    n, total = struct.unpack_from('<II', data, 4)
    if total != len(data):
        raise SystemExit('total_bytes %d != file size %d' % (total, len(data)))
    bucket = list(struct.unpack_from('<%dI' % (N_BUCKETS + 1), data, 12))
    entries = []
    off = HEADER_SIZE
    for b in range(N_BUCKETS):
        if bucket[b] != off:
            raise SystemExit('bucket %d offset %d != %d' % (b, bucket[b], off))
        while off < bucket[b + 1]:
            rlen, ncand = struct.unpack_from('<BB', data, off)
            off += 2
            r = ''.join(chr(cp) for cp in
                        struct.unpack_from('<%dH' % rlen, data, off))
            off += 2 * rlen
            if ord(r[0]) - HIRA_FIRST != b:
                raise SystemExit('entry %r in wrong bucket %d' % (r, b))
            cands = []
            for _ in range(ncand):
                clen, flags = struct.unpack_from('<BB', data, off)
                off += 2
                cands.append(''.join(chr(cp) for cp in
                                     struct.unpack_from('<%dH' % clen, data, off)))
                off += 2 * clen
            entries.append((r, cands))
    if off != total or len(entries) != n:
        raise SystemExit('trailing bytes or entry count mismatch')
    return entries


def main():
    args = sys.argv[1:]
    if len(args) == 2 and args[0] == '--dump':
        with open(args[1], 'rb') as f:
            data = f.read()
        for r, cands in decode(data):
            sys.stdout.write('%s /%s/\n' % (r, '/'.join(cands)))
        return 0
    if len(args) == 2 and args[0] == '--empty':
        with open(args[1], 'wb') as f:
            f.write(encode([]))
        return 0
    max_cands = 8
    max_read = 8
    pos = []
    i = 0
    while i < len(args):
        if args[i] == '--max-cands':
            max_cands = int(args[i + 1]); i += 2
        elif args[i] == '--max-read':
            max_read = int(args[i + 1]); i += 2
        else:
            pos.append(args[i]); i += 1
    if len(pos) != 2:
        sys.stderr.write('usage: genvidict.py <SKK-JISYO> <out.dat> '
                         '[--max-cands N] [--max-read N]\n'
                         '       genvidict.py --empty <out.dat>\n'
                         '       genvidict.py --dump <in.dat>\n')
        return 1
    entries = parse_skk(pos[0], max_cands, max_read)
    data = encode(entries)
    assert decode(data) == entries
    with open(pos[1], 'wb') as f:
        f.write(data)
    ncand = sum(len(c) for _, c in entries)
    sys.stderr.write('genvidict: %d entries, %d candidates, %d bytes -> %s\n'
                     % (len(entries), ncand, len(data), pos[1]))
    return 0


if __name__ == '__main__':
    sys.exit(main())
