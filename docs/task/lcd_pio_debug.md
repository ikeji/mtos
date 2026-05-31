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

### 2026-05-31: PIO 動作開始 + 高速化 (commit `bba6949`〜)

`g_lcd_use_pio = 1` で起動 + GPIOBASE 周辺の register に対する write+
read-back を仕込んで実機調査。結果は2つの bug が判明、両方修正で
PIO LCD 動作 + fb_fill が **5388ms → 1139ms** (4.7x 高速化)。total
boot **KERN: starting → first sh rendered = 1810 ms** (元の 6167ms から
3.4x 高速化)。

#### Bug 1: GPIOBASE を bit 0 に書いていた

pico-sdk `src/rp2350/hardware_regs/include/hardware/regs/pio.h` の定義:

```
#define PIO_GPIOBASE_OFFSET _u(0x00000168)
#define PIO_GPIOBASE_BITS   _u(0x00000010)   ← bit 4 ONLY
#define PIO_GPIOBASE_MSB    _u(4)
#define PIO_GPIOBASE_LSB    _u(4)
```

つまり register は 0x168 で正解、ただし書き換え可能な bit は **bit 4**
(mask 0x10) のみ。`docs/problem.md` #37 の前回実装は

```c
poke32(PIO2_BASE + PIO_GPIOBASE, 1u32);   // bit 0 — no-op
```

と bit 0 に書いていたため write が完全に no-op (read-back 0 のまま)。
PIO2 SM は内部 pin 24/25 を低半 GP24/25 に向けていて、ハードウェアの
LCD GP40/41 までは届いていなかった。

修正: `poke32(PIO2_BASE + PIO_GPIOBASE, 0x10u32);` で bit 4 を立てる。
read-back で `0x00000010` 確認、GP40/41 の STATUS register
(`0x40028140` / `0x40028148`) が **0x00000000 → 0x00002000** に変化、
pad が PIO の OUTFROMPERI/OEFROMPERI を反映していることを確認。

#### Bug 2: FSTAT_TXFULL の bit 位置が違っていた

pico-sdk の同じヘッダ:

```
// PIO_FSTAT_TXEMPTY: bits 24-27 (SM0 = bit 24, mask 0x01000000)
// PIO_FSTAT_TXFULL:  bits 16-19 (SM0 = bit 16, mask 0x00010000)
// PIO_FSTAT_RXEMPTY: bits  8-11
// PIO_FSTAT_RXFULL:  bits  0- 3
```

前回実装は:

```c
var FSTAT_TXFULL_SM0:  u32 = 0x10000000u32;  // bit 28 — WRONG
var FSTAT_TXEMPTY_SM0: u32 = 0x01000000u32;  // bit 24 — OK
```

bit 28 は RP2350 PIO FSTAT には何も無く (SM 0-3 のみ存在、bit 28-31 は
存在しない SM 4-7 用)、常に 0 を読む。結果 `pio_spi_byte` の TXFULL 待ち
ループ `while (FSTAT & 0x10000000) != 0 { }` は **一度も block せず**、
TX FIFO が満タンになっても CPU が push を続けて溢れた byte が黙って
drop される。LCD は画面上から 1/4 (~120 行) だけ描画して以降は空転、
というユーザ目撃通りの症状。

修正: `var FSTAT_TXFULL_SM0: u32 = 0x00010000u32;` で bit 16 に。
TXFULL が立つようになり push が正しく rate-limit されて全 byte が
LCD まで届くように。

#### CLKDIV チューニング

修正後 fb_fill 時間:

| CLKDIV INT | SM clock | SPI clock | fb_fill 実測 |
|---:|---:|---:|---:|
| 64 (初期試験値) | 2.34 MHz | 1.17 MHz | 3605 ms |
| 4 (採用) | 37.5 MHz | 18.75 MHz | 1139 ms |

INT=4 で SPI 18.75 MHz、ILI9488 の 20 MHz spec ceiling の手前で安定。
1139ms のうち SPI 転送は 460800 byte × 8 / 18.75 MHz = ~200ms、残り
~900ms は per-byte の CPU push overhead (lcd_dat → pio_spi_byte の
poke32 が pixel 1 個あたり 3 回)。さらに高速化するには DMA か
asm 化が必要だが現時点では十分。

#### 最終 boot 内訳 (warm reset、PIO ON、CLKDIV=4)

| 段階 | mtime | 区間 |
|---|---:|---:|
| KERN: starting | 142184 | base |
| FATFS: mounted | 142236 | +52 |
| CONSOLE: ready | 142261 | +25 (kernel boot 含む) |
| CONSOLE: spawning sh | 142283 | +22 |
| CONSOLE: before fb_fill | 142299 | +16 |
| LCD: lcd_init begin | 142307 | +8 |
| LCD: lcd_init done | 142783 | +476 (delays + init seq、変わらず) |
| **CONSOLE: after fb_fill** | **143922** | **+1139 ms** ← PIO で 5388→1139 |
| CONSOLE: LCD ready | 143933 | +11 |
| CONSOLE: first sh rendered | 143994 | +61 |

**KERN: starting → first sh rendered = 1810 ms**。元の 6167ms から
**4357ms 短縮** (boot 全体で 3.4x、fb_fill 単体で 4.7x)。
