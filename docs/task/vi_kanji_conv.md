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
- 辞書は SKK-JISYO.M (送りなし部 + 送りあり部) をコンパクトなバイナリに
  変換して `.incbin` で埋め込む。
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
| 変換中 | Enter | **確定だけ** (改行しない、改行はもう一度 Enter。2026-11-01 追加) |
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
- リスト末尾に **カタカナ** を足す (SKK の q 相当、辞書に無い外来語に
  効く。U+3041..3096 → +0x60、ー はそのまま)。読み全体だけでなく
  短い接尾辞ごとにも 1 候補ずつ (2026-11-01、「あんぱん」→ 版 /
  アンパン / ンパン / パン / ン で「あんパン」に届く)。ー で始まる
  接尾辞は飛ばす。辞書ヒットの上限は `CONV_MAX_CANDS - 読み長`。

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

`set_msg` のメッセージ ("no kana before cursor" など) は**次のキーで
消す** (2026-11-01 修正)。以前は次の `set_msg` まで残り、変換中は候補
表示に隠れていたぶん確定した瞬間に古い "no kana before cursor" が
再表示されて「確定するとエラーが出る」ように見えた。main loop が
キー 1 個ごとに `g_msg_len = 0` してから handler に渡す (そのキー自身が
出すメッセージは残る)。test_os は "no kana before cursor" を 1 回わざと
出し、ログ中の出現回数が 1 以下であることを見る。

## 辞書

### ソース

**SKK-JISYO.M** (skk-dev/dict、GPL-2+、EUC-JP、144 KB、送りなし
6.4k 見出し) を既定にする (S = 55 KB / 2.4k は語彙不足、ML = 953 KB /
41k は Phase 0 の表参照)。送りあり部 (1.4k 行) も Phase 3 から使う。
font.bmp と同じく **リポジトリには入れず `tmp/SKK-JISYO.M` に置く**。
`make -C userland fetch-dict` で
`https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.M`
を curl する便宜ターゲットを用意する。無ければ **空辞書で vi をビルド**
し (警告のみ、`make test` は壊れない)、test_os の変換テストは SKIP。

### 生成: `userland/scripts/genvidict.py`

```
genvidict.py <SKK-JISYO> <out.dat> [--max-cands 8] [--max-read 8]
genvidict.py --empty <out.dat>      見出し 0 の有効な .dat
genvidict.py --dump <in.dat>        .dat → テキスト (検証用)
```
(実装済、往復テスト `userland/tests/test_genvidict.sh` を
`make -C userland test` から実行。)
- `;; okuri-ari entries.` と `;; okuri-nasi entries.` の両方を読む。
  見出し行 `よみ /候補1/候補2;注釈/` の `;注釈` を落とし、`(concat ...)`
  を含む候補と `[る/送/]` 形式の厳密送り仮名ブロックは捨てる。
- 送りあり見出しは「語幹 + 子音字 1 文字」(`よm`)。子音字は SKK の
  ローマ字入力の揺れ (ち/つ = c or t、じ = j or z、ふ = f or h) を
  **t / z / h に正規化**して衝突した見出しを併合し、vi 側の
  `okuri_letter()` (かな → 行の子音、あ行は母音、っ = t、ん = n) と
  一致させる。
- 読みは先頭がひらがなで全文字がひらがな / `ー` のものだけ (数値
  `#`、カタカナ、ASCII 見出しは捨てる)。
- 候補の各文字は **JIS X 0208 で表せるもの** (`euc_jp` で 2 バイト)、
  または ASCII / かなに限る。console の jpfont は 94×94 の JIS X 0208 全面
  を持つので、この条件を満たせば LCD で豆腐にならない。
- 1 見出し `--max-cands` 候補まで、読みは `--max-read` 文字まで
  (vi は最大 8 文字しか引かないので、長い見出しは捨てる)。読みの
  コードポイント列で昇順ソート。
- `--dump` は .dat をテキストに戻す (生成テストと目視確認用)。
- `--empty` は見出し 0 の有効な .dat (辞書ファイルが無いときの fallback)。

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
    u8  flags       1 = 送りあり (reading 末尾が ASCII 子音字)、0 = 送りなし
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

### サイズ実測 (Phase 0、2026-11-01) と loader の 256 KB しきい値

`genvidict.py` (送りなし、`--max-read 8`) の出力 (Phase 3 で送りあり
1.4k 見出しが加わり M は 7.8k 見出し / 131 KB、vi.bin 244 KB):

| ソース | 原本 | 見出し | 候補 | .dat (候補 ≤ 8) | .dat (候補 ≤ 4) |
|---|---|---|---|---|---|
| SKK-JISYO.S | 55 KB | 2,373 | 3,890 | 39 KB | 37 KB |
| SKK-JISYO.M | 144 KB | 6,402 | 8,616 | 112 KB | 109 KB |
| SKK-JISYO.ML | 953 KB | 40,833 | 55,563 | 814 KB | 801 KB |

計画時の「S で 300 KB」は見積り違いで、S は小さすぎ (かんじ / にほんご /
きょう は入るが語彙 2.4k)。**デフォルトは M** (`VI_DICT_SRC ?=
tmp/SKK-JISYO.M`): vi.bin は 89 + 112 ≈ 200 KB で **256 KB 未満のまま**
なので、`kernel/src/loader.tc` の固定スロット (virt で 256 KB 超の
タスクを 0x87000000 に置く経路) には乗らず、virt の console 内でも
衝突しない。ML (814 KB) を選ぶと固定スロットに乗る (XIP の pico2 /
tn20k / web には無関係)。その場合の制限は「virt console 内で vi を
起動すると console の像を上書きする」で、ML を既定にする日が来たら
`docs/problem.md` に記録するか、下の明示フラグ化を先にやる。

`kernel/src/loader.tc` のしきい値は「picolibc 製 GCC タスクか」の代用
ヒューリスティックで、`console.bin` (436 KB、純 TC) が既に超えている
一方 `gcc_hello.bin` (273 B) は kmalloc 経路で動く。本修正は別タスク:
`GCC_TASK_RULE` が出す K3 ヘッダの stack word に bit 31 を立て、
`read_task_header_stack` がマスク、`load_fd` はそのビットで固定スロット
/ kmalloc を選ぶ (TC ヘッダ不変で self-replicate byte-exact に影響なし、
gcc_doom_pico2 は XIP 経路で early return)。

**送りなしだけだと動詞 / 形容詞が引けない** (よむ・かく・たかい は
okuri-ari 部に `よm /読/` の形でしかない) ので Phase 3 で送りあり対応
(完了)。vi.bin は 244 KB で 256 KB しきい値まで残り 12 KB: 辞書を
増やす (ML など) か vi がさらに太るときは loader のフラグ化が先。

pico2 flash (kernel.bin ≈ 2.3 MB / 4 MiB)、tn20k / web (2.6 MB / 8 MB
SDRAM) とも M の 112 KB は余裕。self-replicate は DROP_TASKS で vi を
落としているので影響なし。

## 実装

### ビルド配線

- `userland/Makefile`: `VI_DICT_SRC ?= $(ROOT)/tmp/SKK-JISYO.M`、
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

- **Phase 0 (計測、完了 2026-11-01)**: `tmp/SKK-JISYO.{S,M,ML}` 取得、
  genvidict.py + 往復テスト、.dat サイズ実測 (上表)。M を既定に決定。
- **Phase 1 (配線、完了 2026-11-01)**: `userland/Makefile` に
  `vidict.dat` / `vidict_inc.s` / `dict` / `fetch-dict`、空辞書 fallback、
  `kernel/scripts/build.sh` の生成 .s ミラーを case 文化 (console →
  jpfont_inc.s、vi → vidict_inc.s)。
- **Phase 2 (変換本体、完了 2026-11-01)**: vi.tc に `conv_*` /
  `dict_lookup` (~200 行)、vi.bin 89 → 216 KB。test_os の fs_virtio
  セッションに 4 行 (第 1 候補 / 第 2 候補 / Backspace 復元 / カタカナ
  fallback) を追加、`grep <語> /tmp/k | wc` の行バイト数で保存結果を
  検証。**実装メモ**: (a) vi は stdin を 8 byte バッチで読み、`:wq` で
  quit するとバッチの残りを捨てるので、連続 pipe 入力では `:wq\r` の
  後に LF を 7 個詰める (対話では起きない)。(b) `KERN: live=` canary は
  vi の 216 KB イメージで kmalloc pool が 1 回だけ +5 成長する (1 回でも
  2 回でも同値) ので上限を 145 → 150 に。(c) md5sum は
  EXTRA_GUEST_TASKS で disk-demo に無いので使わなかった。
- **Phase 3 (送りあり、完了 2026-11-01)**: genvidict が okuri-ari 部も
  取り込み (子音字 c/j/f → t/z/h 正規化、`[...]` ブロック除去、
  flags=1)、M は 6.4k → 7.8k 見出し / 112 → 131 KB、vi.bin 244 KB。
  vi 側は読みの各接尾辞 (長い順) について「送りなし見出し → 語幹 +
  送り仮名の分割 (送り仮名が短い順)」で候補を集め、送り仮名の先頭かな
  を `okuri_letter()` で子音字にして `dict_lookup(off, n, letter)` を
  引く。候補は漢字 + ユーザーが打った送り仮名 (`g_cand_ok` 文字) で
  表示 / 挿入。`CONV_MAX_CANDS` 32 → 48。test_os にケース f (よむ →
  読む、第 1 候補) / g (たかい → 高井 → 高い、Space 1 回) を追加、
  手動で 感じる / 送った / 走る / 美しい / 食べた / 考える の第 1 候補
  を確認。

## TODO (続編候補、未着手)

- ~~**TUT 表に記号を足す**~~ (完了 2026-11-01): 本家 TUT-code の記号は
  「文字キー + Space」の 2 打鍵なので、uim の `tutcode-rule.scm` の
  30 字 (q“ w〒 eー r【 t「 y」 u】 i… o・ p” a‘ s☆ d、 f。 g『 h』 j々
  k※ l＼ ;’ z〆 x§ c○ v÷ b← n→ m× ,《 .》 //) を `g_tut_sym` に持ち、
  1 打目のあとの Space で挿入。全部 JIS X 0208 内。打ちかけ無しの
  Space は空白を挿入 (以前は捨てていた)。変換中の Space は次候補の
  まま (変換中は 1 打目が無いので衝突しない)。
- ~~**確定時に TUT の打ち方を表示する**~~ (完了 2026-11-01): 候補を
  確定したキーの render で status 行に「字=no 事=uf」のように候補
  (辞書側の文字列、送り仮名 / カタカナは除く) の各文字の打鍵を出す。
  `conv_commit()` → `conv_hint()` が `g_msg` を動的に組み立て
  (`msg_reset / msg_putb / msg_put_cp`)、`msg_put_tut()` が 40×40 表の
  線形走査 (2 打鍵 `kf`)、`g_tut_vo` 逆引き (濁音 / 小書き `sla`、ぱ行
  `tlta`)、`g_tut_sym` 逆引き (記号 `t_` = キー + Space) の順で引く。
  表に無い字は `?` (例: 漢 は TUT 773 字に無いので `漢=? 字=no`)。
  カタカナ候補は表に無い (TUT 表のカタカナは 0 字) ので、ひらがなの
  打鍵と、そこに届くまでの Ctrl-J 回数を出す (`ピ=tlti ピ=tlti ^J*1`)。幅は
  `g_print_cols - 20` で切る。次のキーで消える。**test_os では検証
  しない**: pipe 入力は 8 byte バッチで、確定キーと次のキーが同じ
  バッチに入ると render 前にメッセージが消えるため非決定的。1 キー
  ずつ sleep を挟んで qemu に流す手動確認で `漢=? 字=no`、
  `感=bp じ=sli`、`「=t_ 」=y_`、`ぱ=tltk ぴ=tlti` を確認 (後 2 つは
  合成辞書で vi をビルドして確認)。
- 任意: (先頭文字, rlen) 二段 bucket、前候補移動 (Shift-Space 相当)。

## 決めごと (デフォルトで進める、異論があれば変更)

1. **TUT 中の Ctrl-J は変換専用**になり、TUT 終了は ESC のみ。
2. 辞書ファイルは **コミットしない** (GPL データを tree に入れない)。
   `tmp/SKK-JISYO.M` + `make -C userland fetch-dict`、無ければ空辞書。
3. loader は変更しない。M 既定なら vi.bin ≈ 200 KB で固定スロットに
   乗らない (ML を選んだときだけ乗る)。明示フラグ化は別タスク。
4. 候補リストは「長い読みの候補 → 短い読みの候補 → カタカナ (読み全体
   → 短い接尾辞)」の 1 本。

## リスク / 注意

- `make test` 1 分上限: 新規 boot を増やさず既存セッションに相乗りする。
- 非整列 `lh` 禁止 (tn20k / web)。形式の 2 B 境界を genvidict が assert。
- pico2 では辞書が flash XIP 上にあり `peek16` で直接読む。SPI flash の
  XIP はキャッシュ経由なので線形走査 200 見出しでも体感遅延なし。
- 既存の TUT 2 ストローク確定は `insert_codepoint` 直書きなので、変換中に
  TUT キーが来た場合は先に `conv_commit()` を呼ぶ順序を守る。
