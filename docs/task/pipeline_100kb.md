# フェーズ 2.5 / 7: コンパイルパイプラインを 100 KB 級に縮める計画

## 目的

Pico 2 (RP2350、SRAM 520 KB) で自分自身を再コンパイルできるようにする。
phase 7 M6 で qemu virt 上のセルフコンパイルは達成したが、実測ピークが
asm ≈ 9.5 MB、bc2asm ≈ 1.4 MB で、どちらも pico2 では到底載らない。
各ステージのデータセグメント (BSS + heap) を **100 KB 前後** に抑えるのが
目標。達成できれば 256 KB task RAM (kernel/loader.tc) の枠に余裕で収まる。

理想は **1 パス + ストリーム処理**。どうしても forward reference が外せない
ステージは、必要最小限の 2 パス or ステージ分割で逃げる。

関連: `docs/problem.md` #7 (asm.tc memory)、 K3 (per-task size)、
`docs/task/phase7_compiler_on_os.md` (M1〜M6 記録、実測ピーク表)。

---

## 現状 (phase 7 M6 時点)

| ステージ | 実測ピーク | 主な allocation (静的) | 入力 | 出力 |
|---|---:|---|---|---|
| parse      | 14 KB   | tok_buf 4K + SourceReader 4K + StringBuffer 増 | stream | stream |
| typecheck  | 717 KB  | strtab 512K + fntab 113K + AstNode プール | stream | stream |
| codegen    | 303 KB  | strtab 256K + AstNode(4K slot) + locals 8K | stream | stream |
| bc2asm     | 1.4 MB  | **instrs 1M** + strtab 256K + label_pcs 64K | stream | stream |
| asm        | 9.5 MB  | **g_code 4M + g_lines 4M** + labels 320K | slurp | 一括 |

- **parse**: 合格。単調 stream、forward reference 無し。
- **typecheck**: 大半が固定サイズの strtab (524288) と fntab (600 × 47 i32)。
  いま fntab は 600 関数分固定、1 関数あたり 47 フィールドもあるので
  実質上限まで取っている。
- **codegen**: 固定 256 KB strtab が支配的。AstNode は per-function reset
  できているので pool の絶対ピークは既に制御下。
- **bc2asm**: `I32Array(262144)` で 1 MB の全 instruction バッファを持ち、
  pass 全体を終えるまで保持している。"stream 入力・bulk emit" 構造。
- **asm**: g_code と g_lines がそれぞれ 4 MB。入力を全部バッファリングして
  2 パス、出力も 4 MB の U8Array に書いてから一括 write_elf で吐く。
  `MAX_CODE = 4194300` に素で張り付く最悪クラス。

参考: `docs/problem.md` #7 に asm.tc 単独の内訳と assembler/linker 分離の
短中長期案あり。本計画はそれを phase 7 と統合して pipeline 全体で 100 KB
に寄せる。

---

## 構造的な障害物 (なぜ RAM が要るのか)

ステージごとに「これがある限り完全 stream 化は無理」という制約:

| ステージ | 障害物 | 影響 |
|---|---|---|
| parse     | なし | —  |
| typecheck | **forward fn / struct 参照** | AST 全体を持たないと未定義識別子か後出し関数か判断不能 |
| codegen   | 実装上は無いが、strtab を固定で大きく取っている | 単なる余剰確保 |
| bc2asm    | **function 内の forward jump label** | 命令ストリームが固まるまで `jal` / `br` のオフセット決まらず |
| asm       | **global label forward reference** (関数を跨ぐ call / la) + ELF ヘッダの size 事前確定 | 全関数読むまで label → 絶対 PC が定まらない。ELF 側も segment size を先頭に埋めるので全体長が必要 |

ポイントは **forward reference の粒度** が違うこと:

- typecheck / asm: module-wide (別の関数 / top-level を指す)
- bc2asm: function-local (同じ関数内のラベル)

ここが設計の分岐点。

---

## 目標予算

各ステージ **working set 100 KB 以下** を目標 (コード + 固定 rodata は別勘定)。
1 ステージずつ独立に動作するので、同時に乗る心配はない。

| ステージ | 現在 | 目標 | 主なやること |
|---|---:|---:|---|
| parse     |  14 KB |  15 KB | 維持 (tok_buf を少し伸ばす余地はあり) |
| typecheck | 717 KB |  80 KB | ステージ分割 + strtab/fntab 動的成長 |
| codegen   | 303 KB |  50 KB | strtab / locals を動的成長に |
| bc2asm    | 1.4 MB |  40 KB | **per-function emission** (関数ごとに instrs リセット) |
| asm       | 9.5 MB |  80 KB | ステージ分割 + streaming emit + seekable output |

合計 (順次実行なので意味は薄いが目安): ≈ 265 KB、ただし 1 ステージずつなら
`max` が支配的なので **最大 80 KB** に収まる。

---

## ステージごとの具体策

### 1. parse (14 KB → 15 KB)

何もしない。lexer の tok_buf を必要なら拡張する程度。

### 2. typecheck (717 KB → 80 KB)

障害物は forward fn / struct 参照 だけ。対策は 2 パス分割:

#### 案 A: 既存 extract_sigs を再利用して 2 パス化

- **pass 1 (既存 `extract_sigs`)**: AST を読んで top-level
  (fn シグネチャ、struct 定義、global var) だけ `.th` に吐く。
  関数本体は捨てる。AstNode pool は top-level ごとにリセットできるので
  pool を 500 slot (≈ 18 KB) に縮めて OK。
- **pass 2 (`tcheck`)**: 自分自身の `.th` + import 先の `.th` を事前に
  読んでシンボルテーブルを作り、本体の .ast をもう一度 stream で読んで
  関数本体を 1 個ずつ type check → .tast emit。関数間で AstNode pool を
  reset できる。

コスト: AST を 2 回読む。 ストリーム前提だが 2 回読めるように入力が
seekable (= ファイル) である必要あり。現状 typecheck は stdin。解決:

- (1) sh が `typecheck < a.ast > a.tast` と redirect するとき、tmpfs は
  すでにランダムアクセス可能なので kernel 側が `lseek` をサポートすれば
  同じ fd で 2 回読める。
- (2) pass 1 → pass 2 を 2 個の別プロセスに分けて中間ファイルを挟む。
  sh ではもう `parse < in > tmp` のパイプを使っているので同じパターン。

**推奨**: (2)。既に extract_sigs バイナリがあり、コマンドとしても自然。

新しいパイプライン:

```
parse      < a.tc   > a.ast
sigscan    < a.ast  > a.th      (= extract_sigs の OS 移植)
tcheck     -h a.th < a.ast > a.tast
```

#### 見積もり (tcheck pass 2 後)

- strtab: 16 KB (top-level 識別子 + import 名のみ、動的成長)
- fntab: 100 関数 × 47 i32 = 19 KB (50% 余裕で動的成長)
- AstNode pool: 関数 1 個分 ≈ 1000 slot × 36 B = 36 KB
- その他: ~10 KB
- **合計 ≈ 80 KB**

### 3. codegen (303 KB → 50 KB)

障害物は無い。ただの余剰バッファ問題:

- strtab 262144 → 16 KB から始めて 2x growth (最大 64 KB で pico2 セルフ
  ホストは回る見込み)
- locals 2048 × 4 → 動的成長 or 512 × 4 = 2 KB 開始
- AstNodeArray(4096) は per-function reset があるので縮める必要なし
  (refs 16 KB は許容)

実装はほぼ機械的。StringBuffer 的な動的 U8Array / I32Array を作って
差し替えるだけ。

#### 見積もり

- strtab: 32 KB (動的)
- AstNode pool refs: 4 KB (1024 slot まで絞る)
- locals / slits: 4 KB
- その他: 10 KB
- **合計 ≈ 50 KB**

### 4. bc2asm (1.4 MB → 40 KB)

障害物は function-local な forward jump のみ。現在の構造は **全関数の
instruction を instrs I32Array(262144) に溜めてから emit** なので、関数間
で forward reference が発生しない限り 1 関数ずつ処理できる。

対策: **per-function streaming**。

- `.fn` directive を読んだら 1 関数分の instruction / label / locals だけ
  溜める
- 関数末端 (次の `.fn` or EOF) で、その関数の label offsets を確定させて
  アセンブリを emit、バッファをリセット
- 関数を跨ぐのはシンボル名 (strtab) と string literal プールのみ。
  string literal は .rodata にまとめて出したいので、関数本体を emit する
  際に追加分だけストリームに吐く (literals の追加順 index は保存)。

現在の `__<first_fn>_strobj<N>` 命名は今の修正で既に per-file 一意
(#21 fix) だが、このリストラクチャ後は per-function に戻せる。

#### 見積もり

- strtab: 16 KB (動的)
- 現在の関数分 instrs: 1024 entry × 16 B = 16 KB (1 関数 1000 命令まで)
- label_pcs: 1 KB
- string_lits 追加バッファ: 4 KB
- **合計 ≈ 40 KB**

### 5. asm (9.5 MB → 80 KB)

ここが本丸。障害物は:

1. **全 label を集めないと pass 2 の命令エンコードが決まらない**
   (特に関数 間の `call foo` / `la global_var` / `.word symbol`)
2. **ELF ヘッダに全セクションの size を書かないといけない**
3. 現在は入力 (g_lines 4 MB)・出力 (g_code 4 MB) とも丸ごと持っている

対策は 2 軸:

#### 5a. 入力を stream 2 パスに

`g_lines` を廃止する。入力を 2 回読むために以下のどちらか:

- (A) asm への入力を **ファイル引数** にする。引数なしなら stdin を一度
  中間 tmpfs にコピーしてから 2 回読む
- (B) 入力を tmpfs ファイルから取る前提で kernel 側に `lseek` (openat +
  pread) を追加し、同じ fd を巻き戻す

ファイル引数方式 (A) が素直。sh はすでに `asm < /tmp/full.s > /tmp/hw`
と redirect しているので、kernel 側 sh + loader を少し変えて
`asm /tmp/full.s > /tmp/hw` に切り替えられる。

#### 5b. 出力を stream emit + backpatch に

出力の 4 MB g_code を廃止する。選択肢:

- (I) **backpatch list 方式**: 命令を「ほぼ確定の機械語」として emit
  先の tmpfs ファイルにどんどん吐く。forward label 参照のところは
  仮の 0 を書きつつ `(file_offset, label_name)` のタプルを **1 パス
  目** から記録 (pass 1 ≠ label collector、pass 1 が本番 emit)。全行を
  読み終わった時点で label テーブルが完成するので、tmpfs に seek して
  32 bit ずつ patch する。
  - 利点: 入力 1 パスで済む (5a の 2 パスが不要になる) 。
  - 要件: **tmpfs が pwrite / lseek をサポート**。現状 tmpfs は append
    のみ。これを最初に拡張する必要がある。`tmpfs.tc` の grow-on-write
    を少し強化すれば可能。
  - ELF ヘッダ問題: 先頭 84 B は最後に埋めるので、先頭にダミーで 84 B
    書いておいて後から seek + 上書き。これも pwrite 相当が要る。

- (II) **2 パス+軽量 state 方式**: 5a の stream 2 パスを使って、pass 1 で
  全 label を集め、pass 2 で emit を tmpfs に stream する。backpatch 不要。
  tmpfs は append で足りる。コード量は今とほぼ同じだが state が激減。
  - 利点: tmpfs 拡張不要。今の pass 構造をほぼ維持。
  - 欠点: 入力を 2 回読む必要がある (5a が前提)。

**推奨**: まず (II) を実装して 80 KB を達成する。tmpfs が pwrite を
サポートしたタイミングで (I) に切り替えて 1 パスに寄せる。 (I) は
assembler/linker 分離とも整合するが、工数がかさむ。

#### 内部テーブルも縮める

- `g_lab_names` 262144 → 8192 (動的成長、初期 4 KB から)
- `g_labels` 16384 → 1024 (十分、動的成長)
- `g_line_section` / `g_line_offs` / `g_line_lens` → 廃止 (g_lines を
  捨てるので per-line 追跡は pass 2 の stream 中にその場で計算する)
- `g_numlab` 40 KB → 1024 entries (10 digits × 64 entries、動的) =
  2.5 KB

#### 見積もり (pass 2 中の peak)

- 動的 labels: 1024 × 20 B = 20 KB
- lab_names packed: 16 KB
- g_numlab: 4 KB
- 現在の 1 行バッファ + tok: 8 KB
- **合計 ≈ 50〜80 KB**

---

## 横断的に必要な下地 (新規実装)

### T1. 動的成長 U8Array / I32Array

pool allocator の上で `U8Array` / `I32Array` を 2x growth する薄い wrapper
を追加する。現行は固定サイズ一発確保なので、各ステージの strtab / pool を
動的に変えるためにはこれが全部の前提。

- 場所: compiler/runtime.tc か compiler/dyn_array.tc 新設
- API 案: `da_new_u8(initial_cap)`, `da_push_u8(da, b)`, `da_get_u8(da, i)`,
  `da_len(da)`, `da_free(da)` (i32 版も同様)。
- kmalloc/kfree で reallocate (copy + free)。

### T2. 入力の stream 2 回読み

asm.tc 用。案 A (ファイル引数) が小さく済む:

- compile-gen2.sh / sh から見える呼び出し形を `asm FILE > OUT` に変える
- asm.tc の main を `argc/argv` 対応 (既に `fn main(argv: StringArray)`
  経路がある)
- ファイルを openat/read で 2 回開き直すか、lseek(0) で巻き戻す
- 現行 SourceReader が fd を持つ形なので `SourceReader_reset(sr)` を
  足すと軽い

kernel 側:

- **lseek** syscall (a7 = 62, Linux 番号と合わせる) を追加。tmpfs / mtfs
  のドライバに `seek(fd, off, whence)` を実装。mtfs は inode size 内で
  位置を持つだけで十分。tmpfs も RAM backed なので簡単。
- VFS 層に vfs_seek を通す
- この下地は phase 8 で vfs を拡張するときにも必要なので投資価値あり

### T3. (オプション) tmpfs pwrite / seek 書き込み

asm の (I) 案を採るとき必要。後回し可。

### T4. 新コマンド `sigscan` / `tcheck` の typecheck 分割

- sigscan: 既存 bootstrap `extract_sigs` を自己ホスト化した
  `compiler/extract_sigs.tc` がすでに存在。これをタスク化して mtfs に
  載せるだけでよいか確認 (EXTRA_TASKS に追加)
- tcheck: 既存 typecheck.tc から「AST 全体を pool に貯めて 2 パスする」
  ロジックを「`.th` 事前読み + 関数ごとに stream check」に書き直す。
  出力フォーマット (.tast) は同じ

---

## 実装順序 (独立性高い順)

0. **T1 動的成長配列**: 全員がこれを使うので先。2〜3 日規模。
1. **codegen shrink**: strtab を T1 ベースに差し替え、固定 256 KB を
   32 KB 開始にする。AST pool は既に per-function reset あり。小規模、
   低リスク。これだけで 303 → 60 KB 見込み。
2. **bc2asm per-function emission**: 構造変更だが機能は閉じている。
   関数ごとに instrs をリセットする処理 + label_pcs のリセット + emit。
   1.4 MB → 40 KB のジャンプが一番インパクト大きい。
3. **typecheck 分割 (T4)**:  先に sigscan を別バイナリとして動かし、
   tcheck 側を差し替える。pipeline script (compile-gen2.sh / sh) も
   更新が要る。stage 増えて中間ファイルも増えるが、kernel 側の
   `make test` は同じシェル経由で動くはず。
4. **asm stream 2 パス (T2 + 5a)**: lseek syscall + argv 化 + g_lines /
   g_code 廃止。kernel 側の VFS 拡張が入るので段階的に。asm だけで
   9.5 MB → 80 KB。最大の効果。
5. **(後回し) asm 1 パス + backpatch (T3 + 5b-I)**: pwrite 対応で更に
   軽くできるが、(4) の時点で目標達成なら無理に進めない。
6. **(後回し) assembler / linker 完全分離**: problem.md #7 long term。
   ここまで来てからで遅くない。

各ステップでの測定:

- 既存の `km_dump_peak` が exit 時に peak を stderr に出すので、
  毎ステップ `tests/test_phase7.sh` を回せば回帰・改善がそのまま見える。
- 各ステップをコミット単位にして「X KB → Y KB」を commit message に
  記録する。

---

## リスクと未解決

- **T1 動的成長配列** が kmalloc/kfree 依存で、growth のたびに
  コピーが発生する。成長頻度が多いステージ (codegen strtab?) で
  peak メモリが一瞬 2x に膨らむ点に注意。予約容量をドライランで
  見て初期 cap を調整する。
- **typecheck 分割** で既存 `make test` が通るか要確認。Gen1 パイプ
  ラインは typecheck を 1 プロセスで実行しているので、Gen1 側は
  変えない。Gen2/Gen3 パイプラインだけ sigscan + tcheck の 2 プロセス
  にする。compile-gen2.sh の変更。
- **lseek syscall** は Linux 番号 62 (`lseek`)。既存 syscall 番号
  (64/63/56/57/93/220/221/260) にぶつからないので OK。
- **1 パス streaming の夢**: asm を 1 パス化するためには tmpfs の pwrite
  が必須。tmpfs.tc はすでに kmalloc backed / grow-on-write なので、offset
  指定の書き込みは数十行で足りるはず。T3 の工数は小さいが、まずは
  (II) で目標達成してからで良い。
- **bc2asm per-function**: `.rodata` に置く string literal を **関数を
  またいで収集** する部分だけモジュールワイドの状態が残る。これは現在の
  `string_lits: I32Array(512)` を動的成長させて残す。index 値 (= literal
  番号) は関数境界を越えて単調増加なので、per-function emit でも
  問題ない。

---

## 目標達成後

pico2 (256 KB) で全ステージが走るようになれば、**phase 2.5 (pico2 セルフ
ホスト)** がほぼ手に入る。実際に動かすには K3 (per-task サイズ宣言) で
各コンパイラタスクに適切な task RAM を配る必要がある。K3 と本計画は
同時進行できる独立作業。

また、bc2asm / asm を per-function に再構成した結果、**phase 7 M7
(OS 上で Gen2 → Gen3 一周)** も速度・メモリ両面で現実的になる。
