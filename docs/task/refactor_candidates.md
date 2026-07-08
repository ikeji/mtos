# リファクタ候補リスト (2026-07-08 調査)

kernel / compiler / userland / scripts+Makefile の 4 領域を横断調査した
結果。docs/design_decisions.md に「意図的」と記録済みのもの (struct
private、peek/poke 境界なし、固定 cap 等) は除外済み。

着手順序 (決定済): §A → §B → §C → §D。各ステップの完了状況は
末尾の「進捗」を更新する。

---

## A. 最優先 — 潜在バグを内包する重複

### A1. AST kind 番号 (NK_*) が 3 ファイルで独立定義され番号が不整合

- `sigscan.tc:38` は `NK_CONST_DECL = 9`。一方 `tcheck.tc:74` /
  `codegen.tc:19` では `9 = NK_ASSIGN`、`NK_CONST_DECL = 27`。
- 各バイナリがテキスト AST を独立にパースするので現状は動くが、
  「同名の定数なのに値が違う」状態は将来の共通化・比較コードで
  即座に壊れる罠。
- 対処: 正準番号への統一 (tcheck/codegen 側の番号を正とし sigscan を
  renumber)。可能なら共有モジュールへ集約。規模: 中。

### A2. S 式リーダ前半部が sigscan / tcheck / codegen で三重複製

- `peek_in` / `skip_ws_in` / `read_atom_in` (バイト単位で同一)、
  `read_node` (~100 行 ×3)、`classify_kind` (tcheck/codegen ほぼ同一、
  sigscan は部分集合)、`is_digit_c`。
- 対処: 共有モジュール (ast_node.tc または新規 sexpr_reader.tc) へ
  括り出し。A1 と同時に実施すると効率的。規模: 大。
- 注意: 新規 .tc ファイルを足す場合は self-replicate の device 側
  staging (import closure) に追従が必要。既存 import 済みの
  ast_node.tc に足せるならファイル追加なしで済む。

### A3. compile-gen3.sh のコメントが虚偽 (gen2 と大きく乖離)

- 冒頭コメントは「Mirrors compile-gen2.sh exactly」だが、gen2 は
  per-file asm_pass1 + CACHED_S_DIR + .incbin 対応に進化済みで、
  gen3 は旧来の cat 連結 prelude のまま。
- Gen2==Gen3 byte-exact 検証の信頼性に関わる。理想は
  `compile-gen.sh` 本体 + gen1/2/3 の薄いラッパ。最低限コメント修正。
- 規模: 大 (コメントのみなら極小)。

## B. 低リスク即効群 (1 コミットでまとめて)

### B1. 死にコード削除 (~250 行、参照ゼロ確認済み)

- `kernel_pico2.tc::dump_mtfs_to_sd` 一式 (+dump_str/dump_digit/
  dump_dec、~150 行) — K21 で boot から外れ mr -a 経路に置換済み
- `trap_common.s::kern_run_task` — 旧タスク実行経路の残骸
- `kernel_pico2.tc::kput_hex32` — PIO LCD bring-up の残骸
- `kernel_common.tc::kdbg_write` — 呼び出しゼロ
- `call0/call2/call4` (trap_common.s) は参照ゼロだが **意図的な
  将来用セット** (fs vtable 実装時に揃えた) なので削除せず
  コメントで明示する
- 準デッド: `sched_task_exit` 内の `km_dump_brief`/`km_dump_buckets`
  (「原因判明したら消す」コメント付き debug 出力が本番経路に残存)

### B2. fd テーブル満杯の silent -1 を loud 化

- design_decisions.md §5 (固定 cap は loud error 必須) に違反:
  `vfs.tc::alloc_vfs_fd` / `devfs.tc::devfs_alloc` /
  `tmpfs.tc::tmpfs_create` / `tmpfs_alloc_fd` / `mtfs.tc::mtfs_open` /
  `fatfs.tc::fatfs_alloc_fd` / `procfs.tc` の空きスロット枯渇。
- 対処: kputs/eputs で "table full" を出してから -1。規模: 小。

### B3. arg_eq / is_digit_c の重複を strlib で置換

- `arg_eq`: asm_pass1.tc / asm_pass2.tc / asm_pass3.tc / tcheck.tc の
  4 箇所完全一致 → `strlib.streq` 相当で置換または 1 本化
- `is_digit_c`: sigscan.tc / codegen.tc / tcheck.tc — strlib import 済み
  なのに再実装 → `strlib.is_digit` へ (A2 と重なるので A2 側で消える
  ならそれで良い)
- `err(s)`: asm_pass1/2/3 の 3 箇所同一

## C. 大きな重複塊 (独立して検証可能)

### C1. virt の virtio-blk ドライバ 2 本を統合

- `block_virtio.tc` (259 行) と `block_fat_virtio.tc` (231 行) は
  prefix と「何台目のデバイスを掴むか」以外行単位で一致。
- 対処: base/skip をパラメタ化した 1 本に統合。`make -C kernel test`
  で検証可。規模: 大。
- 補足: `block_fat_virtio.tc:20` の `FAT_REG_GUEST_FEAT_SEL` だけ
  const でなく var (不整合)。

### C2. pico2 実機スクリプト 10 本の共通ブロック括り出し

- UF2→bin 抽出 Python ヒアドキュメント / openocd flash + "Verified
  OK" grep / stty+UART drain / OPENOCD 等 env デフォルト、の 4 ブロック
  が run_pico2*.sh, test_pico2*.sh ×5, pico2_verify.sh,
  pico2_test_compile_parse.sh, pico2_self_replicate.sh に逐語コピー。
- 対処: `integration/lib/pico2_hw.sh` に uf2_to_bin / pico2_flash /
  uart_drain / env デフォルトを集約し source。各 20〜40 行削減。
- `run_pico2.sh` だけ OPENOCD が env 上書き不可のベタ代入
  (他は `${OPENOCD:-...}`) — 非一貫も同時に修正。
- 検証: 実機 flash + boot 1 回。規模: 中。

## D. 効果最大・リスク最大 (実機 self-replicate 再検証をセットに)

### D1. fatfs のディレクトリ走査イテレータ化

- `dir_find_by_name` / `dir_has_sfn` / `dir_alloc_slots` /
  `dir_is_empty` / `fatfs_readdir_dir` の 5 関数が同じ
  「クラスタチェーン→セクタ→32B×16 エントリ」三重ループ。
  LFN 解析ブロックは逐語的に同一。
- callN (関数ポインタ) が入ったので callback 式イテレータに抽出可能。
- 検証: `make -C kernel test` + 実機 self-replicate byte-exact。
  規模: 大。

## E. その後の候補 (今回のスコープ外、順不同)

- **BC opcode 層の共通化**: `OP_*` 37 個 + `classify_op` + 命令
  アクセサが bc2asm / bcrun で完全複製 → `bc_common.tc`
- **数値→ASCII 変換の乱立**: kernel 8 箇所 + compiler/userland の
  `dump_dec` 完全一致 3 連 + `put_dec`/`emit_dec` 系 6 種
- **import 閉包収集の重複**: 正規版 `collect_imports.sh` があるのに
  compile-gen1/2/3.sh と test_common.sh が劣化版を自前実装
- **readdir name-append** (kernel 3 箇所完全一致 + 3 インライン) と
  **パス vs StringLiteral 比較ループ** (6 重複) の 1 本化
- **loader.tc の spawn/exec/spawn_fds ハンドラ 3 本** の同型部括り出し
- **定数散在**: O_* フラグ + 生値 577 (userland、const/var 混在)、
  trap frame オフセット (saved a0=+40, mepc=+128, size=132 が
  trap_common.s と kernel_common.tc に生値)、fatfs の 512 リテラル
  40 箇所超
- **asm_common.tc 内の二重化**: ELF ヘッダ生成 ×2、レジスタ名分類 ×2
- **procfs/devfs の read「snapshot バッファ + pos 消費」共通化**、
  fd alloc ループ 6 箇所の同型
- **devfs / procfs ディスパッチの vtable 化** — fs vtable で様子を
  見てから、の合意済み保留項目
- **userland**: build_path (sh/msh コピペ)、readdir 走査ループ、
  10 進パーサ 4 種、エラーを stdout に出しているタスク多数
  (ls/cp/wc/head)、usage 文言不統一
- **Makefile**: compiler/Makefile の bin2uf2/mkfs 同型レシピ、
  Gen1 リンク 4 連の pattern rule 化
- **kernel/kernel_pico2 の main 初期化フロー重複** (mount 手順 +
  sh seed フォールバック)
- **tty_tag_for_slot の 16 連 if** → 桁変換で数行化
- **test_common.sh:179 のデッドコメント** (存在しない test_all.sh 参照)

---

## 進捗

- [x] A1+A2: NK_ 統一 + S 式リーダ共通化 (2026-07-08 完了。副産物で
      bcrun 連結 .bc の string table 衝突を発見・修正 —
      `docs/solved.md` #43)
- [x] A3: compile-gen3.sh 乖離 (2026-07-08 完了。調査の結果 in-tree
      から一切呼ばれていない死にスクリプトと判明 — Makefile gen3 は
      compile-gen2.sh を直接使い、test_gen3.sh は段階を自前駆動。
      GEN2_DIR=GEN3_DIR で compile-gen2.sh に委譲する薄いラッパに置換)
- [x] B1+B2+B3 (2026-07-08 完了): 死にコード削除 (dump_mtfs_to_sd 一式
      ~150 行 / kern_run_task / kput_hex32 / kdbg_write、call0/2/4 は
      「将来用」コメントを明記して温存)、fd/table 満杯 7 箇所に kputs
      loud error、arg_eq ×4 + err ×3 を strlib.tc に集約
      (is_digit_c ×3 は A2 で解消済み)
- [x] C1: virtio 統合 (2026-07-08 完了。block_fat_virtio.tc を削除し
      block_virtio.tc に vblk_scan/vblk_init_at/vblk_request の
      パラメタ化コアで統合、未使用の virtio_blk_base/version も削除。
      検証: make -C kernel test 8/8 + qemu FAT smoke (mount/read/
      write/readdir) + qemu_mr_scale.py)
- [x] C2: pico2 スクリプト共通化 (2026-07-08 完了。
      integration/lib/pico2_hw.sh に uf2_to_bin / pico2_flash_{halt,run}
      / pico2_reset_run / pico2_uart_{setup,drain} + env デフォルトを
      集約、10 スクリプトを移植。副産物 3 件: run_pico2_interactive.sh
      の stale path 2 件修正 (tests/pico2_tty.py → integration/、
      make pico2-kernel → make -C kernel pico2)、build.sh の console
      タスクに jpfont_inc.s が link されていなかった欠落を修正
      (#42 の hard error が検出)。実機検証: flash_halt+reset_run 経路
      (test_pico2.sh の flash/boot)、flash_run 経路 (console-land
      焼き戻し + boot 確認)。test_pico2.sh の UART 検証 fail は既存の
      capture byte-lossy 問題 — docs/problem.md #44)
- [x] D1: fatfs イテレータ化 + 実機 self-replicate 再検証
      (2026-07-08 完了、commit 46c1011。DirIter カーソル型で 5 関数を
      共通化、qemu FAT スモーク全パス + 24 LFN ファイルの 7 クラスタ
      跨ぎ成長 OK。検証中に既存 limitation #45 (SFN base 同一は ~9 まで)
      を発見・記録。**実機 self-replicate byte-exact MATCH 再確認**:
      host/device とも kernel.bin md5 5af1c5bb938855e7e0be117a284801f6
      / kernel.uf2 cb918de48f25167a6428d55d9781c0b8、リファクタ A〜D
      全部入りのツールチェーン+カーネルで維持)

全 6 項目完了 (2026-07-08)。次にやるなら §E から。
