// soc.js — the hw/ SoC as seen by software (hw/rtl/soc/soc.v):
//   0x0010_0000  exit device (0x5555 = pass, 0x3333|code<<16 = fail), +4 BOOT_UART_WAIT (ro)
//   0x0200_0000  CLINT: +0x4000 mtimecmp lo/hi, +0xBFF8 mtime lo/hi
//   0x1000_0000  UART 16550: +0 DR, +5 LSR (bit0 RX ready, bit5/6 TX empty)
//   0x1003_0000  SD SPI master (hw/rtl/soc/spi_master.v): +0 DATA, +4 STATUS bit0 busy, +8 CTRL
//                — transfers complete at once. With `sd` (an SdCard) attached the byte goes
//                through its state machine; without a card every read is 0xFF so block_sd.tc
//                reports "SD: card init failed" and the kernel runs without /sd
//   0x1004_0000  LCD SPI (hw/rtl/soc/lcd_spi.v): +0 DATA byte, +4 STATUS (never busy), +8 CTRL div,
//                +0xC PIX (RGB565 -> 3 bytes), +0x10 FILL (repeat last PIX n times), +0x14 GAP.
//                Bytes go to the Ili9488 model; DC comes from GPIO GP38
//   0x1005_0000  vram_lcd refresh engine: +0 CTRL enable, +4 BASE (SDRAM word addr), +8 DIV, +0xC STATUS
//   0x1006_0000  text_lcd character engine: word 0..1199 cells, 2048 CTRL, 2049 DIV, 2050 ZBASE
//   0xD000_0000  GPIO, RP2350 SIO layout (hw/rtl/soc/gpio_sio.v): the keyboard matrix sits on GP1..12,
//                LCD DC / CS / RST / BL on GP38 / 39 / 43 / 44
//   0x4002_8000 / 0x4003_A000 / 0x4003_B000  IO_BANK0 / PADS: unmapped on the SoC (writes ignored, reads 0)
//   0x8000_0000  SDRAM (8 MB)
// mtime advances one tick per executed instruction (deterministic, like
// qemu icount). In strict mode any other access throws so we learn what
// the kernel touches.

import { RAM_BASE, hex } from "./cpu.js";
import { Ili9488 } from "./lcd.js";
import { Gpio, KeyMatrix } from "./gpio.js";

export const EXIT_PASS = 0x5555;

export class Soc {
  constructor({ ramSize = 8 << 20, strict = true } = {}) {
    this.ramBase = RAM_BASE;
    this.ramSize = ramSize;
    this.buf = new ArrayBuffer(ramSize);
    this.ram8 = new Uint8Array(this.buf);
    this.ram16 = new Uint16Array(this.buf);
    this.ram32 = new Int32Array(this.buf);
    this.strict = strict;

    this.mtime = 0;               // Number: exact up to 2^53 ticks
    this.mtimecmpLo = 0xffffffff;
    this.mtimecmpHi = 0xffffffff;
    this.mtimecmp = 2 ** 64 - 1;

    this.rx = [];                 // UART RX queue (bytes)
    this.rxHead = 0;
    this.onTx = (byte) => {};     // UART TX sink

    this.sd = null;               // SdCard or null
    this.spiRx = 0xff;            // last byte received on the SD SPI

    this.lcd = new Ili9488();
    this.lcdDiv = 0; this.lcdGap = 0;
    this.vram = { enable: 0, base: 0x1e9400, div: 0 };   // reset BASE = 0x807A5000 (vram_lcd.v hardcodes it; console relies on that)
    this.text = { cells: new Uint32Array(1200), enable: 0, div: 0, zbase: 0 };
    this.gpio = new Gpio();
    this.kbd = new KeyMatrix();
    this.gpio.inLoFn = (outLo, oeLo) => this.kbd.sampleIn(outLo, oeLo);
    this.gpio.onHiOut = (hi) => {
      this.lcd.dc = (hi >> 6) & 1;                       // GP38
      if (!((hi >> 11) & 1) && (this.gpio.oeHi >> 11) & 1) this.lcd.hwReset();   // GP43 driven low
    };
    this.halted = false;
    this.exitCode = null;
    this.unmapped = new Map();    // lenient mode: addr -> count, for Phase 2 stubs
  }

  noteUnmapped(addr) {
    const key = addr >>> 0;
    this.unmapped.set(key, (this.unmapped.get(key) || 0) + 1);
  }

  loadBin(bytes, addr = RAM_BASE) {
    const off = (addr - RAM_BASE) >>> 0;
    if (off + bytes.length > this.ramSize) throw new Error("bin does not fit in RAM");
    this.ram8.set(bytes, off);
  }

  timerPending() {
    return this.mtime >= this.mtimecmp;
  }

  uartPush(byte) {
    this.rx.push(byte & 0xff);
  }

  uartRxReady() {
    return this.rxHead < this.rx.length;
  }

  uartPop() {
    if (this.rxHead >= this.rx.length) return 0;
    const b = this.rx[this.rxHead++];
    if (this.rxHead > 1024 && this.rxHead * 2 > this.rx.length) {
      this.rx = this.rx.slice(this.rxHead);
      this.rxHead = 0;
    }
    return b;
  }

  // size = 1 / 2 / 4. Returns the raw value (caller masks / sign-extends).
  mmioRead(addr, size) {
    const page = addr >>> 16;
    if (page === 0x1000) {                    // UART
      const reg = addr & 7;
      if (reg === 0) return this.uartPop();
      if (reg === 5) return 0x60 | (this.uartRxReady() ? 1 : 0);
      if (reg === 4 && size === 4) return (0x60 | (this.uartRxReady() ? 1 : 0)) << 8;
      return 0;
    }
    if (page === 0x0200) {                    // CLINT
      switch (addr & 0xffff) {
        case 0x4000: return this.mtimecmpLo | 0;
        case 0x4004: return this.mtimecmpHi | 0;
        case 0xbff8: return (this.mtime % 4294967296) | 0;
        case 0xbffc: return Math.floor(this.mtime / 4294967296) | 0;
        default: return 0;
      }
    }
    if (page === 0x0010) {                    // exit device
      return (addr & 0xf) === 4 ? 0 : (this.exitCode | 0);
    }
    if (page === 0x1003) {                    // SD SPI master
      return (addr & 0xf) === 0 ? this.spiRx : 0;   // DATA: last rx; STATUS: never busy
    }
    if (page === 0x1004) {                    // LCD SPI: STATUS idle, CTRL / GAP read back
      const reg = addr & 0x1c;
      return reg === 8 ? this.lcdDiv << 8 : reg === 0x14 ? this.lcdGap : 0;
    }
    if (page === 0x1005) {                    // vram_lcd
      switch (addr & 0xc) {
        case 0: return this.vram.enable;
        case 4: return this.vram.base;
        case 0xc: return this.vram.enable;    // active while enabled
        default: return 0;
      }
    }
    if (page === 0x1006) {                    // text_lcd
      const idx = (addr & 0x3fff) >>> 2;
      if (idx < 1200) return this.text.cells[idx] | 0;
      if (idx === 2048) return this.text.enable;
      if (idx === 2049) return this.text.div;
      if (idx === 2050) return this.text.zbase;
      return 0;
    }
    if (page === 0xd000) return this.gpio.read(addr & 0xff);
    if (page === 0x4002 || page === 0x4003) return 0;   // IO_BANK0 / PADS
    if (this.strict) throw new Error("unmapped MMIO read " + hex(addr) + " size " + size);
    this.noteUnmapped(addr);
    return 0;
  }

  mmioWrite(addr, size, value) {
    const page = addr >>> 16;
    if (page === 0x1000) {                    // UART
      if ((addr & 7) === 0) this.onTx(value & 0xff);
      return;
    }
    if (page === 0x0200) {                    // CLINT
      switch (addr & 0xffff) {
        case 0x4000: this.mtimecmpLo = value >>> 0; break;
        case 0x4004: this.mtimecmpHi = value >>> 0; break;
        case 0xbff8: this.mtime = Math.floor(this.mtime / 4294967296) * 4294967296 + (value >>> 0); return;
        case 0xbffc: this.mtime = (value >>> 0) * 4294967296 + (this.mtime % 4294967296); return;
        default: return;
      }
      this.mtimecmp = this.mtimecmpHi * 4294967296 + this.mtimecmpLo;
      return;
    }
    if (page === 0x0010) {                    // exit device
      if ((addr & 0xf) === 0) {
        this.exitCode = value >>> 0;
        this.halted = true;
      }
      return;
    }
    if (page === 0x1003) {                    // SD SPI master
      const reg = addr & 0xf;
      if (reg === 0) this.spiRx = this.sd ? this.sd.xfer(value & 0xff) : 0xff;
      else if (reg === 8 && this.sd) this.sd.setCs((value & 1) !== 0);
      return;
    }
    if (page === 0x1004) {                    // LCD SPI
      const lcd = this.lcd;
      switch (addr & 0x1c) {
        case 0: lcd.byte(value & 0xff, lcd.dc); break;
        case 8: this.lcdDiv = (value >> 8) & 0xff; break;
        case 0xc:
          lcd.byte((value >> 8) & 0xf8, lcd.dc);
          lcd.byte((value >> 3) & 0xfc, lcd.dc);
          lcd.byte((value << 3) & 0xf8, lcd.dc);
          break;
        case 0x10: if (lcd.dc) lcd.repeatLast(value >>> 0); break;
        case 0x14: this.lcdGap = value & 0xffff; break;
        default: break;
      }
      return;
    }
    if (page === 0x1005) {                    // vram_lcd
      switch (addr & 0xc) {
        case 0: this.vram.enable = value & 1; this.lcd.dirty = true; break;
        case 4: this.vram.base = value & 0x1fffff; break;
        case 8: this.vram.div = value & 0xff; break;
        default: break;
      }
      return;
    }
    if (page === 0x1006) {                    // text_lcd
      const idx = (addr & 0x3fff) >>> 2;
      if (idx < 1200) this.text.cells[idx] = value >>> 0;
      else if (idx === 2048) { this.text.enable = value & 1; this.lcd.dirty = true; }
      else if (idx === 2049) this.text.div = value & 0xff;
      else if (idx === 2050) this.text.zbase = value & 0x1fffff;
      return;
    }
    if (page === 0xd000) { this.gpio.write(addr & 0xff, value >>> 0); return; }
    if (page === 0x4002 || page === 0x4003) return;     // IO_BANK0 / PADS
    if (this.strict) throw new Error("unmapped MMIO write " + hex(addr) + " size " + size + " value " + hex(value));
    this.noteUnmapped(addr);
  }
}
