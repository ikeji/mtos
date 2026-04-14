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

## 追加のガイドライン

ここに載る判断は以下の性質のもの:

- コードから直感的に読み取れない (「なぜ wrapper 書くの?」)
- 安全性や保守性のために **意図して摩擦を残している** 部分
- 修正候補として定期的に問題に挙がるが、直してはいけないもの

単なるコーディング規約 (命名、フォーマットなど) はここではなく
`docs/language.md` / `CLAUDE.md` に書く。

未解決の問題 (本当のバグ、今後直したい limitation) は
`docs/problem.md` に書く。
