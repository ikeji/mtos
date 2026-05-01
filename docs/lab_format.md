# .lab フォーマット (asm-pass1 → asm-pass2 の中間ファイル)

## 概要

`asm-pass1` が `.s` を 1 回読んで集めた **シンボルテーブル + セクション
レイアウト** を 1 行 1 entry のテキストで吐き、`asm-pass2` が起動時に
その .lab を読み込んでから `.s` を **再度**読んで機械語を emit する。

asm.tc が 1 プロセスで持っている 2-pass 状態を、ファイル境界で切る
ためのフォーマット。docs/task/pipeline_100kb.md §5 「asm 分割」を参照。

`.lab` は **link 後の最終形** (絶対アドレス、live のみ)。link 前の
per-file 中間状態は [`.idx` フォーマット](idx_format.md) を参照。
4 段パスの整理は [docs/task/asm_pass_split.md](task/asm_pass_split.md)。

## 行の種別

各行は 1 個のキーワード (空白区切りの先頭トークン) で識別する:

| key | 形式 | 意味 |
|---|---|---|
| `;`  | `; ...` | 行コメント。`asm-pass1` が出力する `; lab v1` は仕様バージョン (現在 v1) |
| `raw` / `load_base` / `src_bytes` | `raw <0\|1>` 等 | meta 状態（`; raw` ディレクティブ等を asm-pass2 に渡す） |
| `sec` | `sec <id> <base> <size>` | セクション情報。4 個固定 |
| `src` | `src <path>`（≡ `src asm <path>`） | asm-pass2 が open + tokenize + encode する入力 .s。複数可、順序は text→rodata→data エミット時の section base 計算順 |
| `src raw` | `src raw <path> <section_id>` | **(v2)** asm-pass2 がそのまま memcpy する pre-encoded バイナリ。section_id は 0=text / 1=rodata / 2=data |
| `lab` | `lab <addr> <section> <name>` | 通常ラベル (関数名・global var・string literal 等) |
| `num` | `num <digit> <addr>` | 数値ラベル `0:`〜`9:` の 1 定義 |
| `reloc` | `reloc <offset> <kind> <name>` | **(v2)** pre-encoded `src raw` セクション内の placeholder を、リンク時に label `<name>` の最終アドレスで patch する指示 |

行末は LF (`\n`)。空行は無視。

### `sec` (4 個必須、id 0..3 の順)

```
sec <id> <base> <size>
```

- `id`: 0=text, 1=rodata, 2=data, 3=bss
- `base`: そのセクションの絶対先頭 (= text_size + 前セクション size の累積、
  0..total_memsz の範囲)
- `size`: そのセクションの最終サイズ (16-byte align 後)

asm-pass1 が必ず 4 行出力する。順序は 0→1→2→3。

### `lab` (任意個)

```
lab <addr> <section> <name>
```

- `addr`: ラベルの絶対値 (= asm-pass1 の `g_sec_base[section] + intra_offset`)。
  10 進
- `section`: 0..3 (sec と同じ規約)
- `name`: 空白を含まない識別子。`__global_pointer$` などの記号文字も
  そのまま許容

`__global_pointer$` も普通の `lab` として吐く (asm-pass1 が data_base+2048
で patch 済みの値を持っている)。

asm-pass2 は `lab` を読みながら `define_label` 同等の処理で in-memory
テーブルに登録する。**順序は不問**。

### `num` (任意個)

```
num <digit> <addr>
```

- `digit`: 0..9
- `addr`: 数値ラベルの絶対値

asm-pass1 は **ソース順** に出力する (= 同じ digit の複数定義が、
ソースの出現順に並ぶ)。`numlab_back` / `numlab_fwd` は出現順前提なので、
asm-pass2 は読んだ順に append すれば正しい挙動になる。

### `src` / `src asm <path>` (任意個、v1 後方互換 + v2 で意味付け)

```
src <path>             ; v1 と v2 共通
src asm <path>         ; v2 で明示的なエイリアス
```

- `path`: asm-pass2 が `do_openat` で開いて読み、tokenize + encode する
  asm ソース。複数行可。

asm-pass2 は宣言順に open し、各セクションパス（text→rodata→data）で
全 src を順に walk。target_section にマッチする bytes を emit。

### `src raw <path> <section_id>` (任意個、v2)

```
src raw <path> <section_id>
```

- `path`: pre-encoded バイナリ。bytes はそのまま `<section_id>` の bytes
  として連結される（tokenize / encode しない）
- `section_id`: 0=text, 1=rodata, 2=data

bss (id=3) には raw bytes は出さない（zero-fill 専用）。

複数の raw / asm が混在する場合、`.lab` 内の宣言順に concat される。
セクション境界は **明示的に各 `src raw` が `section_id` を指定**するの
で、asm ソース内の `.text` / `.data` ディレクティブとは独立。

例：prelude pre-encode の典型例
```
src raw /prelude.text.bin 0
src raw /prelude.rodata.bin 1
src raw /prelude.data.bin 2
src asm /sd/u.strip
```

asm-pass2 はテキストセクション emit 時：
1. `prelude.text.bin` を memcpy
2. `/sd/u.strip` を tokenize + encode、`.text` 部分の bytes を append
3. （reloc があれば最後に patch）

### `reloc <offset> <kind> <name>` (任意個、v2)

```
reloc <offset> <kind> <name>
```

- `offset`: text section 内の絶対オフセット (バイト)
- `kind`: 命令形式
  - `0`: J-type 21-bit PC-relative (jal)
  - `1`: U+I 32-bit PC-relative (auipc + jalr ペア; offset は auipc を指す)
- `name`: target ラベル名

**目的**: pre-encoded prelude.text.bin のうち、user 側ラベルを参照する
命令の placeholder (オフセット 0 で encode 済み) を、リンク時に最終
アドレスで上書きする。例：

```
reloc 84 1 main__StringArray
```

= prelude.text.bin の offset 84 にある `auipc + jalr` ペアの即値 32 bit
を、`main__StringArray` の最終アドレス - 84 (PC) で計算した値で patch。

asm-pass2 は全 src を emit してから reloc を順に適用する。複数 reloc
は独立で順序非依存。

## サンプル

下記の .s に対する .lab:

```asm
.text
_start:
    li a0, 0
0:  j 0b
.rodata
__strobj_main_0:
    .word 13
    .string "Hello, World!"
.data
g_count:
    .word 42
```

```
; lab v1
sec 0 0 16
sec 1 16 32
sec 2 48 16
sec 3 64 0
lab 0 0 _start
lab 16 1 __strobj_main_0
lab 48 2 g_count
lab 2096 3 __global_pointer$
num 0 8
```

`__global_pointer$` は data_base (48) + 2048 = 2096。

## 設計判断

### なぜ asm-pass2 にラベル table を渡すだけで足りるか

asm-pass2 は `.s` を **stream で再度読む** ので、行ごとの section 状態
(`g_current_section`) は `.text` / `.rodata` / `.data` / `.bss` ディレクティブ
を見れば自前で track できる。pass 2 が必要なのは:

1. **シンボル名 → 絶対値** (`la`/`call`/`.word symbol` のエンコード)
2. **数値ラベル → 絶対値** (`bnez 0f` 等)
3. **セクション base** (`g_pos = sec_base[sec] + sec_pos[sec]`)

の 3 つだけで、いずれも .lab に乗っている。

### なぜ「現在 emit 中の section 切り替え情報」を per-line で持たないか

`.text` / `.rodata` 等のディレクティブを pass 2 が見たときに自前で
切り替えれば良い。asm.tc は per-line `g_line_section[]` キャッシュを
作っているが、これは「pass 1 で full source を持っているからついでに
キャッシュ」しているだけ。pass 2 単体では再 derive 可能。

### なぜ ELF ヘッダ用の filesz/memsz を .lab に書かないか

- `memsz` = sum of all `sec` size = .lab から計算可能
- `filesz` = pass 2 emit 中の `g_code_end` (最後に書いた byte 位置)。
  pass 2 が emit しながら自分で track できる。pass 1 は `.s` を読むけど
  encode しないので `g_code_end` を持っていない

### なぜテキストフォーマットか

- デバッグ容易 (cat してそのまま読める)
- TC で書く parse がシンプル (空白 split + atoi 程度)
- 中間ファイルは tmpfs 上に置くだけで永続化しないので、サイズより
  読み書きの単純さを優先

## バージョン

- v1: `sec` / `lab` / `num` / `src` の基本形式
- v2: `src raw <path> <id>` + `reloc <offset> <kind> <name>` を追加
  (prelude pre-encode 対応、docs/task/asm_pre_encode.md)

reader はヘッダコメントのバージョンを照合しなくても動く（不要な行種別
は無視）が、明示的に `; lab v1` / `; lab v2` で spec mismatch を検出
する余地がある。v2 reader は v1 ファイルを問題なく読める（後方互換）。
