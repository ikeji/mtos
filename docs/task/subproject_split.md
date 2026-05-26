# サブプロジェクト分割設計

## 目的

### 主目的: テストスコープを編集箇所に限定する

現在 `make test` は **コンパイラ・カーネル・ユーザーランドの全テストを
一括実行する**。ユーザーランドの 1 タスク (例: `console` コマンド) を
書き換えただけでも、コンパイラの golden test、Gen2 == Gen3 自己ホスト
検証、kernel OS test まで全部走る。これは無駄。

このリファクタの **第一の目的** は、編集したサブプロジェクトのテストだけ
を走らせれば済む構造にすること:

| 編集対象 | 実行するテスト |
|---|---|
| `userland/bin/console/console.tc` を書き換えた | **`userland/tests/`** のみ |
| `compiler/src/parse.tc` を書き換えた | **`compiler/tests/`** のみ |
| `kernel/src/vfs.tc` を書き換えた | **`kernel/tests/`** のみ |
| `integration/` 配下を触った / 3 つにまたがる変更 / リリース直前 | **`integration/`** (オプトイン、`make full-test`) |

つまり `make -C userland test` / `make -C compiler test` /
`make -C kernel test` がそれぞれ独立に閉じていて、隣のサブプロジェクトの
ソース・テストを一切触らないことを保証する。これを実現する最小限の構造
として 3 サブプロジェクト分割を行う。

### 副次目的

- **再利用**: 他の OS / アーキテクチャに MTOS コンパイラを移植するとき、
  カーネル一式を持っていかなくて済む
- **差し替え**: ユーザープログラムだけを別リポで管理し、kernel image に
  「追加で入れる bin の集合」として渡せる
- **構築の並列化**: コンパイラを 1 度ビルドすれば、その artifact を
  指してカーネルとユーザーランドを並行ビルドできる
- **責務の可視化**: 「これは誰のコード?」が一目でわかる

### 非目標 (やらないこと)

- リポジトリ分割 (git submodule / 別 origin) はしない。**1 つの git
  リポジトリの中で 3 つのトップレベルディレクトリに整理する** だけ。
  将来分割したくなったら `git filter-repo` で抽出できる粒度にする。
- 言語仕様変更や ABI 変更は伴わない。純粋にディレクトリと Makefile の
  再配置。

---

## 現状サマリ (分割前)

```
riscv/
├── bootstrap/                C 実装の Gen1 コンパイラ (x86 Linux native)
├── compiler/                 TC 自己ホスト Gen2/3 コンパイラ
│   ├── parse.tc, sigscan.tc, tcheck.tc, codegen.tc, bc2asm.tc
│   ├── asm_common.tc, asm_pass1.tc, asm_pass2.tc, asm_pass3.tc
│   ├── ast_node.tc, string_buffer.tc, source_reader.tc, strlib.tc
│   ├── runtime.tc            (TC ランタイム: kmalloc/kfree)
│   ├── crt0_tc.s             (Linux ELF 用 crt0)
│   ├── crt0_tc_data.s        (.data + .bss + __arena)
│   └── bcrun.tc              (TC バイトコードインタープリタ)
├── kernel/                   OS カーネル (virt / pico2)
│   ├── kernel.tc, kernel_pico2.tc, kernel_common.tc
│   ├── vfs.tc, tmpfs.tc, procfs.tc, mtfs.tc, fatfs.tc, loader.tc
│   ├── platform_virt.s, platform_pico2.s, trap_common.s
│   ├── crt0_data.s, crt0_pico2_data.s
│   ├── block_virtio.tc, block_flash.tc, block_sd.tc
│   ├── build.sh, run_pico2*.sh, bin2s.sh, bin2s_incbin.sh
│   └── tasks/                ユーザータスク群 + compiler symlinks
│       ├── libtc/, sh/, ls/, cat/, vi/, ...     (ユーザータスク)
│       ├── parse/, sigscan/, ...                (compiler/*.tc への symlink)
│       ├── task_crt0.s, task_data.s             (ユーザータスク共通 crt0)
│       └── */task.mk                            (各タスクの GUEST_TASKS 宣言)
├── tools/                    ホスト側 TC ツール (kernel build から呼ばれる)
│   ├── mkfs.tc               mtfs ディスクイメージ生成
│   ├── bin2uf2.tc            raw bin → UF2
│   ├── collect_imports.sh
│   └── tc_deps_to_d.sh
├── tests/                    テストスイート
│   ├── test_all.sh           (`make test`)
│   ├── test_unit.sh, test_pipeline.sh, test_gen3.sh, test_os.sh, ...
│   ├── test_phase7.sh        self-host integration
│   ├── pico2_self_replicate.sh   pico2 self-replicate integration
│   ├── golden/, fixtures/, ...
│   └── *.tc                  (テスト入力)
├── compile-gen1.sh           ユーザ向けスクリプト
├── compile-gen2.sh
├── compile-gen3.sh
├── tc_run.sh, tc_run_all.sh, tc_build.sh
├── Makefile                  ルート Makefile (全部統括)
└── docs/                     ドキュメント
```

**依存関係 (現状)**:

```
                       ┌────────────────────────────┐
                       │ bootstrap/ (C, x86 native) │
                       └──────────────┬─────────────┘
                                      │ build/gen1/*  (parse, codegen, bc2asm, ...)
                                      ▼
              ┌────────────────────────────────────────┐
              │ compiler/*.tc + runtime.tc + crt0_tc.s │
              └───────────────┬─────────┬──────────────┘
                              │         │
            compile-gen1.sh   │         │ compile-gen2.sh (with kernel/ 用 CRT0)
            (host artifact)   ▼         ▼ (mtos artifact)
                  build/gen2/{parse,sigscan,...}  kernel/build/disk-extra.img 内 /bin/*
                          │                                      │
                          │ ← kernel build もこれを使う ←        │
                          ▼                                      │
                 kernel/build.sh ─→ kernel/build/*.bin / *.uf2  ◄┘
                          ▲
                          │
                   kernel/tasks/*/*.tc, kernel/*.tc, platform_*.s
```

ポイント: コンパイラのソース (`compiler/*.tc`) からは
- **Linux ELF (RV32, qemu-riscv32 経由)** — `build/gen2/*` 用 (host artifact)
- **MTOS raw bin (RV32 + K3 header)** — `kernel/tasks/parse/` 等 symlink を
  経由して kernel mtfs に `/bin/parse` 等として埋め込まれるもの (mtos artifact)

の **2 種類のバイナリ** が生成される。違いは `CRT0` / `CRT0_DATA` の選択
だけで、TC ソースは完全に同じ。

---

## テスト境界の定義 (最重要)

「あるサブプロジェクトを書き換えたら、そのサブプロジェクト内のテストだけで
確信を持って commit/push できる」状態を作るために、**現状の各テストを
どこに振り分けるか** をこのセクションで確定する。これが分割の中身。

### サブプロジェクト内テストの定義

**「サブプロジェクト X 内のテスト」とは、X のソースだけを入力として、
X の build 出力のみを検証するテスト** のこと。Y や Z のソースに触らず、
Y や Z の出力を要件にしない。

| 観点 | compiler 内 | userland 内 | kernel 内 |
|---|---|---|---|
| 入力ソース | `compiler/**` のみ | `userland/**` のみ | `kernel/**` のみ |
| 使う build | 自分の build/host のみ | compiler/build/host (固定 artifact、再ビルドしない) | compiler/build/host (固定 artifact) |
| 検証対象 | Gen1/Gen2/Gen3 のバイナリ出力 | ユーザータスクの単体動作 | カーネル本体の boot / scheduler / VFS |
| qemu 起動 | 必要なら qemu-riscv32 (RV32 ELF user mode) | qemu-riscv32 (user mode) | qemu-system-riscv32 (system mode、virt 機械) |
| 所要時間目標 | ~10 sec | ~5 sec | ~20 sec |

**禁則**: サブプロジェクト X 内のテストが Y のソース・ビルドルールを
要求してはいけない (これを破ると「Y を書き換えたら X のテストが落ちる」
事態が起きうる)。

### 現状テストの振り分け

現在 `tests/` 配下にある全テストを 4 つの区分に振り分ける:

#### → `compiler/tests/` (コンパイラだけで完結)

| 現状ファイル | 説明 |
|---|---|
| `tests/test_unit.sh` | parse / typecheck / codegen / interp / bcrun / rv32 (Gen1 出力 vs golden) |
| `tests/test_pipeline.sh` | Gen2 パイプライン (qemu rv32 native) |
| `tests/test_consistency.sh` | tc_run_all 全メソッド (interp / bcrun / rv32 / pipeline / bc2asm_tc) 一致 |
| `tests/test_golden_examples.sh` | サンプル .tc の golden test |
| `tests/test_gen3.sh` | Gen1 vs golden、Gen2 AST vs Gen1 AST、**Gen2 == Gen3 byte-exact** (自己ホスト確認) |
| `tests/test_import.sh` | 複数ファイル import/export |
| `tests/test_asm.sh` | hello2.tc を `; raw` で compile → qemu-system-riscv32 -M virt 実行 (CSR + タイマ割り込み検証含む) |
| `tests/test_kmalloc.tc`, `test_kernel1.tc` (FULL_TEST) | kmalloc / 協調タスクの単体検証 |
| `tests/golden/`, `tests/golden/tc/` | 全 golden 出力 |
| `tests/hello.tc`, `fib.tc`, `fizzbuzz.tc`, `calc.tc`, `struct_*.tc`, ... | unit / consistency / golden の入力 |
| `tests/qemu_bin2uf2_test.*` | bin2uf2.tc の byte-exact 検証 |

**※** `test_asm.sh` は qemu-system-riscv32 を起動するが、検証対象は
「コンパイラ出力が CSR / タイマを正しくエンコードできているか」なので
compiler/tests に置く。`virt_crt0.s` も同じ場所に同居。

#### → `userland/tests/`

ユーザータスクの単体動作テスト。**現状ほぼ存在しない** (test_consistency
が `hello.tc` を扱うが、それは compiler テスト寄り)。新規に作る:

| 新規 | 説明 |
|---|---|
| `userland/tests/test_libtc.sh` | libtc の puts / eputs / putchar / string_from_bytes / eq の単体 (bcrun または qemu-riscv32 user) |
| `userland/tests/test_<task>.sh` | 必要に応じて (例: `vi` の縦スクロール、`grep` の `-i`、`rm -r` の挙動)。Pure 関数化できる部分のみ |
| `userland/tests/smoke.sh` | 全タスクが「コンパイル + リンクできて K3 header が正しい」だけを検証する高速 smoke (~3 sec) |

**OS ブートを必要とするタスクテスト** (sh interactive、spawn/wait、pipe、
リダイレクト) は kernel/tests または integration に置く — userland 単体
では検証できないため。

#### → `kernel/tests/`

カーネル単体動作テスト。Userland バイナリは **テスト用 fixture として
事前ビルドされた最小セット** (例: hello / hello2 / sh / cat / tmpdemo)
を使い、本物の userland/build は参照しない。

| 現状ファイル | 説明 |
|---|---|
| `tests/test_os.sh` (fs_virtio + その他) | kernel + tmpfs + argv + redirect の virt end-to-end |
| `tests/fixtures/kern_demo.conf` | init=/bin/hello + hello2 + sh の起動設定 |
| `tests/test_pico2.sh` | pico2 実機 boot smoke (Debug Probe + UART grep) |
| `tests/test_pico2_hw.sh` | pico2 実機ハードウェアテスト |
| (新規) `kernel/tests/fixtures/userland/*` | hello, hello2, sh, cat, tmpdemo の **事前ビルド済 raw bin** を git で固定。userland 側の更新を意図的に切り離す |

**重要**: kernel/tests の fixture userland は **意図的に古いまま保つ**。
userland 側の修正が kernel/tests を壊さないため。fixture が古すぎて
本物の userland と乖離してきたら、リリース直前に integration テストで
追従させる。

#### → `integration/`

サブプロジェクト境界をまたぐテスト。`make test` には **含まれず**、
`make full-test` または明示的に `make -C integration` でのみ走る。

| 現状ファイル | 何が境界をまたぐか |
|---|---|
| `tests/test_phase7.sh` | コンパイラ全段 (`parse → asm_pass3`) を userland として実機 OS 上で実行する → 3 つ全部 |
| `tests/pico2_self_replicate.sh` | pico2 上で **kernel + 全コンパイラ** を実機で再生成し host gen2 と md5 一致を検証 → 3 つ全部 |
| `tests/phase3_verify.py` | virt 上で 9 段全部走らせて byte-exact 検証 → compiler + kernel |
| `tests/qemu_mr_scale.py` | K11 (mr UART upload hang) qemu virt 再現 → kernel + userland |
| `tests/pico2_hw_driver.py`, `pico2_tty.py`, `uart_demux.py`, `pico2_verify.sh` | 実機 UART driver (補助ツール) |
| `tests/fixtures/pico2_self_step{1,2,3,4}.sh` | self-replicate ステップ fixture |

### `make test` の境界保証メカニズム

各サブプロジェクトの Makefile は次の不変条件を守る:

1. **`make -C X test` は `X/` 配下のファイルしか読まない** (`X/src/`,
   `X/tests/`, `X/Makefile`)。隣 (Y/, Z/) の .tc / .sh / .md は一切
   open しない。
2. **`make -C X test` は `X/build/` と `X/build-tmp/` 配下にしか書かない**。
   sibling サブプロジェクトの build には絶対に触らない。
3. **依存サブプロジェクトの artifact (compiler の build など) は
   「ビルド済 input」として参照する**。`make -C userland test` を実行
   したときに compiler が再ビルドされたら境界違反 — その場合 user に
   `make -C compiler` を先に実行するよう求めるか、ルート Makefile 経由
   で `make test` したときだけ前段ビルドが走るようにする。
4. 違反検出のため、CI とは別に `tools/check-test-isolation.sh` を用意し、
   `strace -e trace=open` で `make -C X test` のファイルアクセスを記録、
   `X/` と `${X_DEPS}/build/` 以外への read アクセスがあれば fail させる
   (Phase 4 で導入予定の安全網)。

### `make test` の実行モード

| コマンド | 内訳 | 想定所要時間 |
|---|---|---|
| `make -C compiler test` | compiler/tests のみ | ~10 sec |
| `make -C userland test` | userland/tests のみ | ~5 sec |
| `make -C kernel test` | kernel/tests のみ (compiler/build は ready 前提) | ~20 sec |
| `make test` (ルート) | 上記 3 つを順に。 ${\bf integration\ は走らない}$ | ~35 sec |
| `make full-test` (ルート) | `make test` + integration + FULL_TEST=1 系 | 数分〜30 分 (self-replicate 込) |

**ルート Makefile の `make test` ですら integration を含めない** のが
ポイント。integration はリリース前 / CI ナイトリー / 手動でのみ走る。

---

## 提案するディレクトリレイアウト (分割後)

```
riscv/
├── compiler/                       【サブプロジェクト 1: コンパイラ】
│   ├── bootstrap/                  C 実装 (x86 native Gen1)
│   ├── src/                        TC ソース (現 compiler/*.tc を移動)
│   │   ├── parse.tc, sigscan.tc, tcheck.tc, codegen.tc, bc2asm.tc
│   │   ├── asm_common.tc, asm_pass1.tc, asm_pass2.tc, asm_pass3.tc
│   │   ├── ast_node.tc, string_buffer.tc, source_reader.tc, strlib.tc
│   │   └── bcrun.tc
│   ├── runtime/                    バイナリターゲットごとの runtime
│   │   ├── tc/runtime.tc           TC 製 kmalloc (共通)
│   │   ├── linux/crt0_tc.s         Linux ELF + qemu-riscv32 用
│   │   ├── linux/crt0_tc_data.s
│   │   └── mtos/                   MTOS bin 用 (現 kernel/tasks/task_crt0.s)
│   │       ├── task_crt0.s         compiler-on-MTOS + userland 共用 crt0
│   │       └── task_data.s         同上 .data + .bss
│   ├── scripts/                    内部スクリプト
│   │   ├── compile-gen1.sh
│   │   ├── compile-gen2.sh
│   │   ├── compile-gen3.sh
│   │   ├── collect_imports.sh
│   │   └── tc_deps_to_d.sh
│   ├── tests/                      コンパイラ単体テスト
│   │   ├── golden/                 .ast / .bc / .s / .out / .exit
│   │   ├── unit_inputs/            hello.tc, fib.tc, fizzbuzz.tc, ...
│   │   └── test_*.sh
│   ├── Makefile                    コンパイラだけビルド
│   ├── README.md
│   └── build/                       【出力ディレクトリ — gitignored】
│       ├── host/                   Linux native + qemu-riscv32 経由で host で動く
│       │   ├── gen1/{parse,codegen,bc2asm,...}   x86 native (C)
│       │   ├── gen2/{parse,sigscan,...,asm_pass3,mkfs,bin2uf2}  RV32 ELF
│       │   └── gen3/{parse,...}    自己ホスト確認用
│       └── mtos/                   MTOS で動く raw bin (K3 header 付き)
│           ├── parse, sigscan, tcheck, codegen, bc2asm
│           └── asm_pass1, asm_pass2, asm_pass3
│
├── userland/                       【サブプロジェクト 3: ユーザープログラム】
│   ├── lib/
│   │   └── libtc/libtc.tc          全タスク共通ユーザライブラリ
│   ├── bin/                        個別ユーザータスク (現 kernel/tasks/* を移動)
│   │   ├── sh/{sh.tc, task.mk}
│   │   ├── ls/, cat/, cp/, du/, head/, wc/, grep/, rm/, mkdir/, rmdir/, echo/, rot13/
│   │   ├── vi/, neofetch/, count/, seq/
│   │   ├── launcher/, hello/, hello2/, catfile/, tmpdemo/, msh/
│   │   ├── mx/, mr/, muxon/, muxoff/, sdprobe/, tcc/, kbdump/, md5sum/
│   │   ├── console/                Windows 95 風 GUI コンソール
│   │   └── fbtest/
│   ├── tests/
│   │   └── …                       (test_unit.sh の一部、test_consistency.sh など)
│   ├── Makefile                    ユーザータスクだけビルド
│   ├── README.md
│   └── build/                       【出力ディレクトリ — gitignored】
│       └── mtos/                   MTOS raw bin (K3 header 付き)
│           ├── sh, ls, cat, ...    (各タスクの実体)
│           └── _index              (タスク名 → arena / stack 一覧)
│
├── kernel/                         【サブプロジェクト 2: カーネル】
│   ├── src/
│   │   ├── kernel.tc, kernel_pico2.tc, kernel_common.tc
│   │   ├── vfs.tc, tmpfs.tc, procfs.tc, mtfs.tc, fatfs.tc
│   │   ├── loader.tc, trap_common.s
│   │   └── rtc.tc, rtc_ds3231.tc
│   ├── platform/
│   │   ├── virt/
│   │   │   ├── platform_virt.s, crt0_data.s
│   │   │   ├── block_virtio.tc, block_fat_virtio.tc
│   │   │   └── platform.mk
│   │   └── pico2/
│   │       ├── platform_pico2.s, crt0_pico2_data.s
│   │       ├── block_flash.tc, block_sd.tc
│   │       └── platform.mk
│   ├── fs-spec/                    mtfs に何を入れるかの宣言
│   │   ├── default.spec            sh + libtc 必須
│   │   ├── extra.spec              + parse/sigscan/.../bin2uf2 (compiler/build/mtos)
│   │   ├── demo.spec               + kern_demo.conf (init=/bin/hello)
│   │   └── etc/                    bundled 設定ファイル (kern.conf 等)
│   ├── tools-src/                  TC で書かれた kernel 専用ホストツール
│   │   ├── mkfs.tc                 mtfs ディスクイメージ生成 (現 tools/mkfs.tc)
│   │   └── bin2uf2.tc              raw bin → UF2 (現 tools/bin2uf2.tc)
│   ├── scripts/
│   │   ├── build.sh                (現 kernel/build.sh)
│   │   ├── bin2s.sh, bin2s_incbin.sh
│   │   ├── run_pico2.sh, run_pico2_interactive.sh
│   │   └── run_virt.sh
│   ├── tests/
│   │   ├── test_os.sh
│   │   ├── test_pico2.sh
│   │   └── fixtures/kern_demo.conf
│   ├── Makefile                    カーネルだけビルド
│   ├── README.md
│   └── build/                       【出力ディレクトリ — gitignored】
│       ├── virt/kernel.bin
│       ├── virt/disk.img
│       ├── pico2/kernel.bin
│       └── pico2/kernel.uf2
│
├── integration/                    【3 つの境界をまたぐテスト】
│   ├── test_phase7.sh              self-host pipeline on OS
│   ├── pico2_self_replicate.sh
│   ├── qemu_mr_scale.py
│   └── phase3_verify.py
│
├── docs/                           (ほぼそのまま)
├── Makefile                        ルート: 3 つの sub-Makefile を順序付き呼び出し
└── README.md
```

---

## サブプロジェクトの境界と成果物

### 1. compiler/ サブプロジェクト

**責務**: TinyC ソースを RISC-V バイナリに翻訳する道具一式を提供する。

**入力**:
- 自身のソース (`compiler/src/*.tc`, `compiler/bootstrap/*.c`)
- ターゲットごとの crt0 / runtime (`compiler/runtime/{linux,mtos}/...`)

**出力 (= build/)**:

| 出力 | 形式 | 用途 |
|------|------|------|
| `build/host/gen1/{parse,codegen,bc2asm,bcrun,interp,typecheck}` | x86 ELF | bootstrap、`compile-gen1.sh` から呼ばれる |
| `build/host/gen2/{parse,sigscan,tcheck,codegen,bc2asm,asm_pass1,asm_pass2,asm_pass3,bcrun}` | RV32 ELF | host で qemu-riscv32 経由で動かす全段コンパイラ |
| `build/host/gen3/*` | RV32 ELF | Gen2 == Gen3 byte-exact 検証用 |
| `build/mtos/{parse,sigscan,tcheck,codegen,bc2asm,asm_pass1,asm_pass2,asm_pass3}` | MTOS raw bin (K3 header 付) | カーネルが mtfs に埋めて `/bin/parse` 等として展開する |

**外部依存** (許される):
- ホスト側: gcc, qemu-riscv32, GNU make, bash, python3
- **kernel / userland に対する依存は一切なし** (compiler は他 2 つを知らない)

**インターフェース契約**:
- `build/host/gen2/*` の CLI と stdin/stdout フォーマットは固定 (現在の
  `parse / sigscan / tcheck / codegen / bc2asm / asm_pass{1,2,3}` の I/O
  と同じ)
- `build/mtos/*` の bin は K3 header (8 byte) + raw bin、ABI は
  `compiler/runtime/mtos/task_crt0.s` から呼ばれるものと同じ。この crt0
  は compiler サブプロジェクトが所有し、userland はそれを参照して使う
  (compiler ↛ userland の依存方向を維持)
- 各バイナリの (arena, stack) サイズが必要なら `build/mtos/_index` に
  taskname:arena:stack を 1 行ずつ書き出す (kernel 側で消費)

**ビルドコマンド**:
```
make -C compiler              # gen1 + gen2 + build/host
make -C compiler build/mtos    # MTOS 向け bin
make -C compiler test         # 単体テスト
```

### 2. userland/ サブプロジェクト

**責務**: MTOS で動くユーザープログラムをビルドする。

**入力**:
- 自身のソース (`userland/bin/<name>/<name>.tc`, `userland/lib/libtc/...`)
- 各タスクの `task.mk` (arena / stack サイズ宣言)
- **compiler/build/host** (RV32 ELF コンパイラ群、`compile-gen2.sh` 経由で呼ぶ)

**出力 (= build/)**:

| 出力 | 形式 | 用途 |
|------|------|------|
| `build/mtos/<name>` | MTOS raw bin (K3 header 付) | kernel が mtfs に埋めて `/bin/<name>` |
| `build/mtos/_index` | テキスト | name:arena:stack 一覧 |

**外部依存** (許される):
- `compiler/build/host/gen2/{parse,sigscan,tcheck,codegen,bc2asm,asm_pass1,asm_pass2,asm_pass3}`
- `compiler/runtime/mtos/{task_crt0.s,task_data.s}` (compiler が所有する共用 crt0)

**インターフェース契約**:
- `task.mk` の DSL は現状維持: `GUEST_TASKS += <name>`、
  `EXTRA_GUEST_TASKS += <name>`、`TASK_ARENA_<name>`、`TASK_STACK_<name>`
- `build/mtos/<name>` のフォーマットは MTOS raw bin (8 byte header +
  raw bin、entry は header skip 後の +8)

**ビルドコマンド**:
```
make -C userland COMPILER_BUILD=../compiler/build
make -C userland COMPILER_BUILD=../compiler/build EXTRA=parse,sigscan,...
make -C userland test
```

### 3. kernel/ サブプロジェクト

**責務**: 起動可能なカーネルイメージを組み立てる (virt / pico2)。

**入力**:
- 自身のソース (`kernel/src/*.tc`, `kernel/platform/*/...`)
- 自身のホストツールソース (`kernel/tools-src/{mkfs,bin2uf2}.tc`、
  compiler/build/host/gen2 でビルド)
- **compiler/build/host** (カーネル自身 + kernel/tools-src を RV32 ELF
  にコンパイルするため)
- **fs-spec** (どのバイナリ・データを mtfs に入れるか)
- 上記 fs-spec が参照する **compiler/build/mtos** と **userland/build/mtos**

**出力 (= build/)**:

| 出力 | 形式 | 用途 |
|------|------|------|
| `build/host/{mkfs,bin2uf2}` | RV32 ELF | kernel ビルド過程の内部ツール (mtfs 生成と UF2 化) |
| `build/virt/kernel.bin` | raw bin | qemu-system-riscv32 -M virt -bios none |
| `build/virt/disk.img` | mtfs image | qemu の `-drive` で渡す |
| `build/pico2/kernel.bin` | raw bin | デバッグ用 (UF2 化前) |
| `build/pico2/kernel.uf2` | UF2 | RP2350 にフラッシュ |

**※** `mkfs.tc` / `bin2uf2.tc` は TC で書かれているが、用途が完全に
「カーネルイメージ生成のための内部ツール」なので **kernel サブプロジェクト
の所有物** として置く。compiler は単に「TC を翻訳するエンジン」を提供する
だけで、kernel 専用ツールを知らない。

**fs-spec の形** (例: `kernel/fs-spec/default.spec`):
```
# format: <mtfs_path> <source_path>
/bin/sh                 ${USERLAND_BUILD}/mtos/sh
/bin/libtc              ${USERLAND_BUILD}/mtos/libtc
/etc/kern.conf          ./fs-spec/etc/default_kern.conf
/hello.txt              ./fs-spec/etc/hello.txt
```

`kernel/scripts/build.sh` は spec を読んで、source_path を `build/mtos/`
の中から探してきて mtfs に追加する。compiler バイナリを入れたいときは
`extra.spec` を選ぶ:
```
# extra.spec — extends default.spec with the compiler pipeline
*include default.spec
/bin/parse              ${COMPILER_BUILD}/mtos/parse
/bin/sigscan            ${COMPILER_BUILD}/mtos/sigscan
/bin/tcheck             ${COMPILER_BUILD}/mtos/tcheck
/bin/codegen            ${COMPILER_BUILD}/mtos/codegen
/bin/bc2asm             ${COMPILER_BUILD}/mtos/bc2asm
/bin/asm_pass1          ${COMPILER_BUILD}/mtos/asm_pass1
/bin/asm_pass2          ${COMPILER_BUILD}/mtos/asm_pass2
/bin/asm_pass3          ${COMPILER_BUILD}/mtos/asm_pass3
/bin/bin2uf2            ${USERLAND_BUILD}/mtos/bin2uf2  # userland 側にも入れたい場合
```

これによって **「コンパイラがファイルシステムに含まれる」** という現状の
動作 (`EXTRA_TASKS="parse sigscan ..."` の置き換え) は維持される — ただし
やり方が違って、kernel の build.sh が compiler を symlink 経由で touch
することはなくなり、**compiler/build/mtos/ にビルド済バイナリがあるという
前提でコピーする** だけになる。

**ビルドコマンド**:
```
make -C kernel TARGET=virt    COMPILER_BUILD=../compiler/build USERLAND_BUILD=../userland/build
make -C kernel TARGET=pico2   FS_SPEC=extra
make -C kernel TARGET=pico2   FS_SPEC=demo
make -C kernel test
```

---

## ビルド依存グラフ (分割後)

```
                  ┌─────────────────┐
                  │ compiler/       │ (x86 + qemu-riscv32)
                  │   bootstrap → gen1 → gen2 → gen3 (verify)
                  │   build/host/gen2/{parse,sigscan,...,asm_pass3}
                  │   build/mtos/{parse,sigscan,...,asm_pass3}
                  └────────┬────────┘
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
      ┌───────────────┐         ┌──────────────────────────────────┐
      │ userland/     │         │ kernel/                          │
      │   bin/* compile          │  src/*.tc compile (via compiler/build/host)
      │   via compiler/build/host│  tools-src/{mkfs,bin2uf2}.tc を
      │   build/mtos/{sh,ls,...} │    compiler/build/host で先にビルド
      └────────┬──────┘         │  fs-spec resolve → mtfs.img
               │                │    ├ uses userland/build/mtos/*
               │                │    └ uses compiler/build/mtos/* (optional)
               │                │  link kernel.bin / UF2 化
               └───────────────►│  build/{virt,pico2}/kernel.{bin,uf2}
                                └──────────────────────────────────┘
```

**重要**: kernel は compiler の **両方の build 出力** に依存する:
- `build/host`: カーネル自身を RV32 ELF にコンパイルするため
- `build/mtos`: fs-spec で `/bin/parse` 等を入れたいとき (オプション)

userland は compiler の **host build** だけに依存する (自分自身が MTOS で
動く側だが、ビルドはホストでする)。

**循環していないこと**:
- compiler → (なし)
- userland → compiler
- kernel → compiler, userland

DAG なので、まず compiler、次に userland と kernel を並行 (両方は compiler
にしか依存しない) で組める。

---

## ルート Makefile

```makefile
# riscv/Makefile - top-level coordinator
.PHONY: all compiler userland kernel test clean

COMPILER_BUILD := $(CURDIR)/compiler/build
USERLAND_BUILD := $(CURDIR)/userland/build
KERNEL_BUILD   := $(CURDIR)/kernel/build

all: kernel

compiler:
	$(MAKE) -C compiler

userland: compiler
	$(MAKE) -C userland COMPILER_BUILD=$(COMPILER_BUILD)

kernel: compiler userland
	$(MAKE) -C kernel \
	    COMPILER_BUILD=$(COMPILER_BUILD) \
	    USERLAND_BUILD=$(USERLAND_BUILD)

# `make test` は 3 つのサブプロジェクト test を走らせるだけ。
# integration は含めない (時間がかかる + 3 つ全部 ready を要求するため)。
test:
	$(MAKE) -C compiler test
	$(MAKE) -C userland test
	$(MAKE) -C kernel   test

# integration + FULL_TEST=1 系を含む完全テスト。リリース前 / 手動。
full-test: test
	$(MAKE) -C integration test
	FULL_TEST=1 $(MAKE) -C kernel test

clean:
	$(MAKE) -C compiler clean
	$(MAKE) -C userland clean
	$(MAKE) -C kernel   clean
```

各サブプロジェクト Makefile は **自分の build/ の中だけ** に書き込む。
sibling のサブプロジェクトのファイルは絶対に書き換えない。これにより、
compiler だけを再ビルドしたいときに kernel/userland を絶対に汚さない
ことが保証される。

---

## 移行計画 (段階)

リファクタは何回かに分けて、各段階で `make test` が通る状態を保つ。

### Phase 0: 設計凍結 (このドキュメント) — **完了** ✅
- 決定事項 8 件を確定 (下記 "決定事項" 節)

### Phase 1: ディレクトリ移動 — 機械的 — **完了** ✅ (2026-05-25、9 commits)
- ✅ `compiler/*.tc` → `compiler/src/*.tc`
- ✅ `compile-gen{1,2,3}.sh` → `compiler/scripts/` (ルートからは削除)
- ✅ `compiler/crt0_tc{,_data}.s` → `compiler/runtime/linux/`
- ✅ `kernel/tasks/task_crt0.s`, `task_data.s` → `compiler/runtime/mtos/`
- ✅ `tools/{mkfs,bin2uf2}.tc` → `kernel/tools-src/`
- ✅ `kernel/tasks/{libtc,sh,ls,...}` → `userland/{lib,bin}/`
  (compiler symlink は維持 — fs-spec 化は Phase 2 の future work)
- ✅ `kernel/{kernel*.tc,vfs.tc,...}` → `kernel/src/`
- ✅ `kernel/{platform_*.s,crt0_*_data.s,block_*}` → `kernel/platform/{virt,pico2}/`
- ✅ `kernel/build.sh` 等 → `kernel/scripts/`

完了時点で `make test` 148 PASS。詳細 commit: a3d8f8e, 14f20d0, 27789be,
b55173b, 97c1b2d, 0628374, 206fef4, ab1c484, ad21c8a。

### Phase 2: サブプロジェクト Makefile 分離 — **完了** ✅ (2026-05-25、1 commit)
- ✅ `compiler/Makefile` 新設 (test scope: 140 tests)
- ✅ `userland/Makefile` 新設 (smoke: 40 builds)
- ✅ `kernel/Makefile` 新設 (test scope: 8 tests)
- ⚠ build recipe の物理移動は **未完了**。current は root Makefile が
  recipe を持ち、サブ Makefile が delegate する coordinator パターン。
  本格分離は将来のフェーズで実施。
- ⚠ `EXTRA_TASKS` → `FS_SPEC` 化は **未完了**。current は EXTRA_GUEST_TASKS
  経由 (userland/bin/*/task.mk の宣言)。

完了 commit: 18c32a7。

### Phase 3: テスト再配置 — **完了** ✅ (2026-05-25、4 commits)
- ✅ compiler tests → `compiler/tests/` (test_unit, test_pipeline,
  test_consistency, test_golden_examples, test_gen3, test_import, test_asm
  + 入力 .tc + golden/ + virt_crt0.s + update_golden.sh + bench_pipeline.sh
  + qemu_bin2uf2_test.py)
- ✅ kernel tests → `kernel/tests/` (test_os, test_pico2*, fb_render.py,
  fixtures/kern_*.conf, fixtures/msh_*.sh)
- ✅ integration tests → `integration/` (test_phase7, pico2_self_replicate,
  pico2_verify, phase3_verify.py, qemu_mr_scale.py, pico2_*.py,
  inputs/phase7_*.tc, fixtures/pico2_*.sh)
- ✅ Root Makefile: `integration-test` ターゲット追加、`full-test` が
  integration を起動

完了 commit: c085b73, f85077d, a1208df, 67b1106。

### Phase 4: 仕上げ — **完了** ✅ (2026-05-25 〜 2026-05-26、5 commits)
- ✅ `docs/sources.md` 全面リライト
- ✅ `CLAUDE.md` ディレクトリ構成 / ビルド＆実行 / テスト構造を更新
- ✅ ルート + 各サブプロジェクト README.md 新設
- ✅ **互換性 alias 完全撤去** (Phase 4b、decision 6):
  - `make virt-kernel` / `make pico2-kernel*` / `make run*` / `make gen2-tools`
    / `make gen3-tools` / `make test-asm-bins` / `make update-golden` /
    `make update-golden-and-run-test` を root から削除
  - 新 API は `make -C compiler {gen1/gen2/gen3/test/test-warm/test-asm-bins/
    update-golden}`、`make -C kernel {virt/pico2{,-extra,-demo,-console{,-land}}/
    run{,-extra,-pico2{,-extra,-console{,-land}}}/flash/test}`、
    `make -C userland {test/test-quick}`
  - run/run-pico2 系の qemu/openocd 呼び出し recipe は `kernel/Makefile` に物理移動
- ✅ 全 30+ ドキュメント (docs/*.md + docs/task/*.md) の path refs を一斉更新
- ✅ ルート整理: `tasks.md`, `hardware-check/`, `console.bmp`, `os/`,
  `tmp/{convert,gen_jis_unicode}.rb` 削除
- ✅ `tc_run.sh` / `tc_run_all.sh` / `tc_build.sh` → `compiler/scripts/`
- ✅ `tests/test_common.sh` → `compiler/tests/test_common.sh`
- ✅ `tests/test_all.sh` 削除、root Makefile が直接 sub-Makefile に委譲
- ✅ `tests/` ディレクトリ消滅

完了 commit: 1a59a7d (docs + READMEs), d52e0e7 (alias 撤去), f40ab94
(整合性 cleanup), 8cd4f52 (problem/roadmap update), 6b3f71f
(solved/overview update), 51d5716 (残り全 doc update), 801d611
(root cleanup), 3c27115 (tests/ 解体), d55cd89 (最終 doc cleanup)。

最終状態: ルートに `CLAUDE.md`, `Makefile`, `README.md` + 7 サブ
ディレクトリ (compiler, userland, kernel, integration, docs, build,
tmp) のみ。`make test` 148 PASS 維持。

---

## 残件 (Phase 4d で実施)

Phase 2 が conservative に止めた項目を Phase 4d で順次実施:

- ✅ **per-subproject `build/` 分離** (Phase 4c、2026-05-25〜26):
  `compiler/build/gen{1,2,3,test_asm}`, `userland/build/{tasks,shared,
  jpfont*,task_sizes.sh}`, `kernel/build/{virt_kernel.bin,pico2_kernel*.uf2,
  disk*.img,fat.img}` に分離完了。ルート `build/` には共有作業領域
  `intermediate/` のみ残る。
- ✅ **build recipe の物理移動** (Phase 4d-1/2/3、2026-05-26):
  root Makefile から各サブ Makefile に recipe 移動。
  - compiler/Makefile: Gen1/2/3 + mkfs/bin2uf2 + test_asm
  - userland/Makefile: task binaries + shared.s + jpfont + task_sizes
  - kernel/Makefile: disk images + virt_kernel + 5 pico2 UF2 + fat + run
  root Makefile 580 → 46 行 (coordinator only: all/test/full-test/
  integration-test/isolation-check/clean)。cross-sub deps は order-only
  delegation 経由 (`_compiler-gen2` 等の phony が `$(MAKE) -C ../X target`
  を呼ぶ)。
- ✅ **テスト境界の strace ベース isolation check** (Phase 4d-4、
  2026-05-26): `integration/check-test-isolation.sh <subproj>` が
  `make -C <subproj> test` を strace で計測し、許可された subproject
  (自身 + 依存) 外への file open を検出。`make isolation-check` で
  3 サブプロジェクト全部を順に検証。検証済の境界:
  - compiler test → compiler/ のみ touch
  - userland test → compiler/ + userland/
  - kernel test   → compiler/ + userland/ + kernel/
- ⏳ **`EXTRA_GUEST_TASKS` → `FS_SPEC` 駆動**: 未着手。
  `kernel/Makefile` の disk image recipe に大量の fixture コピーが残る
  (~50 行 × 5 variant)。宣言的 spec ファイル (`kernel/fs-spec/*.spec`)
  に移し、parse して mtfs に展開する build.sh 化が望ましい。

---

## 決定事項

以下は議論を経て確定した内容。実装時の指針として参照する。

1. **compiler-on-MTOS と userland 共用の crt0 (`task_crt0.s` / `task_data.s`) は compiler が所有する**
   → `compiler/runtime/mtos/` に置く。userland はそれを参照して自分の
   bin を生成する (依存方向: userland → compiler、DAG 整合)。
   crt0 ABI を変えるときは compiler サブプロジェクト内のテストで検出する
   (compiler-on-MTOS bin の boot smoke を compiler/tests に置く)。

2. **`mkfs.tc` / `bin2uf2.tc` は kernel が所有する**
   → `kernel/tools-src/` に置く。TC で書かれているが用途は完全に「カーネル
   イメージ生成のための内部ツール」なので、compiler は知らない。kernel
   サブプロジェクトのビルドが `compiler/build/host/gen2/*` を使って自前で
   `kernel/build/host/{mkfs,bin2uf2}` を生成する。

3. **bootstrap (C コンパイラ) は compiler が所有する**
   → `compiler/bootstrap/` に置く。compiler の再現性を 1 サブプロジェクト
   内に閉じる。

4. **テスト fixture の振り分け**
   - `tests/hello.tc`, `fib.tc` 等 → `compiler/tests/unit_inputs/`
   - `tests/golden/` → `compiler/tests/golden/`
   - `tests/fixtures/kern_demo.conf` → `kernel/tests/fixtures/`
   - `tests/phase7_*.tc` → `integration/inputs/`

5. **出力ディレクトリは `build/` の名前を保持する**
   → 各サブプロジェクトは `compiler/build/`, `userland/build/`,
   `kernel/build/` に成果物を置く。「dist/」は使わない。
   既存ルート `build/{gen1,gen2,gen3,kernel,test}/` は分割完了時に
   全削除する。

6. **互換性 alias は導入しない (旧呼び出しは破棄)**
   → ルート Makefile の `make virt-kernel` / `make pico2-kernel`
   / `make gen2-tools` 等の旧ターゲットや、`./compile-gen1.sh` 等の
   ルートスクリプトはすべて削除する。新しい呼び出し方
   (`make -C kernel TARGET=pico2`、`compiler/scripts/compile-gen1.sh`) に
   揃え、CLAUDE.md / docs / 各 test スクリプトを一斉更新する。

7. **self-replicate の中間ファイル名は維持**
   `pico2_self_replicate.sh` は 12 個の中間 .s と .lab の byte-exact
   一致を見ているので、`kernel/scripts/build.sh` の rewrite でも
   `PRELUDE_NAME=p` / `INPUT_NAMES="kc pp bf ..."` の指定経路を維持し、
   host gen2 build と device 側中間ファイル名を揃え続ける。

8. **CLAUDE.md の更新は Phase 4 の最後**
   ディレクトリ構成 / ビルドコマンド / テスト構造の節を一括書き直す。

---

## 期待される効果

- **編集 → ビルドのレイテンシ短縮**: compiler/src/parse.tc を 1 行
  直したときに kernel まで再リンクしない (compiler/build/host だけ
  更新)。userland も影響受けない場合は skip。
- **新規 OS ターゲット追加が容易**: `kernel/platform/<new>/` を足して
  `kernel/Makefile` で参照を増やすだけ。compiler / userland はそのまま。
- **コンパイラの他プロジェクト流用**: `compiler/` ディレクトリだけ
  別リポにコピーすれば、TinyC を持ち出して別の OS / 別の用途に使える。
- **責務の見通し**: 「これは誰のコード?」が一目でわかる。`docs/sources.md`
  も 3 セクションに分かれてシンプルになる。

---

## 次のステップ

1. このドキュメントをレビュー、open question を決める
2. Phase 1 (ディレクトリ移動) を 1 PR で実行
3. Phase 2 (Makefile 分離) を 1〜2 PR で実行
4. Phase 3 (テスト再配置) を 1 PR で実行
5. Phase 4 (ドキュメント / 仕上げ) を 1 PR で実行

各 PR は `make test` と `make full-test` の通過を必須にする。
self-replicate (`pico2_self_replicate.sh`) と test_phase7.sh も
Phase 2 完了時点で通ること。
