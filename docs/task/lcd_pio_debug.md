# LCD PIO SPI 化デバッグノート

ILI9488 を bit-bang ではなく PIO2 SPI で駆動するための作業ノート。
背景は `docs/problem.md` #37 (2026-05-24 着手、未解決で bit-bang に
退避)、今回 (2026-05-31) 再開。

## ゴール

`kernel/platform/pico2/display_ili9488.tc::pio_lcd_init` を動作させて
`g_lcd_use_pio = 1` で起動できるようにする。

期待効果は `fb_fill` の SPI 転送時間短縮 → boot トータル短縮:

| 転送 | bit-bang (現状) | PIO @ 18.75 MHz (目標) |
|---|---:|---:|
| `fb_fill` 320×480 (460 KB) | 5388 ms | ~200 ms |

## 現在判明している起動時間 (warm openocd reset、console build)

電源 ON / chip reset → LCD プロンプト表示までの内訳。SIO_MTIME
(`kern_uptime_us` 経由) を `[N ms]` prefix に埋めて計測。

| 段階 | mtime (warm) | 区間 |
|---|---:|---:|
| KERN: starting | 986030 | base |
| FATFS: mounted | 986200 | +170 (SD init / fatfs mount) |
| KERN: mount_fs done | 986200 | +0 |
| KERN: sched_init | 986202 | +2 |
| KERN: timer arm | 986220 | +18 |
| KERN: sched_start | 986221 | +1 |
| CONSOLE: ready | 986224 | +3 |
| CONSOLE: jpfont loaded | 986226 | +2 |
| CONSOLE: portrait, hardware scroll | 986230 | +4 |
| CONSOLE: opening /dev/kbd | 986234 | +4 |
| CONSOLE: opening /dev/fb | 986240 | +6 |
| CONSOLE: devices open | 986242 | +2 |
| CONSOLE: spawning sh | 986246 | +4 |
| CONSOLE: sh spawned | 986257 | +11 |
| CONSOLE: before fb_fill | 986262 | +5 |
| LCD: lcd_init begin | 986271 | +9 |
| **LCD: lcd_init done** | **986690** | **+419 ms** ← LCD reset + ILI9488 init seq |
| **CONSOLE: after fb_fill** | **992078** | **+5388 ms** ← bit-bang SPI 転送 |
| CONSOLE: after draw_cursor | 992086 | +8 |
| CONSOLE: LCD ready | 992090 | +4 |
| CONSOLE: first sh output rendered | 992197 | +107 |

合計 KERN: starting → first sh output rendered = **6167 ms**
うち fb_fill が 87%。

cold boot (USB抜き差し) もほぼ同じ値で、CONSOLE: LCD ready が
mtime 5843ms、first sh rendered が 5951ms。Pico 2 bootrom + crt0
は数百 ms (USB-CDC enumeration がフレーム化遅延を加えるが mtime は
SIO カウンタ直読みで影響受けない)。

参考 trace 実装: commit `bba6949` (console.tc に
`eputs_t before/after fb_fill / draw_cursor`、display_ili9488.tc の
`fb_backend_write` に `kputs_t LCD: lcd_init begin/done`、
kernel_pico2.tc の `kputs_t` / `kput_ms` を export)。

`fb_fill` 5.4 秒 = `460800 bytes / (~85 KB/s effective bit-bang)`
程度の bit-bang SPI 効率なので、PIO で 25 MHz 出ると単純比で
~150× 高速 (3 MB/s 実効、3,125 KB/s 理論)。

## 前回 (2026-05-24) で詰まった点 (`docs/problem.md` #37 抜粋)

`pio_lcd_init` 実装後、`g_lcd_use_pio = 1` にしても LCD は真っ白。
GDB probe で:

- PIO2 が RESETS から開放できる (RESETS_RESET[13] clear)
- SM0 起動できる (CTRL = 1 確認)
- INSTR_MEM の書き込みは効いている (SM0_INSTR で実行中の opcode 確認)
- `SET PINS 1` を SM0_INSTR 経由で発行 → DBG_PADOUT bit 25 立つ
  (PIO 内部での MOSI は high になっている)
- だが GP41 STATUS register (`0x40028148`) は全 0、pad に届かない

仮説: GPIOBASE register が設定できていない。
- RP2350 PIO2 は GPIOBASE 1-bit register で pin 0-31 / 16-47 を選択
- pico-sdk header では offset 0x168
- そこに書き込んでも (GDB / kernel どちらからも) 効かず 0 のまま
- 0x180 への書き込みは効くが、これは IRQ1_INTF register

未確認:
- ACCESSCTRL_PIO2 (`0x400600BC`) の secure/nonsecure / master gate
- BootROM が PIO2 を lock している可能性
- 別 register (SYSCFG など) でのマッピング切替の可能性
- 板上のチップが RP2350A (高 GPIO 無し) variant の可能性

## 今回 (2026-05-31) の調査計画

優先順:

1. **`g_lcd_use_pio = 1` で起動して何が起きるか UART 出力で再確認** — 当時の
   不具合パターンが今も再現するか、ハードウェア状態でズレてないか
2. **RP2350 datasheet で GPIOBASE register の正しい offset を再確認** —
   pico-sdk version で名前/番地が変わっていないか
3. **ACCESSCTRL_PIO2 を確認 / 設定** — secure-only になっている場合 M-mode
   から書けないなどがあるか
4. **openocd で 0x168 / 0x180 周辺を mdw でフル dump** — RW 可能な番地が
   どこかを bit 単位で探す
5. **GPIOBASE が手詰まりなら GP24/25 等の低番 GPIO で PIO2 試行** —
   仮に動けば routing 設定の問題、動かなければ PIO2 自体の問題

## 参考リンク / コード

- `kernel/platform/pico2/display_ili9488.tc::pio_lcd_init` (line ~130)
- `docs/problem.md` #37 (前回調査ログ)
- pico-sdk: `RP2350-datasheet.pdf` PIO 章、特に GPIOBASE register

## ログ

(調査進めながら追記)
