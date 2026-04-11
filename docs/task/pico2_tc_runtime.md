# Pico 2 で TC ランタイムを動かす

## 目的

`compile-gen2.sh` (または `compile-gen3.sh`) で `.tc` ソースを Pico 2 (RP2350 RISC-V)
向けにビルドし、実機で動作させる。第一段階として `hello.tc` を UART に出力する。

前提タスク: `pico2/hello.s` (素のアセンブリ hello world) は実機で動作確認済み。

## 設計方針

### 1. text/rodata = Flash, data/bss = SRAM の分離

- `text` / `rodata` は Flash XIP (0x10000000~) に置き、PC 相対 (PIC) で参照
- `data` / `bss` は SRAM (0x20000000~) に置き、`gp` 相対で参照
- `gp` は SRAM データセグメント先頭 + 0x800 にセット (RISC-V の慣例)

### 2. asm.tc を常に PIC で動作させる

現状の asm.tc は固定アドレス前提:
- `load_vaddr = 0x10000` ハードコード
- `TEXT_BASE = 0x10054` (ELF ヘッダ後)
- ラベルアドレスは絶対値で保持
- `.word symbol` は絶対アドレスを埋め込む

これを **常に PIC** で動かすように変更する:
- ラベルアドレス = コード先頭からのオフセット (常時)
- `.word symbol` はそのオフセット値を埋め込む
- `la` / `jal` / 分岐は今まで通り PC 相対 (動作は変わらない)
- ELF 出力時のみ `e_entry` / `p_vaddr` に `load_vaddr` を加算してマップする

**`.word symbol` のセマンティクス変更が安全な根拠**:
コードベース全体で `.word symbol` (シンボル参照) を使っているのは `pico2/hello.s` だけ。
- bc2asm.tc が出す `.word` はすべて数値リテラル (`.word INITVAL`, `.word LENGTH`)
- 文字列リテラルへの参照は `la rd, __tc_strobjN` で PC 相対
- crt0_tc.s / crt0_tc_data.s も `.word symbol` を使わない

→ 常時 PIC 化しても既存テストは無傷。手書きの IMAGE_DEF だけが影響を受け、
crt0_pico2.s の中で `.word 0x10000020` のように絶対値ベタ書きで対応する。

### 3. 出力フォーマットの切替

ELF (デフォルト、Linux qemu 用) と raw bin (Pico 2 用) の切替が必要。
stdin 先頭の `; raw` ディレクティブで切替。

### 4. load_vaddr の切替

ELF 出力時の `load_vaddr` を Pico 2 用に 0x10000000 にできるようにする。
`; load_base 0x10000000` ディレクティブで指定。raw 出力時は ELF ヘッダがないので
`load_vaddr` 自体は出力に現れないが、IMAGE_DEF の絶対値ベタ書きと合致させる
ためのドキュメンタリ用途として保持。

### 5. asm.tc に gp 相対参照を追加

セクション情報をラベルに持たせ、`la rd, sym` のうち `sym` が `.data` / `.bss` セクション
にあるものは pass 2 で `addi rd, gp, (sym_addr - gp_addr)` に展開する。

- `auipc rd, 0` + `addi rd, gp, offset` の 8 バイトに展開 (la のサイズを保持)
- 12-bit signed 範囲 (-2048 ~ +2047) を超えたらコンパイルエラー

`__arena` への依存は crt0_pico2.s のみで、しかも先頭アドレスを取得して main に渡すだけ。
配列の中身は a0 経由で渡された後はデータベース不要。よって la の先頭アドレスが gp 相対 12-bit
に収まれば十分。

### 4. SRAM レイアウト (crt0_pico2.s に固定アドレス定義)

```
0x20000000 ── data セグメント先頭 ──
            __pool_free       (68 bytes, BSS)
            __pool_base       (68 bytes, BSS)
            __pool_end        (68 bytes, BSS)
            __pools_ready     (4 bytes, BSS)
            __arena           (256 KB, BSS, gp 相対先頭参照)
0x20040??? ── data 末尾 ──
   ...
0x20081???: gp = 0x20000800 (= data先頭 + 0x800)
   ...
0x20082000: SP (SRAM 末尾)
```

`__pool_sizes` / `__pool_counts` は不変の定数なので `.rodata` (Flash) に置いて
`la` で PC 相対参照する (Pico 2 用にプール構成は縮小: 16/32/64/128/256/512/1024 など)。

### 6. ELF ヘッダなし raw bin → UF2

`compile-pico2.sh`:
1. stdin の先頭に `; raw` (+ `; gp 0x20000800` 等) を注入
2. `compile-gen2.sh` 相当のパイプラインを実行
3. asm.tc の raw bin 出力を IMAGE_DEF 含む生バイナリとして取得
4. `bin2uf2.py` で UF2 化

## 必要な変更

### asm.tc (compiler/asm.tc)

**常時 PIC 化 (常に有効):**
- ラベルアドレスをコード先頭からのオフセットで保持 (= 現状の `TEXT_BASE` を 0 にする)
- ELF 出力時に `e_entry` / `p_vaddr` / `p_paddr` に `g_load_vaddr` を加算
- `.word symbol` は label_offset (= オフセット値) を埋め込む

**stdin 先頭ディレクティブ (新規):**
- `; raw` → 出力フォーマットを raw bin に切替 (デフォルト: ELF)
- `; load_base 0xHHHHHHHH` → ELF 出力時の `load_vaddr` を変更 (デフォルト: 0x10000)
- `; gp 0xHHHHHHHH` → gp の論理アドレスを設定。0 でなければ data/bss シンボルへの
  `la` を gp 相対展開する。デフォルト 0 (= gp 相対無効)

**セクション追跡 (gp 相対のため、新規):**
- `g_current_section: i32` (0=text, 1=data, 2=bss, 3=rodata)
- セクションディレクティブ (`.text` / `.data` / `.bss` / `.section .rodata`) で更新
- `g_lab_section: I32Array` (各ラベルのセクション ID)
- ラベル定義時にセクション ID を記録
- pass 1 終わり: text/data/bss/rodata の base アドレスを計算してラベルを fixup
- `la rd, sym` の処理: pass 2 で sym のセクションが data/bss なら
  `auipc rd, 0` + `addi rd, gp, (sym_addr - g_gp_addr)` を生成
  - 範囲外なら fatal エラー
- `read_all_lines` の冒頭で `; raw` / `; load_base ...` / `; gp ...` ディレクティブを解釈
- `write_elf` を分岐: `; raw` 時は ELF ヘッダなしの生 code を sys_write

### crt0_pico2.s (新規, pico2/crt0_pico2.s)

```
.section .embedded_block, "a"
__embedded_block:
    # IMAGE_DEF (絶対アドレスベタ書き)
    .word 0xFFFFDED3
    .byte 0x42 .byte 0x01 .hword 0x1101
    .byte 0x44 .byte 0x03 .hword 0x0000
    .word 0x10000020      # _start (= block start + 32 bytes)
    .word 0x20082000      # SP
    .byte 0xFF .hword 4 .byte 0x00
    .word 0x00000000
    .word 0xAB123579

.text
.globl _start
_start:
    # core 1 を park
    li t0, 0xD0000000
    lw t0, 0(t0)
    bnez t0, _park

    # SP/gp 設定
    li sp, 0x20082000
    li gp, 0x20000800

    # XOSC + clk_peri + RESETS + GPIO + UART0 初期化 (hello.s と同じ)
    ...

    # __bss クリア (0x20000000 ~ __arena 末尾)
    li t0, 0x20000000
    li t1, 0x20040000
1:  sw zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 1b

    # ランタイム初期化
    la a0, __arena
    la a1, __pool_sizes
    la a2, __pool_counts
    la a3, __pool_free
    la a4, __pool_base
    la a5, __pool_end
    la a6, __pools_ready
    call __runtime_init__u32__u32__u32__u32__u32__u32__u32

    call main

_park:
    j _park

# UART スタブ
.globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    # a0=fd (無視), a1=buf, a2=len → UART に出力
    ...
    ret

.globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    # 未実装 (or UART 読み取り)
    li a0, 0
    ret

.globl do_exit__i32
do_exit__i32:
    j _park

# peek/poke (Linux 版と同じ)
.globl peek8__u32, peek16__u32, peek32__u32
.globl poke8__u32__u8, poke16__u32__u16, poke32__u32__u32
...
```

### crt0_pico2_data.s (新規, pico2/crt0_pico2_data.s)

```
# .rodata: pool 構成 (Flash, la で PC 相対参照)
.section .rodata
.globl __pool_sizes
__pool_sizes:
    .word 16, 32, 64, 128, 256, 512, 1024  # 7 buckets

.globl __pool_counts
__pool_counts:
    .word 256, 256, 64, 32, 16, 8, 4

# .bss: SRAM 上、gp 相対参照
.section .bss
.globl __pool_free
__pool_free:  .space 28      # 7 buckets x 4
.globl __pool_base
__pool_base:  .space 28
.globl __pool_end
__pool_end:   .space 28
.globl __pools_ready
__pools_ready: .space 4
.globl __arena
__arena:      .space 262144  # 256 KB
```

注: `compiler/runtime.tc` の `NPOOLS` も Pico 2 用ビルドでは 7 にする必要がある。
プールサイズが減るので `runtime_pico2.tc` を別ファイルにするか、`runtime.tc` の
NPOOLS を変更可能にするか決める必要がある (後述)。

### compile-pico2.sh (新規, ルート直下)

```bash
#!/bin/bash
# compile-pico2.sh — .tc → Pico 2 UF2
# Usage: GEN2_DIR=/path/to/gen2 compile-pico2.sh -o hello.uf2 hello.tc
#
# compile-gen2.sh ベース。crt0 を crt0_pico2.s に差し替え、
# stdin 先頭に `; raw` + `; gp 0x20000800` を注入。
# 出力は raw bin → bin2uf2.py で UF2 化。

CRT0=pico2/crt0_pico2.s
CRT0_DATA=pico2/crt0_pico2_data.s
RUNTIME_TC=compiler/runtime.tc

# ... import 解決, 各 .tc → .s ...

# アセンブリ結合
{
    echo "; raw"
    echo "; gp 0x20000800"
    cat "$CRT0"
    cat "$TMP/runtime.s"
    cat "${ASM_FILES[@]}"
    cat "$CRT0_DATA"
} | "$QEMU" "$GEN2_DIR/asm" > "$TMP/out.bin"

python3 pico2/bin2uf2.py "$TMP/out.bin" "$OUTFILE" 0x10000000
```

### hello.tc (新規, pico2/hello.tc)

`tests/hello2.tc` をほぼそのまま流用する。`sys_write(1, buf, len)` (runtime.tc:244)
が内部で `do_write__i32__u32__i32` を呼ぶので、Pico 2 用 crt0 で `do_write` を
UART 出力に置き換えれば動く。

```tinyc
fn to_buf(str: StringLiteral) -> U8Array {
  var len: i32 = len(str);
  var buf: U8Array = U8Array(len);
  var i: i32 = 0;
  while i < len {
    set(buf, i, get(str, i));
    i = i + 1;
  }
  return buf;
}

fn main() -> i32 {
    var buf: U8Array = to_buf("Hello, Pico 2!\r\n");
    sys_write(1, buf, 16);
    delete(buf);
    return 0;
}
```

## 実装ステップ (1コミット = 1ステップ)

| # | 作業 | 検証 |
|---|---|---|
| 1 | `docs/task/pico2_tc_runtime.md` 追加 (本ファイル) | レビュー |
| 2 | asm.tc を常時 PIC 化 (TEXT_BASE=0、ELF 出力時に load_vaddr 加算) + `; raw` / `; load_base` ディレクティブ追加 | 既存テスト合格、`; raw` モードで簡単な hello world (text のみ) を生 bin 出力 → qemu で動作確認 |
| 3 | asm.tc にセクション追跡 + `; gp` ディレクティブ + gp 相対 la 展開を追加 | 既存テスト合格、`; gp` モードで data/bss を持つ簡単な .s をビルドして動作確認 |
| 4 | `pico2/crt0_pico2.s` + `pico2/crt0_pico2_data.s` 作成 | asm.tc で .s を結合してアセンブル成功 (実機未確認) |
| 5 | `compile-pico2.sh` 作成、`pico2/hello.tc` 作成 | UF2 生成成功、IMAGE_DEF バイト確認 |
| 6 | 実機動作確認 (UART に "Hello, Pico 2!" 出力) | 実機 |

## 検討事項

### NPOOLS の差し替え方法

`compiler/runtime.tc` の `NPOOLS = 16` (asm.tc の `__pool_sizes` 定義に合わせている) を
Pico 2 用には 7 に変えたい。選択肢:

- (a) `runtime_pico2.tc` を新規作成し、compile-pico2.sh で差し替え
- (b) `runtime.tc` の `NPOOLS` を `crt0_*` 側で渡せる引数にする
- (c) Pico 2 側でも 16 buckets を用意 (大きいバケットは count=0 にして実質無効化)

最も小さい差分は (c)。runtime.tc を変更せず、`__pool_sizes` だけ Pico 2 用にして、
大バケットの count を 0 にすれば BSS を消費しない。これで進める。

### gp 相対 12-bit 範囲

`__pool_free` (offset 0) ~ `__arena` 先頭 (offset 208) は -2048 ~ -1840 で全部 12-bit
範囲内。仮に bucket 数を増やしたり配列が膨らんでも、`__arena` 先頭が +2047 以内に収まれば OK。
範囲を超えたら asm.tc がコンパイルエラーで知らせる。

### .data セクションは使わない

定数は `.rodata` (Flash)、変数はすべて zero-init (.bss)。これにより crt0 で
Flash → SRAM の data コピーが不要。

## 関連ファイル

- 既存: `compiler/asm.tc`, `compiler/runtime.tc`, `bootstrap/crt0_tc.s`,
  `bootstrap/crt0_tc_data.s`, `compile-gen2.sh`, `pico2/hello.s`, `pico2/bin2uf2.py`
- 新規: `pico2/crt0_pico2.s`, `pico2/crt0_pico2_data.s`, `pico2/hello.tc`,
  `compile-pico2.sh`
- 変更: `compiler/asm.tc` (PIC モード + gp 相対)

## 関連ドキュメント

- `docs/task/pico2_port.md` — Pico 2 ポート全体計画 (PSRAM、コンパイラ自体の移植等を含む)
- `docs/task/assembler.md` — asm.tc の現状仕様
