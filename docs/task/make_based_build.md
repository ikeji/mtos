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

### D1: ビルド成果物は `build/` ツリーに固定パスで置く

```
build/
  gen2/                 # Gen2 ツール (compile-gen1.sh 出力)
    parse
    sigscan
    tcheck
    codegen
    bc2asm
    bcrun
    asm_pass1
    asm_pass2
  cache/                # shared .s キャッシュ
    runtime.s           # compiler/runtime.tc から 1 回だけ生成
    libtc.s             # kernel/tasks/libtc/libtc.tc から
  kernel/
    virt/
      tasks/
        hello.bin
        hello2.bin
        catfile.bin
        sh.bin
        tmpdemo.bin
        echo.bin
        parse.bin          # EXTRA_TASKS 時
        sigscan.bin        # 〃
        tcheck.bin
        codegen.bin
        bc2asm.bin
        asm_pass1.bin
        asm_pass2.bin
        cat.bin
      disk.img
      kernel.bin
    pico2/
      tasks/<same>
      kernel.uf2
  test/
    asm/                # tests/test_asm.sh 用の中間 ELF
      hello2_virt.bin
      test_timer.bin
      test_echo.bin
```

これにより `make test` 2 回目は Make が mtime を見てスキップできる。
`git clean -x build/` で全捨てに戻せる。

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

### D3: 既存シェルスクリプトは生かす (recipe として呼ぶ)

`compile-gen1.sh` / `compile-gen2.sh` / `kernel/build.sh` は今も動く
ものをゼロから書き直さない。Make の recipe から単純に呼び出すだけに
する:

```makefile
build/gen2/%: compiler/%.tc $(GEN1_TOOLS) | build/gen2
	./compile-gen1.sh -o $@ $<
	./tools/collect_imports.sh $< > $(@).d
```

recipe の中で KEEP_TMP / CACHED_S_DIR 等の既存環境変数を使って
incremental 効率を引き出す。

唯一例外は `kernel/build.sh`: 今の「ワンショットで全部やる」形を、
**個別 task を 1 つだけビルドするサブターゲット** + **それらを束ねて
kernel + mtfs を作る最終ステップ** に二段に分ける。分けないと P2 が
解決できない。具体的には:

- `kernel/build.sh --task <name>` サブコマンドを新設: 1 task の
  .bin だけを `build/kernel/<target>/tasks/<name>.bin` に出力
- `kernel/build.sh --link <target>` サブコマンドを新設: 既存の
  `build/kernel/<target>/tasks/*.bin` を mtfs 化して kernel と
  リンクする最終段。task .bin は再ビルドせず読むだけ

Make がそれぞれを独立ターゲットとして駆動:

```makefile
build/kernel/virt/tasks/hello.bin: kernel/tasks/hello/hello.tc ...
	./kernel/build.sh --target virt --task hello

build/kernel/virt/kernel.bin: $(VIRT_TASK_BINS) $(VIRT_KERNEL_SOURCES)
	./kernel/build.sh --target virt --link -o $@
```

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

test-os: $(GEN2_TOOLS) build/kernel/virt/kernel.bin build/kernel/virt/disk.img
	./tests/test_os.sh --use-prebuilt build/kernel/virt
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
Gen1 tools (Makefile 現行)
    parse, codegen, bc2asm, typecheck, bcrun, interp, extract-sigs

build/gen2/<tool>                      depends on
    compiler/<tool>.tc + transitive imports + Gen1 tools

build/cache/runtime.s                  depends on
    compiler/runtime.tc + Gen2 parse/sigscan/tcheck/codegen/bc2asm

build/cache/libtc.s                    depends on
    kernel/tasks/libtc/libtc.tc + Gen2 tools

build/kernel/virt/tasks/<task>.bin     depends on
    kernel/tasks/<task>/<task>.tc + transitive imports
    + build/cache/runtime.s
    + kernel/tasks/task_crt0.s + kernel/tasks/task_data.s
    + Gen2 tools + asm_pass1/pass2

build/kernel/virt/disk.img             depends on
    all $(VIRT_TASK_BINS) + tests/phase7_hello*.tc
    + kernel/tasks/task_crt0.s + kernel/tasks/task_data.s
    (mtfs 化 + prelude staging)

build/kernel/virt/kernel.bin           depends on
    kernel/kernel.tc + kernel/kernel_common.tc + kernel/*.tc
    + kernel/platform_virt.s + kernel/trap_common.s
    + kernel/crt0_data.s
    + build/cache/runtime.s
    + build/kernel/virt/disk.img   (virt はディスク別ファイル)
    + Gen2 tools
```

`pico2` も同型。`disk.img` は pico2 では `bin2s.sh` で .rodata に
埋めるので kernel.uf2 が直接依存する (別 .img は出ない)。

## 段階的移行計画

一度に全部ひっくり返すと壊れやすいので 4 フェーズに分ける。

### Phase A: 共有 Gen2 ディレクトリを `build/gen2/` 固定に (小)

- `tests/test_all.sh` の `SHARED_GEN2_DIR=$(mktemp -d)` を
  `SHARED_GEN2_DIR=build/gen2` にし、trap cleanup を廃止
- Makefile に `build/gen2/%: compiler/%.tc` ルールを追加
- Makefile に `GEN2_TOOLS = build/gen2/parse build/gen2/sigscan ...`
  を定義
- `make test` のターゲットを `test: all $(GEN2_TOOLS)` に変更
- `tests/test_all.sh` から Gen2 pre-build ループ自体を削除

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

### Phase C: kernel/build.sh を --task / --link に分割 (大)

- `build/cache/runtime.s` / `build/cache/libtc.s` を Make ルール化
- `build/kernel/<target>/tasks/<task>.bin` を Make ルール化。中身は
  新規追加の `kernel/build.sh --target <t> --task <name> -o <path>`
  (既存 for ループを 1 task 分に切り出しただけ)
- `build/kernel/<target>/kernel.bin` / `.uf2` を Make ルール化。中身は
  `kernel/build.sh --target <t> --link --disk-out ... -o <out>`。
  task 再コンパイルはしない
- `test-os`/`test-phase7`/`test-pico2` を新ルールに依存させる

**期待節約**: kernel/ を触らない make test では kernel もタスクも
再生成されない。kernel/tasks/<X> を 1 つ touch しても、X.bin +
disk.img + kernel.bin だけが再ビルドされる

### Phase D: テストスクリプト移行 + 旧パス削除 (中)

- `tests/test_*.sh` にビルド責任が残っているところを削ぎ落とし、
  Make からのプリビルド版を受け取る形に統一
- `compile-gen2.sh` の単独実行パスは残すが、キャッシュディレクトリ
  指定を正式な env (`BUILD_CACHE_DIR=build/cache`) にリネーム
- README / CLAUDE.md 更新 (`make test` の体感が変わるので周知)

## 未解決 / オープン課題

### Q1: test_consistency / test_gen3 の自作 tmp

- `test_gen3.sh` が各ファイルに mktemp を使って中間 ast/bc を
  出している。そこは Make にはせず shell 側のままで OK か?
- consistency は FULL_TEST 限定なのでデフォルトは影響しない

### Q2: Gen3 (`compile-gen3.sh`) の扱い

Gen2 == Gen3 自己ホストチェックは make test の中には無い (test_gen3
の内部で Gen2 ツールで再コンパイルするだけ)。`build/gen3/*` の置き場
と更新トリガをどう決めるか。たぶん `test-gen3` サブターゲットで
ローカルに `$(BUILD)/gen3` を作る暫定でいい

### Q3: ビルド並列化 (-j)

Phase C まで進めば Make が自動で並列化してくれるはずだが、
`compile-gen2.sh` の中で qemu / CACHED_S_DIR を共用しているので
race するかも。最初は `-j1` 前提で動かして確認

### Q4: hardware テスト (pico2) のタイムスタンプ戦略

`test-pico2` は実機を触るのでスキップ判定が難しい。今回は
デフォルトで `.PHONY`、手動呼び出し時だけ kernel.uf2 を依存と
する扱いでよさそう

### Q5: mtfs image と task 依存

`disk.img` は mtfs_mkfs の結果なので task binary 変化のたびに作り
直す。phase7 の test input (.tc を /hw.tc として入れる) も
dependency に入る。prelude_tc の header 値 (32 KB / 8 KB baked in)
も変えたら disk.img を再生成

### Q6: 既存 update_golden.sh の扱い

`make update-golden` は `tests/update_golden.sh` を呼ぶだけ。
Gen1 ツール依存なので Phase A/B/C の影響は薄いが、golden の
更新判定は自動化しない (開発者が意図的に走らせるやつ)

## 進め方

1. この文書にレビューをもらう
2. Phase A を実装 + `make test` で計測 (before/after 比較)
3. Phase A が安定したら B/C/D を段階的に
4. 各フェーズ完了時点で CLAUDE.md + roadmap.md を更新
