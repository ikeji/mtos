# 作業ルール

- タスクの区切りで git コミットする (一時停止やユーザー確認は不要)。
- `make test` の実行時間は 1 分以内を維持する。新規テストを追加するときは
  既存テストの合計時間と合わせてこの上限を超えないか確認する。

---

# 現在のフェーズ

`docs/roadmap.md` 参照。**フルセルフホスト達成 (K18、2026-05-14)**:
pico2 実機が parse / sigscan / tcheck / codegen / bc2asm / asm_pass1
/ asm_pass2 / asm_pass3 の **全 8 コンパイラ binary** を host build
と byte-exact 一致で再生成する。kernel.bin/uf2 の self-replicate
(K13〜K17、2026-05-06〜2026-05-13) と合わせて Pico 2 が catalyst
抜きで kernel + 全コンパイラを再生産できる完全な self-hosting loop
が成立。

実機での self-build 経路 (commit `d59e9c0`、各コンパイラ 5〜21 min):
`/sd/<name>.bin` md5 を `build/kernel/tasks/<name>.bin` と比較して
完全一致を確認済。詳細は `docs/solved.md` の K18 entry。

完了済の前段マイルストーン:
- **Pico 2 self-replicate 1-boot byte-exact 完走** (K13 解決
  2026-05-06、K15 再帰仕上げ 2026-05-12、K16 kernel arena
  fragmentation 解消 2026-05-13、K17 tcheck fd_t leak 解消 + byte-
  exact 1 boot 完走 2026-05-13): host gen2 build と md5 完全一致
  を確認した状態で `CLEAN_SD=1 REFRESH_KERN_MODS=1 NORESET=1
  tests/pico2_self_replicate.sh` が end-to-end **~22 min** で完走
  (2026-05-13 計測、commit 66386cb)。
- **Hello World end-to-end** も 1 boot で **13.78 sec** に短縮
  (K7 era 127 sec → 9.2× speedup、`docs/scaling.md` Q1)。

これでコンパイラ + カーネル全ソースが pico2 でセルフホストし、ホスト
PC は触媒として一度ソースを置いた後は更新時にしか登場しない。詳細は
`docs/solved.md` の K13 / K15 / K16 / K17 / K18 エントリ、
`docs/roadmap.md` 2026-05-06 milestone。

完了した過去マイルストーン — フェーズ 7 完走 (K7 解決、2026-04-29、qemu
virt + pico2 実機で `parse → sigscan → tcheck → codegen → bc2asm →
asm_pass1 → asm_pass2` 完走、"Hello, World!" 出力)、パイプライン 100
KB 計画 Phase 1+2+3 (sigscan/tcheck 分割 + asm 分割 + in-place shrinks)、
Gen2 toolchain migration、K3 タスクサイズ宣言、Make ベース incremental
build、UART 多重化 + msh、coreutils (ls/wc/head/cp/du/grep/rm/cat
/mkdir/rmdir エラー処理)、procfs + neofetch + sh タブ補完 + ヒストリ、vi (undo +
縦スクロール)、kern.conf 駆動 init、非ブロッキング UART stdin、パイプ
syscall (`sys_pipe` + `sys_spawn_fds` で concurrent pipeline)、U8Array-
as-String 片付け (`path: String` syscall ABI)、フェーズ 8 部分着手
(`kernel/tools-src/{bin2uf2,mkfs}.tc` + `kernel/platform/*/platform_*.tc` TC port、
`.incbin SIZE "path"` + asm_pass1 incbin-defer で kernel build
6.9× speedup) — 詳細は `docs/roadmap.md` の各 milestone と
`docs/solved.md` の K* / 数字 entry を参照。

**次の候補** (どれも独立):

- **フェーズ 8 残り**: 手書き asm は `platform_*.s` の boot/CSR 部分、
  `trap_common.s`, `crt0_*_data.s`, `task_crt0.s` のみ
- **K11 (mr UART upload hang)**: boot-time dumper で迂回済だが、UART
  大容量転送が pico2 device をハングさせる原因は未特定 (qemu virt
  では再現せず — PL011 / DMA 経路に固有の何か、`docs/problem.md` K11)
- **echo / spawn baseline ではなく pipeline 内の処理時間**: msh-driven
  `echo BENCH_DONE` は ~10 ms と無視可。残るのは個別 task の本体実行
  + SD I/O (`docs/scaling.md` Q1, Q6)。self_replicate ~30 min の支配項
  は asm_pass3 link (~10 min) + bin2uf2 (~9 min) で、どちらも 3.8〜
  7.6 MB を SD 書き込みする時間 (SPI 6 MHz + fatfs FAT cache)
- **bcrun.tc::vm_run の vartab=128 制限**: 現在の tcheck では bcrun.tc
  自身が vartab overflow で compile 不可。pipeline の現実的 worst case
  は bc2asm.tc (nc=1656) に格下げ済 (`docs/scaling.md` Q5)

問題詳細は `docs/problem.md`、self-replicate 全体像は `docs/roadmap.md`
2026-05-06 milestone + `docs/solved.md` K13 / K14、phase 7 実装記録は
`docs/task/phase7_compiler_on_os.md`、pipeline メモリ削減計画は
`docs/task/pipeline_100kb.md`、.lab 中間フォーマットは
`docs/lab_format.md`、スケーリング分析は `docs/scaling.md`。

---

# プロジェクト チートシート

## ディレクトリ構成

3 サブプロジェクト + 共有インフラ。詳細ファイル一覧は `docs/sources.md`、
分割設計は `docs/task/subproject_split.md` を参照。

```
compiler/   サブプロジェクト 1: TinyC コンパイラ
  bootstrap/   Gen1: C 製コンパイラ (x86 native) — parse, codegen, bc2asm 等
  src/         Gen2/3: TC 製コンパイラ — parse.tc, sigscan.tc, tcheck.tc,
               codegen.tc, bc2asm.tc, asm_pass{1,2,3}.tc, ast_node.tc,
               string_buffer.tc, source_reader.tc, strlib.tc, runtime.tc,
               bcrun.tc, asm_common.tc + lib/dead_strip
  runtime/
    linux/     compile-gen2/3.sh が使う crt0 (Linux ELF + qemu-riscv32)
    mtos/      task_crt0.s, task_data.s (MTOS bin 用、userland 共用)
  scripts/     compile-gen{1,2,3}.sh + collect_imports.sh + tc_deps_to_d.sh
  tests/       compiler 単体テスト (test_unit, test_pipeline, test_consistency,
               test_golden_examples, test_gen3, test_import, test_asm) +
               golden/ + 入力 .tc (hello, hello2, fib, fizzbuzz, calc, ...) +
               import/ + virt_crt0.s + update_golden.sh + bench_pipeline.sh
  Makefile     `make -C compiler test` で 140 tests scoped 実行

userland/   サブプロジェクト 2: MTOS ユーザータスク
  lib/libtc/   共通ユーザライブラリ (puts/eputs/print/syscall stub forward decl)
  bin/<task>/  各タスク (40 個) + task.mk (GUEST_TASKS / EXTRA_GUEST_TASKS 宣言)
    sh, msh, ls, cat, echo, wc, head, cp, du, grep, rm, mkdir, rmdir, rot13,
    md5sum, vi, neofetch, console, fbtest, count, seq, mx, mr, muxon, muxoff,
    sdprobe, kbdump, tcc, bin2uf2, launcher, hello, hello2, catfile, tmpdemo
    parse/, sigscan/, tcheck/, codegen/, bc2asm/, asm_pass{1,2,3}/
      → compiler/src/<name>.tc への symlink (compiler-on-MTOS)。
        EXTRA_GUEST_TASKS なので default ビルドには含まれない
  Makefile     `make -C userland test` で全 40 タスク build smoke

kernel/     サブプロジェクト 3: OS カーネル (virt + pico2)
  src/         kernel core (両 platform 共通)
    kernel.tc, kernel_pico2.tc, kernel_common.tc — main + scheduler
    vfs.tc, tmpfs.tc, procfs.tc, mtfs.tc, fatfs.tc, devfs.tc, loader.tc,
    rtc.tc, trap_common.s
  platform/
    virt/       platform_virt.{s,tc}, crt0_data.s, block_virtio.tc,
                block_fat_virtio.tc, block_fat_stub.tc, dev_backend_virt.tc
    pico2/      platform_pico2.{s,tc}, crt0_pico2_data.s, block_flash.tc,
                block_sd.tc, display_ili9488.tc, keyboard_matrix.tc,
                rtc_ds3231.tc
  scripts/     build.sh + run_pico2{,_interactive}.sh + bin2s{,_incbin}.sh +
               genjpfont.py
  tools-src/   TC で書かれた kernel build 用 host ツール
    mkfs.tc    mtfs ディスクイメージ生成 (qemu-riscv32 で実行)
    bin2uf2.tc raw bin → UF2 コンバータ
  tests/       kernel 単体テスト
    test_os.sh, test_pico2*.sh, fb_render.py
    fixtures/  kern_demo.conf, kern_console{,_land}.conf, msh_smoke.sh,
               msh_abort.sh
  Makefile     `make -C kernel test` で 8 tests scoped 実行

integration/  3 サブプロジェクトをまたぐテスト (`make full-test` で実行)
  test_phase7.sh, pico2_self_replicate.sh, pico2_verify.sh,
  pico2_test_compile_parse.sh, phase3_verify.py, qemu_mr_scale.py,
  pico2_{drive,hw_driver,k11_reproduce,pipeline_drive,tty,upload}.py,
  uart_demux.py
  inputs/      phase7_hello{,_world,_min}.tc
  fixtures/    pico2_*.sh (実機 fixture: self_step1-4, dumper test, 各
               compile_* fixture 等) + calib.sh

tests/      共有テストインフラ (3 サブプロジェクトすべてが使う)
  test_all.sh    全 suite を順に呼ぶ root 集約スクリプト
  test_common.sh 共通ヘルパ (paths, counters, report_pass/fail, build_gen2_tool)

docs/       仕様・設計ドキュメント (詳細は ls docs/)
  task/subproject_split.md  サブプロジェクト分割設計 (このリファクタの根拠)

build/      生成物 (gitignored)
  gen1/      Gen1 バイナリ (x86)
  gen2/      Gen2 バイナリ (RV32 ELF + qemu-riscv32 経由)
  gen3/      Gen3 (Gen2 == Gen3 byte-exact 検証用)
  kernel/    kernel.bin, disk*.img, tasks/*.bin
  intermediate/ asm pipeline 中間ファイル (.idx, .lab 等)
```

## ビルド＆実行

### サブプロジェクト別 (主目的: テストスコープを編集箇所に限定)

| 編集対象 | コマンド | 内容 |
|---|---|---|
| `compiler/src/*.tc` | `make -C compiler test` | compiler 140 tests (~60s) |
| `userland/bin/<task>/*.tc` | `make -C userland test` | 40 タスク build smoke (~0.07s warm) |
| `kernel/src/*.tc`, `kernel/platform/*` | `make -C kernel test` | test_os 8 tests (~10s) |
| integration | `make full-test` | 上記 + test_phase7 等 |
| 全部統合 | `make test` (root) | 148 tests (~50s warm) |

### サブプロジェクト Makefile (ユーザー向け API)

ユーザー向けターゲットは各サブ Makefile が所有 (decision 6 で旧 root alias は撤去済)。

```bash
# 全体
make                              # Gen1 (build/gen1/) のみ build
make test                         # 148 tests 集約レポート (test_all.sh 経由)
make full-test                    # + integration + FULL_TEST=1 (kmalloc/kernel1)
make clean                        # Gen1 + build/ 全消去

# compiler サブプロジェクト
make -C compiler gen1             # Gen1 (C) — build/gen1/
make -C compiler gen2             # Gen2 (TC, RV32 ELF) — build/gen2/
make -C compiler gen3             # Gen3 (Gen2 == Gen3 検証) — build/gen3/
make -C compiler test             # 140 tests
make -C compiler test-warm        # 高速版 (golden/gen3/consistency 抜き)
make -C compiler test-asm-bins    # build/test/asm/*.bin プリビルド
make -C compiler update-golden    # compiler/tests/golden/ 再生成

# kernel サブプロジェクト
make -C kernel virt               # build/kernel/virt_kernel.bin
make -C kernel pico2              # build/kernel/pico2_kernel.uf2
make -C kernel pico2-extra        # + EXTRA_GUEST_TASKS 込み
make -C kernel pico2-demo         # + disk-demo.img (kern_demo.conf 駆動 init)
make -C kernel pico2-console      # + LCD console
make -C kernel pico2-console-land # + LCD console (landscape)
make -C kernel test               # test_os 8 tests
make -C kernel run                # virt kernel を対話起動 (qemu stdio serial)
make -C kernel run-extra          # 同上 + EXTRA_GUEST_TASKS
make -C kernel run-pico2          # pico2 kernel → flash → 対話 UART
make -C kernel run-pico2-extra    # 同上 + EXTRA_GUEST_TASKS
make -C kernel run-pico2-console{,-land}  # console 起動
make -C kernel flash              # 既存 UF2 を再 flash (build 無し)

# userland サブプロジェクト
make -C userland                  # 全 40 タスク build
make -C userland test             # smoke (build OK 確認)
make -C userland test-quick       # GUEST_TASKS のみ (compiler symlink 除外)

# DROP_TASKS="vi neofetch" 等で除外可。pico2 4 MiB flash に収める用
#
# ディスクイメージ 4 種 (kernel build が自動生成):
#   build/kernel/disk.img           標準 (kern.conf 省略 → seed = sh only)
#   build/kernel/disk-extra.img     + EXTRA_GUEST_TASKS (parse/sigscan/...)
#   build/kernel/disk-demo.img      + kernel/tests/fixtures/kern_demo.conf
#                                   (test_os.sh が使用)
#   build/kernel/disk-console.img   + console 起動
#   build/kernel/disk-console-land.img  + console (landscape)
```

`make -C kernel run` は `qemu-system-riscv32 -machine virt` に標準入出力を
繋いで sh と対話できる。Ctrl-a x で抜ける。Ctrl-a c で qemu モニタ。

`make -C kernel run-pico2` は Debug Probe 経由で pico2 をフラッシュし、
`integration/pico2_tty.py` による双方向 UART コンソールを開く。
Ctrl-a x で終了 (qemu と同じ escape)。
`OPENOCD` / `UART_PORT` 環境変数で上書き可。

`make test` は時間短縮のため一部テストをスキップする (FULL_TEST=1 で有効化)。
詳細は `tests/test_all.sh` 参照。

## Pico 2 (RP2350 RISC-V) ビルド

カーネルを Pico 2 向けにビルドするには `kernel/scripts/build.sh --target pico2`
を使う。「カーネル / 統一ビルド」節 (後述) を参照。
`kernel/tools-src/bin2uf2.tc` (フェーズ 8 で TC port、2026-05-06) が raw
bin → UF2 (family_id=0xe48bff5a) 変換を担当し、`build/gen2/bin2uf2`
(RV32 ELF) を `qemu-riscv32` 経由でカーネルビルドが呼ぶ。

bring-up 当初は `pico2/hello.tc` というカーネル抜きの standalone hello
world と専用の `compile-pico2.sh` / `pico2/crt0_pico2.s` を持っていたが、
カーネルが Pico 2 で動くようになって以降は使われなくなったので削除済み
(履歴は `git log -- pico2/`)。

## 世代の定義

- **Gen1**: `compiler/bootstrap/` の C コードを GCC で x86_64 にコンパイルしたもの
- **Gen2**: `compiler/src/` の TC コードを Gen1 でコンパイルし RV32 ELF にしたもの (`compile-gen1.sh`)
- **Gen3**: `compiler/src/` の TC コードを Gen2 でコンパイルし RV32 ELF にしたもの (`compile-gen2.sh`)

## コンパイルスクリプト

スクリプトは `compiler/scripts/` に集約済。

```bash
# Gen1 ツール (C 版) で .tc → RV32 ELF (Gen2 ツールの生成に使う)
./compiler/scripts/compile-gen1.sh -o output file.tc

# Gen2 ツール (qemu 経由) で .tc → RV32 ELF (Gen3 ツールの生成に使う)
GEN2_DIR=/path/to/gen2 ./compiler/scripts/compile-gen2.sh -o output file.tc

# Gen3 ツール (qemu 経由) で .tc → RV32 ELF (Gen2==Gen3 の確認に使う)
GEN3_DIR=/path/to/gen3 ./compiler/scripts/compile-gen3.sh -o output file.tc
```

compile-gen1.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. 各 .tc を個別にコンパイル → .s
3. 全 .s を GCC でリンク (compiler/bootstrap/crt0.s + runtime_syscall.c)

compile-gen2/gen3.sh パイプライン:
1. import 先の .tc を再帰的に収集
2. Gen1 parse + extract-sigs で import 先の .th（tc header、exports のみ）を生成
3. 各 .tc について parse → sigscan で extended .th を作り、
   `(imports)(self)(program)` でラップして tcheck へ渡す
4. tcheck → codegen → bc2asm で .s を emit
5. ASM_PROLOGUE (`; raw` 等) / 各 CRT0 ファイル / runtime.s / 各 .s /
   各 CRT0_DATA ファイルを **個別に** asm_pass1 にかけ (prelude を
   cat で 1 本に結合する処理は廃止)、asm_pass2 が全 .idx を `--add`
   して .lab、asm_pass3 が ELF 出力（GCC 不要）

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
(`compiler/src/ast_node.tc` 参照)。詳細は `docs/design_decisions.md` #1 と
`docs/task/multi_file.md`。

## テスト構造

Phase 3 で 3 サブプロジェクトに物理分離済。各 Makefile が test target を
持ち、編集箇所に応じて scoped 実行する。詳細は `docs/task/subproject_split.md`。

### compiler test (`compiler/tests/`, `make -C compiler test`)
- `test_unit.sh` — Gen1 単体 (parse/typecheck/codegen/interp/bcrun/rv32)
- `test_pipeline.sh` — Gen2 パイプライン (qemu rv32 native)
- `test_consistency.sh` — tc_run_all 全 5 メソッド一致
- `test_golden_examples.sh` — サンプル .tc の golden 比較
- `test_gen3.sh` — Gen1 vs golden、Gen2 AST vs Gen1 AST、Gen2==Gen3 BC
- `test_import.sh` — 複数ファイル import/export
- `test_asm.sh` — hello2.tc / test_timer.tc を `; raw` で compile-gen2.sh
  にかけ、qemu-system-riscv32 -M virt で実行 (CSR / タイマ割り込み検証含む)
- `update_golden.sh` / `bench_pipeline.sh` / `qemu_bin2uf2_test.py` — ツール
- `golden/`, `import/`, `*.tc` (hello, fib, fizzbuzz, calc, struct_*, ...)
- `virt_crt0.s` — qemu virt 用 crt0 (test_asm 専用)

### kernel test (`kernel/tests/`, `make -C kernel test`)
- `test_os.sh` — OS コンポーネントテスト。`build/kernel/disk-demo.img`
  (= `kernel/tests/fixtures/kern_demo.conf` で init=/bin/hello + hello2
  + sh を seed) でブートし、kern.conf 駆動 init (A/B preempt 可視化) +
  tmpfs 書き戻し (tmpdemo) + catfile argv + `>` リダイレクト +
  spawn/wait leak canary (`KERN: live=...`) を同時に検証。`FULL_TEST=1`
  で kmalloc と kernel1 協調タスク (compiler/tests/test_kmalloc.tc /
  test_kernel1.tc を入力に使う) も追加
- `test_pico2*.sh` — Pico 2 実機テスト (`make test` 非同梱)。Debug Probe
  + openocd-rpi が接続された状態で `GEN2_DIR=/tmp/gen2 kernel/tests/test_pico2.sh`
  と起動すると、pico2 カーネルをビルドして SWD フラッシュ、/dev/ttyACM0
  の UART から `BLOCK: flash backend ready / MTFS: mounted / CAT:hello,
  mtfs / all tasks done` を grep 検証
- `fb_render.py` — /dev/fb framed-blit dump を BMP に変換 (test_os が使用)
- `fixtures/` — kern_*.conf + msh_*.sh

### userland test (`userland/Makefile`, `make -C userland test`)
全 40 タスクの build smoke のみ (タスクごとの単体テストは未整備)。

### integration test (`integration/`, `make full-test` または手動)
- `test_phase7.sh` — phase 7 自己ホスト実行テスト。`make full-test` から
  起動される。`EXTRA_GUEST_TASKS` 込みでカーネルをビルドし、2 ステージを
  qemu virt で検証する: stage 1 は `parse → sigscan → cat wrap → tcheck
  → codegen → bc2asm` パイプラインで `.s` を生成、stage 2 は prelude を
  cat して asm_pass1/2/3 に通して `/tmp/hw` を作り、sh の絶対パス実行で
  "Hello, World!" が UART に出ることを確認する
- `inputs/phase7_hello.tc` / `phase7_min.tc` / `phase7_hello_world.tc` —
  phase 7 入力。それぞれ kernel/scripts/build.sh が `/phase7.tc` /
  `/phase7_min.tc` / `/hw.tc` として mtfs に staging する
- `pico2_self_replicate.sh` — Pico 2 self-replicate orchestrator (実機必要)。
  9 ステップで kernel + 全コンパイラを実機再生成し host gen2 と md5 一致
  検証 (~30 min REFRESH 込み)。`PRELUDE_NAME=p` / `INPUT_NAMES="kc pp bf
  bs ff mf tf pf vf ld kp pt"` を `compile-gen2.sh` に渡して host/device
  中間ファイル名を揃える
- `pico2_verify.sh` / `pico2_test_compile_parse.sh` — pico2 実機 byte-exact
  検証
- `phase3_verify.py` — virt 上で 9 段全部走らせて byte-exact 検証
- `qemu_mr_scale.py` — K11 (mr UART upload hang) qemu 再現 (`-serial stdio`
  + `-monitor null`、`-serial mon:stdio` だと qemu モニタが Ctrl-A 吸収)
- `pico2_*.py` — pico2 UART driver / utility
- `fixtures/pico2_*.sh` — pico2 実機 fixture (self_step{1-4}, compile_* 等)

### 共有 (`tests/`)
- `test_all.sh` — 全 suite を順に呼ぶ集約スクリプト (`make test` のバック)
- `test_common.sh` — 共通ヘルパ (paths, counters, build_gen2_tool 等)

### Gen2 ツールのビルド
- `build_gen2_tool` は `compile-gen1.sh` を使用 (GCC リンカ + runtime_syscall.c)
- `ensure_gen2_tools` は qemu-riscv32 + riscv-gcc が必要。parse / sigscan /
  tcheck / codegen / bc2asm / bcrun / asm_pass1 / asm_pass2 / asm_pass3 を
  Gen2 として一式ビルドする
- `compiler/tests/test_asm.sh` は追加で qemu-system-riscv32 が必要 (無ければ SKIP)

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
- `.incbin SIZE "path"` — リンク時にファイルから `SIZE` バイトを読み
  current section に埋め込む。section 先頭 (intra_off == 0) の場合は
  asm_pass1 が自動 defer して idx に `incbin <sec> <intra> <size>
  <path>` を記録、asm_pass3 が link 時に memcpy する (kernel build で
  `_mtfs_image_*` を full.s に直接連結せず `.incbin` で参照する経路と、
  self-replicate の /sd/wrap.s から /sd/dx.img を埋める経路が同
  フォーマット)
- 先頭ディレクティブ:
  - `; raw` — ELF ヘッダを出さず、code 部分だけを raw bin として出力
  - `; load_base 0xHHHHHHHH` — ELF 出力時の `e_entry`/`p_vaddr`/`p_paddr` を
    この値ベースに設定（デフォルト 0x10000）

## compile-gen2.sh の環境変数
デフォルトは Linux ELF 用の crt0 だが、以下を設定すると別ターゲット
（qemu virt, Pico 2 等）向けにビルドできる:
- `CRT0` — `.s` ファイルパスの **空白区切りリスト**。各ファイルが
  個別に asm_pass1 にかかる。デフォルト `compiler/runtime/linux/crt0_tc.s`
- `CRT0_DATA` — `.s` ファイルパスの空白区切りリスト (末尾 data
  セクション)。デフォルト `compiler/runtime/linux/crt0_tc_data.s`
- `ASM_PROLOGUE` — asm 入力先頭の 1 行（例 `; raw`）。`PRELUDE_NAME.s`
  に書き出され単独 input になる (raw_mode を input[0] から拾うため)
- `GEN2_DIR` — Gen2 ツール (parse/sigscan/tcheck/codegen/bc2asm/asm_pass1/asm_pass2)
  の置き場所

## カーネルビルド

統一ビルドスクリプト (virt と Pico 2 共通):

```bash
# Gen2 ツールを事前にビルドしてから:
GEN2_DIR=/path/to/gen2 ./kernel/scripts/build.sh --target virt  -o kernel.bin
GEN2_DIR=/path/to/gen2 ./kernel/scripts/build.sh --target pico2 -o kernel.uf2
```

ビルドフロー (両ターゲット共通):
1. Step 0: `compiler/src/runtime.tc` と `userland/lib/libtc/libtc.tc` を 1 度
   だけコンパイルし `CACHED_S_DIR` 経由で各タスクビルドで共有 (phase 7 で
   導入、-8.8 s)
2. ゲストタスク (`userland/bin/*/task.mk` が GUEST_TASKS に積む: hello,
   hello2, catfile, sh, msh, tmpdemo, echo, cat, ls, wc, head, cp, du,
   grep, rm, mkdir, rmdir, neofetch, vi, console, fbtest, launcher,
   count, seq, mx, mr, muxon, muxoff, sdprobe, kbdump, tcc, md5sum,
   bin2uf2, rot13) を raw バイナリにコンパイル。各タスクには
   `task_arena_size()` / `task_stack_size()` の値を `.word` 2 本の
   header として prepend する (K3 案C)。`EXTRA_TASKS="parse sigscan
   tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3 cat"` を渡すと
   phase 7 のコンパイラタスク群を追加できる。起動時 seed task は現在
   sh のみ (hello/hello2 を足したいときは kern.conf 経由)
3. `kernel/tools-src/mkfs.tc` (`build/gen2/mkfs` を qemu-riscv32) で
   `/bin/<task>` + `/hello.txt` + phase 7 の test 入力
   (`/phase7.tc` / `/hw.tc`) + OS 側 linker 用 `/prelude.s` (= `; raw` +
   `.word 32768; .word 8192` + task_crt0.s + cached runtime.s) +
   `/prelude_tail.s` (= task_data.s) を含む mtfs イメージを生成
4. virt は `--disk-out` でイメージを出力し、qemu の `-drive` から読む。
   pico2 は `bin2s.sh _mtfs_image` で .rodata に埋め込み、XIP 経由で読む
5. platform_*.s + trap_common.s + crt0_*_data.s + kernel*.tc (+pico2 は mtfs
   image) を各々個別に asm_pass1 にかけ asm_pass2/pass3 でリンク
   (CRT0 = "platform.s trap_common.s"、CRT0_DATA = "crt0_data.s
   [mtfs_image.s]" を空白区切りで compile-gen2.sh に渡す)
6. 起動時にカーネルの `loader.tc` (`load_task`) が `/bin/*` を VFS で開き、
   先頭 8 バイトの K3 header (`arena_size / stack_size`) を読んで
   `make_task(entry+8, arena, stack)` を呼ぶ。XIP 可能なら flash 上の
   アドレスを直接 entry にし、そうでなければ RAM にコピーする。pico2
   でも dynamic spawn/exec は動く (K7 part 1/2 完了、残件は part 3 の
   phase 7 コンパイラ完走 — `docs/problem.md` 参照)

qemu virt で実行:
```bash
qemu-system-riscv32 -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
    -machine virt,aclint=on -bios none \
    -device "loader,file=kernel.bin,addr=0x80000000" \
    -device "loader,addr=0x80000000,cpu-num=0"
```

Pico 2 実機で実行 (Debug Probe + openocd-rpi):
```bash
./kernel/scripts/run_pico2.sh build/kernel/pico2_kernel.uf2
# → openocd で SWD 経由フラッシュ → /dev/ttyACM0 で UART キャプチャ
```

タスクは ecall で syscall を発行 (Linux 互換 ABI: a7=34 mkdir,
a7=40 rmdir, a7=56 openat, a7=57 close, a7=63 read, a7=64 write,
a7=87 unlink, a7=89 readdir, a7=93 exit, a7=101 nanosleep,
a7=219 spawn_fds, a7=220 clone/spawn, a7=221 execve, a7=222 pipe,
a7=250 mux_enable, a7=260 wait4)。mkdir / rmdir は path 1 引数のみ
(`/sd/` 専用、kernel/fatfs.tc)。
**path 引数は NUL 終端 C-string ではなく String layout (4 バイト count
+ bytes) を直接渡す**: `do_openat(dirfd, path: String, flags)` のように
`task_crt0.s` の stub は String / StringLiteral 2 種の mangled name を
同一本体に alias、kernel vfs_open は `peek32(addr)` で長さを読む。
read/write のバッファは従来どおり `(buf: U8Array, len)` ペア。
カーネルの ecall handler (trap_common.s) がアセンブリでディスパッチし、
read/write/openat/close は `kernel/src/vfs.tc` 経由で mtfs / UART に振り分け、
exec は `kernel/src/loader.tc` の `sys_exec_handler` が呼び出し元の
スケジューラスロットを新バイナリに置き換える。
タイマ割り込みで TC の trap_handler (kernel/src/kernel_common.tc) がラウンドロビン
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
