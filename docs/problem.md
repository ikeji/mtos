# 処理系の既知の問題

このプロジェクトの TC コンパイラ・ツールチェーンで見つかっているが
まだ直していない / 設計判断で後回しにしている問題のリスト。

凡例:
- **bug**: 明確な不具合。正しい挙動に直す必要あり。
- **limitation**: 言語 / ツールの設計上の制限。ワークアラウンドあり。
- **ergonomics**: 動作は正しいが書きにくい / デバッグしにくい。

---

## 言語 / コンパイラ本体

### 3. 暗黙の int → u32 変換がない (ergonomics)

`U8Array(256)` と書くと i32→u32 のミスマッチで overload 解決に失敗する。
配列コンストラクタが u32 になったため、リテラルは `256u32`、
変数は `(n) as u32` と毎回書かないといけない。

対処案:
- 整数リテラルが型推論時に文脈を見て型を決める (大きな言語変更)。
- 非負の整数リテラルは自動的に符号なし型へ代入可能にする。

### 5. Gen2 typecheck のエラーメッセージが `Type error` だけ (ergonomics)

compiler/typecheck.tc が失敗すると行番号も何も出ない。Gen1 の
bootstrap/typecheck.c は `file:line: message` を出すので、Gen2 との
比較で最初に試すといい。

対処案:
- typecheck.tc に行番号トラッキング + エラーメッセージを追加。

### 6. Gen2 codegen のエラーメッセージが `get: out of bounds` のみ (ergonomics)

配列アクセス境界エラーが出ると場所がわからない。実は
コンパイラ自身のバグを示唆していることが多い (例: 今回の Gen2 キャッシュ
stale 問題の初期症状)。

対処案:
- codegen.tc 側の境界チェックに文脈情報を足す。

---

## asm.tc (アセンブラ兼リンカ)

### 7. `.macro` / `.endm` 未対応 (limitation)

アセンブラマクロが使えないため、trap_common.s のように
ecall ハンドラを書くときに prologue/epilogue をコピペすることになる。
一箇所直すと全部直す必要がある。

### 8. `.align 12` 未対応 (limitation)

16 バイト境界 (`.align 4`) までしか扱えない。virtio-legacy の queue
のように 4KB 境界が必要な場合は、TC 側で手動マスクしてアラインを
確保する必要がある (block_virtio.tc の `g_mem_base` 参照)。

### 9. エラーメッセージが `asm: unknown instruction 'xxx'` だけ (ergonomics)

行番号が出ない。入力行は連結された .s ファイルで、grep する手がかりが
ほぼ命令名だけになる。

### 10. struct array 呼び出しが mangle 名で未解決 (FIXED)

歴史的経緯メモ: `set__FooArray__i32__Foo` のような mangle 名に対して
実装が存在せず、リンカ未定義エラーになっていた。parser で synthetic
fn を生成することで修正済み。

---

## カーネル / OS

### K1. `load_task` / `sys_exec_handler` は task 画像を一切 free しない (limitation)

`kernel/loader.tc` の slow path (virtio-blk) は mtfs から読み込んだ
binary を kmalloc バッファに置いたまま回収しない。XIP fast path は
flash 上のアドレスを直接使うので問題ないが、slow path では task が
exit してもバッファがリークする。

影響:
- virt の fs_virtio テストでは最終的にカーネルが all tasks done で
  停止するので実害なし。
- シェルで何度もコマンドを spawn する (step 6.5 以降) とアリーナを
  徐々に消費する。現在の arena サイズ (virt 4.6MB / pico2 256KB) で
  は short-run なら耐えるが、長時間動作は不可。

対処案:
- プロセステーブルを導入し、task exit 時に `kfree` で RAM / stack /
  binary バッファを回収する。
- XIP fast path に寄せる (Pico 2 では既に達成)。

### K2. スケジューラの最大スロット数がハードコード (limitation)

`kernel_common.tc` の `sched_init(max)` が `max` 個のスロットを確保し、
`sched_spawn` はその中から unused / done スロットを再利用する。
`max` を超える同時タスクは spawn できない (spawn が -1 を返す)。
現状 virt / pico2 とも `sched_init(8)` で 8 並列が上限。

対処案:
- スロット数を動的に増やす (U32Array の再割り当て)。
- done スロットを積極的にリサイクル (既に実装済み)。

### K3. タスクのスタック / arena サイズがハードコード (limitation)

`make_task(entry, ram_size, stack_size)` の呼び出し側でサイズを指定
するが、virt は 65536/65536、pico2 は 16384/8192、sys_exec_handler
は 16384/8192 とバラバラ。統一した "task size policy" がない。

対処案:
- ELF ヘッダで必要な BSS サイズを宣言する (現在 raw bin なのでヘッダ
  なし)。
- kmalloc ベースのタスクであれば最低限のサイズ (4KB?) で済むように
  するか、タスクの crt0 が自分の必要量を宣言する仕組みを入れる。

### K4. `do_uart_read` が無限ループで EOF を検出できない (limitation)

`kernel/platform_virt.s` / `kernel/platform_pico2.s` の
`do_uart_read` は LSR Data Ready ビットを busy-loop で待つだけで、
stdin が閉じた (EOF) 状態を区別できない。

影響:
- qemu 側でパイプ入力が尽きた後に sys_read(0, ...) すると、永久に
  ブロックする。
- `/bin/sh` をループ化する場合、EOF で抜けられず "quit" コマンドなど
  明示的な終了手段が必要。

対処案:
- UART ドライバに "non-blocking read" / "peek" を追加。
- qemu のシリアル終了条件を使う (但し実機との挙動差が出る)。

## バイトコード / ランタイム

### 11. bcrun.tc の `shr_u` 実装が手動マスク (limitation)

TC 側の `>>` が常に arithmetic shift なので、bcrun.tc で `shr_u` を
実装するときに 1 ビットずらして `& 0x7FFFFFFF` する trick を使っている。
コンパイラ自身に u32 用の論理シフト命令がないと綺麗に書けない
(循環依存)。

### 12. `poke8` / `poke16` / `poke32` は境界チェックなし (by design)

`set(U8Array, i, v)` は範囲チェックするが、raw アドレスへの poke は
しない。これは意図的 (MMIO とカーネル用) だが、ユーザコードで使う
と簡単にメモリを壊せる。

### 13. Compiler bug: struct 定義時にも auto-generated array の size が u32 ハードコード

struct を宣言すると `XxxArray(__n: u32) -> XxxArray` が parser で生成
されるが、現状 `u32` 固定になっている。将来配列サイズを `i32` に
戻したい場合は parser を直す必要がある。

---

## ビルド / テスト

### 14. `compile-gen2.sh` が stderr を `2>/dev/null` で潰している (ergonomics)

中の `typecheck`/`codegen`/`bc2asm`/`asm` が失敗してもエラーが見えない。
デバッグするときは毎回、同じパイプラインを手で組み直してエラーを
出している (`TMP=$(mktemp -d); ./parse ... | ...` を手書き)。

対処案:
- エラーの時だけ表示するラッパを挟む。
- `-v` / `VERBOSE=1` で stderr を残すオプション。

### 15. `/tmp/gen2` キャッシュが stale になる (ergonomics)

手動で `/tmp/gen2` に Gen2 ツールを置いて開発していると、compiler/*.tc
を変更したときに古い Gen2 が使われて意味不明なエラー (`get: out of
bounds`) を食らう。`make test` の中では毎回 fresh ビルドするので OK。

対処案:
- `compile-gen2.sh` に `GEN2_REBUILD=1` のようなフラグを追加。
- Gen2 ツールのビルド時刻を compiler/*.tc の最新 mtime と比較して
  警告を出す。

### 16. Gen2 ツールの再ビルドが遅い (ergonomics)

`compile-gen1.sh` で 7 本 (parse/typecheck/codegen/bc2asm/bcrun/asm/
extract_sigs) を順次ビルドすると 15 秒以上かかる。インクリメンタル
ビルドはしていない。

対処案:
- ツール単位でタイムスタンプ比較してスキップ。
- make ベースのビルドに移行。

### 17. `make test` の実行時間が 60 秒上限にぎりぎり (ergonomics)

現在 58 秒前後で 60 秒制約 (CLAUDE.md) を満たしている。qemu ベースの
テストがこれ以上増えると制約を超える可能性がある。フェーズ6 で
/bin/sh を追加したときも 60.3 秒まで伸び、`kernel/build.sh` の TASKS
リストを target 別に切ることで 58 秒台に戻した経緯がある。

対処案:
- 並列実行 (現状逐次)。
- 遅いテストを `make full-test` 側に移す。
- kernel タスクの qemu コンパイルがボトルネックなので、ビルドキャッシュ
  導入を検討 (同じ .tc で同じ Gen2 なら前回の .bin を再利用)。

---

## 言語仕様で未確定 / 揺れているもの

### 18. 構造体フィールドに `StringLiteral` 型を書けるか (open)

`docs/filesystem.md` のデザインで `struct Mount { prefix: StringLiteral, ... }`
と書いたが、まだ実際に使っていないので検証してない。

### 19. ネストしたジェネリック配列 (`MtfsFDArrayArray` など) (open)

`struct Foo { ... }` は `FooArray` を自動生成するが、`FooArrayArray` は
生成しない (= 二次元配列はできない)。現状ニーズがないが、将来の
ことを考えるとどこかで線引きが必要。

---

## 参考: すでに直した問題

履歴として残す。コミットメッセージを見れば詳細がわかる。

- `u32 >> n` が arithmetic shift だった → `shr_u` opcode 追加 (9ff97b5)
- `u32 < u32` (`<=`, `>`, `>=`) が signed 比較になっていた → `lt_u` /
  `le_u` / `gt_u` / `ge_u` opcode 追加 + codegen で LHS 型を見て分岐。
  合わせて `string_buffer.emit_int` が INT32_MIN を出力できなかった
  バグも修正
- `u32 / u32` / `u32 % u32` が signed 除算になっていた → `div_u` /
  `mod_u` opcode 追加。bc2asm は `divu` / `remu` を emit。asm.tc にも
  `divu` / `remu` エンコーディングを追加。bcrun.tc 側はバイナリ長除算
  で software 実装
- 16 進リテラル `0xFFFFFFFF` 等で top bit 以上が壊れる → compiler/parse.tc
  の hex/binary 累積を `<<` + `|` に変更して bit パターンを保存。
  合わせて bootstrap の ast/codegen を `printf %d (int32_t)` に揃え
  (Gen1 と Gen2 の AST テキストを一致させる)、interp.c の `>>` も
  u32 なら論理シフトするように修正。typecheck.tc の int literal 読み
  取りが先頭 `-` を受け付けていなかったバグも修正 (negative 値が 0 扱い
  だった)
- struct 定義の trailing comma が通らなかった (parser) → 修正 (b04855c)
- 関数宣言 / 関数呼び出しの trailing comma → 修正 (b04855c)
- struct array が asm リンカで未定義シンボル → parser で synthetic fn
  を生成して修正 (b04855c)
- 配列コンストラクタの size が i32 だった → u32 に変更 (b04855c)
- Gen2 typecheck が struct array 型を知らなかった → 対症療法として
  typecheck.tc に register_struct_array を足したが、最終的には synthetic
  fn で置換 (b04855c)
- runtime.tc の pool アロケータが固定バケット + 先頭追加しかできず
  カーネルで任意サイズの task RAM を確保できなかった → kmalloc/kfree
  (free-list + 10 bucket) に置き換え (d889401)
- kernel が bin2s で .rodata にタスクを埋め込んでいたので /bin/* という
  概念がなかった → mtfs + `loader.tc` + `vfs_xip_addr` で FS からロード
  するフローに差し替え (フェーズ6 Step 6.2 / 6.3、bb5ad5c / 4d082c3 /
  6955d8b)
- スケジューラが固定スロットで 1 度 done したら再利用不可だった →
  state 4 種 + sched_spawn / sched_wait を追加してプロセス管理の土台を
  作り、sh をループ化できるようにした (フェーズ6 Step 6.5)
