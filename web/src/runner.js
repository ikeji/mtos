// runner.js — drives Cpu + Soc in time slices so a Web Worker (or a Node
// harness) can keep servicing messages. Environment-agnostic: the host
// supplies yieldFn (run cb as soon as possible, e.g. via MessageChannel)
// and sleepFn (run cb after ms, e.g. setTimeout). All output goes
// through the on* callbacks.
//
// Throttling: targetMips = 0 runs flat out; otherwise the runner keeps
// executed instructions <= elapsed_ms * targetMips * 1000 and sleeps when
// it is ahead (tn20k hw ~12 MIPS, pico2 ~150 MIPS).

import { Cpu, CpuError, hex } from "./cpu.js";
import { Soc } from "./soc.js";
import { SdCard } from "./sd.js";
import { renderDisplay, displayDirty, FRAME_BYTES } from "./display.js";

const SLICE_INSNS = 1 << 20;        // ~8 ms at 120 MIPS
const STATS_INTERVAL_MS = 250;
const FRAME_INTERVAL_MS = 33;       // LCD frames to the page, at most ~30 fps and only when changed

export class EmuRunner {
  constructor({ yieldFn, sleepFn, now = () => performance.now(), strict = false } = {}) {
    this.yieldFn = yieldFn;
    this.sleepFn = sleepFn;
    this.now = now;
    this.strict = strict;
    this.bin = null;
    this.soc = null;
    this.cpu = null;
    this.running = false;
    this.targetMips = 0;
    this.txBuf = [];
    this.onTx = (bytes) => {};          // Uint8Array
    this.onStats = (s) => {};           // {insns, mips, running, halted, exitCode, unmapped}
    this.onError = (msg, dump) => {};
    this.onHalt = (exitCode) => {};
    this.onSdWrite = () => {};          // called at most once per second while the OS writes the card
    this.onFrame = (w, h, rgba) => {};  // LCD picture (Uint8ClampedArray RGBA, transferable)
    this.frameT = -Infinity;
    this.sdImage = null;                // Uint8Array, survives reset()
    this.sdNotifiedAt = -Infinity;      // performance.now() starts near 0 in a fresh Worker
    this.epochT = 0;                    // throttle reference (wall clock ms)
    this.epochInsns = 0;
    this.statsT = 0;
    this.statsInsns = 0;
    this.pendingSlice = false;
  }

  load(bytes) {
    this.bin = bytes;
    this.running = false;
    this.soc = new Soc({ strict: this.strict });
    this.soc.loadBin(bytes);
    this.soc.onTx = (b) => { this.txBuf.push(b); };
    this.cpu = new Cpu(this.soc);
    this.txBuf.length = 0;
    this.attachSdToSoc();
    this.emitStats(true);
    this.pumpFrame(true);
  }

  // Matrix keyboard: a key press / release by scancode, or bytes to type
  // one key at a time (gpio.js KeyMatrix).
  key(sc, down) {
    if (!this.soc) return;
    if (down) this.soc.kbd.press(sc); else this.soc.kbd.release(sc);
  }

  kbdType(bytes) {
    if (this.soc) this.soc.kbd.type(bytes);
  }

  pumpFrame(force) {
    if (!this.soc) return;
    const t = this.now();
    if (!force && (t - this.frameT < FRAME_INTERVAL_MS || !displayDirty(this.soc))) return;
    this.frameT = t;
    const rgba = new Uint8ClampedArray(FRAME_BYTES);
    const { w, h } = renderDisplay(this.soc, rgba);
    this.onFrame(w, h, rgba);
  }

  // Attach (or detach with null) an SD image. Takes effect at the next
  // reset for the kernel's boot-time probe, but the card itself is live
  // immediately.
  attachSd(image) {
    this.sdImage = image;
    this.attachSdToSoc();
  }

  attachSdToSoc() {
    if (!this.soc) return;
    if (!this.sdImage) { this.soc.sd = null; return; }
    const card = new SdCard(this.sdImage);
    card.onWrite = () => {
      const t = this.now();
      if (t - this.sdNotifiedAt > 1000) { this.sdNotifiedAt = t; this.onSdWrite(); }
    };
    this.soc.sd = card;
  }

  reset() {
    if (this.bin) this.load(this.bin);
  }

  input(bytes) {
    if (!this.soc) return;
    for (const b of bytes) this.soc.uartPush(b);
  }

  setTargetMips(m) {
    this.targetMips = m || 0;
    this.rebase();
  }

  rebase() {
    this.epochT = this.now();
    this.epochInsns = this.cpu ? this.cpu.insns : 0;
  }

  start() {
    if (!this.cpu || this.running || this.soc.halted) return;
    this.running = true;
    this.rebase();
    this.statsT = this.epochT;
    this.statsInsns = this.epochInsns;
    this.schedule(0);
  }

  pause() {
    this.running = false;
    this.emitStats(true);
    this.pumpFrame(true);
  }

  schedule(ms) {
    if (this.pendingSlice) return;
    this.pendingSlice = true;
    const go = () => { this.pendingSlice = false; this.slice(); };
    if (ms > 0) this.sleepFn(ms, go); else this.yieldFn(go);
  }

  slice() {
    if (!this.running) return;
    let n = SLICE_INSNS;
    if (this.targetMips > 0) {
      const allowed = (this.now() - this.epochT) * this.targetMips * 1000 - (this.cpu.insns - this.epochInsns);
      if (allowed < 1) { this.schedule(Math.min(50, Math.max(1, -allowed / (this.targetMips * 1000)))); return; }
      n = Math.min(n, Math.ceil(allowed));
    }
    try {
      this.cpu.run(n);
    } catch (e) {
      this.running = false;
      this.flushTx();
      const dump = e instanceof CpuError ? this.cpu.dump() : "";
      this.onError(e.message, dump);
      this.emitStats(true);
      this.pumpFrame(true);
      return;
    }
    this.flushTx();
    if (this.soc.halted) {
      this.running = false;
      this.emitStats(true);
      this.pumpFrame(true);
      this.onHalt(this.soc.exitCode);
      return;
    }
    this.emitStats(false);
    this.pumpFrame(false);
    this.schedule(0);
  }

  flushTx() {
    if (this.txBuf.length === 0) return;
    const bytes = Uint8Array.from(this.txBuf);
    this.txBuf.length = 0;
    this.onTx(bytes);
  }

  emitStats(force) {
    const t = this.now();
    if (!force && t - this.statsT < STATS_INTERVAL_MS) return;
    const insns = this.cpu ? this.cpu.insns : 0;
    const dt = t - this.statsT;
    const mips = dt > 0 && this.running ? (insns - this.statsInsns) / (dt * 1000) : 0;
    this.statsT = t;
    this.statsInsns = insns;
    const unmapped = this.soc ? [...this.soc.unmapped.keys()].sort((a, b) => a - b).map(hex) : [];
    this.onStats({
      insns, mips, running: this.running,
      halted: this.soc ? this.soc.halted : false,
      exitCode: this.soc ? this.soc.exitCode : null,
      unmapped,
    });
  }
}
