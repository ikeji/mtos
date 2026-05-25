# スクリプト一覧と呼び出し関係

## Make ターゲット

ユーザー向けターゲットは各サブ Makefile に集約済み (Phase 4b で旧 root
alias は撤去)。`make` 単独はルート Makefile (gen1 build + test 集約のみ)。

### ルート Makefile

| ターゲット | 内容 |
|---|---|
| `make` (= `make all`) | `build/gen1/*` (Gen1 C ツール) のみビルド |
| `make test` | 全テストスイートを順に実行 (148 tests、warm ~33s) |
| `make full-test` | 上 + integration + FULL_TEST=1 (kmalloc / kernel1) |
| `make integration-test` | integration/test_phase7.sh を qemu virt で実行 |
| `make clean` | Gen1 + build/ を削除 |

### サブプロジェクト Makefile

| ターゲット | 内容 |
|---|---|
| `make -C compiler gen1` | `build/gen1/*` (C 製) |
| `make -C compiler gen2` | `build/gen2/*` (TC 製 RV32 ELF) |
| `make -C compiler gen3` | `build/gen3/*` (Gen2 == Gen3 検証) |
| `make -C compiler test` | compiler test 140 tests (~60s) |
| `make -C compiler test-warm` | golden/gen3/consistency 抜き高速版 |
| `make -C compiler test-asm-bins` | `build/test/asm/*.bin` 事前ビルド |
| `make -C compiler update-golden` | golden ファイル再生成 |
| `make -C kernel virt` | `build/kernel/virt_kernel.bin` |
| `make -C kernel pico2` | `build/kernel/pico2_kernel.uf2` |
| `make -C kernel pico2-extra` | 上 + EXTRA_GUEST_TASKS 込み |
| `make -C kernel pico2-demo` | 上 + `kern_demo.conf` (init=/bin/hello) |
| `make -C kernel pico2-console{,-land}` | 上 + LCD console |
| `make -C kernel run` | virt kernel を qemu で対話起動 |
| `make -C kernel run-extra` | 上 + EXTRA_GUEST_TASKS |
| `make -C kernel run-pico2` | pico2 実機 flash + 双方向 UART |
| `make -C kernel run-pico2-extra` | 上 + EXTRA_GUEST_TASKS |
| `make -C kernel run-pico2-console{,-land}` | 上 + LCD console |
| `make -C kernel flash` | UF2 を再 flash (build 無し) |
| `make -C kernel test` | kernel test 8 tests (~10s) |
| `make -C userland` | 全 40 タスク build |
| `make -C userland test` | smoke (build OK 確認) |
| `make -C userland test-quick` | GUEST_TASKS のみ (compiler symlink 除外) |

ディスクイメージは 5 種類が自動生成される:

- `build/kernel/disk.img` — 既定、kern.conf 省略で default seed (sh のみ)
- `build/kernel/disk-extra.img` — EXTRA_GUEST_TASKS 追加 (compiler 等)
- `build/kernel/disk-demo.img` — `kernel/tests/fixtures/kern_demo.conf`
  (init=/bin/hello) を `/etc/kern.conf` として staging (`test_os.sh` が使用)
- `build/kernel/disk-console.img` — `kern_console.conf` staging
- `build/kernel/disk-console-land.img` — landscape 版 console.conf

## テスト呼び出しグラフ

```
make test
  └── tests/test_all.sh              ← メインエントリポイント
        ├── compiler/tests/test_unit.sh             ← Gen1 単体テスト
        ├── compiler/tests/test_pipeline.sh         ← Gen2 パイプラインテスト (qemu rv32)
        ├── compiler/tests/test_consistency.sh      ← tc_run_all 全メソッド一致
        ├── compiler/tests/test_golden_examples.sh  ← サンプル .tc の golden テスト
        ├── compiler/tests/test_gen3.sh             ← Gen2 vs golden + Gen2 == Gen3
        ├── compiler/tests/test_import.sh           ← import/export テスト
        ├── compiler/tests/test_asm.sh              ← TC → qemu virt end-to-end
        └── kernel/tests/test_os.sh               ← kernel + tmpfs + argv + redirect

make -C compiler update-golden
  └── compiler/tests/update_golden.sh  ← Golden ファイル再生成

make full-test
  └── integration/test_phase7.sh       ← phase 7 self-hosted (qemu virt)

# 手動実行 (実機 / 特殊環境必要):
kernel/tests/test_pico2.sh             ← pico2 実機テスト (Debug Probe 経由)
kernel/tests/test_pico2_sd.sh          ← pico2 実機 SD カード SPI + FAT
kernel/tests/test_pico2_phase7_sd.sh   ← pico2 実機 phase 7 self-host
kernel/tests/test_pico2_hw.sh          ← pico2 実機 UART pipeline driver
integration/pico2_self_replicate.sh    ← pico2 上で kernel+全コンパイラ再生成
integration/pico2_verify.sh            ← pico2 実機で compile 7 段 byte-exact
integration/phase3_verify.py           ← virt 上で 9 段 byte-exact
integration/qemu_mr_scale.py           ← K11 (mr UART) qemu 再現
```

`tests/test_common.sh` は共通ライブラリ (`source` で読み込む)。
ツールパス、カウンタ、report 関数、`compile_tc_to_bc`、Gen2 ツール
ビルド等を提供。

---

## 各スクリプトの詳細

### ユーザー向けスクリプト (ルート)

| スクリプト | 説明 | 使い方 |
|-----------|------|--------|
| `compiler/scripts/compile-gen1.sh` | Gen1 (C) ツールで .tc → RV32 ELF (x86 ホスト上で GCC リンク) | `./compiler/scripts/compile-gen1.sh -o out file.tc` |
| `compiler/scripts/compile-gen2.sh` | Gen2 (TC) ツールで .tc → RV32 ELF (qemu 経由、asm_pass2/pass2 リンク) | `GEN2_DIR=... ./compiler/scripts/compile-gen2.sh -o out file.tc` |
| `compiler/scripts/compile-gen3.sh` | Gen3 (= Gen2 自身が吐いた Gen2) で同じ処理 | `GEN3_DIR=... ./compiler/scripts/compile-gen3.sh -o out file.tc` |
| `tc_run.sh` | .tc を指定メソッドで実行 | `./tc_run.sh <method> <file.tc> [stdin]` |
| `tc_run_all.sh` | 全 5 メソッドで実行し出力一致を確認 | `./tc_run_all.sh <file.tc> [stdin]` |
| `tc_build.sh` | 複数 .tc をコンパイル + リンクして RISC-V ELF に | `./tc_build.sh -o prog main.tc lib.tc` |

#### tc_run.sh のメソッド

| メソッド | パイプライン |
|---------|-------------|
| `interp`     | parse → typecheck → interp (AST 直接実行) |
| `bcrun`      | codegen (C) → bcrun (C)     (バイトコード実行) |
| `rv32`       | codegen (C) → bc2asm (C) → riscv-gcc → qemu |
| `pipeline`   | parse.tc + sigscan.tc + tcheck.tc + codegen.tc を bcrun 上で連結 |
| `bc2asm_tc`  | codegen (C) → bc2asm.tc (bcrun) → riscv-gcc → qemu |

### カーネルビルド (`kernel/`)

| スクリプト | 説明 |
|-----------|------|
| `kernel/scripts/build.sh` | virt / pico2 共通ビルド: `--target virt|pico2` + `-o out` + `--disk-out path` + `EXTRA_TASKS=...`。Step 0 で runtime/libtc を事前コンパイル、各タスクを raw bin 化、mtfs image を生成、platform .s とリンク |
| `kernel/scripts/bin2s.sh` | raw bin → `.s` データ変換 (`PREFIX_addr` 関数を生成) |
| `kernel/scripts/bin2s_incbin.sh` | 同上の `.incbin` 版 (size を `wc -c` で測り `.incbin SIZE "path"` を含む `.s` を emit) |
| `kernel/scripts/run_pico2.sh` | Debug Probe 経由で pico2 に flash し UART をキャプチャ |
| `kernel/scripts/run_pico2_interactive.sh` | build + flash + 双方向 UART コンソール (`make -C kernel run-pico2`) |
| `kernel/scripts/genjpfont.py` | np21w PC-98 `font.bmp` → `jpfont.dat` (console 用) |

### テストスクリプト (`tests/`)

| スクリプト | 説明 |
|-----------|------|
| `test_all.sh`            | 全スイートのエントリポイント (`make test` が呼ぶ) |
| `test_common.sh`         | 共通ライブラリ。パス定義、カウンタ、report 関数、Gen2 ツールビルド、`compile_tc_to_bc` |
| `test_unit.sh`           | Gen1 単体テスト (parse / typecheck / codegen / interp / bcrun / rv32) |
| `test_pipeline.sh`       | 自己ホスト版コンパイラ (Gen2) でのコンパイル + 実行 (qemu rv32) |
| `test_consistency.sh`    | tc_run_all による全メソッドの出力一致テスト |
| `test_golden_examples.sh`| サンプル .tc の golden テスト (Gen1 vs Gen2) |
| `test_gen3.sh`           | Gen1 vs golden、Gen2 AST vs Gen1 AST、Gen2 == Gen3 BC 自己ホスト検証 |
| `test_import.sh`         | import/export 機能のテスト |
| `test_asm.sh`            | `hello2.tc` / `test_timer.tc` を `; raw` モードで compile-gen2.sh にかけて qemu-system-riscv32 -M virt で実行 (CSR 命令、タイマ割り込み検証) |
| `test_os.sh`             | OS コンポーネントテスト。`make test` では `fs_virtio` を実行: `disk-demo.img` でブートして kern.conf 駆動 init + tmpfs 書き戻し + `catfile argv` + `>` リダイレクト + spawn/wait leak canary (`KERN: live=...`) を同時検証。`FULL_TEST=1` で kmalloc / kernel1 協調タスクを追加 |
| `test_phase7.sh`         | phase 7 自己ホスト実行テスト (手動)。`EXTRA_TASKS="parse sigscan tcheck codegen bc2asm asm_pass2 asm_pass3 cat"` で kernel をビルドし、qemu virt で 2 ステージ検証 (compile → link → run "Hello, World!") |
| `test_pico2.sh`          | pico2 実機テスト (手動、`make test` に含まれない)。Debug Probe + openocd-rpi で flash し、UART の MTFS / CAT / launcher ログを grep |
| `test_pico2_sd.sh`       | pico2 実機 SD カードテスト (手動)。Phase A: kernel flash → `echo TAG > /sd/T.TXT` → `cat` で読み返し。Phase B: re-flash せず reset のみで `cat /sd/T.TXT` が同 TAG を返す = 永続化検証 |
| `test_pico2_phase7_sd.sh`| pico2 実機 phase 7 self-host テスト (手動)。`EXTRA_TASKS` 入りのカーネルを flash し、`pico2_pipeline_drive.py` で `parse → ... → asm_pass3 → /sd/HW → "Hello, World!"` を駆動。`/sd/` に中間ファイル staging。総時間 ~125 秒 (K7 達成版、commit 666d306) — 2026-05-13 再計測で `kernel/kernel/tests/test_pico2_bench.sh` 経由 1 boot ~13.8 秒、`docs/scaling.md` Q1 |
| `test_pico2_hw.sh`       | pico2 実機 UART pipeline テスト (手動) |
| `pico2_verify.sh`        | pico2 実機で compile 7 段の byte-exact 検証 (手動、link 段は K7 の UART 問題で skip) |
| `update_golden.sh`       | golden 再生成 (rv32 ネイティブ高速化) |

### ホスト側ヘルパ (`tests/*.py`)

| ファイル | 説明 |
|---|---|
| `phase3_verify.py` | virt 上で全 9 段 (parse → asm_pass3) + /tmp/hw 実行を Gen2 ホスト参照と byte-exact 検証 |
| `pico2_hw_driver.py` | pico2 UART pipeline driver (compile + optional link) |
| `pico2_tty.py` | pico2 双方向 raw UART フォワーダー (Ctrl-a x で終了、LF→CR+LF 変換) |
| `pico2_pipeline_drive.py` | sh プロンプト同期コマンド送信ドライバ。`sh$ ` を見て次行を送るので PL011 RX FIFO (32 byte) overflow しない。`kernel/kernel/tests/test_pico2_phase7_sd.sh` 等から使用 |
| `uart_demux.py` | UART mux 0x1F フレームパーサー |

### test_common.sh の提供する機能

- **ツールパス**: `PARSE` / `SIGSCAN` / `TCHECK` / `CODEGEN` / `BCRUN`
  / `BC2ASM` / `ASM_PASS1` / `ASM_PASS2` / `INTERP` / `RISCV_CC` /
  `QEMU` 等
- **カウンタ・report**: `PASS` / `FAIL`, `report_pass`,
  `report_fail_diff`, `report_fail_msg`, `check_output`,
  `check_contains`, `print_results`
- **compile_tc_to_bc**: import を解決して BC をマージ
- **Gen2 ツール**: `ensure_gen2_tools` (RISC-V ネイティブビルド、
  `SHARED_GEN2_DIR=build/gen2` を前提にキャッシュ)
- **共通データ**: `EXAMPLE_FILES`, `TC_FILES`, `get_stdin`,
  `get_tc_exec_input_file`
