#!/usr/bin/env node
// node_run.js — run a raw RV32 bin on the emulated SoC from the command line.
//
//   node web/src/node_run.js prog.bin [--max N] [--quiet] [--stdin FILE] [--sd IMG [--sd-out IMG]]
//
// Loads prog.bin at 0x80000000, runs until the exit device is written or
// N instructions (default 200M) have run. UART TX goes to stdout. --sd
// attaches a FAT image as the SD card (web/tools/fatimg.py makes one);
// --sd-out writes the (possibly modified) image back on exit.
// Exit status: 0 = exit code 0x5555 (pass), 1 = other exit code or CPU
// error, 2 = instruction limit.

import { readFileSync, writeFileSync, writeSync } from "node:fs";
import { SdCard } from "./sd.js";
import { Cpu, CpuError, hex, RAM_BASE } from "./cpu.js";
import { Soc, EXIT_PASS } from "./soc.js";

function main(argv) {
  let bin = null, max = 200e6, quiet = false, stdinFile = null, strict = true, sdFile = null, sdOut = null;
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === "--max") max = Number(argv[++i]);
    else if (a === "--quiet") quiet = true;
    else if (a === "--stdin") stdinFile = argv[++i];
    else if (a === "--lenient") strict = false;
    else if (a === "--sd") sdFile = argv[++i];
    else if (a === "--sd-out") sdOut = argv[++i];
    else if (bin === null) bin = a;
    else { console.error("unexpected arg " + a); return 1; }
  }
  if (!bin) { console.error("usage: node_run.js prog.bin [--max N] [--quiet] [--stdin FILE] [--lenient]"); return 1; }

  const soc = new Soc({ strict });
  soc.loadBin(readFileSync(bin), RAM_BASE);
  if (stdinFile) for (const b of readFileSync(stdinFile)) soc.uartPush(b);
  if (sdFile) soc.sd = new SdCard(new Uint8Array(readFileSync(sdFile)));
  const txBuf = [];
  soc.onTx = (b) => {
    txBuf.push(b);
    if (b === 10 || txBuf.length >= 256) { writeSync(1, Buffer.from(txBuf)); txBuf.length = 0; }
  };
  const cpu = new Cpu(soc);

  const t0 = process.hrtime.bigint();
  let status;
  try {
    while (!soc.halted && cpu.insns < max) cpu.run(Math.min(1 << 20, max - cpu.insns));
    status = soc.halted ? (soc.exitCode === EXIT_PASS ? 0 : 1) : 2;
  } catch (e) {
    if (!(e instanceof CpuError) && !(e.message && e.message.startsWith("unmapped"))) throw e;
    if (txBuf.length) writeSync(1, Buffer.from(txBuf));
    console.error("CPU error: " + e.message);
    console.error(cpu.dump());
    return 1;
  }
  const ns = Number(process.hrtime.bigint() - t0);
  if (txBuf.length) writeSync(1, Buffer.from(txBuf));
  if (sdOut && soc.sd) writeFileSync(sdOut, soc.sd.img);
  if (!quiet) {
    const mips = (cpu.insns / (ns / 1e3)).toFixed(1);
    if (status === 2) console.error(`[emu] instruction limit ${max} reached pc=${hex(cpu.pc)} (${mips} MIPS)`);
    else console.error(`[emu] exit code ${hex(soc.exitCode)} after ${cpu.insns} insns, ${(ns / 1e6).toFixed(1)} ms (${mips} MIPS)`);
    if (soc.sd) console.error(`[emu] SD: ${soc.sd.sectors} sectors, ${soc.sd.writes} written`);
    if (soc.unmapped.size) {
      const rows = [...soc.unmapped.entries()].sort((a, b) => a[0] - b[0]).map(([a, n]) => hex(a) + " x" + n);
      console.error("[emu] unmapped MMIO (lenient): " + rows.join(", "));
    }
  }
  return status;
}

process.exit(main(process.argv.slice(2)));
