// gpio.js — the SoC's SIO-compatible GPIO block (hw/rtl/soc/gpio_sio.v,
// 0xD000_0000) and the matrix keyboard hanging off GP1..GP12 that
// kernel/platform/tn20k/keyboard_matrix.tc scans.
//
// Inputs are pulled up: an undriven pin reads 1, a pin with OE set reads
// its own OUT value. The keyboard is a 5-row x 12-column matrix with the
// right half diode-reversed: a key in logical column 0..5 connects row
// pin -> column pin (visible when the row is driven low: scan phase A),
// a key in logical column 6..11 connects column pin -> row pin (phase B).
// Scancode = row * 12 + logical column, mapped by KBD_KEYMAP below (the
// same table as the kernel). Modifier keys produce no byte on hardware,
// so there is no shift: letters are lowercase only.

export class Gpio {
  constructor() {
    this.outLo = 0; this.outHi = 0; this.oeLo = 0; this.oeHi = 0;
    this.inLoFn = (outLo, oeLo) => (outLo & oeLo) | ~oeLo;   // pull-ups
    this.onHiOut = (hi) => {};
  }

  read(off) {
    switch (off >>> 2) {
      case 0x01: return this.inLoFn(this.outLo, this.oeLo) | 0;
      case 0x02: return ((this.outHi & this.oeHi) | (~this.oeHi & 0xffff)) & 0xffff;
      case 0x04: return this.outLo | 0;
      case 0x05: return this.outHi & 0xffff;
      case 0x0c: return this.oeLo | 0;
      case 0x0d: return this.oeHi & 0xffff;
      default: return 0;
    }
  }

  write(off, v) {
    const hi = this.outHi;
    switch (off >>> 2) {
      case 0x04: this.outLo = v | 0; break;
      case 0x05: this.outHi = v & 0xffff; break;
      case 0x06: this.outLo |= v; break;
      case 0x07: this.outHi |= v & 0xffff; break;
      case 0x08: this.outLo &= ~v; break;
      case 0x09: this.outHi &= ~v & 0xffff; break;
      case 0x0a: this.outLo ^= v; break;
      case 0x0b: this.outHi ^= v & 0xffff; break;
      case 0x0c: this.oeLo = v | 0; break;
      case 0x0d: this.oeHi = v & 0xffff; break;
      case 0x0e: this.oeLo |= v; break;
      case 0x0f: this.oeHi |= v & 0xffff; break;
      case 0x10: this.oeLo &= ~v; break;
      case 0x11: this.oeHi &= ~v & 0xffff; break;
      default: return;
    }
    if (this.outHi !== hi) this.onHiOut(this.outHi);
  }
}

// Row / column GPIO numbers (keyboard_matrix.tc KBD_ROW_GP* / KBD_COL_GP*).
const ROW_GP = [2, 1, 4, 3, 6];
const COL_GP = [5, 8, 7, 10, 9, 12];

// scancode -> byte (keyboard_matrix.tc KBD_KEYMAP + its patches).
export const KEYMAP = (() => {
  const s = "_09876_12345'poiuy_qwert_:lkjh_asdfg_/.,mn_zxcvb_     _     ";
  const m = new Uint8Array(60);
  for (let i = 0; i < 60; i++) m[i] = s.charCodeAt(i);
  m[0] = 8; m[6] = 27; m[18] = 9; m[24] = 13;          // BS ESC TAB ENTER (CR, like a UART terminal)
  for (const sc of [30, 36, 42, 48, 54]) m[sc] = 0;    // CTL SFT FN: no byte
  return m;
})();

// byte -> scancode (first match), -1 when the matrix has no such key.
export function scancodeOf(ch) {
  if (ch === 10) ch = 13;                              // "\n" in typed text means Enter
  if (ch >= 65 && ch <= 90) ch += 32;                  // no shift on the matrix: fold to lowercase
  for (let sc = 0; sc < 60; sc++) if (KEYMAP[sc] === ch && ch !== 0) return sc;
  return -1;
}

// The kernel reads GPIO_IN 11 times per scan (5 rows + 6 columns) and
// reports a key on the rising edge between two scans, so a press must
// stay visible for two scans and a release for one before the next press.
// Keys are closed one at a time in the order they arrived: a scan that
// saw two new keys would report them in scancode order, not typing
// order, and a key-down / key-up pair that fits inside one scan would be
// missed entirely (browser key events, or a test typing with no delay).
const HOLD_READS = 22;
const GAP_READS = 11;

export class KeyMatrix {
  constructor() {
    this.queue = [];                 // pending presses {sc, upSeen}
    this.cur = null;                 // the key currently closed {sc, upSeen, at}
    this.inReads = 0;
    this.releasedAt = -Infinity;
  }

  // Physical key down: queued, closed once the matrix is free.
  press(sc) {
    if (sc < 0 || sc >= 60) return;
    this.queue.push({ sc, upSeen: false });
  }

  // Physical key up: the matching press opens again after HOLD_READS.
  release(sc) {
    if (this.cur && this.cur.sc === sc && !this.cur.upSeen) { this.cur.upSeen = true; return; }
    for (let i = this.queue.length - 1; i >= 0; i--) {
      if (this.queue[i].sc === sc && !this.queue[i].upSeen) { this.queue[i].upSeen = true; return; }
    }
  }

  // Queue bytes to be typed one key at a time (bytes without a key are dropped).
  type(bytes) {
    for (const b of bytes) { const sc = scancodeOf(b); if (sc >= 0) this.queue.push({ sc, upSeen: true }); }
  }

  get pending() { return this.queue.length + (this.cur ? 1 : 0); }

  // GPIO_IN value for the low group given the current OUT / OE.
  sampleIn(outLo, oeLo) {
    this.inReads++;
    this.tick();
    let v = (outLo & oeLo) | ~oeLo;
    if (this.cur) {
      const sc = this.cur.sc, r = (sc / 12) | 0, lc = sc % 12;
      let drv, rd;
      if (lc < 6) { drv = ROW_GP[r]; rd = COL_GP[lc]; } else { drv = COL_GP[lc - 6]; rd = ROW_GP[r]; }
      if ((oeLo >> drv) & 1 && !((outLo >> drv) & 1) && !((oeLo >> rd) & 1)) v &= ~(1 << rd);
    }
    return v | 0;
  }

  tick() {
    if (this.cur) {
      if (this.cur.upSeen && this.inReads - this.cur.at >= HOLD_READS) { this.cur = null; this.releasedAt = this.inReads; }
      return;
    }
    if (this.queue.length && this.inReads - this.releasedAt >= GAP_READS) {
      this.cur = this.queue.shift();
      this.cur.at = this.inReads;
    }
  }
}
