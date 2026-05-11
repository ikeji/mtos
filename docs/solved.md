# 解決済みの問題

`docs/problem.md` から移動。コミットメッセージで詳細がわかる。

---

## asm_pass2 / asm_pass3 (アセンブラ兼リンカ)

### 7. パイプライン 100 KB 計画: Phase 1+2+3+4+5 完了 (2026-04-16)

**元の「asm.tc 9 MB」問題は Phase 1+2+3+4+5 で実質解決済**。
`compiler/asm.tc` は `asm_common.tc + asm_pass2.tc + asm_pass3.tc`
に分割され、2026-04-15 の Gen2 toolchain migration で旧 asm.tc /
typecheck.tc は削除。asm_pass3 の g_code を .lab のセクションサイズ
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

Phase 5 (commit 426f51e, 2026-04-16) で **asm_pass3 から g_code を
廃止**し、source を 3 回再読み込みして target section を 4 KB out_buf
経由で直接 stdout に stream emit する方式に変更。Phase 4 の動的確保
段階では ~440 KB だったのが ~260 KB まで落ちた。asm_pass2 も別途
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
- Phase 4: asm_pass3 の g_code を .lab のセクションサイズ合計で動的確保。
  `MAX_CODE = 4194300` 固定を廃止、bss は filesz に含めない。
  4.6 MB → 441 KB (~10x)
- Phase 5: asm_pass3 の g_code 自体を廃止、3-pass source re-scan で
  stream emit。441 KB → 260 KB

計画詳細: `docs/task/pipeline_100kb.md`、.lab 仕様: `docs/lab_format.md`。

---

## カーネル / OS

### K14. device self_replicate byte-exact — 完了 (2026-05-11)

実機 pico2 で `REFRESH_KERN_MODS=1 tests/pico2_self_replicate.sh` が
per-file pre-encode + `asm_pass2 --link` 経路で完走し、生成された
`/sd/k.bin` と `/sd/k.uf2` の md5 が host build
(`compile-gen2.sh kernel/kernel_pico2.tc`) と byte-exact 一致。
walked-source モードはこの時点で退役 (commit dddbf8b)。

- host k.bin md5: `8929f2b12694514f9f5490533fd51595`
- device k.bin md5: `8929f2b12694514f9f5490533fd51595` ✅
- virt k.bin md5: `8929f2b12694514f9f5490533fd51595` (qemu-system + 同 OS image での再現も一致)
- host k.uf2 md5: `b4eee17af1f3ba6d0e9c13b36e6b4797`
- device k.uf2 md5: `b4eee17af1f3ba6d0e9c13b36e6b4797` ✅

**解決した bug の総まとめ**:

1. **OOM (asm_pass2 / asm_pass3 task arena が大きすぎ)**:
   - asm_pass3_lib.tc memory 最適化 (commit 119fac1) で peak 382→328 KB
     - `g_reloc_names` (3000 個の U8Array(name) 保持) → `g_reloc_lab_idx`
       (parse 時に label index 解決) 化で 120 KB 削減
     - `asm_ensure_labels_finalized()` を ref parse 前に呼ぶ (O(1) find_label)
     - `pre_secs` の delete 漏れ修正 (156 KB leak)
     - `RELOCS_CAP_INIT` 256 → 4096 で doubling growth 回避
   - asm_pass3 `raw_memcpy_section` の `U8Array(pad_n)` を 4 KB chunk-write
     loop に置換 (commit d2543e5) — 3.5 MB blob 前の zero pad alloc を回避
   - task arena 384→336 KB (commit 0a57e15) で kernel make_task が
     pico2 508 KB kernel arena に fit

2. **byte-exact 不一致 (parse.tc の silent overflow)** (commit 4fe14d7):
   - `parse.tc::pars_struct` の `fields: FieldInfoArray(16u32)` が
     `struct Task` (19 fields) で 17th 以降 overflow
   - Gen1 (bootstrap C runtime) は set/get の bound check で abort →
     host parse output が 1024 byte で truncate
   - Gen2 (compiler/runtime.tc) は `bc2asm.tc::emit_inline_set` が
     bound check を skip して inline → silent corrupt
   - 結果: virt+device は corrupt AST から「自己整合的だが host と違う」
     k.bin を生成
   - 修正: FieldInfoArray を 32 slots に bump (現状の max Task の 19 が
     収まる)

3. **その他 (virt 再現で見つけた付随 bug)**:
   - fatfs / mtfs / vfs の FD table 上限が device での REFRESH には十分だが
     virt が全 step を 1 boot で走らせると不足 (commit f2d6ce0):
     FATFS_MAX_FDS 8→16, MTFS_MAX_FDS 8→16, VFS_MAX_FDS 16→32
   - loader.tc の sys_spawn_handler 失敗パスに debug_dump_path 追加で
     spawn 失敗時の path がデバッグ可能に

**検出経緯**: 当初 device 側で OOM 393220 で step 2 が必ず落ちる症状。
原因は OOM ではなく kernel make_task の U8Array(arena_size) 失敗 (task
arena 自体が大きすぎた)。task arena を 336 KB に絞ったところ end-to-end
完走したが host kernel build と byte-exact 不一致。virt で device と同じ
OS image を走らせて 13 input idx を host 側と md5 比較したところ 4 個
(ff/mf/ld/pt) が違い、bisect で `parse < kernel_common.tc` の出力が
host=1024 byte で truncate していることが判明。原因は parse.tc の
16-slot FieldInfoArray と struct Task の 19 fields。

**Follow-up 解消 (commit 8501f6d)**: `bc2asm.tc::emit_inline_set/get`
が runtime bound check を skip するという罠は同じバグを再現させる
可能性があったので、両 inline path に 2-insn (lw + bltu) の bound
check + OOB 時に `__array_oob_{set,get}__i32__i32` への jump を
追加した。Gen1 (`bootstrap/runtime_syscall.c`) と Gen2/3
(`compiler/runtime.tc`) の両 runtime に対応する OOB handler を追加。

詳細は `docs/scaling.md` の self_replicate byte-exact 検証節と、
commits 119fac1 / 0a57e15 / d2543e5 / f2d6ce0 / 4fe14d7 / 8501f6d
を参照。

### K13. Pico 2 が自分の UF2 を byte-exact に self-replicate — 完了 (2026-05-06; 2026-05-09 platform fixture 追加)

**2026-05-09 追補**: K13 完成後に compile pipeline が `kernel/platform_pico2.tc` を
新設して `do_uart_*` / `do_write` / `do_read` を asm から TC に移行
したため、self_replicate の REFRESH 経路で `/sd/pp.s` (TC-compiled
platform) が生成されないと on-device link で
`undefined label do_write__i32__u32__i32` が出る状態になっていた。
`tests/fixtures/pico2_compile_platform.sh` を新設し orchestrator に
step 0d として組み込んだ (commit 37b791b)。実機検証: kernel.bin md5
`1ec465d27a1137c66d9554b07e840295` / kernel.uf2 md5
`fb7645d1d735a5c0cfce9f740f3c8cb3` が host build と完全一致、
total ~29 min (REFRESH 込み)。

また step 2 を per-file pre-encode + `asm_pass2 --link` に移行
(`tests/fixtures/pico2_self_step2.sh`)。host compile-gen2.sh と同じ
`asm_pass1 per .s + asm_pass2 --link` の shape で .lab を生成する。
host での同パイプライン再現で byte-exact 確認、device 側の byte-exact
動作は K14 完了時 (2026-05-11) に確認、walked-source モードは退役した
(commit dddbf8b)。

更に asm_pass1 に `--incbin-skip` フラグを追加 (commit 6f57f45 / 2b48cd0):
section 先頭の `.incbin SIZE "path"` を idx の `incbin <sec> <intra>
<size> <path>` レコードに defer し、asm_pass2 --link が `.lab` に
`src raw <path> <sec> <abs>` 行を直接 emit する。asm_pass3 が
original blob (e.g. `/sd/dx.img`) を memcpy するので、3.5 MB の
asm_pass1 read+emit ループが消える。

  - host kernel build (compile-gen2.sh): 288 sec → 42 sec (6.9x)
  - asm_pass1 on pt.s (qemu host): 1020 ms → 39 ms (26x)

Makefile の `pico2_kernel*.uf2` 系ターゲットを `bin2s.sh` (.byte 形式
26 MB ASCII) → `bin2s_incbin.sh` (.incbin 形式 1.5 KB wrap) に切替、
compile-gen2.sh が prelude_tail.s に `--incbin-skip` を自動注入する。



Pico 2 実機がフラッシュ済の UF2 を起点に、自分が動かすファームウェアを
最初から最後まで自前で生成し、host gen2 build と byte-for-byte 完全一致
させる閉ループを達成 (~50 min)。

```
host   kernel.bin md5: 026d825ca32e4d40a67b182505c36d48
device /sd/k.bin md5:  026d825ca32e4d40a67b182505c36d48
host   kernel.uf2 md5: 4a639e26b7fbd057654ec5ac63fbf09a
device /sd/k.uf2 md5:  4a639e26b7fbd057654ec5ac63fbf09a
```

`tests/pico2_self_replicate.sh` orchestrator が openocd reset で
ステップ間を区切りつつ:

1. boot dumper (`kernel_pico2.tc::dump_mtfs_to_sd`) が起動時に
   embedded mtfs を `/sd/dx.img` に dump し、対応する `/sd/wrap.s`
   を emit。Size + 先頭 64 byte content match で skip 判定 (3 s)。
2. `pico2_compile_runtime/libtc/kern/kern2.sh` で /sd 上の .s 群を
   現ソースから regenerate (~14 min)。
3. cat 16 files → /sd/full.s (302 s)
4. asm_pass2 が `--lab-out /sd/full.lab /sd/full.s` で `src` 行を
   `.lab` に bake (232 s)
5. asm_pass3 が `--lab /sd/full.lab --out /sd/k.bin` で /sd/full.s を
   3 回直接読んでリンク (800 s)
6. bin2uf2 task が /sd/k.bin → /sd/k.uf2 を変換 (758 s)

決め手の実装:

- **`bin2uf2` task** (`kernel/tasks/bin2uf2/bin2uf2.tc`):
  `tools/bin2uf2.py` の TC port、qemu virt で 6 KB fixture を
  byte-exact verify 済 (commit b9067cd)
- **`.incbin SIZE "path"` directive** (`compiler/asm_common.tc`):
  bin2s.sh の `.byte` 列挙の代わりに binary file を直接埋め込み、
  巨大な mtfs blob を XIP flash に低コストで載せる (commit 5958574)
- **bin2s_incbin.sh / bin2s.sh の `_mtfs_image_size_value` helper**:
  TC dumper が peek32 を介さずに blob size を取れる
- **boot-time mtfs dumper**: kernel が起動時に `_mtfs_image_*` を
  `/sd/dx.img` + `/sd/wrap.s` として複製。size+content 64 B 比較
  で再 dump 判定 (commit fb9c7fb)
- **fatfs `dir_create` chain growth** (commit 773b746):
  FAT root cluster 128 entries 上限を撤廃、自己再生中に増える
  ファイルが入る
- **asm_pass2 --lab-out + 位置引数で `src` 行を `.lab` に
  emit** (commit 0c9a9a4): cat /sd/full.lab + 3×/sd/full.s →
  /sd/p2_in.s の中間ファイル (13 MB / 305 s) を撤廃。
  実機 v8 検証: kernel.bin md5 `7805e7348...` / kernel.uf2 md5
  `d4be5e9e...` が host と完全一致 (~50 min total、v6 比 ~5 min 短縮)
- **REFRESH skip** (v9 検証): /sd 上の .s 群が直近の build と
  同じソースから生成済みなら `REFRESH_KERN_MODS=0` (default) で
  step 0a-d を skip でき、~14 分短縮 (~50 min → ~36 min)。byte-exact
  は維持。ソースを触ったときだけ `REFRESH_KERN_MODS=1` で再生成。
- **fatfs FAT セクタ書き込みキャッシュ** (commit 27ec588): 連続する
  クラスタ割り当てで fat_get_entry / fat_set_entry が同じ FAT セクタを
  毎回 read-modify-write していた (FAT1 + FAT2 で 4 SD ops/cluster) 部分を
  per-sector write-back cache に置き換え。fatfs_close / fatfs_delete
  で flush。実機 v10 検証: ~50 min → ~26 min (REFRESH 込みで 1.9× 速)。
  step 1 cat (302→78 s, 3.9×)、step 2 asm_pass2 (311→97 s, 3.2×)、
  step 0c kern_leaves (323→105 s, 3.0×) が特に速くなる。byte-exact
  維持 (md5 `5dc55910...` host == device)。
- **dumper 1 KB content probe** (commit 60050f7): mtfs 先頭 64 B
  だけだと superblock layout が同じ別ビルドで誤判定するので 1 KB
  (= superblock + 16 inode entries) に拡大、disk-extra.img の
  ファイル増減を確実に検出する
- **DROP_TASKS Makefile knob**: vi/tcc/sdprobe/neofetch/
  count/tmpdemo/launcher を外して disk-extra.img を 3.5 MB に
  抑え、kernel + dumper + bin2uf2 が 4 MiB flash に収まる

副次的に閉じた issue: K11 の pico2 mr upload hang は「kernel が
disk image を /sd に dump する」内部経路に置き換わったため、
host から大容量を UART で送らずに済むようになった (K11 自体は
未解決のまま、回避経路が確立)。

### K7. pico2 で phase 7 コンパイラを完走 — 完了 (2026-04-29)

実機 Pico 2 上で OS 自身の compile pipeline が完全に走り、生成
バイナリを実行できるようになった:

```
parse → sigscan → cat → tcheck → codegen → bc2asm → cat
       → asm_pass2 → cat → asm_pass3 → /sd/HW
=> Hello, World!
合計 127 秒
```

決め手は 3 点の組み合わせ:

1. **SD カード SPI ストレージ** (commit 37c99c7)
   `kernel/block_sd.tc` + MBR 対応 `kernel/fatfs.tc`。`/sd/<path>`
   経由で SD に読み書きできるようになり、中間ファイル
   (1.ast / 2.tast / 3.bc / 4.s / full.s / lab.s / p2.in / HW) を
   全部 SD に流せるようになった。これで 480 KB SRAM tmpfs 縛りが
   外れ、phase 7 の I/O 量が無制限に。

2. **PLL_SYS bring-up で CPU を 150 MHz 化** (commit cf22718)
   それまで `kernel/platform_pico2.s` は PLL 未使用で clk_sys ≈ 12 MHz。
   asm_pass2 単独で 310 秒もかかっていた (CPU バウンド)。XOSC 12 MHz
   × FBDIV(125) → POSTDIV(5,2) で clk_sys 150 MHz に切替えた結果、
   同じ asm_pass2 が 27 秒に短縮 (11.5×)。clk_peri は XOSC 直 12 MHz
   のまま据え置いて UART/SPI baud は無変更。

3. **プロンプト同期 UART ドライブ** (commit 5dfa631)
   PL011 RX FIFO は 32 byte。sh が `sys_wait` 中は drain されない
   ので fixed-sleep のテストでは長行が捨てられた。
   `tests/pico2_pipeline_drive.py` が `sh$ ` プロンプトを見て次行を
   送る方式に切替えて回避。

旁ら必要だった副次修正:
- `bootstrap/runtime_syscall.c` の 16-byte pool を 256 → 32768
  に拡大 (commit b8049d2)。`make pico2-kernel-extra` が asm_pass2
  自身を Gen2 で compile する際の bucket 0 OOM 解消。

副次の運用 limitation (phase 8 で再検討):
- UART RX FIFO に IRQ + ring buffer は未対応 (K8+K9 と統合)
- task arena 絶対サイズの限界 (asm_pass3 で 320 KB) は維持

### K3. タスクサイズ宣言 — 案C 完了 (2026-04-15)

タスクバイナリの先頭 8 バイトに `.word arena_size; .word stack_size`
の header を埋め込む仕組みで完了。

- `kernel/build.sh` が per-task で header.s を emit し task_crt0.s の
  前にリンク。`task_arena_size()` / `task_stack_size()` の 2 つの
  bash 関数に per-task 値が載っている (hello 8 KB ... asm_pass3 512
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
  - Phase 2: `compiler/asm_common.tc` + `compiler/asm_pass2.tc` +
    `compiler/asm_pass3.tc` を新設。`.lab` 中間ファイル (`docs/
    lab_format.md`) で 2 プロセス分離、g_lines 4 MB を廃止。
    asm-pass1 **~430 KB** (~22x)、asm-pass2 **~4.6 MB** (g_code 残
    件は問題 #7 に移動)
  - Phase 3: codegen は strtab perm/ephemeral 2 cursor 化で
    303 KB → **80〜252 KB**。bc2asm は per-function emission で
    1.4 MB → **120〜126 KB** (~11x)
  - Cleanup (#61 partial): `compiler/extract_sigs.tc` 削除 (unused)、
    `typecheck.tc` / `asm.tc` に deprecation header
  - tests/test_phase7.sh: sigscan + tcheck + asm_pass2 + asm_pass3 の
    full split pipeline で OS 上 Hello World 完走

- **Gen2 toolchain migration 完了 (2026-04-15)**: Phase 1+2+3 の後半
  cleanup。compile-gen2.sh / compile-gen3.sh / kernel/build.sh /
  tests/test_common.sh / tests/test_gen3.sh / tc_run.sh を新パイプ
  ライン (sigscan + tcheck + asm_pass2 + asm_pass3) に切り替え、
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
