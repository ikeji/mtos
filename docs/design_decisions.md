# 設計判断メモ

コードを読むと「これはバグでは?」と誤解されがちな挙動のうち、
**意図して選んでいる** 設計判断を集めたファイル。修正提案 PR を出す前に
ここを読む。

各項目の構成:
- **判断**: 何をそう決めたか (1–2 行)
- **なぜ**: 何の制約 / 利点のために選んだか
- **使い方**: 新しいコードを書くときにどう当てはめるか
- **関連ドキュメント**: 深い議論があればリンク

---

## 1. struct の合成 fn は import 側から見えない (プライベートフィールド機構)

### 判断

`struct Point { x: i32, y: i32 }` を書くと parser が自動生成する
`Point(...)` コンストラクタ / `x(p)` getter / `set_x(p, v)` setter /
`delete(p)` / `PointArray` / `get(PointArray, i)` 等の合成 fn は
**定義ファイル内でのみ呼べる**。import 側からは struct 型名しか見えない。

### なぜ

TC はフィールドの public/private を表す文法を持たない。
代わりに「合成 fn を module-private にする」ことで、import 側からは
struct を **opaque handle** として扱わせ、アクセスは必ず明示的に
export された wrapper 関数を経由させる。

- フィールドの追加・表現変更が lib 側で完結する (import 側の
  コードに影響しない)
- 不変条件 (e.g. 「fd は正の整数」) を破るアクセスを wrapper で
  防げる
- `delete` 忘れや二重 delete を wrapper レベルでガードできる

### 使い方

新しい共通モジュールを書くときは:

```tc
// lib.tc
export struct Point { x: i32, y: i32 }

// 外に出したい操作だけ wrapper で export する
export fn make_point(x: i32, y: i32) -> Point { return Point(x, y); }
export fn point_x(p: Point) -> i32 { return x(p); }
export fn point_y(p: Point) -> i32 { return y(p); }
export fn point_delete(p: Point) -> void { delete(p); return; }
```

```tc
// main.tc
import "lib.tc";

fn main() -> i32 {
    var p: Point = make_point(3, 4);   // OK
    // var q: Point = Point(3, 4);     // ❌ 合成 fn は呼べない
    // var x: i32 = x(p);              // ❌ 同上
    var vx: i32 = point_x(p);          // OK
    point_delete(p);
    return vx;
}
```

**やってはいけないこと**: extract_sigs を拡張して合成 fn を .th に
載せる提案は却下される。それをやると ADT 境界が壊れる。「wrapper が
煩わしいから省きたい」は動機として不十分で、wrapper の存在自体が
API boundary の表明として重要。

### 関連ドキュメント

- `docs/language.md` の「struct のプライベートフィールド」節
- `docs/task/multi_file.md` (import の全体挙動)

---

## 2. `String` と `StringLiteral` は別の型

### 判断

文字列は 2 種類の別型で扱う:

| 型名 | 表現 | 生成元 | delete |
|------|------|--------|--------|
| `StringLiteral` | .rodata 上の静的 HeapObj | `push_str`（文字列リテラル） | no-op |
| `String` | ヒープ上の HeapObj | `append` で構築 | ヒープを free |

両者の間に暗黙変換はない。文字列を受ける関数は `String` 版と
`StringLiteral` 版を両方書く必要があるケースがある。

### なぜ

以前は `is_literal: bool` フィールドで区別していたが、

- HeapObj に 4 バイトのフラグを持たせる必要があった
- `delete(s)` が実行時に分岐して literal のみ no-op するため、
  実装ミスで rodata 領域を free しようとするバグを生みやすかった

型レベルで分ければ:
- `delete(StringLiteral)` は型システム上で「常に no-op」と決まり
  (コード上は存在するが何もしない)、rodata free バグが構造的に
  起きない
- HeapObj から is_literal フィールドが消えて 16B → 12B に縮む
- 「この関数は literal しか受け取らない」「heap 専用」を
  シグネチャで表現できる

### 使い方

- 単純なケース: `StringLiteral` 専用 (e.g. `puts(s: StringLiteral)`)
  や `String` 専用 (append の結果を操作する類) で 1 版だけ書く
- 両方受けたいケース: 明示的にオーバーロードを 2 つ書く
- 引数が 2 つ以上で組み合わせ爆発が気になる場合: `StringOrStringLiteral`
  のような共用ラッパ型を作って受ける (現状まだ実装されていない;
  必要になった時点で設計する)

### 関連ドキュメント

- `docs/task/string_type_split.md` (型分離の詳細設計)

---

## 3. `peek*` / `poke*` は境界チェックしない (raw アドレス専用)

### 判断

`peek8` / `peek16` / `peek32` / `poke8` / `poke16` / `poke32` は
u32 の raw アドレスを第 1 引数に取り、**境界チェックを一切しない**。
`trap_common.s` / `crt0_tc.s` で `.globl` の asm 関数として
`lbu a0, 0(a0); ret` のように 1〜2 命令で定義されている。

対比: `get(U8Array, i) / set(U8Array, i, v)` は U8Array の count
前置フィールドを参照して境界チェックを行う (set 側のみ実装済、#6 参照)。
つまり **安全版 (get/set) と危険版 (peek/poke) の 2 階層** があり、
それぞれ別用途に使い分ける。

### なぜ

peek / poke は以下の用途で、そもそも「境界」が適用できない領域に
アクセスする:

- **MMIO**: `poke32(0x02004000, ...)` で CLINT mtimecmp、`poke32(0x10000000, ...)` で 16550 UART、`poke32(0x10001000, ...)` で virtio-blk MMIO。相手は RAM ではなくデバイスで、count 付き HeapObj として表現できない
- **カーネル BSS 初期化**: `__runtime_init` が `g_bucket_base` 直後のアリーナを `poke32` でゼロ化する
- **タスクフレーム構築**: `init_task_frame` が 132 バイトのトラップフレームに sp/gp/entry を書き込む
- **virtio queue 操作**: desc / avail / used ring を PFN 越しに直接叩く (block_virtio.tc)
- **SRAM への手動書き込み**: Pico 2 の `_mtfs_image_addr` を XIP flash 越しに参照するとき等

これらはいずれも「カーネル / ドライバ / crt0 の下回り」で、安全な
`U8Array` 抽象が届かない層。低レベル経路が無いと実装自体が書けない。

### 使い方

- **peek/poke は kernel / driver / crt0 コードからのみ呼ぶ**。ユーザ
  アプリの .tc から呼ぶべきではない (MMIO / 絶対アドレスを扱う必然性が
  無いはず)
- メモリアクセスしたいだけなら `U8Array` 経由で `get` / `set` を使う
- 迷ったら U8Array を使う方を優先。アドレス演算を 1 文字間違えるだけで
  arena / stack / trap frame を壊せる
- 将来的に peek/poke を bc2asm で intrinsic として直接 `lbu/sb` に
  展開する計画あり (#20) — 当然境界チェックは追加しない

### 関連

- `problem.md #6` (U8Array 側の境界チェック状況)
- `problem.md #20` (peek/poke の関数呼び出しオーバーヘッド)

---

## 追加のガイドライン

ここに載る判断は以下の性質のもの:

- コードから直感的に読み取れない (「なぜ wrapper 書くの?」)
- 安全性や保守性のために **意図して摩擦を残している** 部分
- 修正候補として定期的に問題に挙がるが、直してはいけないもの

単なるコーディング規約 (命名、フォーマットなど) はここではなく
`docs/language.md` / `CLAUDE.md` に書く。

未解決の問題 (本当のバグ、今後直したい limitation) は
`docs/problem.md` に書く。
