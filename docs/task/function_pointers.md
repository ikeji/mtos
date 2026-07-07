# 間接呼び出し (関数ポインタ) — 確定設計 (2026-07-08)

## 結論: 完全ライブラリ方式 — コンパイラ変更ゼロ

言語には一切手を入れない。既存パターン「body-less fn 宣言 + asm 実体」
(peek/poke と同じ) だけで組む:

1. **`callN`** — 間接呼び出しトランポリン (asm)
2. **`fs_ops_init`** — vtable を `la` で埋める初期化関数 (asm)。
   mangled 名はこの asm 1 箇所に集約
3. **typed ラッパ** — キャストを隠す薄い TC 関数 (操作ごとに 1 本)

```tc
// TC 側 (vfs.tc): body-less 宣言
fn call3(f: u32, a: u32, b: u32, c: u32) -> u32;
fn fs_ops_init(read_tab: u32, write_tab: u32 /*, ...*/) -> void;

// vtable (fs_type で index)
var g_fs_read: U32Array = 0 as U32Array;

// vfs_init で asm に埋めてもらう (+4 = U8Array/U32Array の count header skip)
fs_ops_init(g_fs_read as u32 + 4u32, g_fs_write as u32 + 4u32);

// typed ラッパ (キャストをここに集約)
fn fs_read_via(f: u32, inner: i32, buf: u32, n: i32) -> i32 {
    return call3(f, inner as u32, buf, n as u32) as i32;
}

// ディスパッチ (旧 if チェーン 6 本 → 各 1 行 + null ガード)
export fn vfs_read(fd: i32, buf_addr: u32, n: i32) -> i32 {
    // ... fd 検証 ...
    var f: u32 = get(g_fs_read, fs_type(e));
    if f == 0u32 { return -1; }   // 未対応 FS (旧フォールスルーと同義)
    return fs_read_via(f, inner(e), buf_addr, n);
}
```

```asm
# asm 側 (kernel は trap_common.s、userland が使うなら task_crt0.s)

# callN(f, a1..aN) — 引数を 1 つ下にシフトして tail-call。
# 呼び先の ret が callN の呼び出し元へ直接戻る。フレーム無し。
    .globl call3__u32__u32__u32__u32
call3__u32__u32__u32__u32:
    mv   t0, a0
    mv   a0, a1
    mv   a1, a2
    mv   a2, a3
    jr   t0
# call0..call4 を同型で用意

# fs vtable 初期化 — mangled 名はここだけに書く。
# la は PC/gp 相対なので PIC / XIP で正しい実行時アドレスになる。
    .globl fs_ops_init__u32__u32
fs_ops_init__u32__u32:           # (read_tab_data, write_tab_data, ...)
    la   t0, mtfs_read__i32__u32__i32
    sw   t0, 4(a0)               # read_tab[FS_MTFS]   (FS_MTFS=1, *4)
    la   t0, tmpfs_read__i32__u32__i32
    sw   t0, 8(a0)               # read_tab[FS_TMPFS]  (FS_TMPFS=2)
    # ... 各 FS × 各操作
    ret
```

## この形にした理由 (決定の経緯)

検討順に:

1. **フル関数ポインタ型** (`fn(T)->R` + `&` + 間接呼び出し構文):
   デリファレンスを持たない言語に関数だけポインタ型を足すのは不整合、
   全段改修で最重量。却下。
2. **関数名 decay** (裸名 = アドレスの小規則): overload 曖昧性の解決
   ロジックが tcheck に要る + 「呼び忘れ (括弧なし) が silent に u32 で
   通る」footgun。却下。
3. **union of structs / enum+match** (ディスパッチの言語化): 網羅
   チェックは魅力だが union は値表現+呼び出し規約の改修が最重量、
   enum+match は「FS 追加 1 箇所」にならない。fs には過剰。保留。
4. **`_addr`/`_call` 自動合成**: 型検査付き間接呼び出しが得られるが、
   シグネチャ命名は手書きラッパと等価 → ラッパを書く前提なら合成の
   価値が薄い。却下。
5. **`fnaddr("mangled")` builtin**: コンパイラ変更は小さい (~3 ツール
   × 2 gen) が、ゼロではない。
6. **`.word` テーブル (旧 V2)**: PIC のため `.word symbol` はコード
   先頭からのオフセットしか埋められず実行時アドレスにならない。
   **致命的欠陥で却下** (la = PC 相対だけが実行時アドレスを作れる)。
7. **実行時シンボルテーブル** (build 時に .lab から生成 + 実行時検索):
   真の汎用 fnaddr になるが、build ステップ追加・dead-strip 破壊・
   実行時コスト。過剰で却下。
8. **→ 採用: la で埋める asm 初期化関数** (本設計)。コンパイラ変更
   ゼロで、6 の罠を回避し、5 と同じ「typo はリンク時 undefined label
   で loud に失敗」という性質を持つ。

fnaddr builtin (5) との比較:

| | fnaddr builtin | 本設計 (asm fill) |
|---|---|---|
| コンパイラ変更 | 小 | **ゼロ** |
| mangled 名の置き場 | TC ソース | .s 1 箇所に集約 |
| typo 検出 | リンク時 loud | リンク時 loud (同じ) |
| 新 vtable 追加 | TC のみ | asm 編集が要る |

将来 fnaddr が欲しくなったら「asm の la 行を TC の fnaddr(...) に
書き換える」だけで移行できるので、まずコンパイラ無傷で始める。

## 設計の要点

- **callN は unsafe プリミティブ** (任意アドレス・引数個数無検査)。
  peek/poke と同格。直接使用は typed ラッパ内に限る規約。
- **call0..call4** を用意 (fs は f + 3 引数が最大)。必要時に call5+。
- **テーブルは U32Array**、fs_type で index。埋まっていない
  エントリ = 0 → ディスパッチ前に 0 ガードで -1 (現 if チェーンの
  フォールスルーと同じ意味論)。
- **asm の置き場所**: kernel は `kernel/src/trap_common.s` に追記
  (peek/poke の隣)。**新規 .s ファイルを作らない**こと — kernel の
  link 入力が増えると self_replicate manifest / fixtures / INPUT_NAMES
  の追従 (K20/#40 型の作業) が発生する。trap_common.s 内なら不変。
  userland で使う日が来たら `compiler/runtime/mtos/task_crt0.s` に同じ
  callN を足す (fs_ops_init は kernel 専用)。
- **dead-strip**: `la NAME` の operand は asm_pass1 の参照スキャンに
  乗るので、fs_ops_init が参照する関数は自動的に live。逆に
  fs_ops_init 自身が dead なら (呼ばれなければ) テーブルごと strip
  され、参照先も解放される — 正しい挙動。
- **マングル規則の参照** (asm に書くとき): `基底名` + `__型` × 引数
  (戻り値含まず)、0 引数は裸名。
  例: `fn mtfs_read(fd: i32, buf: u32, n: i32) -> i32`
  → `mtfs_read__i32__u32__i32`。
- **fatfs の write 後 sync** (`fat_block_sync`) のような FS 固有の
  後処理は、テーブルに入れず vfs 側に残す (現状の特別扱いを維持)。

## 実装フェーズ

- **Phase 1: 部品** — trap_common.s に call0..call4 + fs_ops_init、
  vfs.tc (または kernel_common.tc) に body-less 宣言。qemu virt で
  動く単体確認 (test_os.sh が通ること)。
- **Phase 2: fs vtable 化** — vfs.tc の `if t == FS_*` チェーン
  (read / write / size / seek / close / xip の 6 本) をテーブル +
  typed ラッパに置換。
  - 検証: `make -C kernel test` (fs_virtio が全 FS の read/write/
    redirect/close を叩く)、`make test` 全 green。
  - **pico2 self-replicate byte-exact 再確認** (trap_common.s と
    vfs.tc は self-replicate 集合内なので必須)。
- 追って: 他の間接呼び出し候補 (devfs バックエンド、procfs synth
  テーブル) への展開は fs で様子を見てから。

## リスク

- mangled 名の asm 手書き: シグネチャ変更・typo はリンク時
  undefined label で **loud に失敗** (silent 化しない)。Phase 1 で
  わざと typo したビルドが失敗することを確認しておく。
- fs_ops_init のテーブルレイアウト (index = FS_* 値) が TC 側の
  定数と暗黙結合: コメントで両方向に相互参照を書く。
- kernel バイナリが変わるので self-replicate 実機再確認 (~1 時間)。

## 将来の拡張メモ (今はやらない)

- **インライン asm (asm 関数)** `fn callN(...) -> u32 asm { ... }`:
  入れば callN/fs_ops_init の mangled ラベル手書きと 2 ファイル
  メンテが消え、sd_spi_xfer 等の hot path asm 化にも使える。
  improvements リストの独立項目として検討。
- **fnaddr builtin**: vtable が fs 以外に増えて asm 編集が煩雑に
  なったら、la 行を TC に移すだけの後方互換な移行が可能。
- **enum + match (網羅チェック)**: FS 追加時の入れ忘れをコンパイル
  エラーにしたくなったら、こちらは別機能として検討。
