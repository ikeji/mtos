# フェーズ7: OS 上でコンパイラを動かす

ゴール: 自作カーネル (qemu virt もしくは Pico 2) の上で `parse` /
`typecheck` / `codegen` / `bc2asm` を実行し、`.tc` ソースから `.s` を
生成できるようにする。最終的には自己ホストループ (OS 上の Gen2 で
Gen3 を再ビルド) まで持っていきたい。

現状 (2026-04-14): カーネルは mtfs (read-only) から `/bin/*` をロード
して実行できる。タスクは `make_task` で 16K RAM / 8K stack を割り当て、
`sh` が `sys_spawn` + `sys_wait` で子プロセスを走らせる。`sys_exec` で
子プロセスがバイナリを差し替えられる。ここまでがフェーズ6で完成済。

以下の 5-6 個の前提機能が揃って初めて、コンパイラをそのまま OS 上で
動かせる。

---

## 準備項目と実装順

推奨順序: B → A+D → E → C-1 → (C-2)。F (stderr) は D と同時に入れる。

### B. コマンドライン引数 (argc/argv)

**なぜ必要**: `parse foo.tc > /tmp/1.ast` のように入力ファイルを引数で
受けられないと、「stdin = 常にソース」の今の I/O から抜け出せず、
パイプライン化も中間ファイル化もできない。独立に価値があり
(`catfile /hello.txt` のようなコマンドが自然に書ける)、既存機能を
壊さないので最初に着手する。

**設計方針**: **kernel 側で argv を TC の `StringLiteralArray` として
構築してから crt0 に制御を渡す**。crt0 はレジスタ配線のみで、TC データ
構造の組み立てはアセンブリでは一切行わない。`StringLiteralArray` は
`len(arr) -> i32` を持っているので **argc は不要**、main には argv
1 本だけ渡す。

**フロー**:
1. `sh.tc` がコマンド行をスペースでトークナイズし、
   `StringLiteralArray(argc)` を構築。新 ABI で
   `sys_spawn(path, argv_array)` を発行
2. `sys_spawn_handler` (kernel TC, `loader.tc`) が自分の kmalloc で
   **新しい** `StringLiteralArray(len(argv))` を allocate し、親から
   来た argv の内容を kernel 所有のバッファにコピー (親が exit しても
   子から argv が見える状態にする)
3. `make_task` がトラップフレームに `a0 = argv_ptr` を書き込み
4. mret でタスクに飛んだら `task_crt0.s` は a0 をそのまま保存して
   `call main`
5. TC の main は `fn main(argv: StringLiteralArray) -> i32` として
   受ける。長さが要るときは `len(argv)` を呼ぶ

**argv の所有権**:
- argv は kernel の kmalloc で確保されているので、タスクからは kfree
  できない (そもそも別アリーナ)。これは Linux の argv (kernel-supplied
  stack image) と同じ扱い
- `struct Task` に `argv` フィールドを追加し、K1 の per-slot owning
  allocations 機構に乗せる
- `sched_task_exit` / `sched_replace_current` が frame_buf / ram /
  stack / img と同じタイミングで kfree
- `make_task` が呼ばれる経路では `g_last_argv` を記録し、
  `slot_capture_last` が拾う (K1 と同じ流れ)

**事前確認 (実装前チェック)**:
- parser が `StringLiteralArray` を合成するか? `StringLiteral` は
  primitive 型 (struct じゃない) なので、現在の struct synthetic fn
  生成ロジックがトリガされないかもしれない
- **合成されない場合の fallback**: `compiler/runtime.tc` 側に手書きで
  `export fn StringLiteralArray(n: u32) -> StringLiteralArray` を足す。
  内部は U32Array の wrapper で、要素は raw pointer (u32) を保持、
  `get(arr, i) -> StringLiteral` で pointer → StringLiteral 変換を返す
- どちらでも main 側の使用感は変わらない

**kernel と task でのレイアウト一致**:
- kernel も task も同じ `compiler/runtime.tc` を使ってビルドされる
  (compile-gen2.sh 経由) ので、StringLiteralArray / StringLiteral の
  メモリレイアウトは自動的に一致する。心配なし

**実装範囲**:
- `compiler/runtime.tc` — StringLiteralArray を fallback で足す (必要なら)
- `kernel/loader.tc` — sys_spawn_handler / sys_exec_handler の argv 対応
- `kernel/kernel_common.tc` — struct Task に argv フィールド追加、
  make_task / slot_capture_last / slot_free_allocs を拡張
- `kernel/trap_common.s` — sys_spawn / sys_exec 各 handler の引数配線
  (a0=path, a1=argv_ptr)
- `kernel/tasks/task_crt0.s` — main 呼び出し時に a0 を main に渡す
  (現状は a0 を破壊していないか要確認)
- `kernel/tasks/sh/sh.tc` — コマンド行をスペース分割、StringLiteralArray
  を構築、sys_spawn に渡す
- `kernel/tasks/catfile/catfile.tc` — len(argv)>1 なら argv[1] を
  open (現状 hardcode `/hello.txt`)
- `tests/test_os.sh` — `catfile /hello.txt` 引数渡しのシナリオ追加

**検証**:
- `/bin/catfile /hello.txt` のように引数付きで起動し、出力が変わる
  ことを確認
- `sh` から `catfile /hello.txt` と打って同じ結果
- 5× spawn/wait ループで `KERN: live=N` が変わらない (argv leak 検証)

### A. tmpfs (RAM-backed filesystem)

**なぜ必要**: コンパイラの中間出力 `.ast` / `.tast` / `.bc` / `.s` を
置く場所が必要。`mtfs` は read-only なので書けない。

**実装範囲**:
- `kernel/tmpfs.tc` を新設。`/tmp` にマウント
- inode 構造: ファイル名 + データバッファ (`U8Array`) + サイズ。
  ディレクトリはまずフラットで十分 (`/tmp/foo` のみ、サブディレクトリ
  なし)
- kmalloc でデータブロックを動的に拡張 (append で size 越えたら倍増)
- VFS 層 (`vfs.tc`) 側の拡張:
  - `vfs_open` に `flags` 引数を追加 (現状は read-only 固定)。
    `O_CREAT` / `O_WRONLY` / `O_RDWR` / `O_TRUNC` の最小サブセット
  - `vfs_write` に tmpfs 経路を追加 (現状は fd<3 = UART のみ書ける)
  - `sys_openat_handler` (ecall 56) の flags を透過させる
- mount テーブルに /tmp のエントリを追加して前方一致で tmpfs に振る
- 初期化時は空。`/tmp/.keep` のようなダミーを作らなくても OK

**検証**: tmpfs 単体は D と組み合わせないと E2E 検証できないので、
D と同時にテスト (`echo foo > /tmp/a; cat < /tmp/a`)。

### D. リダイレクト (`<` / `>`)

**なぜ必要**: C-1 (中間ファイル経由) でパイプの代わりに
`parse foo.tc > /tmp/1.ast; typecheck < /tmp/1.ast > /tmp/2.tast; ...`
を書くため。sh が子を起こす前に fd 0 / 1 を差し替える必要がある。

**実装範囲**:
- `sh.tc` のコマンドパーサに `<` / `>` のトークン認識を追加
- 子タスクを make する前に、必要なら fd 0 / 1 を tmpfs ファイルに
  差し替え。実装方法:
  - **案 D1**: sh が自分の fd table を子にコピーする前に書き換える。
    fd table は現状プロセスごとだが、タスクあたり 1 枚の fd 配列に
    なっている (vfs.tc の g_fds)。sh が `sys_open("/tmp/out",
    O_WRONLY|O_CREAT)` → その fd 番号を子の fd=1 に代入して渡す
    方式。`dup2` 相当を kernel 側で提供する方が素直
  - **案 D2**: sh がリダイレクト記法を解釈し、child 起動前に
    child の fd table (loader.tc がセットアップ) に手動で注入する
- ひとまず案 D1 (kernel 側 `dup2` syscall を提供) が Linux 互換で楽。
  `sys_dup3` (ecall 24) の最小実装

**検証**:
- `echo hi > /tmp/a` (echo コマンドも必要なので併せて実装)
- `cat < /tmp/a` で "hi" が返る
- `parse /bin/hello.tc > /tmp/hello.ast` が走る

### F. stderr (fd=2) 分離

**なぜ必要**: エラー時のメッセージを stdout に書くとパイプ/リダイレクト
が壊れる。現状は fd<3 全てが UART 固定だが、fd=1 を tmpfs にリダイレクト
したとき fd=2 は UART のまま残してほしい。

**設計方針**: コンパイラ側が **エラー用の StringBuffer `obe` を出力用
の `ob` と並行して持ち回す**。エラー書き込みは関数引数で明示的に obe
に向ける。main が最後に `ob` を fd=1、`obe` を fd=2 に流し込む。

**利点**:
- OS 側に fd=2 の特別扱いを入れる必要がない。Linux ホスト / qemu virt /
  OS 上、どこでも同じ仕組みで動く
- StringBuffer は既存なので `emit_string` / `emit_int` / `emit_nl` が
  そのまま使える
- エラーを途中で貯めて、確定してから flush できる (成功時は discard)
- 最終出力 (`ob`) とエラー (`obe`) が物理的に混ざらない

**実装範囲**:
- `string_buffer.tc` — 特に変更不要 (StringBuffer をもう 1 本増やす
  だけ)
- `compiler/typecheck.tc` — エラー発生箇所 (check_call_site など) の
  関数シグネチャに `obe: StringBuffer` を追加。エラー書き込みは全て
  obe 経由に
- `compiler/asm.tc` — `asm_err_begin` / `asm_err_end` を obe を使う
  形に変更
- `compiler/parse.tc` / `compiler/codegen.tc` / `compiler/bc2asm.tc` —
  エラーを吐く箇所があれば同様に obe 化
- 各ツールの main — 最後に obe の中身を sys_write(2) に流す
- **OS 側は何も変更しない**。fd=2 は sys_write の fd<3 経路で UART に
  流れるだけで十分

**注意**: コンパイラ側だけでなく runtime.tc が `do_write` で直接
sys_write を呼んでいる箇所 (境界エラーメッセージなど) も fd=2 に
変える必要がある (現状は fd=1 または fd=2 のどちらに行っているか
要確認)。

### E. タスクのメモリ量 (K3 残件の解決)

**なぜ必要**: コンパイラは arena に数 MB 使う (typecheck.tc で AST の
プールが 16K * 36B ≈ 600KB、codegen.tc の string_buffer で BC バッファ
数百 KB 等)。現状の 16K / 8K では到底足りない。

**段階的アプローチ**: ヘッダ形式を設計する前に、まず「必要量を測って
から決める」方針で進める。

**E-step1: 計測用に固定で大きくして動かす**
- `kernel.tc` の seeded タスク or `sh` が起動するコンパイラタスクだけ
  一律 **10 MB RAM / 64 KB stack** で確保 (qemu virt なら 128 MB
  あるので余裕)
- 他のタスク (hello / hello2 / catfile / sh) は 16K/8K のまま
- 実装: `make_task` の既存 signature をそのまま使い、コンパイラタスク
  の `load_task` 経路だけサイズを大きくする特例を一時的に追加
  (後で E-step3 で正式なメカニズムに置き換える)

**E-step2: 実使用量を計測**
- `compiler/runtime.tc` には既に `km_dump_stats` があり peak 値を
  出せる
- 各コンパイラツール (parse / typecheck / codegen / bc2asm / asm) の
  main 末尾で `km_dump_stats` を stderr (= obe / fd=2) に出すよう
  一時的に追加
- 代表的な入力 (hello.tc, catfile.tc, kernel_common.tc) でそれぞれ
  実使用量を記録
- 仮説: parse.tc (SourceReader ストリーミング済) と bc2asm.tc
  (R7 で最適化済) は小さい、typecheck.tc (AstNode pool) が最大、
  asm.tc は別格 (9 MB、problem.md #7)

**E-step3: 計測結果に応じて方針決定**
- 全ツールが 1 MB 未満 → ヘッダ不要、一律 2 MB で固定して終了
- ツール間で 10 倍以上の差 → 案 C (先頭 8 バイトヘッダ)
  `[arena_size, stack_size]` を導入
  - 案 C の詳細:
    - `task_crt0.s` 先頭に `.word` 2 個を置く、entry は +8 のラベル
    - `kernel/build.sh` に arena_size / stack_size の指定オプション
      追加
    - `kernel/loader.tc` が先頭 8 バイトを読んで kmalloc サイズを決定

**実装順序**: E-step1 → M4 相当 (コンパイラを 1 段だけ OS 上で動かす)
→ E-step2 (計測) → E-step3 (必要なら)

**検証**:
- E-step1: typecheck.tc を /bin/typecheck として mtfs に入れ、
  `/tmp/hello.ast` を入力に sh から起動して、sys_exit(0) するまで
  走る
- E-step2: km_dump_stats のピーク値がツールごとに取れる
- E-step3: (もしヘッダ方式を採用したら) ダミータスクで書き込んだ
  サイズが効いていることを確認

### C-1. 中間ファイル経由のコンパイルパイプライン

**ここまで揃うと**: sh から

```
parse /bin/hello.tc > /tmp/1.ast
typecheck < /tmp/1.ast > /tmp/2.tast
codegen < /tmp/2.tast > /tmp/3.bc
bc2asm < /tmp/3.bc > /tmp/4.s
```

が動く。最終的には `asm < /tmp/4.s > /tmp/hello.bin` まで行きたいが、
asm.tc は #7 (9MB 静的バッファ) が未解決なので、qemu virt
(128MB RAM) でだけ走る状態。これで **OS 上でのコンパイラ初動** が
検証できる。

**実装範囲**:
- parse / typecheck / codegen / bc2asm / asm を `/bin/` に入れる
  task として build (kernel/build.sh の TASKS に追加)
- コンパイラタスクは E (案 C ヘッダ) で arena/stack を大きめに指定
- 初期の tmpfs に `/tmp/hello.tc` のようなテスト入力を seed する
  (mtfs にテスト入力を入れて、sh で `cat /hello.tc > /tmp/hello.tc`
  するでも良い)
- テスト: `tests/test_os.sh` にパイプラインシナリオを追加

### C-2. 真のパイプ (`|`)

**なぜ後回し**: C-1 で動くなら、中間ファイルで十分正しい自己ホストが
できる。パイプは性能 (= tmpfs 経由のコピーが減る) とセマンティクス
(= 途中で止まったらストリーミング止まる) の話なので、ブロッカーでは
ない。

**やるとしたら**:
- `pipe()` syscall (ecall 22 / Linux の pipe2)
- カーネル側に ring buffer 形式のパイプ inode。read で空なら waiting、
  write で満なら waiting、相手プロセスが書いたら ready に戻す
- sh が `|` を見たら pipe() → fork (sys_spawn) して fd をつなぎ変え
- スケジューラの waiting 状態を活用 (既に sys_wait 実装時に入れてある)

---

## 全体のマイルストーン

1. **M1 (B)**: `sh` から `catfile /hello.txt` が動く
2. **M2 (A+D+F)**: `echo foo > /tmp/a; cat < /tmp/a` が動く
3. **M3 (E)**: 4M arena を要求するダミータスクが load/run できる
4. **M4 (C-1)**: OS 上で `parse /bin/hello.tc > /tmp/hello.ast` が動く
5. **M5 (C-1 延長)**: OS 上で 4 段パイプラインが通り `.s` まで落ちる
6. **M6 (self-host 初動)**: OS 上で asm まで走り、生成した bin を
   `/tmp/foo` に置いて load/run できる (= 自己コンパイル → 自己実行)
7. **M7 (自己ホスト一周)**: Gen2 ツールで Gen3 が作れる (OS 上で
   ループを一周)

M7 は asm.tc のメモリ問題 (problem.md #7) を qemu virt なら素で、
Pico 2 実機なら中期/長期案を入れてから、という条件付き。

---

## 触る既存ファイルの一覧

- `kernel/loader.tc` — sys_exec_handler / sys_spawn_handler を argv 対応に
- `kernel/vfs.tc` — open flags、write 経路、dup2、mount テーブル拡張
- `kernel/tmpfs.tc` — 新規
- `kernel/kernel.tc` / `kernel/kernel_pico2.tc` — /tmp mount
- `kernel/trap_common.s` — dup3 などの新 syscall ディスパッチ
- `kernel/tasks/task_crt0.s` — argc/argv 受け渡し、E 案の header 対応
- `kernel/tasks/sh/sh.tc` — コマンド行パーサ拡張、`<` / `>` / 引数
- `kernel/tasks/echo/echo.tc` — 新規 (リダイレクトテスト用)
- `kernel/build.sh` — コンパイラタスクの arena/stack 指定
- `tests/test_os.sh` — パイプラインシナリオ追加
- `compiler/runtime.tc` — 必要なら argv/read-file ヘルパ追加
- `docs/filesystem.md` — tmpfs / mount 表更新

## 関連ドキュメント

- `docs/filesystem.md` — 現状の VFS / mtfs 構成
- `docs/task/phase6_userland.md` — フェーズ6 の実装記録
- `docs/task/kernel_design.md` — スケジューラ / プロセス管理
- `docs/problem.md` #7 — asm.tc のメモリ問題 (M6/M7 の前提)
- `docs/problem.md` K3 — タスクサイズ宣言 (E で解決予定)
