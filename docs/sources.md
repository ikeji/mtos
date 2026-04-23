# ソースファイル一覧

## ディレクトリ構成

```
bootstrap/  C 実装のブートストラップコンパイラ (Gen1)
compiler/   TC 自己ホストコンパイラ (Gen2 / Gen3) + 共通ライブラリ
kernel/     OS カーネル (virt / pico2 両対応) とタスク群
tools/      ホスト側ビルドツール (Python / shell)
tests/      テストファイル + テストインフラ
docs/       ドキュメント
```

---

## C 実装 (フェーズ1ブートストラップ): `bootstrap/`

### コアライブラリ

| ファイル | 説明 |
|----------|------|
| `bootstrap/lexer.c` / `lexer.h` | 字句解析器 (TOKEN 分割) |
| `bootstrap/ast.c` / `ast.h` | AST 生成・操作・S 式 I/O |
| `bootstrap/parser.c` / `parser.h` | LL(1) 再帰下降パーサ |
| `bootstrap/typecheck.c` / `typecheck.h` | 型チェッカー |
| `bootstrap/interp.c` / `interp.h` | AST インタープリタ |
| `bootstrap/codegen.c` / `codegen.h` | バイトコードジェネレータ (C 版) |

### エントリポイント

| ファイル | 生成バイナリ | 説明 |
|----------|-------------|------|
| `parse_main.c` | `parse` | ソース → AST (S 式) |
| `typecheck_main.c` | `typecheck` | ソース → 型チェック済 AST (旧 monolithic 版、Gen1 でのみ使用) |
| `interp_main.c` | `interp` | ソース → AST インタープリタ実行 |
| `codegen_main.c` | `codegen` | ソース → バイトコード |
| `extract_sigs.c` | `extract-sigs` | .ast → .th (export シグネチャ抽出)。compile-gen2.sh の imports 側で使用 |

### バイトコード実行・変換

| ファイル | 生成バイナリ | 説明 |
|----------|-------------|------|
| `bcrun.c` | `bcrun` | バイトコードインタープリタ。`kmalloc` / `kfree` / `km_dump_peak` の builtin stub あり (tcheck.tc を bcrun で動かすため) |
| `bc2asm.c` | `bc2asm` | バイトコード → RISC-V アセンブリ (C 版) |

### ランタイム

| ファイル | 説明 |
|----------|------|
| `runtime_syscall.c` | RV32 ベアメタル用ランタイム (プールアロケータ + syscall stub) |
| `crt0.s` | GCC リンク用スタートアップ |

---

## TC 自己ホスト実装 (フェーズ2〜): `compiler/`

### コンパイラパイプライン

| ファイル | 説明 / ピーク |
|----------|------|
| `parse.tc` | レキサ + LL(1) パーサ。ソース → AST |
| `sigscan.tc` | 拡張 .th 抽出器。AST を stream 読みして全 top-level (export / 非 export / struct / グローバル変数) を .th に吐く。peak ~10 KB |
| `tcheck.tc` | ストリーミング型検査器。`(imports) (self) (program)` ラッパーで per-function check + .tast emit。per-fn strtab rollback + per-fn kmalloc fntab。peak 75〜252 KB |
| `codegen.tc` | 型付き AST → バイトコード。per-top-level strtab rollback。peak 80〜252 KB |
| `bc2asm.tc` | バイトコード → RISC-V asm。per-function emission。peak 120〜126 KB |
| `bcrun.tc` | TC 版バイトコードインタープリタ (リファレンス実装) |
| `asm_common.tc` | asm_pass1 / pass2 の共通 encoder / parser core |
| `asm_pass1.tc` | ラベル収集。.s → .lab。peak ~250 KB |
| `asm_pass2.tc` | エンコーダ。.lab + .s を 3 pass re-scan して stream emit。peak 260〜280 KB (Phase 5 で旧 4.6 MB から ~16x 削減) |

### 共有ライブラリ (複数コンパイラから import)

| ファイル | 説明 |
|----------|------|
| `ast_node.tc` | AST ノードプール (`struct AstNode` + `AstNodeArray` + `n_*` wrappers)。codegen / sigscan / tcheck が import |
| `string_buffer.tc` | 伸長バッファ (`emit_string` / `emit_nl` / `emit_int` 等) |
| `source_reader.tc` | ストリーミング入力リーダー (4 KB バッファ) |
| `strlib.tc` | 共通ユーティリティ (`is_digit`, `is_alpha`, `streq`, `cmp` 等) |
| `runtime.tc` | TC 製ランタイム (kmalloc / kfree / km_dump_peak)。compile-gen2/3.sh で使用 |

### ランタイム (Linux ELF 向け)

| ファイル | 説明 |
|----------|------|
| `crt0_tc.s` | asm_pass1/2 リンク用 Linux crt0 (_start, syscall stub, peek/poke) |
| `crt0_tc_data.s` | asm_pass1/2 リンク用プールメタデータ (`.data` + `.bss` + `__arena`) |

---

## OS カーネル: `kernel/`

### 共通 (virt / pico2 両対応)

| ファイル | 説明 |
|----------|------|
| `kernel_common.tc` | スケジューラ + `Task` 構造体 + make_task + UART mux + 共通 helper |
| `vfs.tc` | VFS 層。`/tmp` は tmpfs、`/proc` は procfs、その他絶対パスは mtfs。fd=0/1 はリダイレクト対応、fd=2 stderr は UART 直行 |
| `tmpfs.tc` | RAM backed FS (kmalloc backed、grow-on-write、O_CREAT / O_TRUNC 対応) |
| `mtfs.tc` | MyTinyFS read-only ドライバ (mount/lookup/open/read/close) |
| `procfs.tc` | read-only virtual FS (`/proc/tasks`, `meminfo`, `cpuinfo`, `uptime`) |
| `fatfs.tc` | FAT ドライバ (SD bring-up 中) |
| `loader.tc` | K3 案C 8 byte header 読みと make_task 呼び出し。`sys_exec_handler` / `sys_spawn_handler` / `sys_spawn_fds_handler` 実装 |
| `trap_common.s` | trap entry/exit + ecall dispatch (write64 / read63 / openat56 / close57 / readdir89 / exit93 / pipe222 / spawn_fds219 / spawn220 / exec221 / mux250 / wait260) |

### virt (qemu) 固有

| ファイル | 説明 |
|----------|------|
| `kernel.tc` | virt 用 main + rearm_timer + mtfs mount |
| `platform_virt.s` | virt 固有: `_start`, 16550 UART, `_set_kern_gp` |
| `crt0_data.s` | virt 用 BSS (`__arena .space 96 MB`) |
| `block_virtio.tc` | virtio-mmio (legacy v1) block デバイスドライバ |
| `block_fat_virtio.tc` | FAT 用 virtio ブロック adapter |
| `block_fat_stub.tc` | FAT 用 stub (pico2 で未接続時) |

### pico2 固有

| ファイル | 説明 |
|----------|------|
| `kernel_pico2.tc` | pico2 用 main + rearm_timer (SIO MTIME) |
| `platform_pico2.s` | pico2 固有: IMAGE_DEF, XOSC, PL011, .data コピー |
| `crt0_pico2_data.s` | pico2 用 BSS (`__arena` 480 KB) |
| `block_flash.tc` | XIP flash block デバイスドライバ (`_mtfs_image_addr` 経由) |

### ビルドスクリプト

| ファイル | 説明 |
|----------|------|
| `build.sh` | virt / pico2 共通ビルド (`--target virt|pico2` + `-o` + `--disk-out` + `EXTRA_TASKS`) |
| `bin2s.sh` | raw バイナリ → `.s` データ変換 |
| `run_pico2.sh` | Debug Probe 経由で pico2 に flash + UART キャプチャ |
| `run_pico2_interactive.sh` | build + flash + 双方向 UART コンソール (`make run-pico2`) |

### タスク (`kernel/tasks/`)

`task_crt0.s` + `task_data.s` が全タスク共通の crt0 / BSS。
libtc は全タスクが import する user ライブラリ。

| タスク | 説明 |
|--------|------|
| `libtc/libtc.tc` | puts / eputs / putchar / print / string_from_bytes / eq、path-taking do_* syscall stub の forward decl を集約 |
| `hello/hello.tc` | "A" 出力 (seed) |
| `hello2/hello2.tc` | "B" 出力 (seed) |
| `catfile/catfile.tc` | argv[1] または `/hello.txt` を開いて `CAT[argc]:` 付きで出力 |
| `launcher/launcher.tc` | `do_exec` で `/bin/catfile` を exec (spawn/exec cascade の smoke test) |
| `sh/sh.tc` | 対話シェル (spawn + wait + `< > |` + 絶対パス + TAB 補完 + history) |
| `msh/msh.tc` | プロンプト/echo なしの silent sh (UART mux driver 用) |
| `tmpdemo/tmpdemo.tc` | /tmp/demo を O_WRONLY|O_CREAT で書いて読み返す phase 7 A 回帰テスト |
| `echo/echo.tc` | argv[1..] を space 区切り + \n で stdout |
| `cat/cat.tc` | argv[1..] のファイルを順に stdout、存在しなければ stderr + exit 1 |
| `ls/ls.tc` | ディレクトリ一覧 (sys_readdir) |
| `wc/wc.tc` | 行数 / バイト数カウント |
| `head/head.tc` | 先頭 N 行表示 |
| `cp/cp.tc` | ファイルコピー |
| `du/du.tc` | ディレクトリ使用量 |
| `grep/grep.tc` | 部分文字列検索 |
| `rm/rm.tc` | ファイル削除 (#30 により /tmp は未対応) |
| `rot13/rot13.tc` | ROT13 変換 |
| `neofetch/neofetch.tc` | ASCII banner + /proc/tasks stats |
| `vi/vi.tc` | 最小 vi エディタ (normal/insert/cmdline、hjkl/dd/gg/:w/:q、ANSI 描画、縦スクロール) |
| `count/count.tc` | 数字を一定間隔で出力 (協調 preempt 可視化) |
| `mx/mx.tc` | stdin → length-prefix framed stdout (UART 転送用) |
| `mr/mr.tc` | mx の逆: framed stdin → raw stdout |
| `muxon/muxon.tc` | UART mux 有効化 (ecall 250) |
| `muxoff/muxoff.tc` | UART mux 無効化 |
| `parse/`, `sigscan/`, `tcheck/`, `codegen/`, `bc2asm/`, `asm_pass1/`, `asm_pass2/` | `compiler/*.tc` への symlink。`EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 cat"` を渡したときだけビルドされ `/bin/<name>` として mtfs に入る (test_phase7.sh が参照) |

---

## ホスト側ツール: `tools/`

| ファイル | 説明 |
|---|---|
| `mkfs.py` | MyTinyFS ディスクイメージ生成 (Python)。`mkfs.py <output> <rootdir>` でディレクトリを再帰的に取り込み、1 階層のサブディレクトリを dir inode 化 |
| `bin2uf2.py` | raw bin → UF2 (family_id=0xe48bff5a) コンバータ。`kernel/build.sh --target pico2` が内部で呼ぶ |
| `collect_imports.sh` | TC ファイルの transitive import を解決して `.d` fragment に出す |
| `tc_deps_to_d.sh` | Make 用 `.d` 依存ファイルを生成 |

---

## テストファイル: `tests/`

### TC サンプル (unit / golden / consistency 対象)

| ファイル | 説明 |
|----------|------|
| `hello.tc` | Hello World (U8Array に文字を直接 set して sys_write) |
| `hello2.tc` | Hello World その 2 (String から U8Array に変換して sys_write) |
| `fib.tc` | フィボナッチ数列 (再帰) |
| `fizzbuzz.tc` | FizzBuzz |
| `calc.tc` | 四則演算電卓 (stdin から式を読んで評価、グローバル変数) |
| `elseif_test.tc` | else if チェーン |
| `charliteral_test.tc` | 文字リテラル (`'A'`, `'\n'` 等) |
| `break_test.tc` / `continue_test.tc` / `nested_break_test.tc` | ループ制御 |
| `struct_basic.tc` / `struct_overload.tc` | struct と合成関数のオーバーロード |
| `source_reader_test.tc` | ストリーミングリーダーのユニットテスト |
| `type_test.tc` | 型検査エラー確認 |
| `test_echo.tc` | stdin echo |
| `test_timer.tc` | CSR 操作 + mtime タイマ割り込み (test_asm.sh で使用) |
| `test_kmalloc.tc` | kmalloc / kfree のストレス (FULL_TEST) |
| `test_kernel1.tc` | 協調タスク動作 (FULL_TEST) |
| `phase7_hello.tc` / `phase7_min.tc` / `phase7_hello_world.tc` | phase 7 テスト入力。kernel/build.sh が /phase7.tc / /phase7_min.tc / /hw.tc として mtfs に staging |

### 設定ファイル / フィクスチャ

| ファイル | 説明 |
|---|---|
| `fixtures/kern_demo.conf` | `init=/bin/hello` + hello2 + sh な kern.conf。Makefile が `disk-demo.img` / `pico2_kernel_demo.uf2` で `/etc/kern.conf` として staging |
| `virt_crt0.s` | qemu-system-riscv32 -M virt 用 crt0 (16550 UART + SiFive test 終了) |

### golden (`tests/golden/`)

| サブディレクトリ | 説明 |
|---|---|
| `tests/golden/` | Gen1 の基準出力 (.ast / .bc / .s / .out / .exit) |
| `tests/golden/tc/` | compiler/ ソースの基準出力 |

### スクリプト

詳細は `docs/scripts.md` を参照。

| ファイル | 説明 |
|---|---|
| `test_all.sh` | 全スイートのエントリポイント (`make test`) |
| `test_common.sh` | 共通ライブラリ |
| `test_unit.sh` | Gen1 単体テスト |
| `test_pipeline.sh` | 自己ホスト版パイプラインテスト |
| `test_consistency.sh` | tc_run_all 全メソッド一致 |
| `test_golden_examples.sh` | サンプル .tc golden テスト |
| `test_gen3.sh` | Gen2 == Gen3 自己ホスト検証 |
| `test_import.sh` | import/export テスト |
| `test_asm.sh` | `; raw` モード + qemu virt end-to-end (CSR、タイマ割り込み) |
| `test_os.sh` | kernel + tmpfs + argv + redirect の virt 上 end-to-end |
| `test_phase7.sh` | phase 7 self-hosted (compile → link → run "Hello, World!" on OS) |
| `test_pico2.sh` / `test_pico2_hw.sh` | pico2 実機テスト (手動) |
| `pico2_verify.sh` | pico2 実機で compile 7 段の byte-exact 検証 (手動) |
| `update_golden.sh` | golden 再生成 |
| `phase3_verify.py` | virt 上で全 9 段 byte-exact 検証 |
| `pico2_hw_driver.py` | pico2 UART pipeline driver |
| `pico2_tty.py` | pico2 双方向 raw UART フォワーダー |
| `uart_demux.py` | UART mux フレームパーサー |

### ルートのユーザ向けスクリプト

| ファイル | 説明 |
|---|---|
| `compile-gen1.sh` | Gen1 (C) ツールで .tc → RV32 ELF |
| `compile-gen2.sh` | Gen2 (TC) ツールで .tc → RV32 ELF |
| `compile-gen3.sh` | Gen3 (= Gen2 自身の出力) で同じ処理 |
| `tc_run.sh` | .tc を指定メソッドで実行 |
| `tc_run_all.sh` | 全 5 メソッドで実行し出力一致確認 |
| `tc_build.sh` | 複数 .tc をコンパイル + リンク |

---

## ドキュメント: `docs/`

| ファイル | 説明 |
|----------|------|
| `overview.md` | プロジェクト全体の概要 |
| `language.md` | TinyC 言語仕様 |
| `compiler.md` | コンパイラパイプライン設計 |
| `kernel.md` | OS カーネル設計 / 実装 |
| `filesystem.md` | VFS + MyTinyFS 設計 + フェーズ5 実装計画 |
| `design_decisions.md` | 意図して残している挙動の設計判断集 |
| `problem.md` | 未解決バグ / limitation / ergonomics リスト |
| `solved.md` | 解決済み問題のログ |
| `roadmap.md` | 開発ロードマップ |
| `tinyc_cheatsheet.md` | TinyC 構文クイックリファレンス |
| `ast_format.md` | AST ファイルフォーマット (.ast / .tast / .th) |
| `bc_format.md` | バイトコードフォーマット仕様 |
| `lab_format.md` | .lab (asm_pass1 出力) フォーマット仕様 |
| `scripts.md` | スクリプト一覧と呼び出し関係 |
| `sources.md` | このファイル: ソースファイル一覧と説明 |
| `task/` | タスク計画・デバッグノート |
