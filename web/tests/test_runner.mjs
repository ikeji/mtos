// test_runner.mjs — exercise EmuRunner (the Worker's core) under Node with
// a per-tick yield, the way worker.js uses it: boot the tn20k
// kernel, wait for the prompt, type a command, check the echo, then check
// that throttling to 12 MIPS actually slows it down.
import { readFileSync } from "node:fs";
import { EmuRunner } from "../src/runner.js";

const binPath = process.argv[2];
// worker.js yields through a MessageChannel; under Node that starves
// timers (the port callback re-posts before the timers phase runs), so
// the harness yields with setImmediate, which lets timers interleave.
const yieldFn = (cb) => setImmediate(cb);
const sleepFn = (ms, cb) => setTimeout(cb, ms);

const r = new EmuRunner({ yieldFn, sleepFn });
let out = "";
let lastStats = null;
r.onTx = (b) => { out += Buffer.from(b).toString("latin1"); };
r.onStats = (s) => { lastStats = s; };
r.onError = (msg, dump) => { console.error("runner error: " + msg + "\n" + dump); process.exit(1); };
r.load(new Uint8Array(readFileSync(binPath)));
r.start();

const until = (pred, ms) => new Promise((res, rej) => {
  const t0 = Date.now();
  const tick = () => pred() ? res() : Date.now() - t0 > ms ? rej(new Error("timeout; output so far:\n" + out.slice(-400))) : setTimeout(tick, 5);
  tick();
});

let fails = 0;
const T0 = Date.now();
const check = (name, ok) => { console.log(`[test] ${name}: ${ok ? "PASS" : "FAIL"} (t=${Date.now() - T0} ms)`); if (!ok) fails++; };
try {
  await until(() => out.includes("sh$ "), 10000);
  check("boot to sh$", true);
  r.input(new TextEncoder().encode("echo via runner\r"));
  await until(() => out.includes("\nvia runner"), 5000);
  check("echo after typed input", true);
  await until(() => lastStats && lastStats.mips > 0, 2000);   // stats sample every 250 ms
  check("stats reported MIPS > 20", lastStats.mips > 20);
  console.log(`[test] full speed: ${lastStats.mips.toFixed(1)} MIPS`);

  r.setTargetMips(12);
  const i0 = r.cpu.insns, t0 = performance.now();
  await new Promise((res) => setTimeout(res, 600));
  const rate = (r.cpu.insns - i0) / ((performance.now() - t0) * 1000);
  console.log(`[test] throttled to 12 MIPS: ${rate.toFixed(1)} MIPS`);
  check("throttle to 12 MIPS lands in 9..15", rate > 9 && rate < 15);

  r.pause();
  check("pause stops execution", !r.running);
} catch (e) {
  console.log("[test] " + e.message);
  fails++;
}
console.log(fails ? `test_runner: FAIL (${fails})` : "test_runner: PASS");
process.exit(fails ? 1 : 0);
