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
| asm_pass1 | 320 KB | 218 KB | ~27 s |
| cat-p2 | 16 KB | — | ~50 s (3× full.s 連結) |
| asm_pass2 | 320 KB | 298 KB | ~80 s |
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
asm_pass1 が 1 回、asm_pass2 が 3 回読むため:

- asm_pass1: 234 KB read + 計算 + 11 KB write ≒ 27 s
- asm_pass2: 234 KB × 3 read + 計算 + 45 KB write ≒ 80 s
- cat-link / cat-p2 で 234 KB SD write × 4 回 ≒ 45 s

→ 1 ファイルあたり **120 s 程度の prelude オーバーヘッド** がほぼ
constant。

ソースサイズ依存分 (parse / tcheck / codegen / bc2asm) は
ソース byte 数に概ね比例。Hello World (366 B) で 12 s 弱。線形外挿:

| ソースサイズ | tcheck+codegen+bc2asm | 合計 (固定 + 比例) |
|---|---|---|
| 1 KB | ~30 s | ~150 s (2.5 分) |
| 10 KB | ~5 分 | ~7 分 |
| 70 KB (tcheck.tc 級) | ~35 分 | ~37 分 |

### 50 ファイル × 平均 5 KB として

平均 5 KB のソース 50 ファイルを 1 つずつコンパイル:
- 1 ファイルあたり 200〜250 s
- **合計 約 3 時間**

実際は heavy file (parse.tc / tcheck.tc / asm_common.tc / bc2asm.tc /
asm_pass2.tc) が支配する。これら 5〜7 ファイルだけで 30 分以上を
食う見込み。

### メモリ: 1 ファイルごとの peak は ~300 KB のまま

asm_pass2 の peak (298 KB) は label 数 + name pool に支配される。
ソース毎に label 数が大きく変わるので peak も伸びるが、
MAX_LABELS = 4096, MAX_NAME_POOL = 128 KB の cap がある (`compiler/asm_common.tc`)。
通常の OS ソースなら 320 KB の task arena 内に収まる見込み。

逆に **kernel arena (480 KB) のほうが先に問題化する**: sh + asm_pass2
の同時 alive で sh (32 KB) + asm_pass2 (320 KB) + stack ≒ 360 KB +
α。fragmentation を考えると ~440 KB 使うので、長時間バッチ実行で
arena leak / fragmentation が積もると詰まる懸念がある。

## Q2: bc2asm / asm_pass1 / asm_pass2 が特にメモリを使う理由

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

### asm_pass1 (peak 218 KB)

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

### asm_pass2 (peak 298 KB)

asm_pass1 と同等の label state を全部受け取って、**追加で encoder
state** を持つ:

- asm_pass1 の構造一式 (label table, line table) ≒ 200 KB
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

## Q3: ドライバ `tcc` (実機実装メモ)

`kernel/tasks/tcc/tcc.tc` として実装。argv[1] にソースを取り、
中間ファイルを `/sd/_*.*`、出力を `/sd/a.out` に書く。各段の
所要時間 (SIO MTIME を peek32 で読んで算出) を stdout に出力。

### 想定動作

```
sh$ tcc /hw.tc
tcc: stage timings
  parse           600 ms
  sigscan         200 ms
  cat-wrap        100 ms
  tcheck         3000 ms
  ...
  asm_pass2     80000 ms
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
3. **task arena を縮める**。tcheck/asm_pass1/asm_pass2 の 320 KB を
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
/prelude.s   = '; raw\n'                 ← asm_pass2 の出力モード指示
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
これが asm_pass1 で 1 回、asm_pass2 で 3 回読まれるので、実は phase 7
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
| asm_pass1 |  45 KB | 224 KB | **320 KB** |
| asm_pass2 |  45 KB | 298 KB | **320 KB** |

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
| asm_pass1.tc     |  148 | OK |
| string_buffer.tc |  164 | OK |
| source_reader.tc |  164 | OK |
| sigscan.tc       |  381 | OK |
| asm_pass2.tc     |  389 | OK |
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
| asm_pass1 | **288 KB** | peak 224 KB (固定 label pool 128 KB が支配) |
| asm_pass2 | **320 KB 維持** | peak 298 KB に余裕なし |

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
| asm_pass1 | **3841 s = 64 分** (sh 駆動 27 s の 142 倍!) |
| cat-p2    | **3044 s** (途中で OOM) |
| asm_pass2 | OOM (320 KB arena 維持なので余裕 79 KB) |

**進歩**: tcheck の OOM は arena 縮小で解消、本来意図した stage は
全部 alloc できるように。

**残課題**:

1. **asm_pass2 が依然 OOM**: 320 KB 維持なので sh + tcc + asm_pass2 =
   401 KB / 480 KB の構造的不可能。tcc 駆動のまま asm_pass2 を通す
   なら、tcc を `do_exec` で asm_pass2 に置き換える必要 (ただし帰還
   後の `wc /sd/a.out` ができなくなる)。
2. **cat / asm_pass1 の異常遅延** (14〜140 倍): tcc が kernel arena
   中央に 25 KB 居座ることで、alloc/free が free list を長く歩く
   症状と推測。`compiler/runtime.tc::large_alloc` は first-fit + 隣接
   merge だが、tcc が中央にあると merge できない。

→ **やはり「tcc を sh の組み込みコマンド化」が筋が良い**。tcc 自体
の実装は維持して、性能リファレンスとしての位置づけ。

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
1. **CPU が実際は 150 MHz で動いていない** (sh-driven asm_pass1 は
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

## 関連ドキュメント

- `docs/task/pipeline_100kb.md` — Phase 1/2/3 のメモリ削減経緯
- `docs/compiler.md` — 各段の peak と algorithm
- `docs/lab_format.md` — asm_pass1/pass2 が共有する .lab 中間形式
- `docs/solved.md` K7 — pico2 phase 7 完走の経緯
