// test_pages_live.mjs — smoke test against the live GitHub Pages site (network!):
// the default kernel boots to a UART sh$ (echo there) and a landscape VRAM-engine console on the LCD (type there).
// argv: <playwright module path> <site url> <screenshot path>. Run via tests/test_pages_live.sh.
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const [pwPath, base] = process.argv.slice(2);
const { chromium } = require(pwPath);
const browser = await chromium.launch();
const page = await browser.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push("pageerror: " + e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push("console: " + m.text()); });
const t0 = Date.now();
await page.goto(base, { waitUntil: "load" });                     // default kernel: console -l -v + a UART sh
await page.waitForFunction(() => window.__emu && window.__emu.log.includes("sh$ "), null, { timeout: 60000 });
console.log(`[live] boot to sh$ after ${Date.now() - t0} ms`);
await page.keyboard.type("echo from pages\r");
await page.waitForFunction(() => window.__emu.log.includes("\nfrom pages"), null, { timeout: 5000 });
console.log("[live] echo output OK");
await page.waitForFunction(() => window.__emu && window.__emu.screenText().includes("sh$"), null, { timeout: 60000 });
await page.click("#lcd");
await page.keyboard.type("cat /hello.txt\n");
await page.waitForFunction(() => window.__emu.screenText().includes("hello, mtfs"), null, { timeout: 20000 });
console.log("[live] landscape console: typed on the LCD, got hello, mtfs");
await page.screenshot({ path: process.argv[4] });
console.log("[live] errors:", errors.length ? errors : "none");
await browser.close();
process.exit(errors.length ? 1 : 0);
