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
// same table as the kernel). The modifier keys (CTL / SFT / FN) emit no
// byte of their own: the kernel decodes the other keys held in the same
// scan through them (SFT = upper case / shifted symbols, CTL = Ctrl+A..Z,
// FN+hjkl = arrows, FN+uiop'n = - = [ ] \ `), so a browser key becomes a
// chord: the modifier scancodes plus the key's, all closed together.

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

// Modifier scancodes (keyboard_matrix.tc SC_*; the left-hand SFT / FN).
export const SC_CTL = 30, SC_SFT = 42, SC_FN = 54;

// The kernel's modifier layers (keyboard_matrix.tc kbd_shift / kbd_fn /
// kbd_fn_arrow), as "unmodified key -> byte" strings.
const SHIFT_FROM = "abcdefghijklmnopqrstuvwxyz1234567890',./:";
const SHIFT_TO   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()\"<>?;";
const FN_FROM = "uiop'n", FN_TO = "-=[]\\`", FN_SHIFT_TO = "_+{}|~";
const ARROW_KEY = { A: "k", B: "j", C: "l", D: "h" };   // CSI final byte -> FN + key

// byte -> scancode of the key that emits it unmodified, -1 when none.
export function scancodeOf(ch) {
  if (ch === 10) ch = 13;                              // "\n" in typed text means Enter
  for (let sc = 0; sc < 60; sc++) if (KEYMAP[sc] === ch && ch !== 0) return sc;
  return -1;
}

// byte -> the chord (scancodes closed together) that types it, or null.
// Bytes 1..26 other than BS / TAB / Enter are Ctrl+letter.
export function chordOf(ch) {
  const sc = scancodeOf(ch);
  if (sc >= 0) return [sc];
  let i = SHIFT_TO.indexOf(String.fromCharCode(ch));
  if (i >= 0) return [SC_SFT, scancodeOf(SHIFT_FROM.charCodeAt(i))];
  i = FN_TO.indexOf(String.fromCharCode(ch));
  if (i >= 0) return [SC_FN, scancodeOf(FN_FROM.charCodeAt(i))];
  i = FN_SHIFT_TO.indexOf(String.fromCharCode(ch));
  if (i >= 0) return [SC_FN, SC_SFT, scancodeOf(FN_FROM.charCodeAt(i))];
  if (ch >= 1 && ch <= 26) return [SC_CTL, scancodeOf(ch + 96)];
  return null;
}

// Arrow key by its CSI final byte ("A" up, "B" down, "C" right, "D" left).
export function arrowChord(final) {
  return final in ARROW_KEY ? [SC_FN, scancodeOf(ARROW_KEY[final].charCodeAt(0))] : null;
}

// The kernel reads GPIO_IN 11 times per scan (5 rows + 6 columns) and
// reports a key once two consecutive scans saw it after one that did
// not, so a press must stay visible for two complete scans (33 reads
// covers two whatever read it starts at) and a release for one complete
// scan before the next press.
// Chords are closed one at a time in the order they arrived: a scan that
// saw two new keys would report them in scancode order, not typing
// order, and a key-down / key-up pair that fits inside one scan would be
// missed entirely (browser key events, or a test typing with no delay).
// A chord's modifiers close and open together with its key, which is
// all the kernel needs: it reads the modifiers in the scan that sees
// the key's rising edge.
const HOLD_READS = 33;
const GAP_READS = 22;

export class KeyMatrix {
  constructor() {
    this.queue = [];                 // pending chords {scs, upSeen}
    this.cur = null;                 // the chord currently closed {scs, upSeen, at}
    this.inReads = 0;
    this.releasedAt = -Infinity;
  }

  // Physical key down: queued, closed once the matrix is free. `scs` is
  // a chord (array of scancodes) or a single scancode.
  press(scs) {
    scs = [].concat(scs).filter((sc) => sc >= 0 && sc < 60);
    if (scs.length) this.queue.push({ scs, upSeen: false });
  }

  // Physical key up: the matching press opens again after HOLD_READS.
  release(scs) {
    const id = [].concat(scs).join(",");
    if (this.cur && this.cur.scs.join(",") === id && !this.cur.upSeen) { this.cur.upSeen = true; return; }
    for (let i = this.queue.length - 1; i >= 0; i--) {
      if (this.queue[i].scs.join(",") === id && !this.queue[i].upSeen) { this.queue[i].upSeen = true; return; }
    }
  }

  // Queue bytes to be typed one chord at a time (bytes without a key are
  // dropped). "ESC [ A-D" types the arrow key; a NUL followed by a letter
  // types Ctrl+letter (so a test can send Ctrl+J, which "\n" cannot).
  type(bytes) {
    for (let i = 0; i < bytes.length; i++) {
      let scs = null;
      if (bytes[i] === 27 && bytes[i + 1] === 0x5b && (scs = arrowChord(String.fromCharCode(bytes[i + 2])))) i += 2;
      else if (bytes[i] === 0 && i + 1 < bytes.length) { scs = [SC_CTL, scancodeOf(bytes[i + 1] | 32)]; i++; }
      else scs = chordOf(bytes[i]);
      if (scs && scs.every((sc) => sc >= 0)) this.queue.push({ scs, upSeen: true });
    }
  }

  get pending() { return this.queue.length + (this.cur ? 1 : 0); }

  // GPIO_IN value for the low group given the current OUT / OE.
  sampleIn(outLo, oeLo) {
    this.inReads++;
    this.tick();
    let v = (outLo & oeLo) | ~oeLo;
    if (this.cur) {
      for (const sc of this.cur.scs) {
        const r = (sc / 12) | 0, lc = sc % 12;
        let drv, rd;
        if (lc < 6) { drv = ROW_GP[r]; rd = COL_GP[lc]; } else { drv = COL_GP[lc - 6]; rd = ROW_GP[r]; }
        if ((oeLo >> drv) & 1 && !((outLo >> drv) & 1) && !((oeLo >> rd) & 1)) v &= ~(1 << rd);
      }
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
