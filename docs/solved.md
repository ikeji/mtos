# 解決済みの問題

`docs/problem.md` から移動。コミットメッセージで詳細がわかる。

---

## asm_pass1 / asm_pass2 (アセンブラ兼リンカ)

### 7. パイプライン 100 KB 計画: Phase 1+2+3+4+5 完了 (2026-04-16)

**元の「asm.tc 9 MB」問題は Phase 1+2+3+4+5 で実質解決済**。
`compiler/asm.tc` は `asm_common.tc + asm_pass1.tc + asm_pass2.tc`
に分割され、2026-04-15 の Gen2 toolchain migration で旧 asm.tc /
typecheck.tc は削除。asm_pass2 の g_code を .lab のセクションサイズ
合計で動的確保する仕組み (Phase 4) で、旧 4 MB 固定を廃止済。

実測ピーク (compile-gen2.sh で build した Gen3 tools を
qemu-riscv32 で動かして `[kmem peak=N live=M]` を回収):

| タスク    | before  | compiler/*.tc (2026-04-16) | 改善量 |
|---|---:|---:|---:|
| parse         | 14 KB  | 14 KB          | — |
| sigscan (新)  | —      | 9〜11 KB       | — |
| tcheck  (新)  | —      | 74〜244 KB     | — |
| codegen       | 303 KB | 79〜246 KB     | ~2x |
| bc2asm        | 1.4 MB | 118〜124 KB    | ~11x |
| asm-pass1 (新)| —      | **227〜268 KB** | (label pool shrink) |
| asm-pass2 (新)| —      | **260〜280 KB** | (Phase 5 stream-emit) |
| (legacy asm)  | 9.5 MB | — (削除済)     | |

Phase 5 (commit 426f51e, 2026-04-16) で **asm_pass2 から g_code を
廃止**し、source を 3 回再読み込みして target section を 4 KB out_buf
経由で直接 stdout に stream emit する方式に変更。Phase 4 の動的確保
段階では ~440 KB だったのが ~260 KB まで落ちた。asm_pass1 も別途
`MAX_LABELS 16384 → 4096` + `MAX_NAME_POOL 256K → 128K` の shrink
(commit 5098a1e) で ~430 KB → ~250 KB へ。

**結果**: すべての compiler task が Pico 2 kernel arena (480 KB) に
余裕で収まる。

対処履歴:
- Phase 1 (#49〜#54、#62〜#64): typecheck を sigscan + tcheck に分割。
  per-top-level AST streaming + per-fn kmalloc fntab で 717 KB → 75 KB 台
- Phase 2 (#55〜#58): asm を 3 ファイルに分割。`.lab` 中間ファイルで
  pass1 / pass2 を別プロセス化。g_lines 4 MB 廃止
- Phase 3 (#59、#60): codegen と bc2asm を in-place shrink。bc2asm は
  per-function emission で 1.4 MB → 126 KB
- Phase 4: asm_pass2 の g_code を .lab のセクションサイズ合計で動的確保。
  `MAX_CODE = 4194300` 固定を廃止、bss は filesz に含めない。
  4.6 MB → 441 KB (~10x)
- Phase 5: asm_pass2 の g_code 自体を廃止、3-pass source re-scan で
  stream emit。441 KB → 260 KB

計画詳細: `docs/task/pipeline_100kb.md`、.lab 仕様: `docs/lab_format.md`。

---

## カーネル / OS

### K3. タスクサイズ宣言 — 案C 完了 (2026-04-15)

タスクバイナリの先頭 8 バイトに `.word arena_size; .word stack_size`
の header を埋め込む仕組みで完了。

- `kernel/build.sh` が per-task で header.s を emit し task_crt0.s の
  前にリンク。`task_arena_size()` / `task_stack_size()` の 2 つの
  bash 関数に per-task 値が載っている (hello 8 KB ... asm_pass2 512
  KB)。
- `kernel/loader.tc::load_fd` が img 先頭 8 バイトから peek32 で
  arena / stack を取り、`make_task(img + 8, arena, stack)` を呼ぶ。
- kernel.tc / kernel_pico2.tc / sys_exec_handler / sys_spawn_handler
  から固定 16 MB / 16 KB を撲滅。`load_task` の引数も
  `load_task(path)` だけに簡潔化された。
- 中間バイナリ (/tmp/hw) 用の header は `/prelude.s` に 32 KB / 8 KB
  が baked in されている。

残件: OS 側で大きいタスクを compile するときに `/prelude.s` の
header 値も調整する仕組みがない (固定 32 KB)。

---

## その他 (以前から解決済み)

- **phase 7 M6 達成 (2026-04-14)**: OS 上で Hello World を自己コンパイル
  + 自己実行。sh の `<` / `>` リダイレクトと絶対パス実行、tmpfs による
  中間ファイル経由のパイプライン、runtime.tc の per-task ピークメモリ
  計測、`task_crt0.s` の `fn main()` / `fn main(argv)` 両対応フォールバック
  スタブ、`kernel/build.sh` の `/prelude.s` 事前連結など。tests/
  test_phase7.sh に 2 ステージのテストあり (`make test` 非同梱)

- **パイプライン 100 KB 計画 Phase 1 + 2 + 3 完了 (2026-04-15)**: 計画
  `docs/task/pipeline_100kb.md`、commit log は #49〜#64。元の 717 KB /
  303 KB / 1.4 MB / 9.5 MB の各ステージを劇的に縮小:
  - Phase 1: `compiler/sigscan.tc` + `compiler/tcheck.tc` を新設。
    拡張 .th (`(imports)(self)(program)` wrapper) で typecheck を
    per-function streaming 化。tcheck は per-fn strtab rollback +
    per-fn kmalloc fntab で 717 KB → **75〜251 KB** (~9x)
  - Phase 2: `compiler/asm_common.tc` + `compiler/asm_pass1.tc` +
    `compiler/asm_pass2.tc` を新設。`.lab` 中間ファイル (`docs/
    lab_format.md`) で 2 プロセス分離、g_lines 4 MB を廃止。
    asm-pass1 **~430 KB** (~22x)、asm-pass2 **~4.6 MB** (g_code 残
    件は問題 #7 に移動)
  - Phase 3: codegen は strtab perm/ephemeral 2 cursor 化で
    303 KB → **80〜252 KB**。bc2asm は per-function emission で
    1.4 MB → **120〜126 KB** (~11x)
  - Cleanup (#61 partial): `compiler/extract_sigs.tc` 削除 (unused)、
    `typecheck.tc` / `asm.tc` に deprecation header
  - tests/test_phase7.sh: sigscan + tcheck + asm_pass1 + asm_pass2 の
    full split pipeline で OS 上 Hello World 完走

- **Gen2 toolchain migration 完了 (2026-04-15)**: Phase 1+2+3 の後半
  cleanup。compile-gen2.sh / compile-gen3.sh / kernel/build.sh /
  tests/test_common.sh / tests/test_gen3.sh / tc_run.sh を新パイプ
  ライン (sigscan + tcheck + asm_pass1 + asm_pass2) に切り替え、
  `compiler/typecheck.tc` / `compiler/asm.tc` (+ kernel/tasks/
  typecheck/, kernel/tasks/asm/, tc_asm.sh, tests/test_split.sh)
  を完全削除

- **bc2asm の `__tc_strobj<N>` ラベルが複数 .tc 間で衝突していた (#21)**:
  ラベルを `__<first_fn_mangled_name>_strobj<N>` にして .tc ごとに一意化

- `u32 >> n` が arithmetic shift だった → `shr_u` opcode 追加 (9ff97b5)
- `u32 < u32` (`<=`, `>`, `>=`) が signed 比較になっていた → `lt_u` /
  `le_u` / `gt_u` / `ge_u` opcode 追加 + codegen で LHS 型を見て分岐
- `u32 / u32` / `u32 % u32` が signed 除算になっていた → `div_u` /
  `mod_u` opcode 追加
- 16 進リテラル `0xFFFFFFFF` 等で top bit 以上が壊れる → parse.tc の
  hex/binary 累積を `<<` + `|` に変更
- struct 定義の trailing comma が通らなかった → 修正 (b04855c)
- 関数宣言 / 関数呼び出しの trailing comma → 修正 (b04855c)
- struct array が asm リンカで未定義シンボル → parser で synthetic fn
  を生成して修正 (b04855c)

### 8. asm セクション 16B アライン制限 (wontfix, 2026-04-17 moved)

実害は qemu virt の block_virtio.tc 1 箇所のみ (12 KB waste)。
pico2 は関係なし。修正不要と判断。

### K4. UART EOF 検出不可 (limitation → mux で解決, 2026-04-17 moved)

`do_uart_read` が busy-loop で EOF を区別できなかったが、
UART mux (mx/mr) の length-prefix フレーミングで len=0 が EOF マーカー
として機能するため、mux ON 環境では解決。mux OFF では sh の "quit"
コマンドで代替。

### K5. cat 5 ファイル後の spawn 失敗 (bug → 解決, 2026-04-17)

調査の結果、`sys_spawn_handler` で `sched_spawn` が失敗した際に
redirect fd / frame / ram / stack / img / argv がリークするバグを発見し
修正 (`free_last_alloc()` 追加)。元の再現条件 (旧パイプライン構成) は
現在の virt 環境で 5-file cat + redirect を 4 回繰り返しても再現せず、
prelude 導入前の構成固有だったと判断。

### K6. デバッグトレース常時 ON (ergonomics → 整理済, 2026-04-17)

TIMER_INTERVAL を 1s → 1ms に復元。kdbg_switch / kdbg_exit を mux ON
時のみに。kdbg_write (vfs redirect trace) を削除。km_dump_peak の
task_crt0.s 常時 call を削除。kdbg_trap と OOM メッセージは残留。

### K10. pico2 multi-file cat hang (bug → 再現せず, 2026-04-17)

pico2 で cat 3+ ファイルが hang する問題。2026-04-17 に pico2 実機で
cat 3 files / cat 4 files (redirect 付き) を確認したところ正常動作。
K5 の sys_spawn_handler リソースリーク修正や構成変更で解消されたと判断。

### 17. make test 60 秒制約 (ergonomics → 解決, 2026-04-17 moved)

Make ベース incremental build 導入後、warm 33s / cold 78s まで短縮。
60 秒制約を十分に満たしている。

### 3. 整数リテラルの型推論 (ergonomics → 解決, 2026-04-18)

関数呼び出し時にサフィックスなし整数リテラル (`256`) をパラメータの
整数型 (`u32`, `u8` 等) に合わせて自動推論するよう tcheck.tc と
bootstrap/typecheck.c に 2段階オーバーロード解決を実装。

Phase 1: exact match (従来通り)。Phase 2: exact match 失敗時に
サフィックスなし整数リテラル引数を相手型に coerce して再解決。
変数経由 (`var n: i32 = 256; f(n)`) は従来通りエラー。

`U8Array(256u32)` → `U8Array(256)` のように配列コンストラクタや
poke/peek 等の直接リテラル引数から u32 サフィックスを ~180 箇所除去。
変数の `as u32` キャストやバイナリ演算内のサフィックスは対象外
(関数呼び出し引数位置のリテラルのみ)。

### UART stdin ブロック (bug → 解決, 2026-04-18)

sh の `sys_read(0, buf, 1)` が ecall ハンドラ内の `do_uart_read` で
M-mode スピンウェイトし、hello/hello2 等の他タスクが実行されなかった。
`do_uart_try_read` (非ブロッキング) + -2 sentinel + `sched_yield_read`
で yield and retry に変更。-2 sentinel により UART empty と file EOF
(リダイレクト時の tmpfs/pipe EOF) を区別。
