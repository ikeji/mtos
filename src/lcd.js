// lcd.js — ILI9488 panel model driven by the SoC's lcd_spi shifter
// (hw/rtl/soc/lcd_spi.v, 0x1004_0000) and by the VRAM / text refresh
// engines. The panel is a 320-column x 480-row GRAM; MADCTL (0x36) maps
// the host's (column, page) address counters onto it and the vertical
// scroll registers (0x33 / 0x37) remap rows at display time, exactly what
// kernel/platform/tn20k/display_ili9488.tc and /bin/console rely on
// (portrait 0x48 + hardware scroll, landscape 0xE8 + software scroll).
//
// Only the commands the drivers use are modelled: SWRESET 0x01, SLPOUT
// 0x11, DISPOFF/ON 0x28/0x29, CASET 0x2A, PASET 0x2B, RAMWR 0x2C, VSCRDEF
// 0x33, MADCTL 0x36, VSCRSADD 0x37. Everything else is accepted and ignored.
// Pixels arrive as 3 bytes (18-bit format, R/G/B left-justified) and are
// stored as RGB565.

export const LCD_COLS = 320;   // physical columns
export const LCD_ROWS = 480;   // physical rows

export class Ili9488 {
  constructor() {
    this.gram = new Uint16Array(LCD_COLS * LCD_ROWS);
    this.dc = 0;                     // DC line: 0 = command byte, 1 = data byte (GPIO GP38)
    this.dirty = true;
    this.args = new Uint8Array(8);
    this.pixBytes = new Uint8Array(3);
    this.hwReset();
  }

  // RST low: back to power-on state (GRAM keeps its contents, like the real panel).
  hwReset() {
    this.madctl = 0;
    this.xs = 0; this.xe = LCD_COLS - 1; this.ys = 0; this.ye = LCD_ROWS - 1;
    this.col = 0; this.page = 0;
    this.cmd = -1; this.argc = 0;
    this.tfa = 0; this.vsa = LCD_ROWS; this.bfa = 0; this.vsp = 0;
    this.pixN = 0;
    this.on = false;
    this.dirty = true;
  }

  byte(b, dc) { if (dc) this.data(b); else this.command(b); }

  command(b) {
    this.cmd = b; this.argc = 0;
    switch (b) {
      case 0x01: this.hwReset(); break;
      case 0x28: this.on = false; this.dirty = true; break;
      case 0x29: this.on = true; this.dirty = true; break;
      case 0x2c: this.col = this.xs; this.page = this.ys; this.pixN = 0; break;
      default: break;
    }
  }

  data(b) {
    const a = this.args;
    switch (this.cmd) {
      case 0x2c: this.pixByte(b); return;
      case 0x2a:
        a[this.argc++] = b;
        if (this.argc === 4) { this.xs = (a[0] << 8) | a[1]; this.xe = (a[2] << 8) | a[3]; this.argc = 0; }
        return;
      case 0x2b:
        a[this.argc++] = b;
        if (this.argc === 4) { this.ys = (a[0] << 8) | a[1]; this.ye = (a[2] << 8) | a[3]; this.argc = 0; }
        return;
      case 0x36: this.madctl = b; this.dirty = true; return;
      case 0x37:
        a[this.argc++] = b;
        if (this.argc === 2) { this.vsp = (a[0] << 8) | a[1]; this.argc = 0; this.dirty = true; }
        return;
      case 0x33:
        a[this.argc++] = b;
        if (this.argc === 6) {
          this.tfa = (a[0] << 8) | a[1]; this.vsa = (a[2] << 8) | a[3]; this.bfa = (a[4] << 8) | a[5];
          if (this.vsa <= 0) this.vsa = LCD_ROWS;
          this.argc = 0; this.dirty = true;
        }
        return;
      default: return;
    }
  }

  // One of the three bytes of an 18-bit pixel.
  pixByte(b) {
    const p = this.pixBytes;
    p[this.pixN++] = b;
    if (this.pixN < 3) return;
    this.pixN = 0;
    this.put(((p[0] >> 3) << 11) | ((p[1] >> 2) << 5) | (p[2] >> 3));
  }

  // Repeat the last pixel n more times (the lcd_spi FILL register).
  repeatLast(n) {
    const p = this.pixBytes;
    for (let i = 0; i < n; i++) { this.pixByte(p[0]); this.pixByte(p[1]); this.pixByte(p[2]); }
  }

  put(c) {
    if (this.page > this.ye) return;             // window full: the panel drops the rest
    const m = this.madctl;
    let pc, pr;
    if (m & 0x20) { pc = this.page; pr = this.col; } else { pc = this.col; pr = this.page; }
    if (m & 0x40) pc = LCD_COLS - 1 - pc;
    if (m & 0x80) pr = LCD_ROWS - 1 - pr;
    if (pc >= 0 && pc < LCD_COLS && pr >= 0 && pr < LCD_ROWS) this.gram[pr * LCD_COLS + pc] = c;
    this.dirty = true;
    if (++this.col > this.xe) { this.col = this.xs; this.page++; }
  }

  get landscape() { return (this.madctl & 0x20) !== 0; }

  // Physical row shown at display row r (vertical scroll).
  srcRow(r) {
    if (r < this.tfa || r >= this.tfa + this.vsa) return r;
    const v = this.vsa;
    return this.tfa + ((((r - this.tfa) + (this.vsp - this.tfa)) % v) + v) % v;
  }

  // Render into an RGBA buffer. Portrait: 320x480, canvas x = mirrored
  // physical column (so MADCTL 0x48 reads upright). Landscape (MV set):
  // 480x320, the portrait picture turned 90 degrees clockwise (so 0xE8
  // reads upright). Returns {w, h}.
  render(out) {
    const g = this.gram;
    let o = 0;
    if (!this.landscape) {
      for (let y = 0; y < LCD_ROWS; y++) {
        const base = this.srcRow(y) * LCD_COLS;
        for (let x = 0; x < LCD_COLS; x++) { o = rgba(out, o, this.on ? g[base + (LCD_COLS - 1 - x)] : 0); }
      }
      this.dirty = false;
      return { w: LCD_COLS, h: LCD_ROWS };
    }
    for (let y = 0; y < LCD_COLS; y++) {
      const pc = LCD_COLS - 1 - y;
      for (let x = 0; x < LCD_ROWS; x++) {
        const pr = this.srcRow(LCD_ROWS - 1 - x);
        o = rgba(out, o, this.on ? g[pr * LCD_COLS + pc] : 0);
      }
    }
    this.dirty = false;
    return { w: LCD_ROWS, h: LCD_COLS };
  }
}

// RGB565 -> RGBA bytes at out[o..o+3]; returns the next offset.
export function rgba(out, o, c) {
  const r = (c >> 11) & 31, g = (c >> 5) & 63, b = c & 31;
  out[o] = (r << 3) | (r >> 2);
  out[o + 1] = (g << 2) | (g >> 4);
  out[o + 2] = (b << 3) | (b >> 2);
  out[o + 3] = 255;
  return o + 4;
}
