// worker.js — Web Worker glue around EmuRunner. Messages from the page:
//   {type:"load", bin:ArrayBuffer}  {type:"start"}  {type:"pause"}  {type:"reset"}
//   {type:"input", bytes:Uint8Array}  {type:"mips", value:number}
//   {type:"sd", image:ArrayBuffer|null}  {type:"sd-get", tag}
// Messages to the page:
//   {type:"tx", bytes:Uint8Array}  {type:"stats", ...}  {type:"error", msg, dump}  {type:"halt", code}
//   {type:"sd-write"} (the OS wrote to the card; throttled)  {type:"sd-image", tag, image:ArrayBuffer|null, writes}

import { EmuRunner } from "./runner.js";

const chan = new MessageChannel();
let pending = null;
chan.port1.onmessage = () => { const f = pending; pending = null; if (f) f(); };
const yieldFn = (cb) => { pending = cb; chan.port2.postMessage(0); };
const sleepFn = (ms, cb) => setTimeout(cb, ms);

const runner = new EmuRunner({ yieldFn, sleepFn });
runner.onTx = (bytes) => self.postMessage({ type: "tx", bytes }, [bytes.buffer]);
runner.onStats = (s) => self.postMessage({ type: "stats", ...s });
runner.onError = (msg, dump) => self.postMessage({ type: "error", msg, dump });
runner.onHalt = (code) => self.postMessage({ type: "halt", code });
runner.onSdWrite = () => self.postMessage({ type: "sd-write" });

self.onmessage = (e) => {
  const m = e.data;
  switch (m.type) {
    case "load": runner.load(new Uint8Array(m.bin)); break;
    case "start": runner.start(); break;
    case "pause": runner.pause(); break;
    case "reset": runner.reset(); break;
    case "input": runner.input(m.bytes); break;
    case "mips": runner.setTargetMips(m.value); break;
    case "sd": runner.attachSd(m.image ? new Uint8Array(m.image) : null); break;
    case "sd-get": {
      const img = runner.sdImage ? runner.sdImage.slice().buffer : null;
      self.postMessage({ type: "sd-image", tag: m.tag, image: img, writes: runner.soc && runner.soc.sd ? runner.soc.sd.writes : 0 }, img ? [img] : []);
      break;
    }
  }
};
