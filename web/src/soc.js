// soc.js — the hw/ SoC as seen by software (hw/rtl/soc/soc.v):
//   0x0010_0000  exit device (0x5555 = pass, 0x3333|code<<16 = fail), +4 BOOT_UART_WAIT (ro)
//   0x0200_0000  CLINT: +0x4000 mtimecmp lo/hi, +0xBFF8 mtime lo/hi
//   0x1000_0000  UART 16550: +0 DR, +5 LSR (bit0 RX ready, bit5/6 TX empty)
//   0x1003_0000  SD SPI master (hw/rtl/soc/spi_master.v): +0 DATA, +4 STATUS bit0 busy, +8 CTRL
//                — stub with no card: every transfer completes at once and reads 0xFF,
//                so block_sd.tc reports "SD: card init failed" and the kernel runs without /sd
//   0x8000_0000  SDRAM (8 MB)
// mtime advances one tick per executed instruction (deterministic, like
// qemu icount). Other MMIO is unmapped for now (Phase 2 adds SD / LCD /
// GPIO stubs); in strict mode an unmapped access throws so we learn what
// the kernel touches.

import { RAM_BASE, hex } from "./cpu.js";

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
    if (page === 0x1003) {                    // SD SPI: no card
      return (addr & 0xf) === 0 ? 0xff : 0;
    }
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
    if (page === 0x1003) return;              // SD SPI: no card, accept writes
    if (this.strict) throw new Error("unmapped MMIO write " + hex(addr) + " size " + size + " value " + hex(value));
    this.noteUnmapped(addr);
  }
}
