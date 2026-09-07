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
