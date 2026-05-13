# コンパイラパイプラインのメモリ / 時間スケーリング

K7 達成 (2026-04-29) で pico2 実機上での Hello World self-host が
完走するようになった。本稿は「次のステップ: OS 全体の self-host
コンパイル」に備えて、**メモリ・時間がどう伸びるか**を実測値から
推定したもの。

## 実測ベースライン (Hello World)

`tests/phase7_hello_world.tc` (366 byte ソース) を pico2 実機で
完走させた値:

| 段 | task arena (decl) | task peak (実測) | 所要時間 |
|---|---|---|---|
| parse | 64 KB | (出力なし) | <1 s |
| sigscan | 16 KB | 8.5 KB | <1 s |
| cat-wrap | 16 KB | — | <1 s |
| tcheck | 320 KB | 73 KB | ~3 s |
| codegen | 320 KB | 75 KB | ~3 s |
| bc2asm | 192 KB | 111 KB | ~5 s |
| cat-link | 16 KB | — | ~25 s (234 KB SD write) |
| asm_pass2 | 320 KB | 218 KB | ~27 s |
| cat-p2 | 16 KB | — | ~50 s (3× full.s 連結) |
| asm_pass3 | 320 KB | 298 KB | ~80 s |
| **合計** | | | **~127 s** |

CPU: clk_sys 150 MHz (PLL_SYS), clk_peri 12 MHz (XOSC)
SD: SPI mode 0, 6 MHz, write ~5 KB/s, read ~17 KB/s

## Q1: OS 全体をコンパイルする所要量

### 前提と単純化

- 「OS 全体 = compiler/*.tc + kernel/*.tc + kernel/tasks/\*/\*.tc」
- 約 **40〜50 ファイル**
- 各ファイルのサイズは様々 (catfile.tc 1 KB、tcheck.tc 70 KB)
- 各ファイルを独立に compile pipeline にかける想定

### 時間: per-file の固定費 + ソースサイズ比例分

phase 7 の 1 ファイルあたりの所要時間は **固定費 ~110 s + ソース
サイズ依存 ~α s**。固定費が大きいのは、`/prelude.s` (234 KB) を
asm_pass2 が 1 回、asm_pass3 が 3 回読むため:

- asm_pass2: 234 KB read + 計算 + 11 KB write ≒ 27 s
- asm_pass3: 234 KB × 3 read + 計算 + 45 KB write ≒ 80 s
- cat-link / cat-p2 で 234 KB SD write × 4 回 ≒ 45 s

→ 1 ファイルあたり **120 s 程度の prelude オーバーヘッド** がほぼ
constant。

ソースサイズ依存分 (parse / tcheck / codegen / bc2asm) は
ソース byte 数に概ね比例。Hello World (366 B) で 12 s 弱。線形外挿:

| ソースサイズ | tcheck+codegen+bc2asm | 合計 (固定 + 固定) |
|---|---|---|
| 1 KB | ~30 s | ~150 s (2.5 分) |
| 10 KB | ~5 分 | ~7 分 |
| 70 KB (tcheck.tc 級) | ~35 分 | ~37 分 |

### 再測定 (2026-05-13、`.idx` pre-encode + 3-binary split + dead-strip 後)

K7 時代の上記モデル (asm_pass2 が prelude.s を walk、asm_pass3 が 3
回 walk) は **完全に古い**。現在の pipeline は:

- prelude は `kernel/build.sh` が **`prelude.{idx,tx,ro,dt,rl}`** に
  pre-encode 済 (`docs/task/asm_pre_encode.md`)。`.tx` は ~50 KB の
  text bin に縮小。
- asm_pass2 は prelude.idx (~30 KB) を読んで label table を merge
  するだけ。prelude.s 234 KB の tokenize は **0 回**。
- asm_pass3 は prelude.tx を **1 回 memcpy** + reloc patch のみ。
  234 KB × 3 walk は **0 回**。
- cat-link / cat-p2 で 234 KB を SD に書く処理は撤廃。
- dead-strip default-on (commit b7d8b4d、2026-05-13) で text セクション
  は ~290 KB → ~264 KB (~9 %)、task .bin は 53 KB → 24 KB に縮小。

**実機 pico2 で `tests/test_pico2_bench.sh` 計測 (Hello World、
PLL_SYS 150 MHz、msh /pico2_bench_idx.sh 駆動、1 boot 完走)**:

| stage | K7 (2026-04-29) | 現在 (2026-05-13) | 比 |
|---|---:|---:|---:|
| parse | 31 s | **2.73 s** | 11× |
| sigscan | 10 s | **0.16 s** | 62× |
| tcheck (file mode) | 5 s | **0.34 s** | 15× |
| codegen | 5 s | **0.20 s** | 25× |
| bc2asm | 5 s | **0.20 s** | 25× |
| cat-link | 10 s | **0.18 s** | 56× |
| asm_pass1 | (n/a — 旧 asm) | **1.06 s** | — |
| prelude staging × 4 (`cat /prelude.* > /sd/`) | — | **1.24 s** | — |
| asm_pass2 | 27 s | **5.17 s** | 5× |
| asm_pass3 | 80 s | **2.27 s** | 35× |
| /sd/HW exec | 1 s | **0.21 s** | 5× |
| **end-to-end 合計 (1 boot)** | **127 s** | **~13.8 s** | **9.2×** |

source 依存 5 stage (parse〜bc2asm) は K7 の **66 s → 3.7 s で
18 倍速** いている。これは:

- 旧 `.s` 経由から `.idx` pre-encode への変更で prelude tokenize 撤廃
- 3-binary asm split (asm_pass1 が user.s を pre-encode、pass2/3 は idx
  merge と memcpy のみ)
- dead-strip default-on で生成バイナリが小さく → SD I/O 削減
- `.incbin` defer (`docs/scaling.md` Q7) で SD への中間書き込み撤廃

#### 過去の OOM 問題と解決 (2026-05-13、3 commit で完全消滅)

K7 era 〜 2026-05-12 までは msh から parse → ... → asm_pass1 → cat ×
4 と多数の task を連続 spawn したあと asm_pass2 を起動すると、kernel
arena (508 KB) の pool が断片化し 336 KB の task arena 確保に失敗
していた:

```
OOM: 344068 p=439388 l=118236
     free=[20484,12132,24408,32748,310320,s=400092,n=5,m=310320]
```

5 ブロック分裂、合計 free 391 KB あるが最大連続が 303 KB しかない。
要求 336 KB に対し 33 KB 不足。

**実機データから 3 種類の根本原因を特定**:

1. **clone_argv が各 String を個別 kmalloc** (commit 688e4ef)
   - tcheck (7 argv) で bucket 16 を +7 carve、asm_pass1 (11 argv) で
     bucket 16 を +4 carve、cat (4 argv) で bucket 8 を +1 carve
   - bucket-pool の entry は一度 carve すると large heap に戻らない
   - **修正**: argv 全体を 1 packed buffer に詰めて large_alloc 経由化

2. **frame_buf (132 byte) が別 alloc** (commit 49ae455)
   - bucket 6 (260 byte) に carve され、msh の frame_buf が「90 KB
     free 領域と 306 KB free 領域の間に persistent live」として常駐
   - **修正**: frame_buf を task ram block 内 (stack 末尾の後) に
     embed → 1 つの大 alloc にまとめる

3. **argv buffer 自体が独立 alloc** (commit 0c1b800)
   - 1 と 2 の修正後も argv は kernel 側で別 alloc (>2048 byte padded)
   - **修正**: argv を task ram block 内 (stack と frame_buf の間) に
     pack_argv_at で書き込む。kernel 側の独立 alloc 撤廃

**結果** (commit 0c1b800 + 後続の dead code 整理):

```
free list: n=1, max=407,436 byte (~398 KB)
全 stage 通して固定、Hello World end-to-end 13.78 sec で 1 boot 完走
```

task ごとの kernel arena alloc:
- 旧: ram + stack + frame_buf + argv + name + (img)  = 5〜6 alloc
- 新: ram(+arena+stack+argv+frame_buf) + name + (img) = 2〜3 alloc

#### `live=109 KB` の内訳

「カーネルが 109 KB も使っている」と見えるが、実はその大部分は
ユーザータスクの ram。

bucket peak から逆算 (`buckets 8:3 16:66 32:38 64:18 128:12 256:2
1024:3 2048:1 L:5`):

| 種別 | サイズ | 内訳 |
|---|---:|---|
| sh task ram (unified) | ~45 KB | 32 KB arena + 8 KB stack + frame + page-align |
| msh task ram (unified) | ~45 KB | 同上 |
| mtfs inode cache | ~3 KB | 48 inodes × 64 byte |
| uart_rx_buf | 4 KB | UART mux 受信 |
| block_flash 系 | ~1 KB | sector cache 等 |
| bucket-cached small | ~11 KB | name / fd / vfs 等の小 alloc |
| **計** | **~109 KB** | |

**「カーネル」自身は ~19 KB**。残り ~90 KB は sh + msh の 2 タスクが
占めている (各 32 KB arena をフル予約)。タスク arena を sh 16 KB /
msh 8 KB に絞れば kernel arena から ~50 KB が空く見込みだが、それは
別タスク。

### 旧 50 ファイル × 平均 5 KB 推計 (2026-04-29、要見直し)

K7 時代の「合計 約 3 時間」は固定費 120 s × 50 = 6000 s が支配して
いた。現在の pipeline で source 依存部分が ~18× 速くなったので、
合計でも **数倍 (10x には届かないが) 速くなる**見込み:

- 旧 1 ファイル 200〜250 s → 推定 **20〜40 s 程度**
- 旧 合計 ~3 時間 → 推定 **15〜30 分**

ただし上記は msh-driven OOM を回避できる前提。実機での再測定が
必要 (本 doc は機会があれば更新する)。

### メモリ: 1 ファイルごとの peak は ~300 KB のまま

asm_pass3 の peak (298 KB) は label 数 + name pool に支配される。
ソース毎に label 数が大きく変わるので peak も伸びるが、
MAX_LABELS = 4096, MAX_NAME_POOL = 128 KB の cap がある (`compiler/asm_common.tc`)。
通常の OS ソースなら 320 KB の task arena 内に収まる見込み。

逆に **kernel arena (480 KB) のほうが先に問題化する**: sh + asm_pass3
の同時 alive で sh (32 KB) + asm_pass3 (320 KB) + stack ≒ 360 KB +
α。fragmentation を考えると ~440 KB 使うので、長時間バッチ実行で
arena leak / fragmentation が積もると詰まる懸念がある。

## Q2: bc2asm / asm_pass2 / asm_pass3 が特にメモリを使う理由

Hello World で 100〜300 KB peak。少しずつ違う原因。

### bc2asm (peak 111 KB)

- **Per-function instruction list**: `instrs: I32Array` に各 fn の
  bytecode を一旦展開してから asm に変換。fn 単位で alloc/free
  するが、最大の fn (Hello World では `main` が小さくても、prelude
  に含まれる `runtime` の fn など) で peak が決まる。
- **String literal 表**: bc 内の string literal を一旦 strtab に
  集めてから `.rodata` に emit。重複排除しないので bc 入力に多くの
  string が含まれると伸びる。
- **StringBuffer (出力バッファ)**: 1024 byte から倍々で grow。
  生成される .s が 数十 KB になると 32〜64 KB バッファに到達。

要点: bc2asm の 111 KB は **per-fn instr buffer + 出力バッファ + strtab**
の合計。Phase 3 で per-fn emission に切替えてから、これでも 1.4 MB
→ 110 KB に落ちている (`docs/task/pipeline_100kb.md`)。

### asm_pass2 (peak 218 KB)

label 収集 only の役割で計算は少ないが、**label 表が大きい**:

- **MAX_NAME_POOL = 128 KB** (`asm_common.tc`): label 名を全部詰める raw
  byte pool。`/prelude.s` に含まれる runtime/crt0 関数名で実際 60〜80 KB
  使う。
- **MAX_LABELS = 4096** × per-label state (`g_lab_addrs` u32 +
  `g_lab_section` u8 + `g_lab_name_pool_offsets` u32 + `g_lab_name_lengths`
  i32) = 16 KB + 4 KB + 16 KB + 16 KB ≒ 50 KB。
- **g_line_offs / g_line_lens / g_line_section** は 1 行 1 entry。
  Hello World の `full.s` で 12K 行 → 144 KB。
- 数字ラベル (`0:`〜`9:`) state、section size accumulator など若干。

合計 ~220 KB。

### asm_pass3 (peak 298 KB)

asm_pass2 と同等の label state を全部受け取って、**追加で encoder
state** を持つ:

- asm_pass2 の構造一式 (label table, line table) ≒ 200 KB
- 4 KB 出力バッファ (stream emit) + 各種 cursor
- per-section 状態 (text/rodata/data/bss の base / cursor)
- 数字ラベルの reference list (forward参照解決)

Phase 5 の stream-emit 化で旧 4.6 MB → 280 KB に削減済み
(`docs/compiler.md`)。これ以上絞るには label table を on-disk に
退避するなどの大規模 refactor が必要。

### 共通要因: SourceReader 4 KB バッファ

全段共通で、入力読み込み用に SourceReader が 4 KB の U8Array を
持つ。3〜10 KB のオーバーヘッドがあるので、軽量タスクのベースライン
が 8 KB 級になる。

### 結論

`/prelude.s` 経由で常に大量の label/instruction を扱うのが
Hello World でも 100〜300 KB peak になる理由。OS 全体コンパイルでも
**1 ファイルの peak は 300 KB 程度に留まる** と予測 (label pool が
頭打ちのため)。

## Q3: ドライバ `tcc` (退役、2026-05-11)

K13 期の `kernel/tasks/tcc/tcc.tc` は asm_pass2 walked-source +
asm_pass3 stdin-pipe を前提に組まれていた。walked-source 退役と
同時にこの driver も削除された。以下は当時の計測値で、sh-driven
vs tcc-driven の slowdown 比較が必要になったときに再実装するための
参考データ。

### 想定動作

```
sh$ tcc /hw.tc
tcc: stage timings
  parse           600 ms
  sigscan         200 ms
  cat-wrap        100 ms
  tcheck         3000 ms
  ...
  asm_pass3     80000 ms
tcc: total   127000 ms → /sd/a.out
sh$ /sd/a.out
Hello, World!
```

### 実機での実測 (2026-04-29)

```
parse         45751 ms     ← sh-driven の <1 s より 50× 遅い
sigscan       18329 ms
cat-wrap      21073 ms     ← inline file copy (small)
OOM: 327684                 ← tcheck spawn 失敗
```

**期待通り動かない**。sh-driven (commit cf22718) は 127 s で完走する
のに、tcc-driven は 4 段目で OOM。

### 原因 (推測)

**sh + tcc + child の 3 タスク同時 alive** で kernel arena が圧迫:
- sh: arena 32 KB + stack 8 KB = 40 KB
- tcc: arena 16 KB + stack 8 KB = 24 KB
- tcheck: arena 320 KB + stack 16 KB = 336 KB
- 合計: 400 KB out of 480 KB kernel arena → fragmentation で 320 KB
  contiguous 確保が失敗

加えて、tcc 経由だと parse / sigscan が sh-driven の 50× 遅い
(原因不明、scheduler 関連?)。

### 解決方向 (今後)

1. **sh の組み込みコマンドとして tcc を実装**。sh プロセス内で完結
   させれば、sh + child の 2 タスクで動く (今の sh-driven と同じ
   メモリ条件)。実装コストは tcc の機能を sh.tc に組み込む数百行。
2. **kernel arena を増やす**。pico2 SRAM 520 KB のうち kernel arena
   480 KB → 500+ KB に拡張。ただし stack や bss を圧迫するので
   小幅増しか取れない。
3. **task arena を縮める**。tcheck/asm_pass2/asm_pass3 の 320 KB を
   減らす。Phase 5 系の追加最適化が必要。
4. **`do_exec` で tcc 自身を最終段に置き換える**。その場合 1〜N-1
   段目は別途処理を要する (chain).

現状の `tcc.tc` は **タイミング測定のリファレンス実装**として残す。
本番の self-host は sh-driven (`tests/test_pico2_phase7_sd.sh` 又は
manually) で。

## Q4: `/prelude.s` とは

OS 内 mtfs に `/prelude.s` として埋め込まれている定型 asm 文字列。
**タスクバイナリの「先頭ボイラープレート」を一切プリビルド** しておく
ためのもので、`kernel/build.sh` (Step 0 / Step 7) が各 task の build
前に下記を 1 度だけ生成して mtfs にステージ:

```
/prelude.s   = '; raw\n'                 ← asm_pass3 の出力モード指示
             + '.word 32768\n.word 8192' ← /sd/HW のタスクヘッダ
                                          (arena=32 KB, stack=8 KB)
             + task_crt0.s               ← ecall stub + peek/poke + main 呼び出し
             + cached runtime.s          ← compiler/runtime.tc のプリコンパイル

/prelude_tail.s = task_data.s            ← .bss .space (32 KB の __arena)
```

`cat /prelude.s /sd/4.s /prelude_tail.s > /sd/full.s` が phase 7
パイプラインの「**疑似リンクステップ**」: ユーザコード `.s` の前後に
crt0 + runtime + bss を貼って一つの完結アセンブリに仕立てる。

サイズ: **`/prelude.s` ≈ 234 KB** (`runtime.s` が大半を占める)。
これが asm_pass2 で 1 回、asm_pass3 で 3 回読まれるので、実は phase 7
のボトルネックの大半が「同じ 234 KB を何度も SD から読む」になって
いる。`runtime.s` を Flash XIP の rodata にしてアドレス渡しできれば
劇的に速くなるはず (将来課題)。

詳細は `kernel/build.sh` の Step 0 と Step 7 を参照。

## Q5: `tcc` の必要メモリ量

### 静的宣言 (`kernel/tasks/tcc/task.mk`)

```
TASK_ARENA_tcc := 16384   # 16 KB
TASK_STACK_tcc := 8192    # 8 KB
```

タスクヘッダ 8 byte + arena 16 KB + stack 8 KB = **24 KB ちょうど**。

### 実行時の内部使用

`tcc.tc` の関数内ローカル変数:
- 4 KB U8Array (cat 用 read buffer): 1 個
- StringArray(1) + String("xxx"): 各段で 4〜8 個、合計 ~200 byte
- `s_lit` で生成した String: 各 path で n+1+4 byte

合計 ~5 KB を tcc 自身の 16 KB arena から消費。十分余裕あり。

### Kernel arena 側の影響 (こちらが本命)

tcc がタスクとして alive な間、kernel arena (480 KB) から:
- frame_buf: ~360 byte
- ram (= 上記 16 KB)
- stack (= 上記 8 KB)
- argv_clone (sh が tcc に渡した argv のコピー): ~50 byte
- name buffer ("tcc"): ~10 byte
- 合計 **~25 KB** が常駐

更に tcc が child を spawn すると:
- child の frame_buf + ram + stack + argv + name
- tcheck の場合 ~340 KB

sh + tcc + tcheck 同時 alive 時の kernel arena 占有:
| タスク | 占有 |
|---|---|
| sh | ~40 KB |
| tcc | ~25 KB |
| 子タスク (tcheck) | ~340 KB |
| **合計** | **~405 KB / 480 KB** |

**残 75 KB は free だが、断片化していて contiguous で取り出せない**
ことがあり、tcheck の 320 KB ram alloc が失敗する (実機で観測。
`OOM: 327684`)。

参考に sh-driven の場合:
| タスク | 占有 |
|---|---|
| sh | ~40 KB |
| 子タスク (tcheck) | ~340 KB |
| **合計** | **~380 KB** |

→ 100 KB の余裕。

### 結論

tcc 自身は **24 KB** の小さいタスク。問題は tcc を経由することで
sh + tcc + child の 3 タスクが同時 alive になり、kernel arena が
ギリギリになること。Q3 で示した 3 通りの解決策のうち、**「tcc を
sh の組み込みコマンドにする」** が一番素直 (sh + child の 2 タスク
構造を維持)。

### 補足: そもそも task arena を切り過ぎている

`docs/task/pipeline_100kb.md` の目標は各段 **80 KB 程度**:

| 段 | 目標 | 実 peak (Hello World) | task.mk arena |
|---|---:|---:|---:|
| tcheck    |  80 KB |  74 KB | **320 KB** |
| codegen   |  50 KB |  77 KB | **320 KB** |
| bc2asm    |  35 KB | 113 KB | **192 KB** |
| asm_pass2 |  45 KB | 224 KB | **320 KB** |
| asm_pass3 |  45 KB | 298 KB | **320 KB** |

Hello World の実 peak は概ね目標 100 KB 級だが、**task arena 予約は
worst case を見越して 320 KB に取っている**。
これが多重 task 同時 alive を阻む元凶。

#### bcrun.tc は実は worst case ではない (2026-04-29 再測定)

歴史的に「tcheck worst case = bcrun.tc::vm_run の 244 KB peak」と
記録されているが、現在の Gen2 tcheck は **vartab=128 上限** に当たって
bcrun.tc を tcheck 通せない (vm_run の局所変数 > 128 で `get: 128 out
of bounds`)。よって今や bcrun.tc は「コンパイル不可」であって、
worst case として参照する意味がない。

ホスト Gen2 で各 compiler ファイルを tcheck し、per-function node
最大値 (`nc`) を測ったもの:

| ファイル | nc (peak fn) | tcheck 結果 |
|---|---:|---|
| ast_node.tc      |   87 | OK |
| asm_pass2.tc     |  148 | OK |
| string_buffer.tc |  164 | OK |
| source_reader.tc |  164 | OK |
| sigscan.tc       |  381 | OK |
| asm_pass3.tc     |  389 | OK |
| tcheck.tc        |  607 | OK |
| codegen.tc       |  854 | OK |
| **bc2asm.tc**    | **1656** | **OK ← 現実の worst case** |
| bcrun.tc         | — | vartab overflow (compile 不可) |

Hello World は nc=11 で peak 74 KB。peak は per-fn の AstNode pool +
strtab に支配されるので、おおよそ nc に線形:
- nc=11 → 74 KB (Hello World)
- nc=1656 → **170 KB 程度** (bc2asm.tc 自身、推定)

つまり**現実の OS self-host で必要な tcheck arena は 200 KB 程度
で十分**。320 KB は依然オーバー。

### 提案: arena を bc2asm.tc 級に絞る

OS 全体を self-host する用途を想定して各段 arena を:

| 段 | 提案 | 理由 |
|---|---:|---|
| tcheck    | **224 KB** | bc2asm.tc tcheck 推定 170 KB + 30% margin |
| codegen   | **128 KB** | Hello World 77 KB + bc2asm.tc 想定でも < 128 KB |
| bc2asm    | **144 KB** | Hello World peak 113 KB に余裕付き |
| asm_pass2 | **288 KB** | peak 224 KB (固定 label pool 128 KB が支配) |
| asm_pass3 | **320 KB 維持** | peak 298 KB に余裕なし |

これで sh + tcc + tcheck = 40 + 25 + 240 = **305 KB / 480 KB**、
余裕 175 KB。tcc-driven が動くようになる見込み。

bcrun.tc を OS 上で再コンパイルしたいなら、まず **vartab を 256 以上
に拡大** + AST pool 分割 (vm_run を関数分解、現状 ユーザ指示で out of
scope) が要る。それは別タスク。

### 実装後の実測 (2026-04-29 追記)

arena 縮小を実装 (commit 後述) して tcc-driven をリトライ:

| 段 | 結果 |
|---|---|
| parse     | 48 s (OK) |
| sigscan   | 20 s (OK) |
| cat-wrap  | 23 s (OK) |
| **tcheck**    | **33 s, peak 74 KB (OOM 解消!)** |
| codegen   | 25 s (OK) |
| bc2asm    | 26 s (OK) |
| cat-link  | **738 s** (sh 駆動 ~25 s の 30 倍!) |
| asm_pass2 | **3841 s = 64 分** (sh 駆動 27 s の 142 倍!) |
| cat-p2    | **3044 s** (途中で OOM) |
| asm_pass3 | OOM (320 KB arena 維持なので余裕 79 KB) |

**進歩**: tcheck の OOM は arena 縮小で解消、本来意図した stage は
全部 alloc できるように。

**残課題**:

1. **asm_pass3 が依然 OOM**: 320 KB 維持なので sh + tcc + asm_pass3 =
   401 KB / 480 KB の構造的不可能。tcc 駆動のまま asm_pass3 を通す
   なら、tcc を `do_exec` で asm_pass3 に置き換える必要 (ただし帰還
   後の `wc /sd/a.out` ができなくなる)。
2. **cat / asm_pass2 の異常遅延** (14〜140 倍): tcc が kernel arena
   中央に 25 KB 居座ることで、alloc/free が free list を長く歩く
   症状と推測。`compiler/runtime.tc::large_alloc` は first-fit + 隣接
   merge だが、tcc が中央にあると merge できない。

→ **やはり「tcc を sh の組み込みコマンド化」が筋が良い**。tcc 自体
の実装は維持して、性能リファレンスとしての位置づけ。

### 訂正: K7 当時の per-stage timing は実は遅かった (2026-04-30)

最初「K7 時の sh-driven full pipeline 127 s」に対して各段が <1 s で
完走するイメージで議論していたが、`tcc-driven parse 48 s` を見て
「sh-driven なら 1 s のはずなのに 48× 遅い」と誤った前提で深堀り
した。実機で sh-driven full pipeline を再走したところ **123 s** で、
K7 とほぼ同じ:

```
parse → sigscan → cat-wrap → tcheck → codegen → bc2asm
     → cat-link → asm_pass2 → cat-p2 → asm_pass3 → /sd/HW

sh-driven, with PLL_SYS @ 150 MHz: 123 sec (K7 era 127 sec)
```

つまり K7 当時から各段の所要時間はこの程度だった。逆算すると:

| 段 | 所要 (推定) |
|---|---:|
| parse | ~31 s |
| sigscan | ~10 s |
| cat-wrap | ~5 s |
| tcheck | ~5 s |
| codegen | ~5 s |
| bc2asm | ~5 s |
| cat-link | ~10 s |
| asm_pass2 | ~27 s |
| cat-p2 | ~10 s |
| asm_pass3 | ~15 s |
| /sd/HW exec | ~1 s |

~~`echo hello world` (UART 出力のみ、12 byte) でも 11 s かかる。~~

**訂正 (2026-05-01)**: msh-driven 最新計測では `echo BENCH_DONE` が
**10 ms**。spawn + tiny task の baseline は数十 ms。先ほどの 11 s は
tcc-driven 検証時の数字か、あるいは PLL_SYS 150 MHz 化前の旧値。
sh/msh から起動した tiny task の spawn コストは無視できる範囲。

`tests/test_pico2_bench.sh` の最新結果より:
- `echo BENCH_DONE` = 0.010 s
- `parse < /hw.tc > /sd/1.ast` (6-line input) = 0.21 s (処理含む)
- `sigscan < /sd/1.ast > /sd/1.th` = 0.11 s

なので spawn overhead 自体は無視でき、**残るコストは個別 task の
本体実行時間 + SD I/O**。

### 残った tcc-driven 固有の slowdown

sh-driven baseline と比較した tcc-driven 倍率:

| 段 | sh-driven | tcc-driven | 倍率 |
|---|---:|---:|---:|
| parse | 31 s | 48 s | 1.5× (許容) |
| asm_pass2 | 27 s | 3841 s | **142×** |
| cat-link | 10 s | 738 s | **74×** |

parse の 1.5× は spawn overhead の僅かな差で説明できるが、
**inline で大量データを扱う段** (cat-link) と **後続の重 task**
(asm_pass2) で激遅。

仮説: tcc が `do_openat` / `sys_read` / `sys_write` を inline で
大量に呼ぶと、毎回 tcc の task arena から 4 KB buffer 経由でデータ
が往復する。kernel arena 側でも fatfs の secbuf alloc/free が
繰り返される。sh-driven cat だと子プロセスとして spawn されて専有
arena で動くため、kernel ↔ user の境界を超える allocation pattern
が違う可能性。

### 補足: 異常遅延の追加観測 (2026-04-29 instrumented tcc)

`copy_to_fd` の各 sys_read/sys_write を `now_us()` で挟んで実測:

```
/prelude.s (mtfs XIP, 234 KB):
  read   = 99970 ms / 59 iter = 1694 ms per 4 KB read
  write  = 628105 ms / 59 iter = 10645 ms per 4 KB write
/sd/_full.s (cat-p2 で 3 回読み):
  1 回目: read=240.6 s write=780.3 s
  2 回目: read=240.7 s write=752.4 s
  3 回目: read=240.7 s write=739.9 s
```

3 回とも同じ時間 → **fragmentation や状態依存ではない。定常的に遅い**。

理論計算: mtfs_read + block_read の byte-by-byte ループは 1 byte
あたり ~200 ns (150 MHz 時)、4 KB なら 1.6 ms 程度のはず。実測 1.7 sec
は **1000× 遅い**。

仮説:
1. **CPU が実際は 150 MHz で動いていない** (sh-driven asm_pass2 は
   27s なので少なくとも sh コンテキストでは PLL 効いてる)
2. **TC compiler の呼び出し ABI が想定より遥かに重い** (関数呼び出し
   per-byte で何百サイクルも)
3. **kernel 側の何か** (fatfs / block_sd / scheduler) が tcc コンテキスト
   下でだけ著しく時間を食う

未解明。次セッションで kernel に per-syscall タイマーを仕込んで切り
分け予定。

### 補足: 「断片化」より「絶対値ギリギリ」が支配項

正確には両方が効くが、絶対量の余裕でほぼ決まる:

| | sh-driven | tcc-driven |
|---|---|---|
| sh 占有 | 40 KB | 40 KB |
| tcc 占有 | — | 25 KB |
| 子 (tcheck) | 336 KB | 336 KB |
| **Σ alive** | **376 KB** | **401 KB** |
| **kernel 480 KB - Σ** | **+104 KB** | **+79 KB** |

sh-driven は 104 KB の余裕があるため断片化があっても通る。
tcc-driven は 79 KB しか残らない上、tcc が arena の中ほどに居座る
ことで前後の free を分断 → 子の 320 KB ram alloc が contiguous で
取れず詰まる。

つまり「フラグメントが問題」というより
**「ベースラインがギリギリで構造的に 3 タスク alive にできない」**
が本質。

## Q6: self_replicate end-to-end 所要時間 (2026-05-09)

K13 / pico2 self_replicate を `REFRESH_KERN_MODS=1` で実機実行した
最新の per-step wall-clock。`tests/pico2_self_replicate.sh` は openocd
reset で各 step を fresh kernel で再起動する設計なので、各 step 末尾の
`spawn failed` / spawn arena fragment が次 step に持ち越されない。

入力: `pico2_kernel_extra.uf2` 7.6 MB (kernel.bin 3.8 MB + disk-extra.img
3.5 MB; `DROP_TASKS="vi neofetch grep cp du head wc tcc sdprobe count
tmpdemo launcher hello hello2 catfile"` で disk-extra を 3.5 MB に slim 化、
4 MiB flash 制約)。

| step | 内容 | 所要 | 累計 |
|---|---|---|---|
| 0 | host gen2 build (host_k.bin / host_k.uf2) | ~4 min | 4 min |
| flash | initial flash + boot dumper (/sd/dx.img + wrap.s) | ~1 min | 5 min |
| 0a | refresh runtime.s on /sd | ~2 min | 7 min |
| 0b | refresh libtc.s on /sd | <1 min | 7 min |
| 0c | refresh kernel-leaf .s (kc/bf/bs/ff/mf/tf/pf) on /sd | ~2 min | 9 min |
| **0d** | **refresh platform_pico2.s** (新、2026-05-09) | <1 min | 10 min |
| 0e | refresh kernel-import .s (vf/ld/kp) on /sd | ~3 min | 13 min |
| 1 | cat → /sd/full.s (~3.8 MB) | ~2 min | 15 min |
| 2 | asm_pass2 → /sd/full.lab | ~2 min | 17 min |
| 3 | asm_pass3 → /sd/k.bin (3.8 MB) | ~9 min | 26 min |
| 4 | bin2uf2 → /sd/k.uf2 (7.6 MB) | ~8 min | 34 min |

(host build は orchestrator が起動時に 1 回だけ走らせる freeze step、
device 側の壁時計に含めれば total ~29 min。host build を除いた
device-only 時間は ~25 min。)

支配的なのは asm_pass3 (step 3) と bin2uf2 (step 4)。両方 SD I/O が
ボトルネックで、k.bin / k.uf2 を 3.8〜7.6 MB SD に書き出す書き込み
時間が大きい。SPI 6 MHz / fatfs FAT cache あり (commit 27ec588)。

### 0d step の追加コスト

`platform_pico2.tc` (`do_uart_*` / `do_write` / `do_read`、no imports、
~1 KB ソース) のコンパイルは 1 ファイル ~50 sec (parse + sigscan +
tcheck + codegen + bc2asm)。0a-0e のいずれかと同程度の時間で、
self_replicate 全体の orchestrator overhead としては誤差レベル。

### byte-exact 結果

- host kernel.bin md5: `1ec465d27a1137c66d9554b07e840295`
- device k.bin md5: `1ec465d27a1137c66d9554b07e840295` (MATCH)
- host kernel.uf2 md5: `fb7645d1d735a5c0cfce9f740f3c8cb3`
- device k.uf2 md5: `fb7645d1d735a5c0cfce9f740f3c8cb3` (MATCH)

K13 + 新 step 0d を含んだ self_replicate path が継続して byte-exact で
動作することを確認済み。

### 再測定 (2026-05-13、K15 仕上げ後)

dead-strip Phase A + B-type reloc + basename emit + Makefile/
orchestrator alignment セッション後の実測:

```
WALL = 1807s = 30m07s
host kernel.bin md5: 51c9fd9d7873ececf0bed2787055bf24
device k.bin md5:    51c9fd9d7873ececf0bed2787055bf24
host kernel.uf2 md5: ca8ac3c75a63b589fcf479df643a94a1
device k.uf2 md5:    ca8ac3c75a63b589fcf479df643a94a1
kernel.bin MATCH / kernel.uf2 MATCH
```

step 3 (asm_pass3 link → /sd/k.bin) は ~104 sec の本処理 +
md5sum ~152 sec で計 ~4 min が観測値。step 4 (bin2uf2 + md5sum)
も同様。全体は 2026-05-09 計測の ~34 min から 4 min ほど縮んだ
(主に 0a-0e refresh のコンパイラ自体が高速化)。

入力 disk-extra 経路の変更: orchestrator が host 側 `kernel/bin2s.sh`
(disk を `.byte ASCII` で 26 MB に展開) ではなく `kernel/bin2s_incbin.sh`
を使い、blob path として `dx.img` (basename only) を渡す。compile-gen2 の
intermediate dir に sibling `dx.img` を copy で staging すると、
device 側の `/sd/dx.img` と path 解決が対称になる。Makefile の
PICO2_KERNEL_RECIPE も同方式に揃えた (commit 086ea91)。

## Q7: section-leading `.incbin` の defer (2026-05-09 追加、2026-05-11 デフォルト化)

`/sd/pt.s` (= `crt0_pico2_data.s` + `wrap.s`) は wrap.s の `.incbin
SIZE "/sd/dx.img"` で 3.5 MB の disk-extra.img blob を埋め込む。
従来の asm_pass1 は pass 2 walk で `.incbin` を読んで per-byte
emit8 で rodata.bin に materialize していた。

### 問題: pt.s の per-byte emit が支配項

step 2 (pre-encode + link) を host (qemu-riscv32) で計測すると:

| .s | asm_pass1 時間 | size |
|---|---|---|
| pt.s (`.incbin` 形式) | **225 sec** | rodata.bin 3.5 MB |
| 残り 12 .s 合計 | 19 sec | 〜 |
| asm_pass2 | 5 sec | full.lab |

→ pt.s 単独で **pass1 全体の 92%** を占める。実機 pico2 では SD SPI
6 MHz で `.incbin` の 3.5 MB read が更に重なる。

### 解決: defer to asm_pass3 memcpy

`compiler/asm_common.tc` の `.incbin` ハンドラを変更し、section の
先頭 (`intra_off == 0`) にある `.incbin` は materialize せず:

1. asm_pass1 が `(sec, intra_off, size, path)` を idx に
   `incbin <sec> <intra_off> <size> <path>` 形式で記録、bytes は
   read/emit せずスキップ
2. asm_pass2 が idx の incbin record を読んで .lab に
   `src raw <orig_path> <sec> <abs_start>` 行を emit
3. asm_pass3 がその src raw を見て original blob を直接 memcpy

asm_pass3 は既存の `src raw` パスを使うので変更なし。当初は opt-in
`--incbin-skip` フラグだったが (2026-05-09)、すべての `.incbin`
caller が section-leading パターンなので 2026-05-11 にデフォルト化、
フラグは削除した。

### 計測結果

#### asm_pass1 単独 (host qemu-riscv32, 1.5 KB pt.s referencing 3.5 MB)

| | 時間 | rodata.bin |
|---|---|---|
| 旧 (materialize) | 1020 ms | 3,544,680 byte |
| **新 (defer)** | **39 ms (26x)** | 4 byte |

#### Host kernel build (`compile-gen2.sh kernel_pico2.tc`)

| | 時間 | kernel.bin md5 |
|---|---|---|
| 旧 (`bin2s.sh` + materialize) | 288 sec | `433c3fcf…` |
| **新 (`bin2s_incbin.sh` + defer)** | **42 sec (6.9x)** | `433c3fcf…` (byte-exact) |

`bin2s.sh` (`.byte` ASCII expansion 26 MB) も `bin2s_incbin.sh`
(`.incbin SIZE "path"` 1.5 KB wrap) も最終 kernel.bin は同一。
qemu の per-byte TCG emit loop が支配的だった分が完全に消える。
実機 (native execution) では差分は小さくなるが、依然として SD I/O
や spawn overhead が削れるので実用的に効く。

### 制限

- 1 input につき 1 個まで (g_pass1_incbin_present で gate)
- `intra_off == 0` 限定 (section の先頭のみ)
- prelude / user では未対応 (extras のみ per-input storage を持つ)

K13 self_replicate の pt.s は wrap.s が必ず section 先頭に
`.incbin` を置くパターンで、上の制限内に収まる。

### device self_replicate byte-exact divergence (2026-05-09〜11)

実機 self_replicate の初回検証で kernel.bin が host build と
byte-exact 一致しなかった (`f1111db7...` vs host `93d12908...`)。

切り分け: 同じ test を `--incbin-skip` を fixture から外して再実行
しても **同じ wrong md5** (`f1111db7...`) が出る。つまり:

- bug は `--incbin-skip` 由来ではない
- bug は pre-encode + link 経路 (asm_pass1 per-file + asm_pass2)
  自体の device-side / pico2-specific な何か
- host (qemu-riscv32) の同経路は byte-exact (host kernel build
  `433c3fcf...` 一致)

### 中間ファイル md5 比較で /sd/pt.idx に絞り込み (2026-05-10)

切り分けのため、self_replicate 後に /sd 上に残った中間ファイル
(13 idx + 13 tx + 13 ro + 13 dt + 13 rl = 65 ファイル) の md5sum を
host 側と比較した:

- **64 / 65 ファイルが host と完全一致** (idx 12 個、bin 39 個、reloc 13 個)
- **`/sd/pt.idx` だけが不一致** (host `e025973b...` vs device `f3fe3bf3...`)

ただし pt.tx / pt.ro / pt.dt / pt.rl は host と byte-exact 一致。
pt.s ソース自体も md5 一致。つまり asm_pass1 が pt.s から生成する
encoder 出力 (.bin / .reloc) は正しく、idx 側だけがズレてる。

pt.idx は asm_dump_idx_state が emit するメタデータ:
`raw` / `load_base` / `src_bytes` / `align` / `secsize` / `lab` /
`num` / `ref` / `incbin` 行。bin に影響しない違いの候補は
`src_bytes` (source byte count、SourceReader 経由) や `align` 状態
あたり。

UART を mx (length-prefix framing) 経由で device → host に転送して
pt.idx のバイナリを取り出すと、device 側の pt.idx には
`incbin 1 0 3590244 /sd/dx.img` 行が**欠けて**いた。host 側には
あった。つまり asm_pass1 の `--incbin-skip` defer が device で
発火していなかった (commit a48855b で root cause 確定 + 修正)。

### 根本原因: pass 1 の `intra_now` が g_sec_base[]の未初期化値に依存

`compiler/asm_common.tc` の `.incbin SIZE "path"` ハンドラが
section 先頭判定に使っていた:

```
var intra_now: i32 = g_pos - g_sec_base[sec_now];
```

これは pass 2 で `asm_compute_sec_bases` が g_sec_base を
merged-link 値で埋めた後なら正しいが、pass 1 では
`g_sec_base = I32Array(4)` が freshly allocated なまま。
TC kmalloc は zero-init しないので、

- **host (qemu-riscv32)**: 初回 kmalloc は fresh mmap pages を
  返すので偶然 zero → `intra_now = 0 - 0 = 0` で defer 発火 (見え
  ない bug)
- **pico2 device**: task arena が spawn 越しに recycle される
  ので I32Array(4) は前 task の残骸 → `intra_now ≠ 0` → defer
  fall-through → pass 1 が `g_pass1_incbin_present = 0` のまま

pass 2 では g_sec_base が valid なので defer 自体は発火 (bin emit
は skip される、pt.ro = 4 byte で host と一致)。だが
`asm_dump_idx_state` は pass 1 と pass 2 の**間**で走るので
present == 0 を見て idx に `incbin` 行を出さない。結果として
asm_pass2 がそれを検知できず、asm_pass3 は `src raw` 行を
受け取らず、最終 kernel.bin が 3.5 MB の disk-extra blob 抜きで
完成 → byte-exact 不一致。

### 修正 (commit a48855b, 2026-05-10)

`g_pos - g_sec_base[sec_now]` を `g_sec_pos[sec_now]` に置換。
asm_run_line がライン処理前にセットする intra-section オフセット
で、pass 1 / pass 2 双方で正しい値 (sec_base に依存しない)。

host 検証: bin2s.sh + no-skip / bin2s_incbin.sh + skip 両経路で
kernel.bin md5 `93d12908...`、`make test` 143/0 PASS。

防御的追加修正 (commit c7c6d9f): asm_init_common で
g_sec_base / g_sec_size も zero-init。今は live read 路がない
(a48855b で唯一の path を撤去) が、未来の regression を防ぐ。

### step 2 / step 3 のメモリスケール (2026-05-10)

a48855b 修正後、device で self_replicate を回すと asm_pass2 /
asm_pass3 が OOM することが判明:

- **asm_pass2** peak `300784 live=292588`: 13-input merge
  (prelude + user + 11 --add) で label name pool が 4→8→16→32→64 KB
  と grow し、各 grow が arena を fragment して最後 64 KB grow で
  OOM。先頭で `asm_preallocate_name_pool(65536)` を呼んで
  事前確保すれば fragment 化を回避できる (commit c7c6d9f で helper
  追加 + 呼び出し)。task arena は 320 KB → **384 KB** に bump
- **asm_pass3 --lab** peak `306444 live=306444`: 上と同じ name pool
  pre-alloc + reloc table の doubling (offs/kinds/names が 12 B/reloc
  + apply 時 pre_addrs/pre_secs が 8 B/reloc) で peak が 300 KB+ に
  到達。task arena 320 KB だと 16 KB allocation で OOM。
  **384 KB** に bump

self_replicate は step 間で openocd reset するので fresh kernel
arena (508 KB) 上に 384 KB task が landfit する。in-pipeline で
parse..asm_pass2 を spawn cycle した後だと fragmentation で
make_task が失敗する可能性は残る (`docs/task/asm_pre_encode.md`
参照)。

### K14 完了 (2026-05-11)

Debug Probe 復旧後の再検証 + parse.tc の `FieldInfoArray` 16→32 bump
(`bc2asm.tc::emit_inline_set` の inline silent overflow を覆っていた
真の root cause、`docs/solved.md` K14 参照) で device 側が byte-exact
完走。これにより walked-source モードは退役 (commit dddbf8b)、
self_replicate は pre-encode + link 単一経路に統一された。

## ベースライン: 10s / 100 KB 最適化計画 (2026-04-30)

`tests/bench_pipeline.sh` で計測した Gen3 + qemu-riscv32 の per-stage
peak memory + 時間。**ターゲット: 各段 ≤ 10 sec (pico2 実機) / ≤ 100 KB
(bcrun.tc を除く worst case = bc2asm.tc)**。bench は host 計測なので
時間は相対的な指標、メモリは pico2 でも同じ。

### 進捗 (2026-04-30 メモリ削減 Phase 1+2+3)

hello.tc は **全段 100 KB 達成**。bc2asm.tc は bc2asm/codegen 達成、
tcheck/asm_pass2/asm_pass3 が残 26〜74 KB。

#### hello.tc (366 byte, 入力小)

| 段 | baseline | 現在 | 100 KB |
|---|---:|---:|---:|
| parse     |   - |   - | ✓ (旧 14 KB) |
| sigscan   |   9 |   9 | ✓ |
| tcheck    |  73 |  69 | ✓ |
| codegen   |  76 |  68 | ✓ |
| bc2asm    | 111 |  79 | ✓ |
| asm_pass2 | 218 |  **67** | ✓ |
| asm_pass3 | 298 |  **80** | ✓ |

#### bc2asm.tc (~50 KB, 実 worst case)

| 段 | baseline | 現在 | 100 KB |
|---|---:|---:|---:|
| parse     |   - |   - | (~14 KB 一定) |
| sigscan   |  10 |  10 | ✓ |
| tcheck    | 190 | 135 | ❌ 1.4× |
| codegen   | 185 | 126 | ❌ 1.3× |
| bc2asm    | 122 |  90 | ✓ |
| asm_pass2 | 249 | 163 | ❌ 1.6× |
| asm_pass3 | 328 | 174 | ❌ 1.7× |

### 適用した削減 (commit 順)

**Phase 1 — 既存 cap の縮小:**
1. **bc2asm.tc instrs 16384 → 8192** (-32 KB): 実 in=1705 max に対し
   2048 命令分で 20% margin。bcrun.tc は除外。
2. **tcheck/codegen AstNodeArray pool 3072/4096 → 2048** (-4/-8 KB):
   ref array shrink、bcrun.tc 除外で十分。
3. **AstNode struct repack 8 → 6 i32 fields** (-50 KB): ss/sl と
   tass/tasl を 16+16 bit pack。`32 → 64 byte bucket` の per-node
   オーバーヘッド削減。importer は n_ss / n_sl 経由なので透過。
4. **asm_common name pool 128 → 96 KB + hash 64 → 32 KB** (-32/-64 KB):
   MAX_NAME_POOL を実測 90 KB に近い 96 KB に絞る。LAB_HASH_SIZE は
   MAX_LABELS の 2x で十分なので 16384 → 8192。

**Phase 2 — 構造再設計:**
5. **Label struct bit-pack 4 → 2 i32** (-17 KB on bc2asm.tc): 16 byte
   payload → 8 byte payload で `32 → 16 byte bucket`、per-label cost を
   半減。name_off (18 bits) + name_len (8 bits) + section (2 bits) を
   1 i32 に詰める。3000 labels なら 48 KB 削減。
6. **numlab storage を digit 0 / others 分離** (-33 KB): 実測 digit 0
   が >500 で digit 1-9 は ~0-1。固定 10×1024 配列 (40 KB) を
   {1024 digit 0} + {9×64 others} = ~7 KB に。
7. **LAB_HASH を finalize 時に動的サイズ** (-16〜28 KB on asm_pass3):
   実 g_nlabels の next-pow-2 × 2 で alloc。hello.tc は 64 entries =
   256 B、bc2asm.tc は 2048 entries = 8 KB 使用 (旧 32 KB 固定)。

**Phase 3 — 動的 buffer:**
8. **g_lab_names を 4 KB 初期 + x2 grow に** (-82/-88 KB on hello.tc):
   `MAX_NAME_POOL=96 KB` 固定 → `NAME_POOL_INITIAL_KB=4 KB` から動的
   grow。hello.tc は 35 byte 使用なので grow せず初期 4 KB のまま。
   bc2asm.tc は 4→8→16→32→64 KB grow で最終 64 KB (旧 96 KB)。grow 中の
   transient peak は old+new で旧 cap 同等なので大きい入力では効果は
   小さいが、小〜中入力で劇的削減。

### 残 gap と原因

- **tcheck bc2asm.tc 35 KB 超過**: 32 KB strtab (per-fn rollback 後
  の sp_max=26244 に合わせ済み) + per-fn kmalloc'd fntab + transients
  が支配。strtab を perm/ephemeral 分離するか kmalloc per-fn 化する
  refactor で削減可。
- **codegen bc2asm.tc 26 KB 超過**: tcheck と同じ strtab 由来
- **asm_pass2 bc2asm.tc 63 KB 超過**: 動的 grow しても 32→64 KB
  grow 中の transient peak (32+64=96 KB) が支配。realloc 相当が
  あれば transient peak を 64 KB に抑えられるが、現 kmalloc 未対応。
- **asm_pass3 bc2asm.tc 74 KB 超過**: pass1 と同じ + LAB_HASH 8 KB

### 削減対象優先順 (残)

1. **realloc-style in-place grow** (asm_pass2/2 ~30 KB 削減): kmalloc
   に "extend large block in place" を追加すれば transient peak が
   消える。kernel arena 全体に影響する大きい変更。
2. **strtab restructure** (tcheck/codegen 30 KB 削減): per-fn 完全
   分離、または perm/ephemeral cursor
3. **parse の km_dump_peak 追加**: 現状未測定

時間ターゲット (pico2 10s) は別途 pico2 での timing 計測後に検討。
host virt の wall time は相対指標として shrink 前後の差を確認するのに
使う。

## 関連ドキュメント

- `docs/task/pipeline_100kb.md` — Phase 1/2/3 のメモリ削減経緯
- `docs/compiler.md` — 各段の peak と algorithm
- `docs/lab_format.md` — asm_pass2/pass2 が共有する .lab 中間形式
- `docs/solved.md` K7 — pico2 phase 7 完走の経緯
- `tests/bench_pipeline.sh` — per-stage memory/time 回帰計測
