# コンパイラパイプラインのメモリ / 時間スケーリング

K7 達成 (2026-04-29) で pico2 実機上での Hello World self-host が
完走するようになった。本稿は「次のステップ: OS 全体の self-host
コンパイル」に備えて、**メモリ・時間がどう伸びるか**を実測値から
推定したもの。

## 実測ベースライン (Hello World)

`tests/phase7_hello_world.tc` (366 byte ソース) を pico2 実機で
完走させた値:

| 段 | task arena (decl) | task peak (実測) | 所要時間 |
|---|---|---|---|
| parse | 64 KB | (出力なし) | <1 s |
| sigscan | 16 KB | 8.5 KB | <1 s |
| cat-wrap | 16 KB | — | <1 s |
| tcheck | 320 KB | 73 KB | ~3 s |
| codegen | 320 KB | 75 KB | ~3 s |
| bc2asm | 192 KB | 111 KB | ~5 s |
| cat-link | 16 KB | — | ~25 s (234 KB SD write) |
| asm_pass1 | 320 KB | 218 KB | ~27 s |
| cat-p2 | 16 KB | — | ~50 s (3× full.s 連結) |
| asm_pass2 | 320 KB | 298 KB | ~80 s |
| **合計** | | | **~127 s** |

CPU: clk_sys 150 MHz (PLL_SYS), clk_peri 12 MHz (XOSC)
SD: SPI mode 0, 6 MHz, write ~5 KB/s, read ~17 KB/s

## Q1: OS 全体をコンパイルする所要量

### 前提と単純化

- 「OS 全体 = compiler/*.tc + kernel/*.tc + kernel/tasks/\*/\*.tc」
- 約 **40〜50 ファイル**
- 各ファイルのサイズは様々 (catfile.tc 1 KB、tcheck.tc 70 KB)
- 各ファイルを独立に compile pipeline にかける想定

### 時間: per-file の固定費 + ソースサイズ比例分

phase 7 の 1 ファイルあたりの所要時間は **固定費 ~110 s + ソース
サイズ依存 ~α s**。固定費が大きいのは、`/prelude.s` (234 KB) を
asm_pass1 が 1 回、asm_pass2 が 3 回読むため:

- asm_pass1: 234 KB read + 計算 + 11 KB write ≒ 27 s
- asm_pass2: 234 KB × 3 read + 計算 + 45 KB write ≒ 80 s
- cat-link / cat-p2 で 234 KB SD write × 4 回 ≒ 45 s

→ 1 ファイルあたり **120 s 程度の prelude オーバーヘッド** がほぼ
constant。

ソースサイズ依存分 (parse / tcheck / codegen / bc2asm) は
ソース byte 数に概ね比例。Hello World (366 B) で 12 s 弱。線形外挿:

| ソースサイズ | tcheck+codegen+bc2asm | 合計 (固定 + 比例) |
|---|---|---|
| 1 KB | ~30 s | ~150 s (2.5 分) |
| 10 KB | ~5 分 | ~7 分 |
| 70 KB (tcheck.tc 級) | ~35 分 | ~37 分 |

### 50 ファイル × 平均 5 KB として

平均 5 KB のソース 50 ファイルを 1 つずつコンパイル:
- 1 ファイルあたり 200〜250 s
- **合計 約 3 時間**

実際は heavy file (parse.tc / tcheck.tc / asm_common.tc / bc2asm.tc /
asm_pass2.tc) が支配する。これら 5〜7 ファイルだけで 30 分以上を
食う見込み。

### メモリ: 1 ファイルごとの peak は ~300 KB のまま

asm_pass2 の peak (298 KB) は label 数 + name pool に支配される。
ソース毎に label 数が大きく変わるので peak も伸びるが、
MAX_LABELS = 4096, MAX_NAME_POOL = 128 KB の cap がある (`compiler/asm_common.tc`)。
通常の OS ソースなら 320 KB の task arena 内に収まる見込み。

逆に **kernel arena (480 KB) のほうが先に問題化する**: sh + asm_pass2
の同時 alive で sh (32 KB) + asm_pass2 (320 KB) + stack ≒ 360 KB +
α。fragmentation を考えると ~440 KB 使うので、長時間バッチ実行で
arena leak / fragmentation が積もると詰まる懸念がある。

## Q2: bc2asm / asm_pass1 / asm_pass2 が特にメモリを使う理由

Hello World で 100〜300 KB peak。少しずつ違う原因。

### bc2asm (peak 111 KB)

- **Per-function instruction list**: `instrs: I32Array` に各 fn の
  bytecode を一旦展開してから asm に変換。fn 単位で alloc/free
  するが、最大の fn (Hello World では `main` が小さくても、prelude
  に含まれる `runtime` の fn など) で peak が決まる。
- **String literal 表**: bc 内の string literal を一旦 strtab に
  集めてから `.rodata` に emit。重複排除しないので bc 入力に多くの
  string が含まれると伸びる。
- **StringBuffer (出力バッファ)**: 1024 byte から倍々で grow。
  生成される .s が 数十 KB になると 32〜64 KB バッファに到達。

要点: bc2asm の 111 KB は **per-fn instr buffer + 出力バッファ + strtab**
の合計。Phase 3 で per-fn emission に切替えてから、これでも 1.4 MB
→ 110 KB に落ちている (`docs/task/pipeline_100kb.md`)。

### asm_pass1 (peak 218 KB)

label 収集 only の役割で計算は少ないが、**label 表が大きい**:

- **MAX_NAME_POOL = 128 KB** (`asm_common.tc`): label 名を全部詰める raw
  byte pool。`/prelude.s` に含まれる runtime/crt0 関数名で実際 60〜80 KB
  使う。
- **MAX_LABELS = 4096** × per-label state (`g_lab_addrs` u32 +
  `g_lab_section` u8 + `g_lab_name_pool_offsets` u32 + `g_lab_name_lengths`
  i32) = 16 KB + 4 KB + 16 KB + 16 KB ≒ 50 KB。
- **g_line_offs / g_line_lens / g_line_section** は 1 行 1 entry。
  Hello World の `full.s` で 12K 行 → 144 KB。
- 数字ラベル (`0:`〜`9:`) state、section size accumulator など若干。

合計 ~220 KB。

### asm_pass2 (peak 298 KB)

asm_pass1 と同等の label state を全部受け取って、**追加で encoder
state** を持つ:

- asm_pass1 の構造一式 (label table, line table) ≒ 200 KB
- 4 KB 出力バッファ (stream emit) + 各種 cursor
- per-section 状態 (text/rodata/data/bss の base / cursor)
- 数字ラベルの reference list (forward参照解決)

Phase 5 の stream-emit 化で旧 4.6 MB → 280 KB に削減済み
(`docs/compiler.md`)。これ以上絞るには label table を on-disk に
退避するなどの大規模 refactor が必要。

### 共通要因: SourceReader 4 KB バッファ

全段共通で、入力読み込み用に SourceReader が 4 KB の U8Array を
持つ。3〜10 KB のオーバーヘッドがあるので、軽量タスクのベースライン
が 8 KB 級になる。

### 結論

`/prelude.s` 経由で常に大量の label/instruction を扱うのが
Hello World でも 100〜300 KB peak になる理由。OS 全体コンパイルでも
**1 ファイルの peak は 300 KB 程度に留まる** と予測 (label pool が
頭打ちのため)。

## Q3: ドライバ `tcc` (実機実装メモ)

`kernel/tasks/tcc/tcc.tc` として実装。argv[1] にソースを取り、
中間ファイルを `/sd/_*.*`、出力を `/sd/a.out` に書く。各段の
所要時間 (SIO MTIME を peek32 で読んで算出) を stdout に出力。

### 想定動作

```
sh$ tcc /hw.tc
tcc: stage timings
  parse           600 ms
  sigscan         200 ms
  cat-wrap        100 ms
  tcheck         3000 ms
  ...
  asm_pass2     80000 ms
tcc: total   127000 ms → /sd/a.out
sh$ /sd/a.out
Hello, World!
```

### 実機での実測 (2026-04-29)

```
parse         45751 ms     ← sh-driven の <1 s より 50× 遅い
sigscan       18329 ms
cat-wrap      21073 ms     ← inline file copy (small)
OOM: 327684                 ← tcheck spawn 失敗
```

**期待通り動かない**。sh-driven (commit cf22718) は 127 s で完走する
のに、tcc-driven は 4 段目で OOM。

### 原因 (推測)

**sh + tcc + child の 3 タスク同時 alive** で kernel arena が圧迫:
- sh: arena 32 KB + stack 8 KB = 40 KB
- tcc: arena 16 KB + stack 8 KB = 24 KB
- tcheck: arena 320 KB + stack 16 KB = 336 KB
- 合計: 400 KB out of 480 KB kernel arena → fragmentation で 320 KB
  contiguous 確保が失敗

加えて、tcc 経由だと parse / sigscan が sh-driven の 50× 遅い
(原因不明、scheduler 関連?)。

### 解決方向 (今後)

1. **sh の組み込みコマンドとして tcc を実装**。sh プロセス内で完結
   させれば、sh + child の 2 タスクで動く (今の sh-driven と同じ
   メモリ条件)。実装コストは tcc の機能を sh.tc に組み込む数百行。
2. **kernel arena を増やす**。pico2 SRAM 520 KB のうち kernel arena
   480 KB → 500+ KB に拡張。ただし stack や bss を圧迫するので
   小幅増しか取れない。
3. **task arena を縮める**。tcheck/asm_pass1/asm_pass2 の 320 KB を
   減らす。Phase 5 系の追加最適化が必要。
4. **`do_exec` で tcc 自身を最終段に置き換える**。その場合 1〜N-1
   段目は別途処理を要する (chain).

現状の `tcc.tc` は **タイミング測定のリファレンス実装**として残す。
本番の self-host は sh-driven (`tests/test_pico2_phase7_sd.sh` 又は
manually) で。

## 関連ドキュメント

- `docs/task/pipeline_100kb.md` — Phase 1/2/3 のメモリ削減経緯
- `docs/compiler.md` — 各段の peak と algorithm
- `docs/lab_format.md` — asm_pass1/pass2 が共有する .lab 中間形式
- `docs/solved.md` K7 — pico2 phase 7 完走の経緯
