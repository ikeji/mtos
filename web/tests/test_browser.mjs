// test_browser.mjs — load web/index.html in headless Chromium (playwright),
// wait for the kernel to boot inside the Worker, type a command into
// xterm.js and check the UART log. argv: <playwright module path> <base url>
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const [pwPath, baseUrl] = process.argv.slice(2);
const { chromium } = require(pwPath);

let fails = 0;
const check = (name, ok, extra = "") => { console.log(`[test] ${name}: ${ok ? "PASS" : "FAIL"} ${extra}`); if (!ok) fails++; };
const browser = await chromium.launch();
const page = await browser.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push("pageerror: " + e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push("console: " + m.text()); });
try {
  await page.goto(baseUrl + "/web/", { waitUntil: "load" });
  await page.waitForFunction(() => window.__emu && window.__emu.log.includes("sh$ "), null, { timeout: 15000 });
  check("kernel boots to sh$ in the Worker", true);
  await page.keyboard.type("echo from browser\r");
  await page.waitForFunction(() => window.__emu.log.includes("\nfrom browser"), null, { timeout: 5000 });
  check("typed command echoes back", true);
  await page.waitForFunction(() => window.__emu.stats && window.__emu.stats.mips > 0, null, { timeout: 2000 });
  const stats = await page.evaluate(() => window.__emu.stats);
  check("stats show MIPS > 20", stats.mips > 20, `(${stats.mips.toFixed(1)} MIPS, ${stats.insns} insns)`);
  const status = await page.textContent("#status");
  check("status says running", status === "running", `(${status})`);
  await page.click("#btn-run");
  await page.waitForFunction(() => window.__emu.stats && !window.__emu.stats.running, null, { timeout: 2000 });
  check("Pause button pauses", true);
  await page.click("#btn-reset");
  await page.evaluate(() => { window.__emu.marker = window.__emu.log.length; });
  await page.waitForFunction(() => window.__emu.log.slice(window.__emu.marker).includes("KERN: starting"), null, { timeout: 5000 });
  check("Reset reboots the kernel", true);
  await page.waitForFunction(() => window.__emu.log.slice(window.__emu.marker).includes("sh$ "), null, { timeout: 5000 });
  await page.waitForFunction(() => document.querySelector(".xterm-rows").textContent.includes("sh$"), null, { timeout: 2000 }).catch(() => {});
  const termText = await page.textContent(".xterm-rows");
  check("xterm renders the prompt", termText.includes("sh$"));

  // SD: new empty image → reboot mounts /sd → write a file → autosave to IndexedDB → reload restores it
  await page.click("#btn-sd-new");
  await page.waitForFunction(() => window.__emu.log.includes("FATFS: mounted"), null, { timeout: 10000 });
  check("New SD image mounts at /sd after reboot", true);
  await page.waitForFunction(() => window.__emu.log.lastIndexOf("sh$ ") > window.__emu.log.lastIndexOf("FATFS: mounted"), null, { timeout: 5000 });
  await page.keyboard.type("echo persisted in idb > /sd/p.txt\r");
  await page.waitForFunction(() => document.getElementById("sd-status").textContent.includes("unsaved writes"), null, { timeout: 5000 });
  await page.waitForFunction(() => document.getElementById("sd-status").textContent.includes("saved in browser"), null, { timeout: 10000 });
  check("SD writes are saved to IndexedDB", true);
  await page.reload({ waitUntil: "load" });
  await page.waitForFunction(() => window.__emu && window.__emu.log.includes("FATFS: mounted"), null, { timeout: 15000 });
  await page.waitForFunction(() => window.__emu.log.includes("sh$ "), null, { timeout: 5000 });
  await page.keyboard.type("cat /sd/p.txt\r");
  await page.waitForFunction(() => window.__emu.log.includes("\npersisted in idb"), null, { timeout: 5000 });
  check("saved image is restored after reload and readable", true);
  await page.click("#btn-sd-forget");
  await page.waitForFunction(() => document.getElementById("sd-status").textContent === "no card", null, { timeout: 5000 });
  check("Forget detaches the card", true);
} catch (e) {
  console.log("[test] " + e.message.split("\n")[0]);
  fails++;
}
check("no page errors", errors.length === 0, errors.join(" | "));
await browser.close();
console.log(fails ? `test_browser: FAIL (${fails})` : "test_browser: PASS");
process.exit(fails ? 1 : 0);
