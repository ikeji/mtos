# VRAM ベースコンソール (連続全画面リフレッシュ)

2026-09-07 着手。現行コンソールのボトルネック (per-glyph syscall + CPU が
SPI を叩く) を、SDRAM 上のピクセル VRAM + ハードウェアリフレッシュエンジンで
アーキテクチャごと解消する。

## 動機 (プロファイル済)

neofetch ~13s の内訳: 計算 ~1s + kernel のピクセル描画(SPI) ~5s +
per-glyph syscall ~7s。VRAM 化で **syscall と CPU-SPI が消える**:
- console は VRAM の物理アドレスに **直接 poke** (MTOS は MMU 無し) →
  syscall ゼロ・純メモリ書き込み
- LCD リフレッシュは HW が背景で連続実行 → CPU は SPI を一切叩かない
- 予想: neofetch ~13s → ~2s、スクロールは SDRAM memcpy で一瞬

画面更新レート自体は SPI 帯域 ~5.5fps のままだが、**描画レイテンシと画面
更新が分離**されるのが本質。

## アーキテクチャ

```
console(userland) --poke16--> VRAM (SDRAM, 480x320 RGB565 = 300KB)
                                 |
                       vram_lcd.v (HW refresh engine)
                       - SDRAM を読み、strip 分割で ILI9488 に連続ストリーム
                       - RGB565 -> 3byte(18bpp)、SCK/MOSI/DC を駆動
                                 |
                              ILI9488 GRAM
```

## リフレッシュ戦略: 連続全画面 (MVP, ユーザー選択)

HW が VRAM 全体を ~5fps で常時 LCD に流し続ける。実装単純・堅牢・CPU 非介入。
テキスト静的でも毎フレーム全画素送るが、SPI は元々暇なので許容。dirty 領域
最適化は将来。

## panel のバースト制限

単一 RAMWR が >~6k 画素だと細い帯しか塗らない (fill で判明)。エンジンも
**strip 分割** (STRIP 行ずつ、WIDTH*STRIP < 6000、strip ごとに CASET/PASET/
RAMWR) する。

## 実装ステップ

1. [進行中] `hw/rtl/soc/vram_lcd.v` — リフレッシュエンジン単体 + tb で sim 検証
   - MMIO: +0 CTRL(bit0 enable), +4 BASE(VRAM word addr), +8 DIV
   - SDRAM マスタ読みポート (valid/ready/addr/rdata) + vram_active
   - 自前 SPI シフタ + DC 駆動、strip FSM (CASET/PASET/RAMWR → pixels)
2. soc.v 統合 — SDRAM アービタを 3-way に (CPU > flash_dma > vram、vram 最下位)、
   MMIO デコード (0x1005_0000)
3. top_soc_sdram.v — vram_active 時に lcd[2]=sck, lcd[3]=mosi, lcd[0]=dc を
   エンジン出力に mux (CS/RST/BL は GPIO のまま)
4. kernel — VRAM 領域 (SDRAM 高位、例 0x807B0000) を確保 (アロケータが使わない)、
   lcd_init 後に vram_lcd を enable
5. console — VRAM に直接ピクセル描画 (glyph 展開を userland のメモリ書き込みに)。
   /dev/fb 経由の描画は撤去 (chrome も VRAM に描く)

## リスク

このツールチェーンは FILL/fast-mul で sim-synth 乖離があった。vram_lcd も
新規 RTL なので段階的に sim 検証 → synth → 実機。一発では通らない前提。

## VRAM レイアウト

RGB565 行優先: VRAM[y*WIDTH + x] (2 byte)。console と engine が同じ配置で
合意。landscape は lcd_init が MADCTL 0xE8 を設定済なので engine は 480x320
として CASET 0..479 / PASET 0..319 で書く。

## 結果 (2026-09-08、実機完了)

**`/bin/console -v` オプションで実装完了・実機検証済** (commit f7c38a4)。
pico2 を壊さないため VRAM 化は kernel 側ではなく console の `-v` オプションに:

- console.tc: `g_vram_mode`、`vram_fill` / `vram_blit_glyph`。fb_fill /
  blit_glyph{,_color} / fb_scroll が `g_vram_mode` で分岐。起動時に VRAM を
  クリア + `poke32(0x10050000, 1)` でエンジン enable。VRAM_BASE = 0x807A5000
  (crt0 が arena 末尾を 0x807A5000 に下げて 300KB 予約)
- ビルド分離: `kern_console_vram.conf` (`console -l -v`) + `disk-console-vram.img`
  + `tn20k-console-vram` ターゲット。pico2-console-land / tn20k-console-land は
  `-l` のみの `disk-console-land.img` を使い続ける (pico2 に VRAM エンジンは
  無く 0x807A5000 も RAM 非バックなので `-v` は厳禁)
- kernel display_ili9488.tc: bring-up 用の VRAM テスト hack を撤去し
  fb_backend_write を通常 /dev/fb パスに復元。エンジンは console が駆動

### 律速は poke16 ではなく asm 化で解決

当初 vram_fill を TC の poke16 ループで書いたら**全画面クリアが ~20s** かかった
(多サイクルコアで poke16 1 回 ~130µs 相当 = 関数呼び出し + スタックスピル
オーバーヘッド)。`task_crt0.s` に **タイトな asm プリミティブ**を足して解決:
- `fill32(addr, val, count)` — sw ループ。2 画素/word パックで全画面クリア
  **20s → 643ms (~30x)**
- `blit_glyph_row(addr, bits, gw, fg16, bg16)` — 1 グリフ行の fg/bg 展開を
  1 呼び出しで (gw 回の poke16 TC 呼び出しを排除)。chrome 描画 4.6s → 3.5s

教訓: このコアでは「メモリ書き込みが遅い」のではなく **TC codegen の per-op
オーバーヘッドが遅い**。ホットな画素ループは asm 化が唯一効くレバー
([[tn20k_bottleneck_is_cpu]] の追試)。

### 実機動作

neofetch が Win95 chrome 付きでクリアに描画 (~5-6s、旧 /dev/fb ~13s の ~2x)。
エンジンが背景で連続リフレッシュするので描画中の tearing はあるが CPU は SPI
非介入。スクロールも動作 (boot neofetch が 1 行スクロールして表示)。kernel
test 8/8 PASS。注: LCD console の sh は stdin=/dev/kbd なので UART からは
操作不可 (マトリクスキーボード配線待ち)。

**実測リフレッシュ FPS = ~4.8fps** (2026-09-08)。エンジンの `dbg_reads`
リードバック (0x10050008、SDRAM から読んだワード数) を 1 秒間サンプルし
374525 words/s、1 フレーム = 480*320/2 = 76800 words なので 4.88fps。理論
上限 ~5.5fps に対しての差は SDRAM リードストール + strip ごとの CASET/PASET/
RAMWR コマンド + CPU との SDRAM アービトレーション (計測は neofetch 描画中の
負荷下)。18bpp を SCK 20MHz で流す SPI 帯域が本質的上限で ~5fps が天井。
超えるにはパラレル 8080 が必要 (使用モジュールにパラレルピン無し)。

### スクロール高速化 (2026-09-08、完了)

当初 VRAM モードのスクロールは grid 全再描画 (~840 グリフ blit) で **~10s**
かかり、neofetch 後のプロンプト表示が遅かった。VRAM は素の SDRAM なので
**pixel memmove** に置換 (`vram_scroll_up`): content 領域を CH px ぶん上に
`copy32` (昇順 word コピー asm、上方向スクロールで安全) で移動 + 最下行を
`vram_fill` でクリア。g_grid と shadow g_grid_prev を同一シフトするので直後の
redraw は no-op。**~10s → ~10ms**。起動時プロンプトまで ~40s → ~28s に短縮
(残りはグリフ blit による neofetch 描画 ~9s)。スクロール中に 1-2 フレームの
tear が出るが連続リフレッシュの非 vsync による一時的なもの。

### 残課題

- neofetch 描画 ~9s の律速はグリフ blit (vram_blit_glyph、行 asm 化済だが
  依然 CPU が全画素書き込み)。dirty 行だけ描く等の最適化余地
- chrome 描画 3.5s の残りは bevel の縦 1px 線 (poke16 パス) + fill の行分割
  オーバーヘッド。気になれば `fill32` を縦線にも効くよう拡張
- 真のスタンドアロン起動には vram kernel を SPI flash へ書く必要
  (`hw/tools/flash_kernel.sh` は UART/reset ロード)
