# 作業ルール

- タスクは1つずつ実装し、完了したら必ずgitコミットしてから一時停止する。
- 次のタスクに進む前にユーザーの確認を待つ。
- `make test` の実行時間は 1 分以内を維持する。新規テストを追加するときは
  既存テストの合計時間と合わせてこの上限を超えないか確認する。

---

# 現在のフェーズ

`docs/roadmap.md` 参照。**フェーズ 7 M1〜M6 + Phase 1/2/3 パイプライン
メモリ削減まで到達**: OS 上で Hello World を自己コンパイル + 自己実行
できる状態。以下が完了済:

- フェーズ 7 B: argc/argv (kernel 側で StringArray 構築 → crt0)
- フェーズ 7 A: tmpfs (/tmp, kmalloc backed, grow-on-write)
- フェーズ 7 D+F: sh の `<` / `>` リダイレクト + per-task stdin/stdout
  fd (fd=2 stderr は常に UART)
- フェーズ 7 E-step1: タスク一律 16 MB / 64 KB、kernel arena 96 MB
  (K3 で per-task 可変化、下記)
- フェーズ 7 E-step2: per-task ピークメモリ計測 (`km_dump_peak`)
- フェーズ 7 C-1: parse / sigscan / tcheck / codegen / bc2asm /
  asm_pass1 / asm_pass2 を `EXTRA_TASKS` 経由でタスク化、sh から中間
  ファイル経由で実行
- フェーズ 7 M6: 7 段パイプライン (parse → sigscan → cat-wrap →
  tcheck → codegen → bc2asm → cat prelude → asm_pass1 → cat lab →
  asm_pass2) を回し、`/tmp/hw` に出力した raw binary を sh の絶対
  パス対応で実行して "Hello, World!"
- **パイプライン 100 KB 計画 (Phase 1 + 2 + 3)** — 計画は
  `docs/task/pipeline_100kb.md`、commit ログは #49〜#64:
  - **Phase 1 (typecheck split)**: `compiler/sigscan.tc` +
    `compiler/tcheck.tc` を新設。拡張 .th フォーマット (`(imports)
    (self) (program)` ラッパー) で関数本体を per-function stream
    check。tcheck 内部は per-fn strtab rollback + per-fn kmalloc
    fntab。**tcheck ≈ 75〜251 KB** (旧 typecheck 717 KB 比 ~9x)、
    **sigscan ≈ 10 KB** (#49〜#52, #54, #62〜#64)
  - **Phase 2 (asm split)**: `compiler/asm_common.tc` +
    `compiler/asm_pass1.tc` + `compiler/asm_pass2.tc` を新設。
    `.lab` 中間ファイル (仕様: `docs/lab_format.md`) で pass1 が
    label を集めて pass2 が encoder。pass1/pass2 とも g_lines 4 MB
    を廃止して SourceReader で stream 読み。**asm-pass1 ≈ 430 KB**
    (旧 9.5 MB 比 22x)、**asm-pass1 ≈ 227〜268 KB**
    (MAX_LABELS 16384→4096 + MAX_NAME_POOL 256K→128K で label pool
    を半分に、2026-04-16 / commit 5098a1e)、**asm-pass2 ≈ 260〜280
    KB** (Phase 5 で g_code 廃止 → 3 pass source re-scan で stream
    emit、2026-04-16 / commit 426f51e)。compiler 全タスクが Pico 2
    の 480 KB arena に余裕で収まる (#55〜#58 + Phase 4/5)
  - **Phase 3 (in-place shrinks)**:
    - codegen: strtab を perm/ephemeral 2 cursor 化 (per-top-level
      rollback) + buffer 縮小。303 KB → **80〜252 KB** (#59)
    - bc2asm: per-function emission (instrs 1 MB 廃止) + global
      table 廃止 + per-fn strtab rollback。1.4 MB → **120〜126 KB**
      (~11x 削減) (#60)
- **Gen2 toolchain migration 完了 (2026-04-15)**: compile-gen2.sh /
  compile-gen3.sh / kernel/build.sh / tests/test_common.sh /
  test_gen3.sh / tc_run.sh を新パイプライン (sigscan + tcheck +
  asm_pass1 + asm_pass2) に移行。`compiler/typecheck.tc` と
  `compiler/asm.tc` を削除 (+ kernel/tasks/typecheck/, kernel/tasks/
  asm/, tc_asm.sh, tests/test_split.sh も削除)。bcrun.c に
  `kmalloc` / `kfree` / `km_dump_peak` の builtin stub を追加
  (tcheck.tc を bcrun で動かすため、tc_run.sh pipeline 用)
- **K3 案C 完了 (2026-04-15)**: タスクバイナリの先頭 8 バイトに
  `.word arena_size; .word stack_size` の header を埋め込み、
  `loader.tc` が読んで `make_task` に渡す。`kernel.tc` /
  `kernel_pico2.tc` / `sys_exec_handler` / `sys_spawn_handler` から
  固定 16 MB / 64 KB を撲滅。`kernel/build.sh` が per-task で
  header.s を emit し task_crt0.s の前にリンク (task_arena_size() /
  task_stack_size() の per-task テーブル)。各 task は測定ピーク
  +25% 程度 (hello 8 KB ... asm_pass2 512 KB) を宣言。phase 7
  パイプラインが virt で動き続けることを test_phase7.sh で確認済
- **K7 部分解決 (2026-04-15)**: pico2 の kernel arena を
  262144 → 491520 (256 KB → 480 KB) に拡大。launcher.tc を
  `do_spawn("/bin/hello2") + do_wait` を挟む形に変更して
  dynamic task spawn の実機 smoke test にした。さらに K7 part 2:
  pico2 の seed task 3 枠目を `launcher` から `sh` に切り替えた
  (`kernel/kernel_pico2.tc`)。Debug Probe の CDC-ACM は双方向なので
  host から `/dev/ttyACM0` に書き込めばコマンドを sh に渡せる。
  `tests/test_pico2.sh` が flash 後に `catfile\n` / `launcher\n` /
  `quit\n` を UART に送って sh + catfile (argv あり) + launcher 経由
  の do_spawn/do_wait/do_exec cascade を実機で検証。出力は
  scheduler tracer で断片化しがちなので grep 前に `[sw ..]` /
  `[x ..]` / `[w ..]` / `[kmem ..]` を sed で落としてから
  `CAT[1]:` / `LAUNCHER: spawned slot ok` / `SH: bye` などを counter
  で確認。実機 2 件 PASS / ~98 秒
- **`test_phase7.sh` (手動実行)**: sigscan + tcheck + asm_pass1 +
  asm_pass2 の full split pipeline で Hello World 完走
- 以前から継続: u32 比較/除算/hex literal, K1 (task 画像 leak),
  R1-R8 refactor, compile-gen\*.sh の `2>/dev/null` 撲滅,
  runtime.s / libtc.s の事前キャッシュ化,
  #21 StringLiteral emission bug (bc2asm ラベル衝突)
- **Make ベース incremental build (2026-04-16、計画は
  `docs/task/make_based_build.md`、Phase A〜E 完了)**:
  `build/gen2/`、`build/gen3/` (自己ホスト確認用)、
  `build/kernel/virt_kernel.bin` + `build/kernel/disk.img`、
  `build/test/asm/*.bin` を Make ターゲット化。依存追跡は
  `tools/collect_imports.sh` で TC の transitive import を解決し
  `.d` fragment を `-include` する。task 一覧は virt/pico2 共通化
  (hello hello2 catfile sh tmpdemo echo launcher cat)。
  `.NOTPARALLEL:` で `-j1` 強制。
  `make test`: **141 passed / warm 33s** (consistency を FULL_TEST
  gate 外に出したので 9 件追加)。cold ~78s。Phase A 前 58s → 33s
  (~1.8 倍速)。compiler/\*.tc を触ると該当 Gen2 ツールだけ、
  kernel/\*.tc を触ると kernel + disk.img だけが再ビルドされる。
  Gen3 経路は kernel build で測って Gen2 比 2x 遅かったので
  (少し遅いの範囲外)、kernel 本番経路は Gen2 を維持。Gen3 は
  自己ホスト確認用 Make ターゲット (`make gen3-tools`) として存在

- **UART 多重化 (2026-04-16〜17)**: kernel → host は 0x1F magic +
  4 byte tag + 1 byte len + ≤ 255 byte payload でフレーム化。host →
  per-task in_buf (Phase 2) で入力もフレーム逆流。muxon/muxoff で
  runtime 切替。タスク: mx (length-prefix framing), mr (decode), msh
  (プロンプトなし sh)。設計: `docs/task/uart_multiplex.md`、
  実装: `kernel/kernel_common.tc` (uart_emit_frame / uart_rx_dispatch /
  task_input_read)、`tests/uart_demux.py` (ホスト側パーサー)
- **coreutils + OS 機能 (2026-04-17)**:
  - `ls` + sys_readdir (ecall 89)、`/etc/kern.conf` (mux / init 設定)
  - `wc`, `head`, `cp`, `du` coreutils
  - `procfs` (/proc/tasks: スロット状態一覧 + readdir 対応)
  - `neofetch` (ASCII banner + /proc/tasks stats)
  - `cat` のエラー報告 (存在しないファイル → stderr + 非 0 exit)
  - `sh` タブ補完 (/bin コマンド + readdir パス補完)
  - `vi` 最小 vi エディタ (normal/insert/cmdline mode、hjkl/dd/gg/
    :w/:q/:wq、ANSI 描画)
- **byte-exact self-hosting verify (2026-04-17)**:
  - `tests/phase3_verify.py`: virt 上で全 9 段 (parse → asm_pass2) +
    /tmp/hw 実行を Gen2 ホスト参照とバイト完全一致確認
  - `tests/pico2_verify.sh`: pico2 実機で compile 7 段をバイト完全
    一致確認 (link 段は UART stdin hang で skip)
- **`make run-pico2` (2026-04-17)**: ビルド + flash + 双方向 UART
  コンソール。Ctrl-a x で終了。`tests/pico2_tty.py` が raw mode
  stdin ↔ /dev/ttyACM0 を select 駆動
- **OS 機能追加 (2026-04-17 後半)**:
  - VFS: `ls /` で /proc、/tmp が表示されるよう vfs_readdir を修正
  - pico2_tty.py: raw mode 端末で LF → CR+LF 変換
  - procfs 拡充: `/proc/meminfo` (peak/used)、`/proc/cpuinfo`
    (rv32ima)、`/proc/uptime` (mtime hex)。`read_mtime()` を
    platform 関数として virt (CLINT) / pico2 (SIO) に追加
  - `/proc/tasks` にヘッダ行 + NAME 列 (タスクバイナリ basename) +
    RAM/STACK 列 (arena/stack サイズ)。Task 構造体に name/t_ram_sz/
    t_stk_sz フィールド追加。loader が spawn/exec 時にセット
  - sh ヒストリ (上下矢印で直近 8 件を呼び出し)
  - sh タブ補完改善 (複数候補の共通プレフィックスまで自動補完)
  - tcheck fntab 256 → 512 に拡大 (Task 構造体のフィールド増加対応)

**次の候補** (どれも独立):

- **フェーズ 7 M7**: OS 上で Gen2 → Gen3 相当の一周 (コンパイラ自身を
  OS 上で再コンパイル)。時間はかかるが現状の memory peak で成立する
  はず
- **フェーズ 7 仕上げ**: K6 debug trace のクリーンアップ、K7 pico2
  対応 (要 K3: per-task サイズ宣言ヘッダ)
- **bcrun.tc::vm_run AST pool outlier**: tcheck/codegen/bc2asm
  すべての peak を跳ね上げる原因が vm_run 1 関数の巨大 AST (2581
  node)。source 分解は intentionally out of scope (ユーザ指示)。
  現状 252 KB peak は phase 7 OS の 16 MB task 枠に収まる
- **フェーズ 8**: OS 全体を独自言語で書く

問題詳細は `docs/problem.md` (#7 / K3 / K5 / K6 / K7)、
phase 7 実装記録は `docs/task/phase7_compiler_on_os.md`、
pipeline メモリ削減計画は `docs/task/pipeline_100kb.md`、
.lab 中間フォーマットは `docs/lab_format.md`。

---

# プロジェクト チートシート

## ディレクトリ構成

```
bootstrap/  C実装のコンパイラ（ブートストラップ用、Gen1）
  crt0.s             GCCリンク用スタートアップ
  runtime_syscall.c  Cランタイム（プールアロケータ、syscallスタブ）
  extract_sigs.c     .th ヘッダ抽出ツール（AST → export シグネチャ）
  codegen_main.c     codegen エントリポイント（parse+typecheck+codegen 一体）
  typecheck_main.c   typecheck エントリポイント
  parse_main.c       parse エントリポイント
  lexer.c parser.c ast.c typecheck.c codegen.c interp.c  共有ライブラリ
  bcrun.c            バイトコードインタープリタ
  bc2asm.c           バイトコード→RISC-V asm 変換
compiler/   自作TinyC製の自己ホスト型コンパイラ（Gen2/Gen3）
  parse.tc           レキサー＋パーサー（ソース → AST .ast）
  sigscan.tc         拡張 .th 抽出器。AST を stream 読みして top-level
                     全部 (export / 非 export / struct / グローバル変数)
                     を .th に吐く。tcheck の前段 (~10 KB peak)
  tcheck.tc          Streaming type checker。stdin に
                     `(imports) (self) (program)` ラッパーを受けて
                     per-function check + .tast emit。per-fn strtab
                     rollback + per-fn kmalloc fntab で 75〜252 KB peak
  codegen.tc         コード生成（型付きAST → バイトコード .bc、per-top-level
                     strtab rollback 済）
  bc2asm.tc          バイトコード → RISC-V asm .s 変換 (per-function
                     emission 済。`--unit` 無しで動き、string literal
                     label は first fn name を使う)
  ast_node.tc        AST ノードプール共有モジュール (struct AstNode +
                     AstNodeArray + n_* wrappers、codegen/sigscan/
                     tcheck が import)
  string_buffer.tc   伸長バッファライブラリ（emit_string/emit_nl/emit_int 等）
  source_reader.tc   ストリーミング入力リーダー（4KBバッファ）
  strlib.tc          共通ユーティリティ（is_digit, is_alpha, streq, cmp 等）
  bcrun.tc           バイトコードインタープリタ（TC版）
  asm_common.tc      asm_pass1 / asm_pass2 の共通 encoder/parser core。
                     process_line / enc_r/i/s/b/u/j / operand parser /
                     label table / section state 全部ここに。asm_pass1/2
                     が import
  asm_pass1.tc       Label collector。`.s` を 1 度読んで `.lab`
                     (docs/lab_format.md) を吐く (~250 KB peak、
                     MAX_LABELS 4096 + MAX_NAME_POOL 128 KB)
  asm_pass2.tc       Encoder。Phase 5 の stream-emit: stdin は
                     `(lab ...)` + source × 3 (text/rodata/data 各
                     1 copy ずつ)、source を 3 回再読み込みして
                     target section を 4 KB out_buf 経由 stdout に
                     直接 emit。peak ~260〜280 KB (旧 4.6 MB 比
                     ~16x 削減)
  runtime.tc         TinyC製ランタイム（kmalloc/kfree 等、compile-gen2/3.sh で使用）
  crt0_tc.s          asm_pass1/2 リンク用 Linux crt0（_start, syscall stub, peek/poke）
  crt0_tc_data.s     asm_pass1/2 リンク用プールメタデータ (`.data` + `.bss` + __arena)
tests/      テストスイート
  golden/            Gen1 の基準出力（.ast .bc .s .out .exit）
  golden/tc/         compiler/ ソースの基準出力
  test_all.sh        全テストスイートのエントリポイント
  test_common.sh     共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）
  test_unit.sh       単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
  test_pipeline.sh   Gen2 パイプラインテスト（qemu rv32）
  test_consistency.sh  tc_run_all 全メソッド一致テスト
  test_golden_examples.sh  サンプル .tc の golden テスト
  test_gen3.sh       Gen1 vs golden、Gen2 AST比較、Gen2 vs Gen3 自己ホスト確認
  test_import.sh     複数ファイル import/export のテスト
  test_asm.sh        hello2.tc を virt crt0 でビルドして qemu-system-riscv32 で実行
  test_os.sh         kernel + tmpfs + argv + redirect の virt 上 end-to-end
  test_phase7.sh     phase 7 self-hosted pipeline (compile → link → run
                     on OS)。sigscan + tcheck + asm_pass1 + asm_pass2
                     full split pipeline で Hello World を完走させる。
                     `make test` 非同梱、手動実行のみ
  phase3_verify.py   virt 上で全 9 段 (parse→asm_pass2) + Hello World
                     実行を Gen2 ホスト参照とバイト完全一致検証
  pico2_verify.sh    pico2 実機で compile 7 段をバイト完全一致検証
  pico2_hw_driver.py pico2 UART pipeline driver (compile + optional link)
  pico2_tty.py       pico2 双方向 raw UART フォワーダー (Ctrl-a x 終了)
  uart_demux.py      UART mux 0x1F フレームパーサー
  phase7_hello.tc    parse 入力: `fn main() -> i32 { return 42; }`
  phase7_min.tc      parse 段階的縮小用の最小入力
  phase7_hello_world.tc Hello World ソース (M6 のゴール)
  virt_crt0.s        qemu-system-riscv32 -M virt 用 crt0（16550 UART + SiFive test 終了）
docs/       仕様・設計ドキュメント
  ast_format.md      AST ファイルフォーマット（.ast/.tast/.th）
  bc_format.md       バイトコード形式仕様
  language.md        TinyC言語仕様
  tinyc_cheatsheet.md  TinyC構文チートシート
  filesystem.md      VFS + MyTinyFS 設計 + フェーズ5 実装計画
  design_decisions.md 意図的に残している挙動の設計判断集
                     (struct 合成 fn の private 化 + export 前方宣言
                     による opt-out、String/StringLiteral 分離、
                     peek/poke の no-bounds-check、2D array 非対応)
  problem.md         既知の未解決バグ / limitation / ergonomics リスト
  sources.md         ソースファイル一覧
  task/              タスク計画・デバッグノート
kernel/     カーネル（プリエンプティブマルチタスク、virt + Pico 2 で動作）
  kernel_common.tc    共通 TC: kputs / make_task / scheduler。スロット
                      状態 (ready/done/unused/waiting) + sched_spawn /
                      sched_wait + phase 7 debug トレース
                      (`[sw from>to]` / `[x slot=code]` /
                      `[TRAP c=.. e=.. s=N]`) を持つ。trap_handler は
                      非タイマー trap でタスクを殺して sched_task_exit 経由
                      で次へ切り替える。forward-decl で vfs_close を
                      参照するだけで import はしない (循環回避)
  kernel.tc           virt 用 main + rearm_timer + mtfs マウント/read デモ。
                      TIMER_INTERVAL は 10_000_000 (1 秒 @ 10 MHz) に
                      落として phase 7 debug マーカーを読みやすく
  kernel_pico2.tc     Pico 2 用 main + rearm_timer (SIO MTIME)
  block_virtio.tc     virtio-mmio (legacy v1) block デバイスドライバ (virt)
  block_flash.tc      XIP flash block デバイスドライバ (pico2、_mtfs_image_addr 経由)
  mtfs.tc             MyTinyFS read-only ドライバ (mount/lookup/open/read/close)
  tmpfs.tc            /tmp 用 RAM backed FS (kmalloc backed, 16 files /
                      8 fds, grow-on-write, O_CREAT / O_TRUNC 対応、
                      phase 7 A)
  procfs.tc           read-only virtual FS (/proc)。/proc/tasks が
                      スロット状態一覧 (slot/state/frame/wait/ram/stack/
                      name)。/proc/meminfo (peak/used)、/proc/cpuinfo
                      (rv32ima)、/proc/uptime (mtime hex) も提供。
                      procfs_readdir で `ls /proc` にも対応
  vfs.tc              VFS 層 (fd テーブル, vfs_open/read/write/close/size/
                      readdir, /bin/hello のような多階層パス, /tmp/ は
                      tmpfs, /proc/ は procfs, それ以外は mtfs)。
                      fd 0 / 1 は current task の stdin_fd / stdout_fd を
                      参照してリダイレクトに対応 (phase 7 D)、fd 2 は常に
                      UART 直行。UART mux on のとき fd=0 は per-task
                      in_buf 経由、fd=1 は uart_emit_tty_frame 経由
  loader.tc           tmpfs / mtfs からタスクバイナリを読み込み make_task で
                      フレーム化する起動時ローダ (load_task)。
                      vfs_xip_addr が非0なら RAM コピーせず flash 直実行。
                      sys_exec_handler (ecall 221) / sys_spawn_handler (220)
                      は 4 引数 ABI (path, argv, in_path, out_path) で
                      kernel 側が redirect ファイルを open し argv を
                      StringArray clone してからスロットを作成。
                      K3 案C: タスクバイナリの先頭 8 バイトに
                      `.word arena_size; .word stack_size` の header が
                      あり、`load_fd` がそれを読んで `make_task(entry+8,
                      arena, stack)` を呼ぶ (ram_size / stack_size の
                      固定値は撲滅済み)。
                      sys_wait_handler (260) は呼び出し元を waiting に
  trap_common.s       共通 asm: trap entry/exit, ecall dispatch (write64 /
                      read63 / openat56 / close57 / readdir89 / exit93 /
                      spawn220 / exec221 / mux_enable250 / wait260),
                      sched_start, kern_run_task。spawn/exec は a0..a3 を
                      読んで handler__u32__u32__u32__u32 に dispatch
  platform_virt.s     virt 固有: _start, 16550 UART, _set_kern_gp via la。
                      `__runtime_init` に渡す arena_size は 100_663_296
                      (96 MB) — crt0_data.s の .space と必ず一致させる
  platform_pico2.s    Pico 2 固有: IMAGE_DEF, XOSC, PL011, .data コピー, _set_kern_gp via li
  crt0_data.s         virt 用 BSS (__arena .space 96 MB — phase 7 で
                      大きめに取っているが asm_pass2 peak 441 KB なので
                      実際は数 MB で足りる)
  crt0_pico2_data.s   Pico 2 用 BSS (256KB __arena)
  build.sh            統一ビルド: --target virt|pico2 [-o output]
                      [--disk-out path] + `EXTRA_TASKS` 環境変数で
                      phase 7 のコンパイラタスク (parse/sigscan/
                      tcheck/...) を追加可能。Step 0 で runtime.s /
                      libtc.s を事前コンパイル + `/prelude.s` (=
                      `; raw` + task_crt0.s + runtime.s) と
                      `/prelude_tail.s` (= task_data.s) を mtfs に
                      staging。tcheck の wrap 入力 (`(imports)` /
                      `(self` / `)` の 3 つの小ヘルパ) も
                      `/empty_imports.txt` / `/self_open.txt` /
                      `/wrap_close.txt` として staging — sh 側で
                      cat して tcheck の wrap 入力を組み立てる。
                      `KEEP_TMP=1` でカーネルビルド中間 tmp dir を残せる
  bin2s.sh            raw バイナリ → .s データ変換 (PREFIX_addr 関数生成)
  run_pico2.sh        Pico 2 実機書き込み + UART キャプチャ (openocd 経由)
  run_pico2_interactive.sh  build + flash + 双方向 UART コンソール
                      (`make run-pico2` が呼ぶ、Ctrl-a x で終了)
  tasks/              ゲストタスク (両プラットフォーム共通)
    task_crt0.s       タスク用 crt0 (ecall syscall + .data コピー、
                      a2 を s2 で保存して main に argv として渡す、
                      main__StringArray と main の両方を fallback スタブ
                      として定義、exit 前に `km_dump_peak` を呼んで
                      `[kmem peak=.. live=..]` を stderr に出す)
    task_data.s       タスク用最小 BSS
    hello/hello.tc    タスク1 ("A" 出力、seed)
    hello2/hello2.tc  タスク2 ("B" 出力、seed)
    catfile/catfile.tc タスク3 (argv[1] または "/hello.txt" を開いて
                      `CAT[argc]:` 付きで出力)
    launcher/launcher.tc タスク4 (pico2 slot 2、do_exec(path, 0, 0, 0) で
                      /bin/catfile を exec)
    sh/sh.tc          対話シェル (sys_spawn + sys_wait + `<` / `>` +
                      絶対パス対応 + TAB 補完 (/bin コマンド + readdir
                      パス、共通プレフィックス自動補完) + コマンド
                      ヒストリ (上下矢印、8 件) + echo-back + backspace。
                      quit で終了、virt slot 2)
    msh/msh.tc        プログラム操作用 silent sh (プロンプト/echo なし、
                      UART mux driver 用)
    libtc/libtc.tc    ユーザ空間ライブラリ (puts/str_nul/strlen)
    tmpdemo/tmpdemo.tc /tmp/demo を O_WRONLY|O_CREAT で書いて読み返す
                      phase 7 A 回帰テスト
    echo/echo.tc      argv[1..] を space 区切り + \n で stdout に出す
    cat/cat.tc        argv[1..] のファイルを順に stdout に流す。存在
                      しないファイルは stderr にエラー + exit 1
    ls/ls.tc          ディレクトリ一覧 (sys_readdir ecall 89)
    wc/wc.tc          行数・バイト数カウント
    head/head.tc      先頭 N 行表示
    cp/cp.tc          ファイルコピー
    du/du.tc          ディレクトリ使用量
    neofetch/neofetch.tc  ASCII banner + /proc/tasks stats
    vi/vi.tc          最小 vi エディタ (normal/insert/cmdline、ANSI 描画)
    mx/mx.tc          stdin → length-prefix framed stdout (UART 転送用)
    mr/mr.tc          mx の逆: framed stdin → raw stdout
    muxon/muxon.tc    UART mux 有効化 (ecall 250)
    muxoff/muxoff.tc  UART mux 無効化
    parse/parse.tc       → compiler/parse.tc (symlink)
    sigscan/sigscan.tc   → compiler/sigscan.tc (symlink)
    tcheck/tcheck.tc     → compiler/tcheck.tc (symlink)
    codegen/codegen.tc   → compiler/codegen.tc (symlink)
    bc2asm/bc2asm.tc     → compiler/bc2asm.tc (symlink)
    asm_pass1/asm_pass1.tc → compiler/asm_pass1.tc (symlink)
    asm_pass2/asm_pass2.tc → compiler/asm_pass2.tc (symlink)
                      上は `EXTRA_TASKS="parse sigscan tcheck codegen
                      bc2asm asm_pass1 asm_pass2 cat"` を渡したときだけ
                      ビルドされ `/bin/<name>` として mtfs に入る
                      (test_phase7.sh が参照)。compile-gen2.sh が
                      TC_FILE の symlink を readlink で解決するので
                      import (string_buffer.tc 等) が正しく compiler/
                      配下から引ける
tools/      ホスト側ツール
  mkfs.py             MyTinyFS (mtfs) ディスクイメージ生成 (Python)
                      mkfs.py <output> <rootdir> でディレクトリを再帰的に
                      取り込み、1 階層のサブディレクトリを dir inode 化する
  bin2uf2.py          raw bin → UF2 (family_id=0xe48bff5a) コンバータ
                      kernel/build.sh --target pico2 が内部で呼ぶ
```

## ビルド＆実行

```bash
make                              # Gen1 バイナリを build/gen1/ にビルド（parse, codegen, bc2asm, typecheck, extract-sigs 等）
make test                         # テスト実行（warm ~33s, cold ~78s、上限 60 秒 warm）
make full-test                    # kmalloc / kernel1 (FULL_TEST=1) 含む全テスト
make update-golden                # goldenファイルを再生成
make update-golden-and-run-test   # golden 再生成してからテスト実行
make gen2-tools                   # build/gen2/* のみビルド (incremental)
make gen3-tools                   # build/gen3/* のみビルド (自己ホスト確認用)
make virt-kernel                  # build/kernel/virt_kernel.bin + disk.img のみ
make pico2-kernel                 # build/kernel/pico2_kernel.uf2 のみ
make test-asm-bins                # build/test/asm/*.bin (test_asm プリビルド)
make run                          # virt kernel を対話起動 (qemu stdio serial)
make run-extra                    # 同上 + EXTRA_TASKS (parse/…/asm_pass2/muxon/mx 等) 込み
make run-pico2                    # pico2 kernel をビルド→flash→対話 UART
make run-pico2-extra              # 同上 + EXTRA_TASKS 込み
make clean                        # Gen1 + build/ まとめて消す
```

`make run` は `qemu-system-riscv32 -machine virt` に標準入出力を繋いで
sh と対話できる。Ctrl-a x で抜ける。Ctrl-a c で qemu モニタ。

`make run-pico2` は Debug Probe 経由で pico2 をフラッシュし、
`tests/pico2_tty.py` による双方向 UART コンソールを開く。
Ctrl-a x で終了 (qemu と同じ escape)。
`OPENOCD` / `UART_PORT` 環境変数で上書き可。

`make test` は時間短縮のため一部テストをスキップする (FULL_TEST=1 で有効化)。
詳細は `tests/test_all.sh` 参照。

## Pico 2 (RP2350 RISC-V) ビルド

カーネルを Pico 2 向けにビルドするには `kernel/build.sh --target pico2`
を使う。「カーネル / 統一ビルド」節 (後述) を参照。
`tools/bin2uf2.py` が raw bin → UF2 (family_id=0xe48bff5a) 変換を担当する
共通ユーティリティで、カーネルビルドが内部で呼ぶ。

bring-up 当初は `pico2/hello.tc` というカーネル抜きの standalone hello
world と専用の `compile-pico2.sh` / `pico2/crt0_pico2.s` を持っていたが、
カーネルが Pico 2 で動くようになって以降は使われなくなったので削除済み
(履歴は `git log -- pico2/`)。

## 世代の定義

- **Gen1**: `bootstrap/` の C コードを GCC で x86_64 にコンパイルしたもの
- **Gen2**: `compiler/` の TC コードを Gen1 でコンパイルし RV32 ELF にしたもの（`compile-gen1.sh`）
- **Gen3**: `compiler/` の TC コードを Gen2 でコンパイルし RV32 ELF にしたもの（`compile-gen2.sh`）

## コンパイルスクリプト

```bash
# Gen1 ツール（C版）で .tc → RV32 ELF（Gen2 ツールの生成に使う）
./compile-gen1.sh -o output file.tc

# Gen2 ツール（qemu経由）で .tc → RV32 ELF（Gen3 ツールの生成に使う）
GEN2_DIR=/path/to/gen2 ./compile-gen2.sh -o output file.tc

# Gen3 ツール（qemu経由）で .tc → RV32 ELF（Gen2==Gen3 の確認に使う）
GEN3_DIR=/path/to/gen3 ./compile-gen3.sh -o output file.tc
```

compile-gen1.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別にコンパイル → .s
3. 全 .s を GCC でリンク（crt0.s + runtime_syscall.c）

compile-gen2/gen3.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. Gen1 parse + extract-sigs で import 先の .th（tc header、exports のみ）を生成
3. 各 .tc について parse → sigscan で extended .th を作り、
   `(imports)(self)(program)` でラップして tcheck へ渡す
4. tcheck → codegen → bc2asm で .s を emit
5. crt0_tc.s + runtime.s + 全 .s + crt0_tc_data.s を結合後、
   asm_pass1 で .lab を作り、`cat .lab all.s | asm_pass2` で ELF 出力（GCC 不要）

## 中間ファイル拡張子

| ステージ | 出力 | 拡張子 |
|---|---|---|
| parse | AST（S式） | `.ast` |
| sigscan / extract-sigs | 拡張/export シグネチャ | `.th` (tc header) |
| tcheck | 型付きAST | `.tast` |
| codegen | バイトコード | `.bc` |
| bc2asm | アセンブリ | `.s` |
| asm_pass1 | ラベルテーブル | `.lab` |

詳細は `docs/ast_format.md`、`docs/bc_format.md`、`docs/lab_format.md` を参照。

## コンパイルパイプライン

### Gen1（C版、codegen が内部で parse+typecheck+codegen を一体実行）
```
source.tc → ./codegen source.tc → .bc → ./bc2asm → .s
```
codegen 内部の typecheck が import 先ファイルを読んでシグネチャを収集する。

### Gen2/Gen3（各ツール分離、stdin ストリーミング）
```
source.tc → parse → .ast → sigscan → .th
                ↘                ↘
                  (imports) + (self .th) + (program .ast) → tcheck → .tast
                                                              ↓
                                         codegen → .bc → bc2asm → .s
```
imports (他モジュール) の .th は Gen1 `extract-sigs` が生成し、self (自モジュール)
の .th は `sigscan` が拡張 .th として生成する。

```bash
./parse source.tc > source.ast
./sigscan < source.ast > source.th
{ cat imports.th; printf '(self\n'; cat source.th; printf ')\n'; cat source.ast; } \
    | ./tcheck | ./codegen | ./bc2asm > source.s
```

## .tcファイルの実行方法

```bash
./tc_run.sh interp    foo.tc          # ASTインタープリタで直接実行（速い）
./tc_run.sh bcrun     foo.tc          # Cコード生成→バイトコード実行
./tc_run.sh rv32      foo.tc          # Cコード生成→RISC-V→qemu実行
./tc_run.sh pipeline  foo.tc          # 自己ホスト版(parse.tc+sigscan.tc+tcheck.tc+codegen.tc on bcrun)
./tc_run.sh bc2asm_tc foo.tc          # 自己ホスト版bc2asm→RISC-V→qemu実行
# stdinを渡す場合
./tc_run.sh bcrun     calc.tc "1 + 2"
./tc_run.sh bcrun     calc.tc @input.txt
```

## 複数ファイルのコンパイル

```bash
./tc_build.sh -o prog main.tc lib.tc  # 複数 .tc ファイルをコンパイル＋リンク
```

`import "lib.tc";` で他ファイルの `export fn` を呼べる。struct は**型名として**
使えるが、自動生成関数（コンストラクタ、getter/setter、delete）は
**デフォルトでは** import 先から呼べない (private field の代替機構)。
必要なら `export fn` のラッパーを定義するか、ライブラリ側で合成 fn と
同じシグネチャの `export fn` 前方宣言を書いて opt-in で export 化する
(`compiler/ast_node.tc` 参照)。詳細は `docs/design_decisions.md` #1 と
`docs/task/multi_file.md`。

## テスト構造

### テストスクリプト構成
- `tests/test_all.sh` — 全スイートのエントリポイント（`make test`）
- `tests/test_unit.sh` — Gen1 単体テスト（parse/typecheck/codegen/interp/bcrun/rv32）
- `tests/test_pipeline.sh` — Gen2 パイプラインテスト（qemu rv32 native）
- `tests/test_consistency.sh` — tc_run_all 全メソッド一致テスト
- `tests/test_golden_examples.sh` — サンプル .tc ファイルの golden テスト
- `tests/test_gen3.sh` — Gen1 vs golden、Gen2 AST vs Gen1 AST、Gen2==Gen3 BC
- `tests/test_import.sh` — 複数ファイル import/export のテスト
- `tests/test_asm.sh` — hello2.tc / test_timer.tc を `; raw` モードで compile-gen2.sh にかけ、
  qemu-system-riscv32 -M virt で実行（CSR エンコード、タイマ割り込み検証含む）
- `tests/test_os.sh` — OS コンポーネントテスト。`make test` では fs_virtio
  (mtfs マウント + `/bin/*` ローダ + preempt + sh 経由 sys_exec end-to-end)
  のみを実行。`FULL_TEST=1` で kmalloc と kernel1 協調タスクも追加
- `tests/test_pico2.sh` — Pico 2 実機テスト。`make test` には含まれない。
  Debug Probe + openocd-rpi が接続された状態で
  `GEN2_DIR=/tmp/gen2 tests/test_pico2.sh` と起動すると、pico2 カーネルを
  ビルドして SWD フラッシュ、/dev/ttyACM0 の UART 出力から
  `BLOCK: flash backend ready / MTFS: mounted / CAT:hello, mtfs / all tasks done`
  を grep して検証する。環境変数 `OPENOCD` / `UART_PORT` で上書き可。
- `tests/test_phase7.sh` — phase 7 自己ホスト実行テスト。`make test` に
  は含まれない。`GEN2_DIR=/tmp/gen2 tests/test_phase7.sh` と起動すると、
  `EXTRA_TASKS="parse typecheck codegen bc2asm asm cat"` でカーネルを
  ビルドし、2 ステージを qemu virt で検証する:
  stage 1 は `parse < /phase7.tc → ... → bc2asm > /tmp/4.s` の 4 段
  パイプライン (`[w slot:len]` + `[x slot=0]` マーカーで検証)、
  stage 2 は `cat /prelude.s /tmp/4.s /prelude_tail.s` を通して asm に
  食わせて `/tmp/hw` を作り、sh の絶対パス実行で "Hello, World!" が
  UART に出ることを確認する
- `tests/phase7_hello.tc` / `phase7_min.tc` / `phase7_hello_world.tc` —
  phase 7 のテスト入力。それぞれ kernel/build.sh が `/phase7.tc` /
  `/phase7_min.tc` / `/hw.tc` として mtfs に staging する
- `tests/test_common.sh` — 共通ライブラリ（パス、カウンタ、Gen2 ツールビルド等）

### Gen2 ツールのビルド
- `build_gen2_tool` は `compile-gen1.sh` を使用（GCC リンカ + runtime_syscall.c）
- `ensure_gen2_tools` は qemu-riscv32 + riscv-gcc が必要。parse / typecheck /
  codegen / bc2asm / bcrun / asm を Gen2 として一式ビルドする。
- `tests/test_asm.sh` は追加で qemu-system-riscv32 が必要（無ければ SKIP）。

### テスト内容
- Gen1 出力 vs golden ファイル（AST, BC, ASM）
- Gen2 AST vs Gen1 AST（コメント除去・空白正規化後の構造比較）
- Gen2 BC/ASM vs golden（import なしファイルのみ）
- Gen2 == Gen3 BC（自己ホスト確認、import なしファイルのみ）
- 実行結果テスト（Gen2 rv32 via qemu）

## bc2asm の注意点
- 条件分岐は `bnez/beqz 0f; j target; 0:` パターンを使用
  （B-type ±4KB 制限を回避、J-type ±1MB で十分、数字ラベルでファイル間衝突なし）
- 関数内ジャンプラベルは `.L_FNAME_pcN` 形式（関数マングル名でグローバル一意）
- セクション出力順: .text → .data → .rodata（asm_pass1/pass2 がフラット配置するため）
- eval stack の最大深さを計算し frame_size に含める

## asm_pass1 / asm_pass2 の注意点
- asm_pass1 + asm_pass2 はこのツールチェーンの「アセンブラ兼リンカ」。
  入力 `.s` を per-section cursor で集計し、出力では text → rodata → data
  → bss の順に物理的に並べ替える。asm_pass1 が label table を `.lab` 中間
  ファイルに吐き、asm_pass2 が `.lab` + `.s` を読んでエンコードする
  (docs/lab_format.md 参照)。
- 共通ロジックは `compiler/asm_common.tc` にあり、pass1/pass2 の両方が import
  する。
- ラベルアドレスは常にコード先頭からのオフセット（PIC）。`la`/`jal`/分岐は
  PC 相対で unchanged、`.word symbol` はオフセット値を埋め込む。
- data/bss セクションのラベルへの `la` は常に gp 相対 (`auipc rd, 0` +
  `addi rd, gp, offset`) に展開される。12-bit signed 範囲外の場合は自動的に
  PC 相対 (`auipc + addi`) にフォールバック。text と data/bss が同じ LOAD
  segment に入る環境 (Linux/virt) ではフォールバックが通常動作する。
- `__global_pointer$` は pass 1 終了後に `data_base + 0x800` を自動定義する。
  Linux/virt 用 `crt0_tc.s` は `la gp, __global_pointer$` で runtime gp を
  初期化する (PC 相対 la なので gp 未初期化でも動作)。Pico 2 用 crt0 は
  同じラベルを参照するか、または SRAM の絶対値で `li gp, 0x20000800`
  のようにセットする。
- 各セクションのサイズは 16 バイトにアラインされる。これは `.align 4`
  (RISC-V GNU as で 2^4 = 16 バイトアラインメント) を pass 1 (intra 0 から
  始まる) と pass 2 (section_base から始まる) で整合させるため。
- ELF 出力: p_offset=0、ヘッダ(84B)+コードを 1 つの LOAD セグメントで出力。
  `g_code_end` までを filesz、`mem_size` を memsz として書き出すので、
  末尾の `.space`（`__arena` 等）は filesz に含まれず memsz だけ広がる。
- 数字ラベル（0:-9:）対応、パス1で定義収集、パス2で参照解決 (text セクション
  前提で section_base の fixup は行わない)
- g_code は .lab のセクションサイズ合計 (text + rodata + data) で
  asm_pass2 起動時に動的確保。旧 MAX_CODE=4 MB 固定は廃止済。
  数字ラベル最大1024個/digit
- CSR 命令: `csrrw`, `csrrs`, `csrrc`, `csrr` (疑似), `csrw` (疑似), `mret`
- `jalr rd, rs1, imm` (I-type 間接ジャンプ)
- `.byte val[,val...]` (1行4バイトまで)、`.rodata` (短縮形)
- stdin 先頭ディレクティブ:
  - `; raw` — ELF ヘッダを出さず、code 部分だけを raw bin として出力
  - `; load_base 0xHHHHHHHH` — ELF 出力時の `e_entry`/`p_vaddr`/`p_paddr` を
    この値ベースに設定（デフォルト 0x10000）

## compile-gen2.sh の環境変数
デフォルトは Linux ELF 用の crt0 だが、以下を設定すると別ターゲット
（qemu virt, Pico 2 等）向けにビルドできる:
- `CRT0` — `.s` ファイルパス。デフォルト `compiler/crt0_tc.s`
- `CRT0_DATA` — `.s` ファイルパス。デフォルト `compiler/crt0_tc_data.s`
- `ASM_PROLOGUE` — asm 入力先頭に注入する 1 行（例 `; raw`）
- `GEN2_DIR` — Gen2 ツール (parse/sigscan/tcheck/codegen/bc2asm/asm_pass1/asm_pass2)
  の置き場所

## カーネルビルド

統一ビルドスクリプト (virt と Pico 2 共通):

```bash
# Gen2 ツールを事前にビルドしてから:
GEN2_DIR=/path/to/gen2 ./kernel/build.sh --target virt  -o kernel.bin
GEN2_DIR=/path/to/gen2 ./kernel/build.sh --target pico2 -o kernel.uf2
```

ビルドフロー (両ターゲット共通):
1. Step 0: `runtime.tc` と `libtc.tc` を 1 度だけコンパイルし `CACHED_S_DIR`
   経由で各タスクビルドで共有 (phase 7 で導入、-8.8 s)
2. ゲストタスク (target 別 TASKS リスト — virt は
   hello/hello2/catfile/sh/tmpdemo/echo、pico2 は hello/hello2/catfile/launcher)
   を raw バイナリにコンパイル。各タスクには `task_arena_size()` /
   `task_stack_size()` の値を `.word` 2 本の header として prepend する
   (K3 案C)。`EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1
   asm_pass2 cat"` を渡すと phase 7 のコンパイラタスク群を追加できる
3. `tools/mkfs.py` で `/bin/<task>` + `/hello.txt` + phase 7 の test 入力
   (`/phase7.tc` / `/hw.tc`) + OS 側 linker 用 `/prelude.s` (= `; raw` +
   `.word 32768; .word 8192` + task_crt0.s + cached runtime.s) +
   `/prelude_tail.s` (= task_data.s) を含む mtfs イメージを生成
4. virt は `--disk-out` でイメージを出力し、qemu の `-drive` から読む。
   pico2 は `bin2s.sh _mtfs_image` で .rodata に埋め込み、XIP 経由で読む
5. platform_*.s + trap_common.s + crt0_*_data.s + kernel*.tc (+pico2 は mtfs image)
   を asm_pass1/pass2 で結合してリンク
6. 起動時にカーネルの `loader.tc` (`load_task`) が `/bin/*` を VFS で開き、
   先頭 8 バイトの K3 header (`arena_size / stack_size`) を読んで
   `make_task(entry+8, arena, stack)` を呼ぶ。XIP 可能なら flash 上の
   アドレスを直接 entry にし、そうでなければ RAM にコピーする。pico2 は
   spawn/exec 経由の動的タスクは未対応 (problem.md K7)

qemu virt で実行:
```bash
qemu-system-riscv32 -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -device "loader,file=kernel.bin,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0"
```

Pico 2 実機で実行 (Debug Probe + openocd-rpi):
```bash
./kernel/run_pico2.sh kernel/kernel_pico2.uf2
# → openocd で SWD 経由フラッシュ → /dev/ttyACM0 で UART キャプチャ
```

タスクは ecall で syscall を発行 (Linux 互換 ABI: a7=56 openat,
a7=57 close, a7=63 read, a7=64 write, a7=93 exit, a7=220 clone/spawn,
a7=221 execve, a7=260 wait4)。
カーネルの ecall handler (trap_common.s) がアセンブリでディスパッチし、
read/write/openat/close は `kernel/vfs.tc` 経由で mtfs / UART に振り分け、
exec は `kernel/loader.tc` の `sys_exec_handler` が呼び出し元の
スケジューラスロットを新バイナリに置き換える。
タイマ割り込みで TC の trap_handler (kernel_common.tc) がラウンドロビン
スケジューリングを実行。詳細は `docs/task/kernel_design.md`、
`docs/task/kernel_platform_split.md`、`docs/task/phase6_userland.md`、
`docs/filesystem.md` を参照。

### Pico 2 デバッグ環境

`~/opt/openocd-rpi/bin/openocd` (Raspberry Pi fork、RP2350 RISC-V 対応) を
使って SWD 経由で実機デバッグできる。Debug Probe (CMSIS-DAP) が必要。

```bash
# 接続テスト
~/opt/openocd-rpi/bin/openocd -s ~/opt/openocd-rpi/share/openocd/scripts \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "init; halt; mdw 0xd0000000 4; exit"
```

UART は Debug Probe の CDC-ACM 経由で `/dev/ttyACM0` (115200 8N1)。

## 言語仕様

- 整数リテラル: 10進数、hex (`0xFF`)、binary (`0b1010`)、サフィックス (`u32`, `i8` 等)
- 本体なし関数宣言: `fn name(args) -> ret;` (セミコロンで終わる、シグネチャのみ)
  → アセンブリ関数や別モジュールの関数を呼ぶときに使う。リンカが解決
- 配列コンストラクタのサイズ型は `u32`。リテラルは `U8Array(256u32)`、
  変数は `U8Array(n as u32)`。`len/get/set` の idx と戻り値は `i32` のまま
- `struct Xxx` を宣言すると、`XxxArray` 型と `XxxArray(u32) / len / get /
  set / delete` が自動生成される（parser が synthetic fn として emit、
  U32Array builtin に委譲される）
- trailing comma を struct フィールド / 関数パラメータ / 関数呼び出し引数
  で許容
- `>>` は u32 では論理右シフト (`srl`)、i32 / i8 / i16 では算術右シフト
  (`sra`)。バイトコードでは `shr` (signed) と `shr_u` (unsigned) を区別
- `docs/language.md` — TinyC言語仕様
- `docs/bc_format.md` — バイトコード形式仕様
- `docs/ast_format.md` — AST ファイルフォーマット（.ast/.tast/.th）
- `docs/filesystem.md` — VFS / MyTinyFS 設計
- `docs/design_decisions.md` — 意図的に残している設計判断 (直す前に読む)
- `docs/problem.md` — 未解決の問題 / refactor TODO
- `docs/sources.md` — ソースファイル一覧と説明
- `docs/tinyc_cheatsheet.md` — TinyC構文チートシート
