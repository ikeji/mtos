# vi: 単文節かな漢字変換 (計画、2026-11-01)

## 動機

vi の TUT モード (`userland/bin/vi/vi.tc`、2 ストローク 773 字) は
かなと常用漢字の一部を直接打てるが、TUT 表に無い漢字 / 熟語は打てない。
TUT で「かんじ」と打って **Ctrl-J で「漢字」に置き換える** 単文節変換を
足す。辞書は vi バイナリの .rodata に持ち (jpfont / tut_data と同じ
方式)、ファイルシステムにも RAM にも依存しない。

## ゴール / 非ゴール

ゴール:
- TUT モード中の Ctrl-J で、カーソル直前のひらがな列 (最大 8 文字) を
  **長い読みから順に** 辞書引きし、候補でその場置換する。Ctrl-J 連打で
  次候補、他のキーで確定。
- 辞書は SKK-JISYO.S (送りなし部) をコンパクトなバイナリに変換して
  `.incbin` で埋め込む。
- qemu virt / pico2 / tn20k / web の 4 環境すべてで同じバイナリが動く。

非ゴール (今回はやらない):
- 連文節 / 文節区切りの手動調整 (SKK の ▽ マーク相当)。
- 学習 (候補順の入れ替え)、ユーザー辞書、SD 上の辞書。
- 送りあり変換 (「おくr」) — Phase 3 に任意項目として残す。

## UX 仕様

### キー操作 (TUT モード中)

| 状態 | キー | 動作 |
|---|---|---|
| 通常 | Ctrl-J | カーソル直前のひらがな列から候補リストを作り、**候補 1 で置換**して変換状態へ。候補が無ければ `-- no candidates --` を status に出して通常のまま (TUT は抜けない) |
| 変換中 | Ctrl-J / Space | 次候補で置換 (末尾の次は元の読みに戻り、以後循環) |
| 変換中 | Backspace | 元の読みに戻して確定 (= キャンセル) |
| 変換中 | ESC | 確定して TUT を抜ける (現状の ESC と同じ) |
| 変換中 | それ以外 | 確定してからそのキーを通常処理 (TUT 2 ストロークの 1 打目になる) |

**変更点**: 現在「TUT 中の Ctrl-J = TUT 終了」だが、これを変換に充てる。
TUT を抜けるのは ESC のみになる (insert → TUT の入口は従来どおり
Ctrl-J)。`web/tests/test_console.sh` の Enter 回帰テストは CR を使って
いるので影響なし。

### 読みの切り出し

- `g_cur` から後方へ、ひらがな (U+3041..U+3096) と `ー` (U+30FC) が
  続く間コードポイントを拾う。行頭 / 漢字 / ASCII / 他のかなで止める。
  最大 `CONV_MAX_READ = 8` 文字。
- 長さ k = 拾えた文字数..1 の各接尾辞 (末尾 k 文字) について辞書を引き、
  **ヒットした順 (長い読みが先) に候補を連結して 1 本のリスト**にする。
  例: 「…をよむ」→「をよむ」ミス → 「よむ」= 読む/詠む → 「む」=
  無/夢… と続く。ユーザーは Ctrl-J を叩き続ければ短い読みの候補にも
  届く。リスト上限 `CONV_MAX_CANDS = 32`。
- リスト末尾に **読み全体のカタカナ** を 1 候補足す (SKK の q 相当、
  辞書に無い外来語に効く。U+3041..3096 → +0x60、ー はそのまま)。

### 置換と undo

- 変換状態は `g_conv_n` (候補数、0 = 変換中でない)、`g_conv_i` (現在
  候補、-1 = 元の読み)、`g_conv_start` (読み先頭の byte offset)、
  `g_conv_rb` (元の読みの UTF-8 bytes、最大 8×3 B を U8Array に退避)、
  候補表 (各候補 = 読みの文字数 + 辞書エントリ addr + 候補 index、
  またはカタカナ特殊値)。
- 最初の置換前に `save_undo()` を 1 回だけ呼ぶ。候補の切り替えでは
  呼ばない (`u` で元の読みに戻る)。
- 切り替えは「現在の置換部分を削除 → 読みを戻す → 候補を挿入」ではなく
  「`g_conv_start..g_cur` を削除して候補 (or 読み) を `insert_codepoint`
  で挿入」の 1 手順に統一する。`g_modified = 1`。

### status 行

```
-- INSERT TUT -- 2/5 [感じ] 幹事 監事 カンジ
```
現在候補から右に向けて `g_print_cols` に収まる分だけ出す (LCD 56 桁
でも 2〜3 候補は見える)。候補の文字列は .rodata から `peek16` で
読んで UTF-8 に encode して `putchar` する小関数を 1 つ足す
(`insert_codepoint` の encode 部を `utf8_emit(cp, sink)` 的に共用)。

## 辞書

### ソース

**SKK-JISYO.S** (skk-dev/dict、GPL-2+、EUC-JP、約 420 KB)。
送りなし部 ≈ 17k 見出し。送りあり部 (≈ 2.5k) は Phase 3 まで捨てる。
font.bmp と同じく **リポジトリには入れず `tmp/SKK-JISYO.S` に置く**。
`make -C userland fetch-dict` で
`https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.S`
を curl する便宜ターゲットを用意する。無ければ **空辞書で vi をビルド**
し (警告のみ、`make test` は壊れない)、test_os の変換テストは SKIP。

### 生成: `userland/scripts/genvidict.py`

```
genvidict.py <SKK-JISYO.S> <out.dat> [--max-cands 8] [--okuri-ari] [--dump]
```
- `;; okuri-nasi entries.` 以降を読む。見出し行 `よみ /候補1/候補2;注釈/`
  の `;注釈` を落とし、`(concat ...)` を含む候補は捨てる。
- 読みは先頭がひらがなで全文字がひらがな / `ー` のものだけ (数値
  `#`、カタカナ、ASCII 見出しは捨てる)。
- 候補の各文字は **JIS X 0208 で表せるもの** (`euc_jp` で 2 バイト)、
  または ASCII / かなに限る。console の jpfont は 94×94 の JIS X 0208 全面
  を持つので、この条件を満たせば LCD で豆腐にならない。
- 1 見出し `--max-cands` 候補まで。読みのコードポイント列で昇順ソート。
- `--dump` は .dat をテキストに戻す (生成テストと目視確認用)。
- 入力ファイルが無い (or 空) ときは見出し 0 の有効な .dat を出す。

### バイナリ形式 `vidict.dat` (全フィールド little-endian、2 B 境界)

```
u32 magic "VDC1"
u32 n_entries
u32 total_bytes
u32 bucket[97]      読み先頭コードポイント (0x3041 + i) ごとの開始 offset、
                    bucket[96] = 末尾。i は 0x3041..0x30A0 の 96 個
entry*:
  u8  rlen          読みの文字数 (1..15)
  u8  ncand
  u16 reading[rlen] コードポイント
  cand × ncand:
    u8  clen        候補の文字数
    u8  flags       0 (Phase 3 で送りあり印に使う)
    u16 cand[clen]  コードポイント
```
- 文字は UTF-8 (3 B) ではなく **u16 コードポイント (2 B)** で持つ
  (vi は `insert_codepoint` を既に持つので復元は無料、-33 %)。
- **2 B 境界を崩さない** (u8 は必ず 2 個組)。tn20k の自作コアと web の
  `ram16[o>>1]` は非整列 `lh` を扱えないため。
- 引き方: `b = cp0 - 0x3041` → `bucket[b]..bucket[b+1]` を線形走査し、
  `rlen` 一致 + `peek16` 比較。1 バケット平均 ≈ 200 見出し、Ctrl-J 1 回で
  最大 8 回引くので tn20k (~5 MIPS) でも数 ms。必要なら
  (先頭文字, rlen) 二段 bucket に後から変えられる。

### サイズ見積と loader の 256 KB しきい値

| 内容 | 概算 |
|---|---|
| 現在の vi.bin | 89 KB |
| SKK-JISYO.S 送りなし、候補 ≤ 8、u16 | 250〜350 KB (Phase 0 で実測) |

`kernel/src/loader.tc` は **256 KB 超のタスクを virt で固定スロット
0x87000000 に置く** (K22、picolibc の絶対アドレス参照のため gcc_doom
をリンク時 VMA に置く経路)。サイズはあくまで「GCC タスクか」の代用
ヒューリスティックで、以下の問題が既にある:

- `console.bin` (436 KB、純 TC) が既にしきい値を超え、virt では固定
  スロットに載っている。console → sh → vi と spawn したとき vi も
  256 KB 超なら **console の像を上書きする**。
- `gcc_hello.bin` (273 B) は kmalloc 経路で動く (picolibc の globals を
  使わないため)。つまり「大きい = 固定 VMA 必要」は両方向で不正確。

**方針 (2026-11-01 決定)**: **loader はいじらず、vi は固定スロットに
載せたまま進める**。衝突するのは「virt で 256 KB 超のタスク 2 本が同時
に生きる」場合だけで、具体的には virt の `console` (kern_console*.conf)
から sh 経由で vi を起動するケースと、gcc_doom 実行中に vi を起動する
ケース。pico2 / tn20k / web は XIP でこの経路を通らず、test_os の
console テストは vi を使わず、web の console + vi テストは XIP なので、
現行テストは何も壊れない。この制限は `docs/problem.md` に「virt
console 内で vi を起動すると console の像を上書きする」として記録する。

後回しにする本修正 (別タスク): サイズではなく **明示フラグ**で判定する。
`userland/Makefile` の `GCC_TASK_RULE` が出す K3 ヘッダの stack word に
bit 31 を立て (`.word stack | 0x80000000`)、`read_task_header_stack`
がマスクして返し、`load_fd` はそのビットで固定スロット / kmalloc を
選ぶ。TC タスクのヘッダは不変なので self-replicate の byte-exact にも
影響しない。gcc_doom_pico2 は XIP 経路で early return するので pico2
側はマスクだけで足りる。その時点で `GCC_TASK_THRESH` を削除。

固定スロットでも kmalloc 経路でも、辞書サイズの制約は **flash /
SDRAM の容量だけ**: pico2 は kernel.bin ≈ 2.3 MB / 4 MiB、tn20k
と web は 2.6 MB / 8 MB SDRAM なので、SKK-JISYO.S 送りなし全部 (≈
300 KB 台) をデフォルトで入れる。`--max-cands` / 見出し数上限は knob
として残す。self-replicate は DROP_TASKS で vi を落としているので
影響なし。

## 実装

### ビルド配線

- `userland/Makefile`: `VI_DICT_SRC ?= $(ROOT)/tmp/SKK-JISYO.S`、
  `$(BUILD_DIR)/vidict.dat` (genvidict.py)、`$(BUILD_DIR)/vidict_inc.s`
  (`bin2s_incbin.sh vidict.dat vidict <path>` → `_vidict_addr` /
  `_vidict_size_value`)、`TASK_EXTRA_S_vi += $(BUILD_DIR)/vidict_inc.s`、
  `fetch-dict` ターゲット。
- `kernel/scripts/build.sh` の「生成 extra .s のミラー」(console 専用
  の if 文、L191 付近) を **task 名 → 生成 .s の case 文**に一般化して
  vi を足す。ここが抜けると asm_pass3 が undefined reloc で hard error
  (solved.md #42) になるので、抜けはビルドで気付ける。
- `.gitignore` は `/tmp/` `/userland/build/` 済なので追加不要。

### vi.tc

- 前方宣言 `fn _vidict_addr() -> u32;` `fn _vidict_size_value() -> i32;`
  (size 0 = 空辞書)。
- 追加関数: `conv_collect_reading()` (後方走査 → コードポイント配列)、
  `dict_lookup(cps, off, n) -> entry addr or 0`、`conv_build()`
  (候補リスト構築)、`conv_apply(i)` (置換)、`conv_commit()`、
  `conv_status()` (status 行)、`utf8_emit`。
- `handle_tut` の先頭に変換状態の分岐を足す (上の表)。
  `if c == 10u8 { g_tut = 0; return; }` を削除。
- ヘッダコメントのキー説明を更新。

### テスト

- **生成器**: `make -C userland test` に python の往復テスト (合成 SKK
  3 行 → .dat → `--dump` が期待通り、注釈 / concat / JIS 外文字の除外)
  を 1 つ足す (~0.1 s)。
- **test_os**: 既存の `fs_out` セッション (sh に raw bytes を printf で
  流し込む 1 boot) に vi の操作を追記して新 boot を増やさない:
  ```
  vi /tmp/k\n  i  かんじ(UTF-8 生 bytes)  \n(TUT 入り)  \n(変換)  \e  \e  :wq\r
  cat /tmp/k
  ```
  insert モードは 0x20 以上の byte をそのまま挿入するので TUT の打鍵表
  なしでひらがなを置ける。期待: `cat` が `漢字` を出す。2 回目の
  Ctrl-J (次候補) と Backspace キャンセルも同じ要領で 1 ケースずつ。
  辞書が空なら SKIP。`make test` は現状 ~50 s なので追加分は 1 s 以内に
  抑える (vi の全画面再描画が増えるだけ)。
- web / 実機: `node_run.js --kbd` で同じ列を打てるが、LCD の OCR は漢字を
  読めないので UART 側の `cat` で確認する任意項目。

## Phase 分割

- **Phase 0 (計測)**: `tmp/SKK-JISYO.S` 取得、genvidict.py、.dat サイズを
  候補数 / 見出し数の knob ごとに実測。
- **Phase 1 (配線)**: Makefile / build.sh / vidict_inc.s、vi に
  `_vidict_addr` を link して `dict_lookup` だけ入れ、status 行に
  見出し数を出すスモーク。空辞書 fallback もここで。
- **Phase 2 (変換本体)**: 読み切り出し、候補リスト、置換 / 循環 /
  確定、undo、status 表示、カタカナ候補、test_os 追加、ドキュメント
  (vi.tc ヘッダ、`docs/sources.md`、CLAUDE.md 現在のフェーズ)。
- **Phase 3 (任意)**: 送りあり (`おくr` → 送 + る: 読み末尾のかなを
  SKK の子音字に写像して okuri-ari 見出しを引き、flags=1 で区別)、
  (先頭文字, rlen) 二段 bucket、候補の前候補移動。

## 決めごと (デフォルトで進める、異論があれば変更)

1. **TUT 中の Ctrl-J は変換専用**になり、TUT 終了は ESC のみ。
2. 辞書ファイルは **コミットしない** (GPL データを tree に入れない)。
   `tmp/SKK-JISYO.S` + `make -C userland fetch-dict`、無ければ空辞書。
3. loader は変更せず vi は virt で固定スロットに載る (virt console 内の
   vi は制限として problem.md に記録、明示フラグ化は別タスク)。
   vi は SKK-JISYO.S 送りなし全部を持つ (縮小は knob)。
4. 候補リストは「長い読みの候補 → 短い読みの候補 → カタカナ」の 1 本。

## リスク / 注意

- `make test` 1 分上限: 新規 boot を増やさず既存セッションに相乗りする。
- 非整列 `lh` 禁止 (tn20k / web)。形式の 2 B 境界を genvidict が assert。
- pico2 では辞書が flash XIP 上にあり `peek16` で直接読む。SPI flash の
  XIP はキャッシュ経由なので線形走査 200 見出しでも体感遅延なし。
- 既存の TUT 2 ストローク確定は `insert_codepoint` 直書きなので、変換中に
  TUT キーが来た場合は先に `conv_commit()` を呼ぶ順序を守る。
