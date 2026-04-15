# Make ベース incremental build 計画

## 目的

`make test` を実行するたびに、`compiler/` も `kernel/` も手を付けて
いなくても Gen2 ツール 8 本 + kernel バイナリ + 全タスクバイナリが
毎回ゼロから再ビルドされている。この無駄を Make の依存グラフで
排除し、**変更した最小限のものだけ再コンパイルしてテスト** を
走らせる状態に持っていく。

ゴール:

- `make test` が 2 回目以降は Gen2 ツール再ビルドをスキップする
- `kernel/*.tc` の 1 ファイル編集で、そのファイルに依存する kernel
  バイナリだけが再生成される (全タスク再ビルドは起こらない)
- `compiler/*.tc` の 1 ファイル編集で、それを使う Gen2 ツール 1 本
  だけが再生成される
- `tests/*.tc` / `tests/*.sh` の編集は既存テスト動作を変えない
- ハード依存 (`qemu-riscv32` / `riscv64-unknown-elf-gcc` /
  `openocd-rpi` など) がないときは該当テストを今まで通り SKIP

## 現状の問題点

### P1: `SHARED_GEN2_DIR` を毎回空から作る

`tests/test_all.sh` が起動時に

```bash
SHARED_GEN2_DIR=$(mktemp -d)
trap 'rm -rf "$SHARED_GEN2_DIR"' EXIT
for t in parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2; do
    compile-gen1.sh -o "$SHARED_GEN2_DIR/$t" compiler/$t.tc
done
```

と 8 本を逐次ビルド → テスト終了と同時に rm。**約 3 s 毎回ロス**。
compiler/*.tc を触っていなくても同じ 3 s が毎回かかる。

### P2: `kernel/build.sh` が毎回全タスクを再コンパイル

`kernel/build.sh --target virt` は毎呼び出しで

1. `runtime.tc` / `libtc.tc` の pre-compile (CACHED_S_DIR 経由)
2. TASKS 全部 (hello/hello2/catfile/sh/tmpdemo/echo) をひとつずつ
   `compile-gen2.sh` で RV32 raw に
3. mtfs image 生成
4. kernel 本体を `compile-gen2.sh` で ELF/raw に

を走らせる。**何も触ってなくても ~10-15 s** かかる。1 つだけ task
を直しても全部再コンパイル。

### P3: `compile-gen2.sh` が `$(mktemp -d)` に中間成果物を置く

parse → sigscan → tcheck → codegen → bc2asm → asm_pass1 → asm_pass2
を 1 本のシェルで流す。成果物 (.ast, .th, .tast, .bc, .s, .lab) は
プロセス終了と同時に消える。再利用できない。

### P4: テスト側にも冗長ビルドが残っている

- `test_asm.sh` が runtime.s を pre-compile しているが、他のテストと
  は共有していない (P1 との重複)
- `test_os.sh` が `kernel/build.sh --target virt` を毎 make test
  で呼ぶ → P2 とフル重複
- `test_phase7.sh` / `test_pico2.sh` は手動実行なのでまだ問題は
  小さいが、同じ仕組みに乗せたい

### P5: 依存関係が暗黙的

`import "foo.tc";` を追加しても Make には見えない。全ソースを touch
してから `make test` すれば間違いなく通るが、それでは P1–P4 の
節約が効かない。

## 設計方針

### D0: 世代ツールの置き場を `build/genN/` に統一

- `build/gen1/` — Gen1 の C 製ツール (parse/codegen/bc2asm/typecheck/
  bcrun/interp/extract-sigs)。現状 `bootstrap/` / トップ直下にバラけて
  いるのをここに集約して `make clean` で一掃できるようにする
- `build/gen2/` — Gen1 で build した TC 製ツール (parse/sigscan/tcheck/
  codegen/bc2asm/bcrun/asm_pass1/asm_pass2)
- `build/gen3/` — Gen2 で build した同じ TC 製ツール (自己ホスト確認
  用 + kernel build の本番経路候補)

### D0b: kernel build は Gen3 で行う (少し遅くなっても採用)

現状 kernel/build.sh は Gen2 ツール (C 製 runtime linked) を使っている
が、将来的には Gen3 ツール (TC runtime.tc linked) で build したい。
qemu 上の実行速度は実測次第だが、**少し遅い程度なら Gen3 を採用** して
「自己ホスト経路だけが本番」という状態を目指す。実装順としては Phase
C 以降、build/gen3/ が安定してから切り替える。

### D1: ビルド成果物は `build/` ツリーに固定パスで置く

```
build/
  gen1/                 # Gen1 ツール (C 製、make で GCC コンパイル)
    parse codegen bc2asm typecheck bcrun interp extract-sigs ...
  gen2/                 # Gen2 ツール (compile-gen1.sh 出力)
    parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2
  gen3/                 # Gen3 ツール (compile-gen2.sh 出力、kernel build 本番)
    parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2
  compiler/             # compiler/*.tc ソースのミラー位置
    runtime.s           # compiler/runtime.tc → 1 回だけ
  kernel/
    tasks/libtc/
      libtc.s           # kernel/tasks/libtc/libtc.tc → 1 回だけ
    root/               # plat 非依存のユーザーランド (disk image 源泉)
      bin/
        hello hello2 catfile sh tmpdemo echo launcher cat
        parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2
      hello.txt
      prelude.s prelude_tail.s
      empty_imports.txt self_open.txt wrap_close.txt
      hw.tc phase7_min.tc phase7.tc
    disk.img            # kernel/root/ を mkfs.py した結果、plat 共通
    virt_kernel.bin     # virt 用カーネル本体 (kernel + disk を link)
    pico2_kernel.bin    # pico2 用 (XIP に disk を埋め込み)
    pico2_kernel.uf2    # bin2uf2.py 出力
  test/
    asm/                # tests/test_asm.sh 用の中間 ELF
      hello2_virt.bin
      test_timer.bin
      test_echo.bin
```

要点:

- **ソースのミラー位置**: `compiler/runtime.tc` → `build/compiler/runtime.s`、
  `kernel/tasks/libtc/libtc.tc` → `build/kernel/tasks/libtc/libtc.s` の
  ようにソース階層をそのまま映す。`build/cache/` のような平置きは廃止
- **task は plat 共通**: `build/kernel/root/bin/<task>` に 1 本だけ置き、
  virt と pico2 の両方から同じ binary を参照する。virt 限定 (sh/echo/
  tmpdemo) と pico2 限定 (launcher) はタスク一覧を統合して両 plat に
  入れる (→ 下記 "タスク一覧の統合")
- **disk.img も plat 共通**: `build/kernel/disk.img` 1 本。pico2 では
  kernel build 時に `bin2s.sh _mtfs_image` でこれを .rodata に埋める
- **kernel 本体は flat**: `build/kernel/virt_kernel.bin` /
  `pico2_kernel.bin` / `pico2_kernel.uf2` を build/kernel/ 直下に置く
  (`build/kernel/virt/` / `build/kernel/pico2/` のサブディレクトリを
  廃止して見通しを良くする)

これにより `make test` 2 回目は Make が mtime を見てスキップできる。
`git clean -x build/` で全捨てに戻せる。

### D1b: タスク一覧を virt/pico2 で統合

現状 `kernel/build.sh` は virt と pico2 で TASKS リストが違う
(virt: hello/hello2/catfile/sh/tmpdemo/echo、pico2: hello/hello2/
catfile/launcher)。task binary 自体は ecall syscall だけで動くので
plat 非依存 → 両方に同じ一覧を入れて `build/kernel/root/` を 1 本に
共有できる。統合後のタスク一覧:

```
hello hello2 catfile sh tmpdemo echo launcher cat
  + EXTRA_TASKS 時: parse sigscan tcheck codegen bc2asm asm_pass1 asm_pass2
```

seed task の選定 (pico2 は slot 2 が launcher、virt は slot 2 が sh)
は変えない — disk.img に両方入っていても kernel 側の seed 設定で
どちらを先に起動するかは決められる。disk.img だけが共通化対象。

### D2: .tc の `import` 依存は `.d` ファイルで auto-tracking

`build/gen2/parse` のビルド時に、`parse.tc` が recursively import
している `.tc` のリストを grep で集め、それを `.d` として書き出す:

```makefile
# build/gen2/parse の recipe 末尾で:
./tools/collect_imports.sh compiler/parse.tc \
    > build/gen2/parse.d

# Makefile 先頭:
-include build/gen2/*.d
```

`.d` の中身は:

```
build/gen2/parse: compiler/parse.tc compiler/strlib.tc \
    compiler/string_buffer.tc compiler/source_reader.tc
```

Gen2 ツール + task 全部 + kernel 本体で使う。Make 標準の `-include`
パターンなので追加ツールは要らない (tools/collect_imports.sh 1 本)。

既存の `compile-gen1.sh` / `compile-gen2.sh` の `_collect_imports`
bash 関数をほぼそのまま使える。依存リストを stdout に出すモード
を足して grep-friendly にする。

### D3: 非再帰 Makefile + 既存シェルスクリプトの薄い wrap

`compile-gen1.sh` / `compile-gen2.sh` は今も動くので recipe から呼ぶ
だけにして再実装しない。`kernel/build.sh` は **段階的に解体** する:
Phase A/B では wrap で動かし、Phase C で task/link のサブコマンド
に分割して、最終的に Makefile が全依存グラフを持つ形にする。

**非再帰 (`include`) 方式**: `kernel/tasks/*/task.mk` を top Makefile
から `include` し、再帰 make は使わない。GNU Make の有名な罠 (再帰
make が依存を壊す問題) を避けつつ、task 追加コストも低く抑える。

```makefile
# top Makefile の抜粋
include $(wildcard kernel/tasks/*/task.mk)

# kernel/tasks/hello/task.mk の中身
$(eval $(call define_task,hello,32768,8192))

# kernel/tasks/tasks.mk (共通マクロ、top から include 済みとする)
define define_task
build/kernel/root/bin/$(1): kernel/tasks/$(1)/$(1).tc \
    $$(shell tools/collect_imports.sh kernel/tasks/$(1)/$(1).tc) \
    build/compiler/runtime.s build/kernel/tasks/libtc/libtc.s \
    $$(GEN2_TOOLS)
	./compile-gen2.sh --task --arena $(2) --stack $(3) \
	    -o $$@ $$<
TASK_BINS += build/kernel/root/bin/$(1)
endef
```

各 task のソースディレクトリに 1 行だけの `task.mk` を置くので、task
追加は「ディレクトリ作って .tc 置いて task.mk を 1 行書く」だけで済む。
ARENA_SIZE / STACK_SIZE は task.mk の引数として明示 → 現状
kernel/build.sh に散らばっている `TASK_ARENA` テーブルが不要になる。

**並列は禁止**: `.NOTPARALLEL:` を top Makefile に宣言して `-j1` 強制。
`compile-gen2.sh` が共用の CACHED_S_DIR / qemu state を race させる
のを避ける (そもそも並列化したくない、という方針)。

`kernel/build.sh` は Phase C で以下のサブコマンドに分割:

- `kernel/build.sh --task <name> --arena N --stack N -o <path>`:
  1 task の .bin だけを出力 (K3 header + crt0 + runtime.s + source)
- `kernel/build.sh --disk <tasks...> -o build/kernel/disk.img`:
  既存 task .bin を mkfs.py で disk image 化 (plat 非依存)
- `kernel/build.sh --link <target> --disk <img> -o <kernel>`:
  kernel 本体を .bin/.uf2 に link。task は触らない

### D4: テストターゲットは必要な成果物にだけ依存させる

```makefile
.PHONY: test test-unit test-pipeline test-gen3 test-asm test-os ...

test: test-unit test-pipeline test-gen3 test-asm test-os ...

test-unit: $(GEN1_TOOLS)
	./tests/test_unit.sh

test-pipeline: $(GEN2_TOOLS)
	SHARED_GEN2_DIR=build/gen2 ./tests/test_pipeline.sh

test-asm: $(GEN2_TOOLS) build/test/asm/hello2_virt.bin \
          build/test/asm/test_timer.bin build/test/asm/test_echo.bin
	./tests/test_asm.sh --use-prebuilt build/test/asm

test-os: $(GEN2_TOOLS) build/kernel/virt_kernel.bin build/kernel/disk.img
	./tests/test_os.sh --use-prebuilt build/kernel
```

各テスト sh はプリビルド済み path を受け取って「すでに存在する
kernel を qemu に食わせる」だけのフェーズに変える。

### D5: 依存抽出ツール

`tools/collect_imports.sh <file.tc>`:

```bash
#!/bin/bash
# Output: newline-separated list of all transitively imported .tc files.
_collect() {
    local tc_file="$1" tc_dir="$(dirname "$1")"
    grep -oE '^import "[^"]+";' "$tc_file" 2>/dev/null \
        | sed 's/^import "\(.*\)";$/\1/' \
        | while read -r imp; do
            local full="$tc_dir/$imp"
            [ -f "$full" ] || continue
            echo "$full"
            _collect "$full"
        done
}
{ echo "$1"; _collect "$1"; } | sort -u
```

これを `.d` の形式に整形する小さなラッパも作る:

```bash
# tools/tc_deps_to_d.sh <target> <file.tc> — emit Makefile .d file
target="$1"
tc="$2"
echo -n "$target: "
tools/collect_imports.sh "$tc" | tr '\n' ' '
echo
```

## ビルドグラフ (主要ターゲット)

```
build/gen1/<tool>                      depends on
    bootstrap/<tool>.c 等 (GCC リンク、Makefile 現行)

build/gen2/<tool>                      depends on
    compiler/<tool>.tc + transitive imports + $(GEN1_TOOLS)

build/gen3/<tool>                      depends on
    compiler/<tool>.tc + transitive imports + $(GEN2_TOOLS)

build/compiler/runtime.s               depends on
    compiler/runtime.tc + $(GEN2_TOOLS) (or Gen3)

build/kernel/tasks/libtc/libtc.s       depends on
    kernel/tasks/libtc/libtc.tc + $(GEN2_TOOLS)

build/kernel/root/bin/<task>           depends on
    kernel/tasks/<task>/<task>.tc + transitive imports
    + build/compiler/runtime.s
    + build/kernel/tasks/libtc/libtc.s
    + kernel/tasks/task_crt0.s + kernel/tasks/task_data.s
    + $(GEN2_TOOLS)  (kernel build 本番で Gen3 採用後は $(GEN3_TOOLS))

build/kernel/disk.img                  depends on
    全 task bin + tests/phase7_hello*.tc + prelude.s / prelude_tail.s
    + kernel/tasks/task_crt0.s + kernel/tasks/task_data.s
    (plat 非依存、virt と pico2 の両方から参照)

build/kernel/virt_kernel.bin           depends on
    kernel/kernel.tc + kernel/kernel_common.tc + kernel/*.tc
    + kernel/platform_virt.s + kernel/trap_common.s
    + kernel/crt0_data.s
    + build/compiler/runtime.s
    + build/kernel/disk.img
    + $(GEN2_TOOLS)  (本番 Gen3 後は $(GEN3_TOOLS))

build/kernel/pico2_kernel.bin          depends on
    kernel/kernel_pico2.tc + kernel/kernel_common.tc + kernel/*.tc
    + kernel/platform_pico2.s + kernel/trap_common.s
    + kernel/crt0_pico2_data.s
    + build/compiler/runtime.s
    + build/kernel/disk.img  (pico2 は bin2s.sh で .rodata に埋める)
    + $(GEN2_TOOLS) / $(GEN3_TOOLS)

build/kernel/pico2_kernel.uf2          depends on
    build/kernel/pico2_kernel.bin + tools/bin2uf2.py
```

## 段階的移行計画

一度に全部ひっくり返すと壊れやすいので 5 フェーズに分ける。

### Phase A: 共有 Gen2 ディレクトリを `build/gen2/` 固定に (小)

- `tests/test_all.sh` の `SHARED_GEN2_DIR=$(mktemp -d)` を
  `SHARED_GEN2_DIR=build/gen2` にし、trap cleanup を廃止
- Makefile に `build/gen2/%: compiler/%.tc` ルールを追加
- Makefile に `GEN2_TOOLS = build/gen2/parse build/gen2/sigscan ...`
  を定義
- `make test` のターゲットを `test: all $(GEN2_TOOLS)` に変更
- `tests/test_all.sh` から Gen2 pre-build ループ自体を削除
- Gen1 ツールも `build/gen1/` に移す (現行の Makefile 出力先変更)

**期待節約**: 毎 make test で ~3 s。もう一方のメリットとして、
compiler/ 以下を触らないときは 1 本もリビルドしない

### Phase B: 依存抽出と `.d` 導入 (中)

- `tools/collect_imports.sh` / `tools/tc_deps_to_d.sh` を新設
- Phase A の Gen2 ビルドルールに `.d` 生成を追加
- Makefile で `-include build/gen2/*.d` する
- compiler/\*.tc を 1 つ編集して対応する Gen2 ツールだけがビルド
  されることを手動確認

**期待節約**: compiler/ 内の 1 ファイル編集時に他のツール (parse →
他の 7 本) を再ビルドしなくなる

### Phase C: kernel/build.sh を --task / --disk / --link に分割 (大)

- `build/compiler/runtime.s` / `build/kernel/tasks/libtc/libtc.s` を
  Make ルール化 (ソース位置ミラー)
- virt/pico2 のタスク一覧を統合 (D1b 参照) — `kernel/build.sh` の
  TASKS 定義を 1 本化し、両 plat で同じ一覧をビルドする
- `kernel/tasks/<task>/task.mk` を各 task ディレクトリに新設。
  トップ Makefile で `include $(wildcard kernel/tasks/*/task.mk)`
- `kernel/tasks/tasks.mk` に `define_task` 共通マクロを置き、
  `build/kernel/root/bin/<task>` を生成する recipe を定義
- `build/kernel/disk.img` を Make ルール化 (plat 非依存、全 task bin
  + phase7 test input + prelude.s を mkfs.py)
- `build/kernel/virt_kernel.bin` / `pico2_kernel.bin` /
  `pico2_kernel.uf2` を Make ルール化 (task は触らない、kernel 本体
  だけリンク)
- `.NOTPARALLEL:` を top Makefile で宣言
- `test-os` / `test-phase7` / `test-pico2` を新ルールに依存させる

**期待節約**: kernel/ を触らない make test では kernel もタスクも
再生成されない。kernel/tasks/<X> を 1 つ touch しても、X.bin +
disk.img + kernel.bin だけが再ビルドされる。virt/pico2 の task
重複ビルドも消える

### Phase D: テストスクリプト移行 + 旧パス削除 (中)

- `tests/test_*.sh` にビルド責任が残っているところを削ぎ落とし、
  Make からのプリビルド版を受け取る形に統一
- `compile-gen2.sh` の単独実行パスは残すが、キャッシュディレクトリ
  指定を正式な env (`BUILD_CACHE_DIR=build/compiler`) にリネーム
- README / CLAUDE.md 更新 (`make test` の体感が変わるので周知)

### Phase E: Gen3 経路 + consistency 脱 FULL_TEST (小〜中)

- `build/gen3/%` ルールを追加 (compile-gen2.sh で build、依存は
  $(GEN2_TOOLS) + compiler/*.tc + imports)
- `time compile-gen2.sh` vs `time compile-gen3.sh` を kernel build
  と代表タスクで実測
- 結果が「少し遅い程度」なら kernel build の本番経路を Gen3 に切替
  ($(GEN3_TOOLS) を kernel/task recipe の依存に差し替え)
- `test_consistency.sh` の中間ファイル (ast/bc/s/elf) を
  `build/consistency/<input>/` に残すように改造し、2 回目以降は
  qemu 実行のみに短縮 → FULL_TEST ガードを外してデフォルトで回す

## 決定済み項目 (旧 Q1-Q5)

### Q1: test_consistency を FULL_TEST から抜ける → Phase E で

中間ファイル (ast/bc/s/elf) を `build/consistency/<input>/` に残し、
2 回目以降は qemu 実行だけに短縮する。`test_consistency.sh` は
作り直さず、中間ファイルの出力先だけ env で切り替え可能にする。
これで FULL_TEST ガードを外してデフォルトで走らせる余地ができる。

### Q2: Gen3 は `build/gen3/` で本番採用 → Phase E で

`build/gen3/%` を Make ルール化し、kernel/task の build 経路を
$(GEN3_TOOLS) に切り替える (実測の上、「少し遅い」程度なら採用)。

### Q3: 並列化はしない

`.NOTPARALLEL:` を top Makefile に宣言して `-j1` 強制。CACHED_S_DIR
/ qemu の race もそもそも無視できるし、シリアル実行の方がログが
読みやすい。

### Q4: pico2 テストは `.PHONY`

実機を触るので時刻比較でスキップ判定はしない。`test-pico2` は
`.PHONY` で、手動呼び出し時に `build/kernel/pico2_kernel.uf2` を
依存として持たせる。

### Q5: disk.img の task 依存

`build/kernel/disk.img` は全 task .bin + phase7 test input
(`tests/phase7_hello*.tc` + `/hw.tc`) + prelude.s のどれかが変われば
再生成。prelude の K3 header 値 (32 KB / 8 KB) も dependency に
含める (実装は stamp ファイルを嚙ませる)。

### Q6: 既存 update_golden.sh の扱い

`make update-golden` は `tests/update_golden.sh` を呼ぶだけ。
Gen1 ツール依存なので Phase A-E の影響は薄いが、golden の
更新判定は自動化しない (開発者が意図的に走らせるやつ)。

## 進め方

1. この文書にレビューをもらう ✔ (2026-04-16)
2. Phase A を実装 + `make test` で計測 (before/after 比較)
3. Phase A が安定したら B/C/D/E を段階的に
4. 各フェーズ完了時点で CLAUDE.md + roadmap.md を更新
