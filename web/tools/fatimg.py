#!/usr/bin/env python3
"""fatimg.py — minimal FAT32 superfloppy image tool (no mtools needed).

  fatimg.py mkfs IMG [SIZE_MB]            create an empty FAT32 image (default 33 MB, 512 B clusters)
  fatimg.py add  IMG NAME=HOSTFILE ...     add files to the root directory (8.3 names only)
  fatimg.py ls   IMG                       list the root directory (LFN-aware)
  fatimg.py cat  IMG NAME                  dump a root file to stdout

Layout matches what kernel/src/fatfs.tc expects: BPB at sector 0,
FSInfo at 1, backup boot sector at 6, 32 reserved sectors, 2 FATs,
root directory at cluster 2. Used by web/tests/test_sd.sh and for
building /sd images for the browser emulator.
"""
import struct, sys, os

BPS = 512
RSVD = 32
NFATS = 2

def le16(b, o): return struct.unpack_from("<H", b, o)[0]
def le32(b, o): return struct.unpack_from("<I", b, o)[0]

class Fat32:
    def __init__(self, img):
        self.img = img
        b = img
        assert b[510] == 0x55 and b[511] == 0xAA, "no boot signature"
        self.bps = le16(b, 11); self.spc = b[13]; self.rsvd = le16(b, 14); self.nfats = b[16]
        self.totsec = le32(b, 32); self.fatsz = le32(b, 36); self.rootclus = le32(b, 44)
        self.fsinfo = le16(b, 48)
        assert self.bps == BPS
        self.fat_start = self.rsvd
        self.data_start = self.rsvd + self.nfats * self.fatsz
        self.nclus = (self.totsec - self.data_start) // self.spc

    def fat_get(self, c):
        return le32(self.img, self.fat_start * BPS + c * 4) & 0x0FFFFFFF

    def fat_set(self, c, v):
        for f in range(self.nfats):
            struct.pack_into("<I", self.img, (self.fat_start + f * self.fatsz) * BPS + c * 4, v & 0x0FFFFFFF)

    def clus_off(self, c):
        return (self.data_start + (c - 2) * self.spc) * BPS

    def chain(self, c):
        out = []
        while 2 <= c < 0x0FFFFFF8:
            out.append(c); c = self.fat_get(c)
        return out

    def read_chain(self, c, size=None):
        data = bytearray()
        for cl in self.chain(c):
            data += self.img[self.clus_off(cl):self.clus_off(cl) + self.spc * BPS]
        return bytes(data if size is None else data[:size])

    def free_clusters(self):
        return [c for c in range(2, self.nclus + 2) if self.fat_get(c) == 0]

    def update_fsinfo(self):
        if not (1 <= self.fsinfo < self.rsvd): return
        free = self.free_clusters()
        o = self.fsinfo * BPS
        struct.pack_into("<I", self.img, o + 488, len(free))
        struct.pack_into("<I", self.img, o + 492, free[0] if free else 0xFFFFFFFF)

    def root_entries(self):
        """Yield (name, attr, first_cluster, size, entry_offset) for root dir entries, LFN-aware."""
        lfn = {}
        for cl in self.chain(self.rootclus):
            base = self.clus_off(cl)
            for i in range(0, self.spc * BPS, 32):
                e = self.img[base + i:base + i + 32]
                if e[0] == 0x00: return
                if e[0] == 0xE5: lfn = {}; continue
                attr = e[11]
                if attr == 0x0F:
                    ord_ = e[0] & 0x1F
                    chunk = e[1:11] + e[14:26] + e[28:32]
                    chars = [le16(chunk, k) for k in range(0, 26, 2)]
                    s = "".join(chr(c) for c in chars if c not in (0, 0xFFFF))
                    lfn[ord_] = s
                    continue
                if lfn:
                    name = "".join(lfn[k] for k in sorted(lfn))
                else:
                    n = e[0:8].decode("ascii", "replace").rstrip(); x = e[8:11].decode("ascii", "replace").rstrip()
                    name = n + ("." + x if x else "")
                lfn = {}
                clus = (le16(e, 20) << 16) | le16(e, 26)
                yield name, attr, clus, le32(e, 28), base + i

    def find_free_root_slot(self):
        for cl in self.chain(self.rootclus):
            base = self.clus_off(cl)
            for i in range(0, self.spc * BPS, 32):
                if self.img[base + i] in (0x00, 0xE5): return base + i
        raise SystemExit("root directory full")

    def add(self, name, data):
        name = name.upper()
        n, _, x = name.partition(".")
        if not (1 <= len(n) <= 8 and len(x) <= 3) or any(c in name for c in ' "*+,/:;<=>?[\\]|'):
            raise SystemExit(f"{name}: not an 8.3 name")
        for ename, attr, clus, size, off in self.root_entries():
            if ename.upper() == name: raise SystemExit(f"{name}: already exists")
        nclus = (len(data) + self.spc * BPS - 1) // (self.spc * BPS)
        free = self.free_clusters()
        if len(free) < nclus: raise SystemExit("image full")
        used = free[:nclus]
        for k, cl in enumerate(used):
            self.fat_set(cl, used[k + 1] if k + 1 < nclus else 0x0FFFFFFF)
            o = self.clus_off(cl)
            piece = data[k * self.spc * BPS:(k + 1) * self.spc * BPS]
            self.img[o:o + len(piece)] = piece
        slot = self.find_free_root_slot()
        e = bytearray(32)
        e[0:8] = n.ljust(8).encode(); e[8:11] = x.ljust(3).encode()
        e[11] = 0x20
        # 2026-01-01 00:00:00 for all timestamps
        struct.pack_into("<HHHHH", e, 14, 0, (46 << 9) | (1 << 5) | 1, (46 << 9) | (1 << 5) | 1, 0, 0)
        first = used[0] if used else 0
        struct.pack_into("<H", e, 20, first >> 16); struct.pack_into("<H", e, 26, first & 0xFFFF)
        struct.pack_into("<H", e, 24, (46 << 9) | (1 << 5) | 1)
        struct.pack_into("<I", e, 28, len(data))
        self.img[slot:slot + 32] = e
        self.update_fsinfo()


def mkfs(size_mb, spc=1):
    totsec = size_mb * 1024 * 1024 // BPS
    # FAT size: enough entries for every data sector (slight over-estimate is fine).
    fatsz = (totsec // spc + 2) * 4
    fatsz = (fatsz + BPS - 1) // BPS
    img = bytearray(totsec * BPS)
    b = bytearray(BPS)
    b[0:3] = b"\xEB\x58\x90"; b[3:11] = b"MTOSWEB "
    struct.pack_into("<HBHBHHBHHHII", b, 11, BPS, spc, RSVD, NFATS, 0, 0, 0xF8, 0, 63, 255, 0, totsec)
    struct.pack_into("<IHHIHH", b, 36, fatsz, 0, 0, 2, 1, 6)
    b[64] = 0x80; b[66] = 0x29
    struct.pack_into("<I", b, 67, 0x20261015)
    b[71:82] = b"MTOS SD    "; b[82:90] = b"FAT32   "
    b[510] = 0x55; b[511] = 0xAA
    img[0:BPS] = b; img[6 * BPS:7 * BPS] = b
    fsi = bytearray(BPS)
    struct.pack_into("<I", fsi, 0, 0x41615252); struct.pack_into("<I", fsi, 484, 0x61417272)
    struct.pack_into("<I", fsi, 508, 0xAA550000)
    img[BPS:2 * BPS] = fsi; img[7 * BPS:8 * BPS] = fsi
    fs = Fat32(img)
    fs.fat_set(0, 0x0FFFFFF8); fs.fat_set(1, 0x0FFFFFFF); fs.fat_set(2, 0x0FFFFFFF)   # root dir = cluster 2
    fs.update_fsinfo()
    return img


def main(argv):
    if len(argv) < 2: raise SystemExit(__doc__)
    cmd, path = argv[0], argv[1]
    if cmd == "mkfs":
        img = mkfs(int(argv[2]) if len(argv) > 2 else 33)
        open(path, "wb").write(img); return
    img = bytearray(open(path, "rb").read())
    fs = Fat32(img)
    if cmd == "add":
        for spec in argv[2:]:
            name, _, host = spec.partition("=")
            fs.add(name, open(host or name, "rb").read())
        open(path, "wb").write(img)
    elif cmd == "ls":
        for name, attr, clus, size, off in fs.root_entries():
            print(f"{'d' if attr & 0x10 else '-'} {size:9d} {name}")
    elif cmd == "cat":
        for name, attr, clus, size, off in fs.root_entries():
            if name.upper() == argv[2].upper():
                sys.stdout.buffer.write(fs.read_chain(clus, size)); return
        raise SystemExit(f"{argv[2]}: not found")
    else:
        raise SystemExit(__doc__)

if __name__ == "__main__":
    main(sys.argv[1:])
