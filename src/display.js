// display.js — what the LCD shows. Three sources, in the SoC's pin-mux
// priority (soc.v: text > vram > spi2): the text_lcd character engine
// (0x1006_0000), the vram_lcd refresh engine (0x1005_0000, streams a
// 480x320 RGB565 framebuffer out of SDRAM), or the ILI9488 GRAM written
// through lcd_spi (0x1004_0000). The two engines issue a fixed 480-wide
// window, which only makes sense in landscape (console sets MADCTL 0xE8
// before enabling them), so their frames are shown landscape directly.

import { rgba } from "./lcd.js";
import { FONT_HANKAKU } from "./font_hankaku.js";

export const FRAME_BYTES = 320 * 480 * 4;   // same for both orientations

// text_lcd.v palette (RGB565).
const PALETTE = [0x0000, 0x001f, 0x07e0, 0x07ff, 0xf800, 0xf81f, 0xfd20, 0xc618,
                 0x7bef, 0x041f, 0x07ef, 0x5fff, 0xfc10, 0xfc1f, 0xffe0, 0xffff];
const TEXT_COLS = 60, TEXT_ROWS = 20, TEXT_W = 480, TEXT_H = 320;

// True when the picture may have changed since the last render.
export function displayDirty(soc) {
  if (soc.text.enable || soc.vram.enable) return true;   // engines re-read memory every frame
  return soc.lcd.dirty;
}

// Render the current picture into out (Uint8ClampedArray >= FRAME_BYTES). Returns {w, h}.
export function renderDisplay(soc, out) {
  if (soc.text.enable) return renderText(soc, out);
  if (soc.vram.enable) return renderVram(soc, out);
  return soc.lcd.render(out);
}

function renderVram(soc, out) {
  const base = (soc.vram.base << 1) >>> 0;        // word address -> Uint16 index
  const ram16 = soc.ram16;
  const n = TEXT_W * TEXT_H;
  let o = 0;
  for (let i = 0; i < n; i++) o = rgba(out, o, ram16[(base + i) & (ram16.length - 1)]);
  soc.lcd.dirty = false;
  return { w: TEXT_W, h: TEXT_H };
}

function renderText(soc, out) {
  const cells = soc.text.cells, ram8 = soc.ram8;
  const zbase = (soc.text.zbase << 2) >>> 0;      // word address -> byte offset
  const stride = TEXT_W * 4;
  for (let row = 0; row < TEXT_ROWS; row++) {
    for (let col = 0; col < TEXT_COLS; col++) {
      const cell = cells[row * TEXT_COLS + col];
      const fg = PALETTE[(cell >> 8) & 15], bg = PALETTE[(cell >> 12) & 15];
      const zen = (cell >> 16) & 1, zright = (cell >> 17) & 1, kuten = (cell >>> 18) & 0x3fff;
      for (let gr = 0; gr < 16; gr++) {
        let bits;
        if (zen) bits = ram8[(zbase + kuten * 32 + gr * 2 + zright) & (ram8.length - 1)];
        else bits = FONT_HANKAKU[((cell & 0xff) << 4) | gr];
        let o = (row * 16 + gr) * stride + col * 8 * 4;
        for (let x = 0; x < 8; x++) o = rgba(out, o, (bits >> (7 - x)) & 1 ? fg : bg);
      }
    }
  }
  soc.lcd.dirty = false;
  return { w: TEXT_W, h: TEXT_H };
}
