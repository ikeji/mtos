// fat32.js — format an empty FAT32 superfloppy image in the browser
// (same layout as web/tools/fatimg.py mkfs: 512 B clusters, 32 reserved
// sectors, 2 FATs, FSInfo at 1, backup boot sector at 6, root at cluster 2).

export function formatFat32(sizeMb = 33) {
  const BPS = 512, RSVD = 32, NFATS = 2, SPC = 1;
  const totsec = (sizeMb * 1024 * 1024) / BPS;
  const fatsz = Math.ceil(((totsec / SPC) + 2) * 4 / BPS);
  const img = new Uint8Array(totsec * BPS);
  const dv = new DataView(img.buffer);
  const boot = (o) => {
    img.set([0xeb, 0x58, 0x90], o); img.set(new TextEncoder().encode("MTOSWEB "), o + 3);
    dv.setUint16(o + 11, BPS, true); img[o + 13] = SPC; dv.setUint16(o + 14, RSVD, true); img[o + 16] = NFATS;
    img[o + 21] = 0xf8; dv.setUint16(o + 24, 63, true); dv.setUint16(o + 26, 255, true);
    dv.setUint32(o + 32, totsec, true); dv.setUint32(o + 36, fatsz, true); dv.setUint32(o + 44, 2, true);
    dv.setUint16(o + 48, 1, true); dv.setUint16(o + 50, 6, true);
    img[o + 64] = 0x80; img[o + 66] = 0x29; dv.setUint32(o + 67, 0x20261015, true);
    img.set(new TextEncoder().encode("MTOS SD    FAT32   "), o + 71);
    img[o + 510] = 0x55; img[o + 511] = 0xaa;
  };
  boot(0); boot(6 * BPS);
  const nclus = Math.floor((totsec - RSVD - NFATS * fatsz) / SPC);
  const fsinfo = (o) => {
    dv.setUint32(o, 0x41615252, true); dv.setUint32(o + 484, 0x61417272, true);
    dv.setUint32(o + 488, nclus - 1, true); dv.setUint32(o + 492, 3, true); dv.setUint32(o + 508, 0xaa550000, true);
  };
  fsinfo(BPS); fsinfo(7 * BPS);
  for (let f = 0; f < NFATS; f++) {
    const o = (RSVD + f * fatsz) * BPS;
    dv.setUint32(o, 0x0ffffff8, true); dv.setUint32(o + 4, 0x0fffffff, true); dv.setUint32(o + 8, 0x0fffffff, true);
  }
  return img;
}
