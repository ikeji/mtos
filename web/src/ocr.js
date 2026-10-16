// ocr.js — read text back off a rendered frame. /bin/console draws the
// 8x16 hankaku glyphs of jpfont.dat, which are byte-identical to the
// SoC's font_hankaku.hex, so an exact bitmap match per cell recovers the
// characters (tests use this to check what the LCD shows). Cells are
// thresholded on luminance; a cell with more lit than dark pixels is
// treated as reverse video. Unknown bitmaps become '?'. The grid may sit
// 8 pixels below the top (console's landscape chrome), so both offsets
// are tried and the one with more recognised glyphs wins.

import { FONT_HANKAKU } from "./font_hankaku.js";

let glyphMap = null;
function buildMap() {
  glyphMap = new Map();
  const key = (code) => String.fromCharCode(...FONT_HANKAKU.subarray(code * 16, code * 16 + 16));
  const order = [];
  for (let c = 32; c < 127; c++) order.push(c);
  for (let c = 0; c < 256; c++) if (c < 32 || c >= 127) order.push(c);
  for (const c of order) { const k = key(c); if (!glyphMap.has(k)) glyphMap.set(k, c < 32 || c >= 127 ? "?" : String.fromCharCode(c)); }
  glyphMap.set("\0".repeat(16), " ");
}

function cellBits(rgba, w, x0, y0) {
  const bits = new Array(16);
  let lit = 0;
  for (let r = 0; r < 16; r++) {
    let b = 0;
    for (let x = 0; x < 8; x++) {
      const o = ((y0 + r) * w + x0 + x) * 4;
      const lum = rgba[o] * 3 + rgba[o + 1] * 6 + rgba[o + 2];   // ~ 10x luminance
      if (lum > 1280) { b |= 0x80 >> x; lit++; }
    }
    bits[r] = b;
  }
  if (lit > 64) for (let r = 0; r < 16; r++) bits[r] = ~bits[r] & 0xff;   // reverse video
  return String.fromCharCode(...bits);
}

// Returns {lines: string[], score}.
export function screenToText(rgba, w, h) {
  if (!glyphMap) buildMap();
  let best = null;
  for (const oy of [0, 8]) {
    const lines = [];
    let score = 0;
    for (let y = oy; y + 16 <= h; y += 16) {
      let line = "";
      for (let x = 0; x + 8 <= w; x += 8) {
        const ch = glyphMap.get(cellBits(rgba, w, x, y));
        if (ch === undefined) line += "?"; else { line += ch; if (ch !== " ") score++; }
      }
      lines.push(line.replace(/\s+$/, ""));
    }
    if (!best || score > best.score) best = { lines, score };
  }
  return best;
}
