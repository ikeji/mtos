# ソースファイル一覧

## ディレクトリ構成

```
compiler/   サブプロジェクト 1: TinyC コンパイラ (ホスト + MTOS 両ターゲット)
userland/   サブプロジェクト 2: MTOS ユーザータスク
kernel/     サブプロジェクト 3: OS カーネル (virt / pico2 両プラットフォーム)
integration/  3 サブプロジェクトをまたぐテスト
tests/      共有テストインフラ (test_all.sh, test_common.sh)
docs/       ドキュメント
build/      生成物 (gitignored)
```

詳細設計は `docs/task/subproject_split.md`。各サブプロジェクトは
独立した `Makefile` を持ち、`make -C <subproject> test` で
そのサブプロジェクトのテストだけを実行する。

---

## サブプロジェクト 1: コンパイラ `compiler/`

```
compiler/
├── bootstrap/      C 製 Gen1 (x86 native)
├── src/            TC 製 Gen2/3 ソース
├── runtime/
│   ├── linux/      Linux ELF + qemu-riscv32 用 crt0
│   └── mtos/       MTOS bin 用 crt0 (userland と compiler-on-MTOS が共用)
├── scripts/        compile-gen{1,2,3}.sh + helper
├── tests/          コンパイラ単体テスト + 入力 + golden
└── Makefile
```

### Gen1: C 実装 (`compiler/bootstrap/`)

#### コアライブラリ

| ファイル | 説明 |
|---|---|
| `lexer.c` / `lexer.h` | 字句解析器 (TOKEN 分割) |
| `ast.c` / `ast.h` | AST 生成・操作・S 式 I/O |
| `parser.c` / `parser.h` | LL(1) 再帰下降パーサ |
| `typecheck.c` / `typecheck.h` | 型チェッカー |
| `interp.c` / `interp.h` | AST インタープリタ |
| `codegen.c` / `codegen.h` | バイトコードジェネレータ |

#### エントリポイント

| ファイル | 生成バイナリ | 説明 |
|---|---|---|
| `parse_main.c` | `parse` | ソース → AST (S 式) |
| `typecheck_main.c` | `typecheck` | 旧 monolithic 型検査器 (Gen1 only) |
| `interp_main.c` | `interp` | ソース → AST インタープリタ実行 |
| `codegen_main.c` | `codegen` | ソース → バイトコード |
| `extract_sigs.c` | `extract-sigs` | .ast → .th (export シグネチャ抽出) |
| `bcrun.c` | `bcrun` | バイトコードインタープリタ |
| `bc2asm.c` | `bc2asm` | バイトコード → RISC-V asm |

#### ランタイム

| ファイル | 説明 |
|---|---|
| `runtime_syscall.c` | RV32 ベアメタル用 (プールアロケータ + syscall stub) |
| `crt0.s` | GCC リンク用スタートアップ |

### Gen2/3: TC 自己ホスト (`compiler/src/`)

| ファイル | 説明 / ピーク |
|---|---|
| `parse.tc` | レキサ + LL(1) パーサ。ソース → AST |
| `sigscan.tc` | 拡張 .th 抽出器 (peak ~10 KB) |
| `tcheck.tc` | ストリーミング型検査器 (peak 75-252 KB) |
| `codegen.tc` | 型付き AST → バイトコード (peak 80-252 KB) |
| `bc2asm.tc` | バイトコード → RISC-V asm (peak 120-126 KB) |
| `bcrun.tc` | TC 版バイトコードインタープリタ (リファレンス実装) |
| `asm_common.tc` | asm_pass1/2/3 共通 encoder / parser |
| `asm_pass1.tc` | label collector (peak ~250 KB) |
| `asm_pass2.tc` | .lab 統合 + sym resolve |
| `asm_pass3.tc` | エンコーダ (peak 260-280 KB) |
| `asm_pass2_lib.tc`, `asm_pass3_lib.tc`, `asm_dead_strip.tc` | 内部ヘルパ |

### 共有ライブラリ

| ファイル | 説明 |
|---|---|
| `ast_node.tc` | AST ノードプール (`struct AstNode` + AstNodeArray + n_* wrappers) |
| `string_buffer.tc` | 伸長バッファ (emit_string/emit_nl/emit_int 等) |
| `source_reader.tc` | ストリーミング入力リーダー (4 KB バッファ) |
| `strlib.tc` | 共通ユーティリティ (is_digit, is_alpha, streq, cmp 等) |
| `runtime.tc` | TC 製 kmalloc/kfree/km_dump_peak (Two-ended allocator) |

### ランタイム

| ファイル | 説明 |
|---|---|
| `runtime/linux/crt0_tc.s` | Linux ELF (qemu-riscv32) 用 crt0 |
| `runtime/linux/crt0_tc_data.s` | .data + .bss + `__arena` |
| `runtime/mtos/task_crt0.s` | MTOS bin 用 crt0 (userland と compiler-on-MTOS 共用) |
| `runtime/mtos/task_data.s` | MTOS bin 用 .data + .bss |

### スクリプト (`compiler/scripts/`)

| ファイル | 説明 |
|---|---|
| `compile-gen1.sh` | Gen1 ツールで .tc → RV32 ELF (GCC リンク) |
| `compile-gen2.sh` | Gen2 ツールで .tc → RV32 ELF (qemu-riscv32 経由) |
| `compile-gen3.sh` | Gen3 = Gen2 を使った自己ホスト確認 |
| `collect_imports.sh` | TC ファイルの transitive import 解決 |
| `tc_deps_to_d.sh` | Make .d 依存ファイル生成 |

### テスト (`compiler/tests/`)

| ファイル | 説明 |
|---|---|
| `test_unit.sh` | Gen1 単体 (parse/typecheck/codegen/interp/bcrun/rv32) |
| `test_pipeline.sh` | Gen2 パイプライン (qemu rv32) |
| `test_consistency.sh` | tc_run_all 全 5 メソッド一致 |
| `test_golden_examples.sh` | サンプル .tc の golden 比較 |
| `test_gen3.sh` | Gen2 == Gen3 byte-exact 自己ホスト確認 |
| `test_import.sh` | 複数ファイル import/export |
| `test_asm.sh` | hello2.tc を `; raw` で compile → qemu virt 実行 |
| `update_golden.sh` | golden 再生成 |
| `bench_pipeline.sh` | パイプライン性能計測 |
| `qemu_bin2uf2_test.py` | bin2uf2 byte-exact 検証 |
| `golden/`, `golden/tc/` | Gen1 基準出力 |
| `import/` | import テスト fixture |
| `virt_crt0.s` | qemu virt 用 crt0 (test_asm 専用) |
| `*.tc` | 入力 (hello, hello2, fib, fizzbuzz, calc, struct_*, ...) |

---

## サブプロジェクト 2: ユーザータスク `userland/`

```
userland/
├── lib/libtc/      共通ユーザライブラリ
├── bin/<task>/     各タスク (40 個)
└── Makefile
```

### 共通ライブラリ

| ファイル | 説明 |
|---|---|
| `lib/libtc/libtc.tc` | puts/eputs/putchar/print/string_from_bytes/eq + do_* syscall stub の forward decl |

### タスク (`userland/bin/`)

`task_crt0.s` / `task_data.s` (compiler/runtime/mtos/) が全タスク共通の crt0。
各タスク dir に `<name>.tc` と `task.mk` (GUEST_TASKS / EXTRA_GUEST_TASKS 宣言 +
TASK_ARENA_<name> / TASK_STACK_<name>) を置く。

**coreutils 系**:

| タスク | 説明 |
|---|---|
| `hello/`, `hello2/` | "A" / "B" 出力 (seed) |
| `cat/` | argv[1..] のファイルを stdout |
| `echo/` | argv[1..] を space 区切り + \n で stdout |
| `ls/` | ディレクトリ一覧 (sys_readdir ecall 89) |
| `wc/` | 行数 / バイト数カウント |
| `head/` | 先頭 N 行 |
| `cp/` | ファイルコピー |
| `du/` | ディレクトリ使用量 |
| `grep/` | 部分文字列検索 |
| `rm/` | ファイル削除 (`-r` / `-f` 対応) |
| `mkdir/`, `rmdir/` | ディレクトリ作成 / 削除 (ecall 34/40、`/sd/` 専用) |
| `rot13/` | ROT13 変換 |
| `md5sum/` | MD5 ハッシュ |

**アプリ系**:

| タスク | 説明 |
|---|---|
| `sh/` | 対話シェル (history / TAB 補完 / pipe / `<` `>`) |
| `msh/` | プロンプト/echo なしの silent sh (UART mux driver 用) |
| `vi/` | 最小 vi エディタ (hjkl/dd/gg/:w/:q、ANSI 描画、縦スクロール) |
| `console/` | Windows 95 風 GUI コンソール (LCD 接続時) |
| `neofetch/` | ASCII banner + /proc/tasks stats |
| `count/`, `seq/` | 数字を一定間隔で出力 (協調 preempt 可視化) |

**phase 7 / テスト用**:

| タスク | 説明 |
|---|---|
| `catfile/` | argv[1] or `/hello.txt` を `CAT[argc]:` 付きで |
| `launcher/` | `do_exec(/bin/catfile)` (spawn/exec cascade smoke) |
| `tmpdemo/` | /tmp/demo を O_WRONLY|O_CREAT で書いて読み返す |

**UART / SD カード関連**:

| タスク | 説明 |
|---|---|
| `mx/`, `mr/` | length-prefix frame stdin↔stdout (UART 転送用) |
| `muxon/`, `muxoff/` | UART mux 有効化/無効化 (ecall 250) |
| `sdprobe/` | SD SPI smoke test |
| `kbdump/` | キーボード スキャンマトリクス dump |
| `fbtest/` | /dev/fb (フレームバッファ) smoke test |
| `tcc/` | OS 内 phase 7 driver (parse → asm_pass3 を sequential spawn) |
| `bin2uf2/` | raw bin → UF2 コンバータ (UF2 family_id 0xE48BFF5A) |

**Compiler-on-MTOS (symlink for `compiler/src/*.tc`)**:

| タスク | symlink target |
|---|---|
| `parse/parse.tc` | `compiler/src/parse.tc` |
| `sigscan/sigscan.tc` | `compiler/src/sigscan.tc` |
| `tcheck/tcheck.tc` | `compiler/src/tcheck.tc` |
| `codegen/codegen.tc` | `compiler/src/codegen.tc` |
| `bc2asm/bc2asm.tc` | `compiler/src/bc2asm.tc` |
| `asm_pass1/asm_pass1.tc` | `compiler/src/asm_pass1.tc` |
| `asm_pass2/asm_pass2.tc` | `compiler/src/asm_pass2.tc` |
| `asm_pass3/asm_pass3.tc` | `compiler/src/asm_pass3.tc` |

これらは `EXTRA_GUEST_TASKS` に登録されており、`make -C kernel pico2-kernel-extra` 等で
disk-extra.img に組み込まれる。

---

## サブプロジェクト 3: カーネル `kernel/`

```
kernel/
├── src/            kernel core (両プラットフォーム共通)
├── platform/
│   ├── virt/       qemu virt 固有
│   └── pico2/      RP2350 Pico 2 固有
├── scripts/        build.sh + run helper + bin2s + genjpfont
├── tools-src/      kernel ビルド時に使う TC ホストツール
├── tests/          kernel 単体テスト (test_os など)
└── Makefile
```

### Core (`kernel/src/`)

| ファイル | 説明 |
|---|---|
| `kernel.tc` | virt 用 main + rearm_timer + mtfs mount |
| `kernel_pico2.tc` | pico2 用 main + rearm_timer (SIO MTIME) + dump_mtfs_to_sd |
| `kernel_common.tc` | スケジューラ + Task 構造体 + make_task + UART mux |
| `vfs.tc` | VFS 層 (fd table, /tmp は tmpfs, /proc は procfs, /sd は fatfs) |
| `tmpfs.tc` | RAM backed FS (kmalloc backed, grow-on-write, O_CREAT/O_TRUNC) |
| `mtfs.tc` | MyTinyFS read-only ドライバ |
| `procfs.tc` | /proc 仮想 FS (/proc/tasks, /proc/meminfo, ...) |
| `fatfs.tc` | FAT12/16/32 ドライバ (VFAT LFN + サブディレクトリ) |
| `devfs.tc` | /dev デバイス FS |
| `loader.tc` | task binary 読み込み + K3 案 C 8 byte header 解析 |
| `rtc.tc` | プラットフォーム独立 RTC (epoch ↔ 年月日 変換) |
| `trap_common.s` | trap entry/exit + ecall dispatch |

### virt platform (`kernel/platform/virt/`)

| ファイル | 説明 |
|---|---|
| `platform_virt.s` | _start, 16550 UART, _set_kern_gp |
| `platform_virt.tc` | virt platform 固有 helper |
| `crt0_data.s` | virt 用 BSS (`__arena .space 96 MB`) |
| `block_virtio.tc` | virtio-mmio (legacy v1) ブロックデバイスドライバ |
| `block_fat_virtio.tc` / `block_fat_stub.tc` | FAT block adapter |
| `dev_backend_virt.tc` | qemu virt 用 /dev/fb (UART dump) + /dev/kbd (UART RX) |

### pico2 platform (`kernel/platform/pico2/`)

| ファイル | 説明 |
|---|---|
| `platform_pico2.s` | IMAGE_DEF, XOSC, PL011, .data コピー |
| `platform_pico2.tc` | pico2 platform 固有 helper |
| `crt0_pico2_data.s` | pico2 用 BSS (`__arena` 480 KB) |
| `block_flash.tc` | XIP flash block デバイスドライバ |
| `block_sd.tc` | SD カード SPI0 backend |
| `display_ili9488.tc` | ILI9488 LCD over SPI1 |
| `keyboard_matrix.tc` | GPIO scan matrix keyboard backend |
| `rtc_ds3231.tc` | DS3231 over bit-bang I2C (GP32/33) |

### ビルドスクリプト (`kernel/scripts/`)

| ファイル | 説明 |
|---|---|
| `build.sh` | virt / pico2 共通ビルド (`--target virt|pico2 -o output --disk-out path`) |
| `bin2s.sh` | raw バイナリ → .s データ変換 |
| `bin2s_incbin.sh` | raw バイナリ → `.incbin SIZE "path"` 経由の .s |
| `run_pico2.sh` | Debug Probe 経由で pico2 に flash + UART キャプチャ |
| `run_pico2_interactive.sh` | build + flash + 双方向 UART コンソール |
| `genjpfont.py` | np21w PC-98 font.bmp → jpfont.dat (console 用) |

### ホストツール (`kernel/tools-src/`)

TC で書かれた kernel build 用ツール。`compile-gen1.sh` で RV32 ELF にビルドし、
qemu-riscv32 経由で呼ぶ。

| ファイル | 説明 |
|---|---|
| `mkfs.tc` | mtfs ディスクイメージ生成 (Python `tools/mkfs.py` の TC port) |
| `bin2uf2.tc` | raw bin → UF2 (family_id 0xe48bff5a) コンバータ |

### テスト (`kernel/tests/`)

| ファイル | 説明 |
|---|---|
| `test_os.sh` | kernel + tmpfs + argv + redirect + devfs + rtc + fb + kbd + pipe + console の virt end-to-end |
| `test_pico2.sh` | pico2 実機 boot smoke (要 Debug Probe) |
| `test_pico2_hw.sh` | pico2 hardware test |
| `test_pico2_sd.sh`, `test_pico2_phase7_sd.sh`, `test_pico2_bench.sh` | pico2 SD カード / phase7 / 性能ベンチ |
| `fb_render.py` | /dev/fb framed-blit dump を BMP に変換 |
| `fixtures/kern_demo.conf` | `init=/bin/hello + hello2 + sh` |
| `fixtures/kern_console.conf`, `kern_console_land.conf` | console portrait / landscape |
| `fixtures/msh_smoke.sh`, `msh_abort.sh` | msh script テスト |

---

## Integration テスト `integration/`

3 サブプロジェクトをまたぐテスト。`make test` には含めず、`make full-test`
または手動で実行する。

| ファイル | 何が境界をまたぐか |
|---|---|
| `test_phase7.sh` | コンパイラ全段を userland として実機 OS 上で実行 |
| `pico2_self_replicate.sh` | pico2 上で kernel + 全コンパイラを実機再生成し host gen2 と md5 一致を検証 |
| `pico2_verify.sh` | pico2 実機で compile 7 段の byte-exact 検証 |
| `pico2_test_compile_parse.sh` | parse.bin 単体実機検証 |
| `phase3_verify.py` | virt 上で 9 段全部走らせて byte-exact 検証 |
| `qemu_mr_scale.py` | K11 (mr UART hang) qemu virt 再現 |
| `pico2_hw_driver.py`, `pico2_tty.py`, `uart_demux.py`, `pico2_drive.py`, ... | pico2 UART driver / utility |
| `inputs/phase7_hello{,_world,_min}.tc` | phase 7 テスト入力 |
| `fixtures/pico2_*.sh` | pico2 実機 fixture (self_step1-4、dumper test 等) |
| `fixtures/calib.sh` | キャリブレーション fixture |

---

## 共有テストインフラ `tests/`

| ファイル | 説明 |
|---|---|
| `test_all.sh` | 全 suite を順に呼ぶ集約スクリプト (root `make test` から呼ばれる) |
| `test_common.sh` | 全テスト script が source する共通ヘルパ (paths, counters, build_gen2_tool, ensure_gen2_tools, report_pass/fail) |

---

## ドキュメント `docs/`

| ファイル | 説明 |
|---|---|
| `overview.md` | プロジェクト全体の概要 |
| `language.md` | TinyC 言語仕様 |
| `compiler.md` | コンパイラパイプライン設計 |
| `kernel.md` | OS カーネル設計 / 実装 |
| `filesystem.md` | VFS + MyTinyFS 設計 |
| `pico2_hardware.md` | Pico 2 開発基板ガイド |
| `design_decisions.md` | 意図して残している挙動の設計判断集 |
| `problem.md` | 未解決バグ / limitation / ergonomics |
| `solved.md` | 解決済み問題ログ |
| `roadmap.md` | 開発ロードマップ |
| `scaling.md` | OS self-host コンパイル時のメモリ / 時間スケーリング分析 |
| `tinyc_cheatsheet.md` | TinyC 構文クイックリファレンス |
| `ast_format.md` | AST ファイルフォーマット (.ast / .tast / .th) |
| `bc_format.md` | バイトコード フォーマット仕様 |
| `lab_format.md` | .lab (asm_pass2 出力) 仕様 |
| `scripts.md` | スクリプト一覧と呼び出し関係 |
| `sources.md` | このファイル: ソースファイル一覧 |
| `task/` | タスク計画・デバッグノート |
| `task/subproject_split.md` | 3 サブプロジェクト分割の詳細設計 |
