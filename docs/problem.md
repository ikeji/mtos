# 処理系の既知の問題

このプロジェクトの TC コンパイラ・ツールチェーンで見つかっているが
まだ直していない / 設計判断で後回しにしている問題のリスト。

凡例:
- **bug**: 明確な不具合。正しい挙動に直す必要あり。
- **limitation**: 言語 / ツールの設計上の制限。ワークアラウンドあり。
- **ergonomics**: 動作は正しいが書きにくい / デバッグしにくい。

---

## 言語 / コンパイラ本体

### 1. u32 の `<` `<=` `>` `>=` が signed 比較になっている可能性 (bug)

`>>` が u32 でも `sra` になっていた問題（`shr_u` opcode を追加して修正済み）と
同じ構造で、比較演算子も signed 版 (`slt` / `slti`) を出している可能性が高い。

影響:
- `u32` 値で top bit が立っているときに `<` の結果が誤る。
- `if addr >= 0x80000000u32 { ... }` のようなコードが壊れる。

対処案:
- バイトコードに `lt_u`/`le_u`/`gt_u`/`ge_u` を追加し、型情報を見て
  分岐する（`shr_u` 追加と同じパターン）。
- それまでは `(x >> 1u32) & 0x7FFFFFFFu32` などで top bit を避ける。

### 2. u32 の `/` と `%` が signed 除算になっている (bug)

bc2asm が `div` / `mod` をそのまま `div t0, t0, t1` / `rem` に展開する。
これは RISC-V の signed 除算命令なので、u32 で top bit が立つ値だと誤る。

影響は比較的小さい (アドレス除算は `>> N` でやることが多い) が、
完全に修正するには `div_u` / `mod_u` opcode を追加する必要がある。

### 3. 暗黙の int → u32 変換がない (ergonomics)

`U8Array(256)` と書くと i32→u32 のミスマッチで overload 解決に失敗する。
配列コンストラクタが u32 になったため、リテラルは `256u32`、
変数は `(n) as u32` と毎回書かないといけない。

対処案:
- 整数リテラルが型推論時に文脈を見て型を決める (大きな言語変更)。
- 非負の整数リテラルは自動的に符号なし型へ代入可能にする。

### 4. Import 先の struct の auto-generated fn が呼べない (limitation)

`import "lib.tc";` で `struct Point` を取り込むと型名としては使えるが、
`Point(3, 4)` / `x(p)` / `delete(p)` などの synthetic fn は import 側から
呼べない。struct array (`PointArray` / `get(PointArray, i)` 等) も同様。

ワークアラウンド:
- import 先で `export fn make_point(x: i32, y: i32) -> Point { ... }` の
  ような wrapper を定義して露出する。

詳細: `docs/task/multi_file.md`。

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

現在 55 秒前後で 60 秒制約 (CLAUDE.md) を満たしている。qemu ベースの
テストがこれ以上増えると制約を超える可能性がある。

対処案:
- 並列実行 (現状逐次)。
- 遅いテストを `make full-test` 側に移す。

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
- struct 定義の trailing comma が通らなかった (parser) → 修正 (b04855c)
- 関数宣言 / 関数呼び出しの trailing comma → 修正 (b04855c)
- struct array が asm リンカで未定義シンボル → parser で synthetic fn
  を生成して修正 (b04855c)
- 配列コンストラクタの size が i32 だった → u32 に変更 (b04855c)
- Gen2 typecheck が struct array 型を知らなかった → 対症療法として
  typecheck.tc に register_struct_array を足したが、最終的には synthetic
  fn で置換 (b04855c)
