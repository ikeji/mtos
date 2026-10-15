// main.js — page glue: xterm.js <-> Worker, kernel loading, controls.
// Serve the repository root (make -C web serve) and open /web/; the
// default kernel path is relative to that.

const $ = (id) => document.getElementById(id);
const term = new Terminal({ cols: 80, rows: 30, convertEol: true, cursorBlink: true, scrollback: 5000,
                            fontFamily: "ui-monospace, Menlo, Consolas, monospace", fontSize: 14 });
term.open($("term"));

const worker = new Worker("src/worker.js", { type: "module" });
const enc = new TextEncoder();
let loaded = false;
let running = false;
const dec = new TextDecoder("latin1");
let emuLog = "";                 // all UART output, for tests (window.__emu)
let lastStats = null;
window.__emu = { get log() { return emuLog; }, get stats() { return lastStats; }, get loaded() { return loaded; } };

function setStatus(text) { $("status").textContent = text; }
function fmt(n) { return n.toLocaleString("en-US"); }

term.onData((d) => {
  if (!loaded) return;
  worker.postMessage({ type: "input", bytes: enc.encode(d) });
});

worker.onmessage = (e) => {
  const m = e.data;
  switch (m.type) {
    case "tx":
      term.write(m.bytes);
      emuLog += dec.decode(m.bytes);
      if (emuLog.length > 1 << 20) emuLog = emuLog.slice(-(1 << 19));
      break;
    case "stats":
      lastStats = m;
      running = m.running;
      $("btn-run").textContent = running ? "Pause" : "Run";
      $("insns").textContent = fmt(m.insns);
      $("mips").textContent = m.running ? m.mips.toFixed(1) : "-";
      setStatus(m.halted ? `halted (exit code 0x${(m.exitCode >>> 0).toString(16)})` : running ? "running" : loaded ? "paused" : "no kernel");
      $("unmapped").textContent = m.unmapped.length ? "unmapped MMIO: " + m.unmapped.join(" ") : "";
      break;
    case "error":
      term.write("\r\n\x1b[31m[emu] " + m.msg + "\x1b[0m\r\n");
      $("dump").textContent = m.dump;
      setStatus("error");
      break;
    case "halt":
      term.write(`\r\n\x1b[33m[emu] exit device: 0x${(m.code >>> 0).toString(16)}\x1b[0m\r\n`);
      break;
  }
};

function loadKernel(buf, name) {
  worker.postMessage({ type: "load", bin: buf }, [buf]);
  loaded = true;
  term.reset();
  $("dump").textContent = "";
  $("kernel-name").textContent = name;
  setStatus("loaded " + name);
  worker.postMessage({ type: "mips", value: Number($("speed").value) });
  worker.postMessage({ type: "start" });
  term.focus();
}

async function fetchKernel(path) {
  setStatus("fetching " + path);
  try {
    const r = await fetch(path, { cache: "no-store" });
    if (!r.ok) throw new Error(r.status + " " + r.statusText);
    loadKernel(await r.arrayBuffer(), path.split("/").pop());
  } catch (err) {
    setStatus("fetch failed: " + err.message + " (build with: make -C kernel tn20k, or pick a file)");
  }
}

$("btn-load").onclick = () => fetchKernel($("kernel").value);
$("file").onchange = async (ev) => {
  const f = ev.target.files[0];
  if (f) loadKernel(await f.arrayBuffer(), f.name);
};
$("btn-run").onclick = () => { worker.postMessage({ type: running ? "pause" : "start" }); term.focus(); };
$("btn-reset").onclick = () => { if (!loaded) return; term.reset(); worker.postMessage({ type: "reset" }); worker.postMessage({ type: "start" }); term.focus(); };
$("speed").onchange = () => worker.postMessage({ type: "mips", value: Number($("speed").value) });

const params = new URLSearchParams(location.search);
if (params.get("kernel")) $("kernel").value = params.get("kernel");
if (params.get("autoload") !== "0") fetchKernel($("kernel").value);
