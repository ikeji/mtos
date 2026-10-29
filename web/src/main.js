// main.js — page glue: xterm.js <-> Worker, kernel loading, controls.
// Kernels named in the <select> are fetched from kernels/ next to the page
// (see fetchKernel); serve the repository root (make -C web serve) and open /web/.

import { formatFat32 } from "./fat32.js";
import { scancodeOf } from "./gpio.js";
import { screenToText } from "./ocr.js";

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
let kernelBuf = null;            // last loaded kernel (ArrayBuffer copy) so Reset / SD attach can reboot
let kernelName = "";
let sdName = "";                 // "" = no card
let sdSaveTimer = null;
let sdWriteGen = 0;              // bumped on every sd-write notification
let sdSaveGen = 0;               // write generation the in-flight save captured
let lastFrame = null;            // last LCD frame {w, h, rgba}
let frames = 0;
const lcd = $("lcd");
const lcdCtx = lcd.getContext("2d");
window.__emu = {
  get log() { return emuLog; }, get stats() { return lastStats; }, get loaded() { return loaded; }, get sdName() { return sdName; },
  get frames() { return frames; },
  kbdType(s) { worker.postMessage({ type: "kbd-type", bytes: enc.encode(s) }); },           // type on the matrix keyboard
  screenText() { return lastFrame ? screenToText(lastFrame.rgba, lastFrame.w, lastFrame.h).lines.join("\n") : ""; },
};

// Dot-by-dot LCD: pick a CSS size so every LCD pixel covers a whole number
// of device pixels (k = 1 on a 1x / 1.25x screen, 2 on 1.5x / 2x, ...); any
// other scale makes nearest-neighbour sampling double some pixel columns.
// On a narrow screen (phones: 2x-3x) step k down until the LCD fits.
function fitLcd() {
  const dpr = window.devicePixelRatio || 1;
  let k = Math.max(1, Math.round(dpr));
  const avail = document.documentElement.clientWidth - 32 - 6;      // page gutters + canvas border
  while (k > 1 && lcd.width * k / dpr > avail) k--;
  lcd.style.width = (lcd.width * k / dpr) + "px";
  lcd.style.height = (lcd.height * k / dpr) + "px";
}
fitLcd();
window.addEventListener("resize", fitLcd);          // browser zoom changes devicePixelRatio

// ---- matrix keyboard: keys typed while the LCD has focus ----
// Focus lives on #lcd-input, an invisible textarea: tapping the canvas focuses
// it, which is what makes phones open their soft keyboard. Physical keyboards
// arrive as keydown/keyup (held keys stay closed in the matrix until keyup);
// soft keyboards mostly report "Unidentified" keydowns and deliver the text
// as textarea edits (the input event), which we diff into typed keys.
const lcdInput = $("lcd-input");
const held = new Map();          // KeyboardEvent.code -> scancode, so key-up releases what key-down pressed
function keyToSc(e) {
  if (e.ctrlKey || e.altKey || e.metaKey) return -1;
  const special = { Enter: 13, Backspace: 8, Escape: 27, Tab: 9 };
  if (e.key in special) return scancodeOf(special[e.key]);
  return e.key.length === 1 ? scancodeOf(e.key.charCodeAt(0)) : -1;
}
lcd.addEventListener("pointerdown", (e) => { e.preventDefault(); });             // keep focus on the textarea
lcd.addEventListener("pointerup", () => { lcdInput.focus({ preventScroll: true }); });
lcd.addEventListener("click", () => { lcdInput.focus({ preventScroll: true }); });
let lcdPrev = "";                // textarea text already sent to the matrix (soft keyboards)
lcdInput.addEventListener("keydown", (e) => {
  const sc = keyToSc(e);
  if (sc < 0) return;                                   // IME / soft keyboard: text arrives via the input event
  if (e.key === "Backspace" && lcdInput.value) return;  // let the textarea delete; the input diff sends the backspace
  e.preventDefault();
  if (e.key === "Enter") { lcdInput.value = ""; lcdPrev = ""; }
  if (e.repeat || held.has(e.code)) return;
  held.set(e.code, sc);
  worker.postMessage({ type: "key", sc, down: true });
});
lcdInput.addEventListener("keyup", (e) => {
  const sc = held.get(e.code);
  if (sc === undefined) return;
  held.delete(e.code);
  worker.postMessage({ type: "key", sc, down: false });
});
// Soft keyboards (and desktop IMEs) edit the textarea instead of sending
// keys: compositions rewrite the current word, autocorrect replaces it. Send
// the difference between what the matrix already got and the new text —
// backspaces for the removed tail, then the added characters — and start
// over at a newline.
lcdInput.addEventListener("input", () => {
  const v = lcdInput.value;
  let p = 0;
  while (p < lcdPrev.length && p < v.length && lcdPrev[p] === v[p]) p++;
  const out = "\b".repeat(lcdPrev.length - p) + v.slice(p);
  if (out) worker.postMessage({ type: "kbd-type", bytes: enc.encode(out) });
  if (v.includes("\n")) { lcdInput.value = ""; lcdPrev = ""; } else lcdPrev = v;
});
lcdInput.addEventListener("blur", () => { for (const sc of held.values()) worker.postMessage({ type: "key", sc, down: false }); held.clear(); });

// ---- SD image persistence (IndexedDB, one record) ----
const DB_NAME = "mtos-web", STORE = "sd";
function idb() {
  return new Promise((res, rej) => {
    const r = indexedDB.open(DB_NAME, 1);
    r.onupgradeneeded = () => r.result.createObjectStore(STORE);
    r.onsuccess = () => res(r.result);
    r.onerror = () => rej(r.error);
  });
}
async function idbGet() {
  try { const db = await idb(); return await new Promise((res, rej) => { const q = db.transaction(STORE).objectStore(STORE).get("image"); q.onsuccess = () => res(q.result || null); q.onerror = () => rej(q.error); }); }
  catch (e) { return null; }
}
async function idbPut(rec) {
  try { const db = await idb(); await new Promise((res, rej) => { const q = db.transaction(STORE, "readwrite").objectStore(STORE).put(rec, "image"); q.onsuccess = res; q.onerror = () => rej(q.error); }); return true; }
  catch (e) { return false; }
}
async function idbDel() {
  try { const db = await idb(); await new Promise((res, rej) => { const q = db.transaction(STORE, "readwrite").objectStore(STORE).delete("image"); q.onsuccess = res; q.onerror = () => rej(q.error); }); }
  catch (e) {}
}
function setSdStatus(text) { $("sd-status").textContent = text; }
function attachSd(buf, name) {
  sdName = name;
  const mb = buf ? (buf.byteLength / 1048576).toFixed(0) : 0;   // before the transfer detaches buf
  worker.postMessage({ type: "sd", image: buf }, buf ? [buf] : []);
  setSdStatus(name ? `${name} (${mb} MB)` : "no card");
}
function saveSd() {
  sdSaveTimer = null;
  sdSaveGen = sdWriteGen;
  worker.postMessage({ type: "sd-get", tag: "save" });
}

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
    case "frame":
      if (lcd.width !== m.w || lcd.height !== m.h) { lcd.width = m.w; lcd.height = m.h; fitLcd(); }
      lcdCtx.putImageData(new ImageData(m.rgba, m.w, m.h), 0, 0);
      lastFrame = m;
      frames++;
      break;
    case "sd-write":                       // OS wrote to the card: persist after 2 s of quiet
      sdWriteGen++;
      setSdStatus(`${sdName} (unsaved writes)`);
      if (sdSaveTimer) clearTimeout(sdSaveTimer);
      sdSaveTimer = setTimeout(saveSd, 2000);
      break;
    case "sd-image":
      if (!m.image || !sdName) break;
      if (m.tag === "download") {
        const a = document.createElement("a");
        a.href = URL.createObjectURL(new Blob([m.image])); a.download = sdName; a.click();
        setTimeout(() => URL.revokeObjectURL(a.href), 10000);
      } else {
        const gen = sdSaveGen, mb = (m.image.byteLength / 1048576).toFixed(0);
        idbPut({ name: sdName, image: m.image }).then((ok) => {
          if (sdWriteGen !== gen) return;          // newer writes exist; a save is already scheduled
          setSdStatus(`${sdName} (${mb} MB, ${ok ? "saved in browser" : "save failed"})`);
        });
      }
      break;
  }
};

function loadKernel(buf, name) {
  kernelBuf = buf.slice(0);
  kernelName = name;
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

function reboot() {
  if (!loaded) return;
  term.reset();
  worker.postMessage({ type: "reset" });
  worker.postMessage({ type: "start" });
  term.focus();
}

// Kernels live in kernels/ next to the page: a symlink to ../kernel/build in
// the repository (make -C web serve), real copies in the Pages build (tools/pages.sh).
async function fetchKernel(name) {
  const path = name.includes("/") ? name : "kernels/" + name;    // a path is used as given
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
$("btn-reset").onclick = reboot;
$("speed").onchange = () => worker.postMessage({ type: "mips", value: Number($("speed").value) });

// ---- SD controls: the kernel probes the card at boot, so attaching reboots ----
$("sd-file").onchange = async (ev) => {
  const f = ev.target.files[0];
  if (!f) return;
  attachSd(await f.arrayBuffer(), f.name);
  saveSd();                                    // persist the fresh image right away
  reboot();
};
$("btn-sd-new").onclick = () => { attachSd(formatFat32(33).buffer, "sd.img"); saveSd(); reboot(); };
$("btn-sd-download").onclick = () => { if (sdName) worker.postMessage({ type: "sd-get", tag: "download" }); };
$("btn-sd-forget").onclick = async () => { await idbDel(); attachSd(null, ""); reboot(); };

for (const b of document.querySelectorAll("button")) b.addEventListener("click", () => setTimeout(() => term.focus(), 0));

const params = new URLSearchParams(location.search);
let initialKernel = $("kernel").value;                      // the <option selected> (console -l -v, VRAM engine)
if (params.get("kernel")) {
  initialKernel = params.get("kernel");
  if ([...$("kernel").options].some((o) => o.value === initialKernel)) $("kernel").value = initialKernel;
}
(async () => {
  const saved = await idbGet();
  if (saved && saved.image) attachSd(saved.image, saved.name || "sd.img");
  if (params.get("autoload") !== "0") fetchKernel(initialKernel);
})();
