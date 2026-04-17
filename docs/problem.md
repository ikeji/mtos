# 処理系の既知の問題

このプロジェクトの TC コンパイラ・ツールチェーンで見つかっているが
まだ直していない / 設計判断で後回しにしている問題のリスト。

凡例:
- **bug**: 明確な不具合。正しい挙動に直す必要あり。
- **limitation**: 言語 / ツールの設計上の制限。ワークアラウンドあり。
- **ergonomics**: 動作は正しいが書きにくい / デバッグしにくい。
- **wontfix**: 直す意図のない既知の挙動。
- **後回し / 残件**: 設計 / 実装方針は決まっているが優先度で後回しにしている項目。

**意図的に残している挙動** (「バグでは?」と誤解されがちなもの) は
`docs/design_decisions.md` に集約。直す前にそちらを読む。

---

## 言語 / コンパイラ本体

### 3. 整数リテラルの型が文脈を見ない (ergonomics)

`U8Array(256)` と書くと i32→u32 のミスマッチで overload 解決に失敗する。
配列コンストラクタが u32 になったため、リテラルは `256u32`、
変数は `(n) as u32` と毎回書かないといけない。

影響範囲: `compiler/*.tc` と `kernel/*.tc` 合わせて `as u32` が 190 箇所
前後ある。これらがほぼ消える見込み。

対処方針 (後回し):
- **整数リテラルはコンテキストが指定する型で parse/typecheck する**
  のが本命。例: `fn f(x: u32) -> void;` に対して `f(256)` と書いたら
  typecheck が 256 を u32 リテラルとして確定し、そのまま overload 解決
  する。変数経由 (`var n: i32 = 256; f(n)`) は従来通りエラー。
- 文脈がないとき (e.g. `var x = 256;`) はデフォルト i32 のまま。

### 5. Gen2 typecheck のエラーメッセージ: 段階 2 (AST line info) のみ残 (ergonomics)

段階 1 (関数名 + 引数型 + 直前 comment) は実装済 (→ fixed list)。
出力例:
```
Type error: no overload for 'append' matching (StringLiteral, i32)
  near: var s: String = append("hi", a);
```

段階 2 は未着手: AST に `@line` 情報を入れて `file:line: message` が
出せるようにする。parse.tc / typecheck.tc / codegen.tc / bc2asm.tc /
extract_sigs.tc と bootstrap 各種の AST 読み取りを同期する大規模変更。
段階 1 で実用上十分に場所が特定できているので、必要性が出てから検討。

### 10. tcheck の fntab サイズ上限 (limitation)

`compiler/tcheck.tc` の fntab は `U32Array(512)` で、1 ファイル中の
関数 (export fn + private fn + struct 合成 getter/setter) の合計が
512 を超えるとコンパイルに失敗する (`set: 512 out of bounds`)。

発生経緯: `kernel/kernel_common.tc` の Task 構造体にフィールドを追加
したところ合成関数が増え、旧上限 256 を超えた。256 → 512 に暫定拡大
(2026-04-17)。

影響: 大きな struct を多数定義するファイルで再発する可能性がある。
512 で当面は足りるが、struct フィールドを追加するたびに 2 関数
(getter + setter) が生え、関数宣言 1 つ + 実装 1 つ = fntab 4 エントリ
消費する。

対処案:
- fntab を動的サイズにする (U32Array を realloc 的に拡大)。ただし
  TC には realloc がないので、上限に達したら 2 倍サイズで再確保 +
  コピーするか、最初から十分大きく取る
- struct 合成関数を減らす方向 (getter/setter を field offset の
  定数化に置き換える) は言語仕様の大変更になるので現実的でない

### 11. struct フィールド名がグローバル関数名と衝突する (limitation)

struct のフィールド名は getter/setter 関数としてマングルされるため、
同名のグローバル関数があると衝突する。例えば `struct Task` に
`ram_size` フィールドがあると、`make_task(entry, ram_size, stack_size)`
の引数名 `ram_size` と getter `ram_size(t)` が曖昧になりリンクエラー
や型エラーを起こす。

回避策: フィールド名にプレフィックスをつける (`t_ram_sz` など)。

対処案:
- マングリング方式を変更 (`Task_ram_size` のような型名プレフィックス)
- 名前空間 / スコープを導入

### 6. 配列境界エラー: 残件 (ergonomics)

段階 1a (bootstrap C runtime のメッセージに idx/len を入れる) と
1b (compiler/runtime.tc の **set** に境界チェック追加) は実装済
(→ fixed list)。例: `set: 10 out of bounds (len=5)`。

残件:
- **get の境界チェックは未実装** (set のみ)。読み取り側 OOB は
  silent に不正な値を返す。set と同じく入れる方が筋だが、get は
  kernel scheduler 他の hot path にあり、入れると `make test` が
  60 秒制約を超えたので保留。runtime 側の最適化か、test 制約の
  緩和が先。
- **段階 2 (大規模)**: BC に line 情報を入れて「どの TC 行」を出す。
  #5 段階 2 と共通の AST/BC フォーマット変更。必要性が出てから
  検討。

---

## asm_pass1 / asm_pass2 (アセンブラ兼リンカ)

パイプライン 100 KB 計画 (#7) と K3 (タスクサイズ宣言) は解決済。
→ `docs/solved.md` 参照。

### 8. asm.tc がセクション境界を 16 バイト単位までしかアラインしない (wontfix)

`compiler/asm.tc:1148-1151` で各セクションサイズを 16 バイト
(`.align 4`) に切り上げるため、`.align 12` (4 KB 境界) 以上を
.bss に書けない。pass 1 と pass 2 で g_pos の basis が違うので、
section_base を合わせないと padding 量が drift する。

実害範囲を検討した結果 **修正不要** と判断:

- 影響するのは `kernel/block_virtio.tc` 1 箇所のみ (virtio-legacy
  の queue を 4 KB 境界に置くため、TC 側で 12 KB kmalloc して
  先頭を手動で 4 KB に切り上げ)。
- **問題になるのは qemu virt ターゲットだけ**。virt は 128 MB
  RAM なので 12 KB の waste は誤差。
- **実機 Pico 2 は virtio を使わない**。block_flash.tc で XIP
  経由、4 KB 境界の要求自体が発生しない。
- したがってこの限界を直しても減るのは qemu 上の 12 KB だけ。

もし将来 virtio-net / virtio-gpu を追加したり、実機で別のデバイスが
4 KB 境界を要求したりしたら再評価する。それまでは block_virtio.tc の
手動アラインのまま。


---

## カーネル / OS

K3 (タスクサイズ宣言) は解決済 → `docs/solved.md` 参照。

### K4. `do_uart_read` が無限ループで EOF を検出できない (limitation)

`kernel/platform_virt.s` / `kernel/platform_pico2.s` の
`do_uart_read` は LSR Data Ready ビットを busy-loop で待つだけで、
stdin が閉じた (EOF) 状態を区別できない。

影響:
- qemu 側でパイプ入力が尽きた後に sys_read(0, ...) すると、永久に
  ブロックする。
- `/bin/sh` をループ化する場合、EOF で抜けられず "quit" コマンドなど
  明示的な終了手段が必要。

対処案:
- UART ドライバに "non-blocking read" / "peek" を追加。
- qemu のシリアル終了条件を使う (但し実機との挙動差が出る)。

### K5. sh パイプラインで cat が 5 ファイルを連続読みした後の asm spawn が失敗 (bug, 回避済)

phase 7 M6 のセルフコンパイルパイプライン実装中に遭遇した再現性の
ある挙動:

```
parse ... > /tmp/1.ast
typecheck ... > /tmp/2.tast
codegen ... > /tmp/3.bc
bc2asm ... > /tmp/4.s
cat /rawhdr.s /crt0.s /runtime.s /tmp/4.s /task_data.s > /tmp/full.s
asm < /tmp/full.s > /tmp/hw      # ← "sh: spawn failed"
```

`cat` が **5 つの** ファイル (mtfs 4 個 + tmpfs 1 個) を読み切った
直後に `asm` を stdin redirect 付きで spawn すると、`sys_spawn_handler`
が -1 を返す。asm 単体 (redirect なし) や、他の組み合わせ (例: cat が
3 ファイルだけ) では再現しない。kernel arena / タスクスロット / vfs
fd テーブルのどれを疑っても明確な原因を特定できなかった。

**回避策 (実装済)**: `kernel/build.sh` で `task_crt0.s` + cached
`runtime.s` を事前連結した `/prelude.s` を mtfs に仕込み、OS 側の
`cat` を 3 ファイルだけ読むように減らしたら再現しなくなった。
phase 7 test も全段 pass している。

この症状はちゃんと原因を突き止めた方が良いが、パイプラインが
動いているので急ぎではない。再現条件 (mtfs 連続 open + tmpfs
redirect) を整理してから `vfs_open` / `alloc_vfs_fd` / 該当する
fd table 状態を dump するのが良さそう。

### K6. phase 7 デバッグトレースがデフォルト ON (ergonomics)

phase 7 M6 時点でカーネルに常時出力している debug 出力:

- `kernel/kernel_common.tc`:
  - `trap_handler` の `[sw from>to]` (タイマープリエンプトで switch したとき)
  - `sched_task_exit` の `[x slot=code]` (タスク exit 時)
  - 非タイマー trap で `[TRAP c=... e=... s=N]`
- `kernel/vfs.tc`:
  - リダイレクトされた stdout への write で `[w slot:len]`
- `kernel/tasks/task_crt0.s`:
  - タスク exit 前に `km_dump_peak` を呼び `[kmem peak=N live=M]`
- `compiler/runtime.tc`:
  - `new_array` OOM 時に `OOM: <size>\n` を stderr へ
- `kernel/kernel.tc`:
  - `TIMER_INTERVAL = 10000000` (1 秒 @ 10 MHz) でプリエンプトを
    ゆっくりにしている

これらは phase 7 のパイプラインが動き出すまでの可視化用。デバッグ
セッションが落ち着いたら、

- タイマー間隔を元の 1 ms (10000) に戻す
- トレース出力を `#ifdef DBG` 的な条件付きにする or 完全削除
- OOM メッセージは残しても良い (診断に便利)
- `km_dump_peak` はタスク exit の常時 call を外し、欲しいときだけ
  呼び出す形にする

の整理が要る。現在 `make test` は 141 passed で通っており、デバッグ
出力が混ざっても grep 条件は無事なので急ぐ必要はないが、
フェーズ 8 以降のクリーンな基盤作りには邪魔になる。

### K7 part 3 debug 未解決 — pico2 + EXTRA_TASKS + sh spawn で OOM

**症状** (2026-04-15):

- pico2 kernel を `EXTRA_TASKS="parse sigscan tcheck codegen bc2asm
  asm_pass1 asm_pass2 cat"` 付きでビルド
- kernel 起動後、sh の sys_spawn path で **何を spawn しても** 
  `OOM: 524292` が出る
- seeded load_task ("/bin/hello", "/bin/hello2", "/bin/sh") はちゃんと
  正しい arena_size (8192 / 8192 / 32768) で load できているので、
  sys_exec_handler / sys_spawn_handler 経由のパスだけが壊れている

**診断中に分かったこと**:

- `load_fd` に debug print を仕込むと、XIP 経路は正しい arena_x /
  stack_x を返している (hello=8192 / 8192)
- sh が do_spawn を呼んだ時の path を `do_write(1, path_addr, 20)` で
  dump すると「/bin/\0catfile」「/bin/\0hello」のような変な bytes 列
  に見える (\0 + 別の task 名が並ぶ)
- その load_fd でもらう xip=0x1001e4f0 系は、正規の seeded load で
  もらう xip=0x100c1e30 系と全然違う flash offset。mtfs superblock /
  inode table 付近
- 結果として load_fd が asm_pass1 の header (arena=524288) を読んで
  しまい 512 KB の kmalloc を発動して arena (480 KB) OOM

**仮説**:

1. **mtfs_lookup が EXTRA_TASKS 有り mtfs image (inode ~32 個) で
   誤マッチする** - 1 inode / 1 parent の照合ロジックのどこかが
   inodes が増えたときに壊れる
2. **sh の cmd / path buffer が UART RX の stale bytes を拾って
   いる** - test_pico2.sh の flash+reset timing or CDC-ACM の buffering
   で stale bytes が残り、sh の read_line が期待と違うバイト列を
   読み込んでいる
3. **vfs_open の path parser が長い path_addr で誤動作** - 20 byte
   dump の見た目だと `/bin/` の後に NUL + 別名が続いているので
   sh 側の path buffer allocation が疑わしい

**未検証**:

- `sh` を経由せずに `kernel_pico2.tc::main` から直接 `load_task("/bin/
  parse")` + `sched_register` したら OOM は出るのか (mtfs_lookup の
  バグと sh の buffer バグを切り分けられる)
- virt で同じ EXTRA_TASKS + sh catfile 経路が動くか (virt は動いて
  いる: test_phase7.sh の stage 1 が既に catfile+compiler task chain を
  問題なく回している → virt でも pico2 でも mtfs の EXTRA_TASKS
  レイアウトは同じなので、pico2 の症状が mtfs の inode 数依存だと
  説明しづらい)

**次に試すべきこと**:

1. pico2 kernel_pico2.tc で main の中に `load_task("/bin/parse")` を
   足して、sh 抜きで spawn できるか確認
2. test_pico2.sh の UART 入力路を単一の `stty` + `exec 3>` pattern に
   せず、pipe-from-host を使う (cdc-acm は読み/書き両用なので double-cat
   pattern の race が出にくい)
3. sh.tc の read_line / parse_redir に debug print を仕込んで実際に
   読んでいる cmd 中身を stderr に流す

時間がかかりそうなので part 3 はここで中断 (2026-04-15)。基本的な
pico2 sh + catfile / launcher cascade は K7 part 2 で動作確認済で、
compiler task を回す目的は上記のどれかで再開する。

---

### K7. pico2 で phase 7 コンパイラが動かない (part 1 + 2 完了、残: compiler 実行)

**K7 part 1 (2026-04-15)**: K3 (per-task サイズ宣言) + kernel arena
拡大 (256 KB → 480 KB) の組み合わせで dynamic sys_spawn /
sys_wait が pico2 実機で動作。`kernel/tasks/launcher/launcher.tc`
が `do_spawn("/bin/hello2")` + `do_wait` → `do_exec("/bin/catfile")`
を実行し、`tests/test_pico2.sh` が UART で verify。

**K7 part 2 (2026-04-15)**: pico2 の 3 つ目 seed task を launcher
から `/bin/sh` に切り替え。Debug Probe の CDC-ACM は双方向なので
host 側から `/dev/ttyACM0` に書き込めば実機 sh にコマンドを送れる。
test_pico2.sh が `catfile\n` / `launcher\n` / `quit\n` を送って、
sh + spawn + wait + exec のカスケードが一通り動くことを実機で
確認。

**pico2 compile 段 byte-exact verify (2026-04-17)**: 
`tests/pico2_verify.sh` で pico2 上の compile pipeline (parse →
sigscan → tcheck → codegen → bc2asm) の全 7 中間ファイルが Gen2
ホスト参照とバイト完全一致することを確認:

  1.ast(272B) 1.th(71B) 1.wrap(361B) 2.tast(294B) 3.bc(202B)
  4.s(799B) full.s(225853B)

link 段 (asm_pass1/asm_pass2) は下記 K8/K9 の理由でスキップ。

残件: **compiler タスク群 (asm_pass1 430 KB / asm_pass2 441 KB 級)
を実際に sh から spawn してパイプラインを一周するところは未着手**:

- sh (32 KB arena) + compiler child を並行で持つには arena が
  sh + asm_pass2 = 32 + 512 + stacks ≈ 570 KB 必要で 480 KB に
  入らない。compiler タスクサイズを pico2 向けに絞るか、arena を
  もう少し広げる (kernel stack を削れば ~500 KB まで拡大可能) か、
  asm_pass2 をさらに shrink する必要がある
- 小さい compiler task (parse 64 KB, sigscan 32 KB, bc2asm 192 KB)
  は今の arena でも理論上 spawn できる。UART から stdin に
  input を流し込む仕組みが必要なので、test_pico2.sh に
  `parse < /hw.tc > /tmp/1.ast` を送る拡張が次の段階

対処案:
- **pico2 向け K3 header を別テーブルにする**: build.sh の
  `task_arena_size()` を `virt` / `pico2` で出し分け。asm_pass1/2
  を 430 KB / 441 KB ちょうどで宣言すれば pico2 でも spawn できる
- **asm_pass2 stream-emit**: docs/task/pipeline_100kb.md で future
  と書いていた最後のステージ shrink。filesz を .lab 経由で pass2
  に渡して g_code バッファなしで write を stream 化

### K8. pico2: UART stdin streaming で kernel が wedge する (bug)

`tcheck > /tmp/2.tast` のように stdout だけリダイレクトし stdin は
UART のままで起動した子タスクに、ホストから `send_stream()` でバイト列
を流し込むと、**カーネルが完全に停止して scheduler tick が出なくなる**。

- 現象: `[sw 2>0]` `[sw 0>2]` の 2 回のコンテキストスイッチだけ出て
  以後一切の出力がない (240 秒 timeout)
- 原因仮説: `do_uart_read` (platform_pico2.s) が最初のバイトを
  spin-wait で待つ。バイト未着時にタイマー割り込みでスケジューラに
  戻り、sh (sys_wait 中 = waiting) と tcheck (read blocking) だけが
  残るとどちらも進まなくなる。virt は同じ do_uart_read だが qemu 側
  のストリームが即座に全バイトを届けるので問題ないと思われる
- **回避策 (実装済)**: pico2 の tcheck は UART stdin ではなく tmpfs
  ファイルを入力に使う。`pico2_hw_driver.py` が 2-file cat chain で
  /tmp/1.wrap を組み立て、`tcheck < /tmp/1.wrap > /tmp/2.tast` で
  tmpfs stdin 経由にすることで wedge を回避。compile 全段が tmpfs
  経由で動く
- 影響: asm_pass1 / asm_pass2 は入力サイズ (225 KB+) が pico2 tmpfs
  に収まらないため UART streaming が必須。K8 が直るまで pico2 の
  link 段はスキップ

### K9. pico2: PL011 RX FIFO overflow で長いコマンドが欠落する (bug, 回避済)

sh にコマンド行 ≥ ~32 バイトを一括送信すると RX FIFO (32 byte) から
溢れたバイトがドロップし、sh の read_line が不完全なコマンドしか受け取
れない。

- 現象: `cat /empty_imports.txt /self_open.txt > /tmp/w1` (49 byte) を
  書くと echo が 33〜36 byte で途切れ、LF が到達しないため sh$ prompt
  が永久に出ない
- 原因: sh は 1 byte ずつ sys_read するため、ecall → kernel → UART
  read → sret のラウンドトリップが ~200 µs。115200 baud では ~87 µs
  ごとに 1 byte 着信するので、16 byte 以上のバーストで FIFO が溢れる
- **回避策 (実装済)**: `pico2_hw_driver.py::send_stream()` を
  CHUNK=4 / 20 ms pacing (~200 B/s) に落として sh の drain rate 内に
  収めている
- 本質的な修正案: PL011 RX interrupt を有効化して in_buf に取り込む、
  または RTS/CTS フロー制御を利用する

### K10. pico2: multi-file cat (>2 ファイル) が hang する (bug, 回避済)

pico2 で `cat a b c > out` のように 3 ファイル以上を 1 コマンドで cat
すると hang する (virt では問題なし)。

- 観測: `cat /empty_imports.txt /self_open.txt > /tmp/w1` は OK (2 file)
  だが 3 file 以上でタイムアウト。K5 の 5-file cat 問題と関連の可能性
- **回避策**: 2-file cat chain で中間ファイルを段階的に組み立てる
  (pico2_hw_driver.py が実装済)

## バイトコード / ランタイム

### 20. `peek*` / `poke*` / `get` / `set` が関数呼び出しで遅い (ergonomics, 後回し)

`peek8` / `peek16` / `peek32` / `poke8` / `poke16` / `poke32` は
それぞれ `trap_common.s` / `crt0_tc.s` で `.globl` ラベルとして定義
された小さなアセンブラ関数で、中身は `lbu a0, 0(a0); ret` のような
1〜2 命令。ところが TC コードから呼ぶと BC レベルでは普通の
call 命令に展開され、bc2asm が `call peek8__u32` を吐く:

- 引数を push
- `call peek8__u32` (jal + 関数先頭 + `lbu`/`ret` + 戻り)
- 結果を pop

実質 1 命令の操作に 5〜6 命令のオーバーヘッドが付く。
`get(U8Array, i)` は内部で `peek8(o as u32 + 4 + i as u32)` を呼ぶ
ので、さらに call が入れ子になる。kernel scheduler / lexer / AST
walk のような hot path で効く。

**症状**: compiler/runtime.tc の `get` 側に境界チェックを追加
しようとしたら (#6 段階 1b) `make test` が 60 秒制約を超えた。
peek/poke の call オーバーヘッドがボトルネックの一因。

対処案:
- bc2asm (または codegen) に「peek/poke を intrinsic として認識し、
  該当 BC opcode → 直接 `lbu`/`lhu`/`lw`/`sb`/`sh`/`sw` を emit」
  する特化コードを入れる。関数 label 自体は残して宣言 fallback と
  して動くようにしておけば、codegen 以外のフロント (bcrun 等) は
  従来通り。
- 将来 get/set にも同様の展開を行えば、境界チェック付き get の
  hot-path コストが許容範囲に収まる可能性あり。

**いつやるか**: kernel/tests/pico2 実機のどれかが「遅くてどうしよう
もない」状態になったら試す。現状は特に実害なし。

---

## ビルド / テスト

### 17. `make test` の実行時間が 60 秒上限にぎりぎり (ergonomics)

現在 57-58 秒前後で 60 秒制約 (CLAUDE.md) を満たしている。スイート別
内訳 (実測):

| スイート | 時間 | 主な内容 |
|---|---|---|
| Compiler Source Tests | ~24 s | parse/codegen/bc2asm/bcrun の Gen1 vs golden、Gen2 vs Gen1、Gen2 vs Gen3 (qemu 経由 4 ファイル) |
| OS Component Tests (fs_virtio) | ~19 s | kernel + 4 task の Gen2 ビルド + qemu 起動 |
| asm Virt End-to-End | ~10 s | 5 件 × compile-gen2.sh |
| その他 (unit / pipeline / import / golden) | ~5 s | |

**最有力の方向 (未実装)**: テストを「コンパイラを触ったときに必要」と
「OS / カーネルを触ったときに必要」に分割する。Makefile に
`make compiler-test` と `make os-test` (仮) を導入し、デフォルト
`make test` の意味を文脈で切り替える。

理由:
- 普段の開発で「コンパイラは触っていない、kernel/* だけ書いている」
  ときに Compiler Source Tests (24s) を毎回回す必要がない
- 逆もまた然り (compiler/* だけ触ってるときに kernel build を回す
  必要がない)。
- 単純に「全部速くする」より「触っていない部分を skip する」ほうが
  実効ターンアラウンドが短くなる
- 60 秒制約への余裕も自然に生まれる

実装メモ:
- ファイル分割: tests/test_compiler.sh (Gen2/Gen3 比較系) と
  tests/test_os.sh (kernel + asm Virt) を独立に呼べるようにする
- `make test` のデフォルト挙動は要相談。今のように全部回すか、
  どれか一方をデフォルトにするか
- CLAUDE.md の 60 秒ルールは「個別ターゲットそれぞれ 60 秒以内」と
  読み替える可能性

その他の高速化案 (副案):
- kernel/build.sh の task コンパイル並列化 (5 ファイル sequential
  → parallel で OS Tests が 19s → ~5s 期待)
- Gen2 中間出力のキャッシュ (.tc hash → .bin)
- 上記分割と独立に効くので、必要に応じて段階的に。

---

解決済みの問題は `docs/solved.md` を参照。
- 配列コンストラクタの size が i32 だった → u32 に変更 (b04855c)
- Gen2 typecheck が struct array 型を知らなかった → 対症療法として
  typecheck.tc に register_struct_array を足したが、最終的には synthetic
  fn で置換 (b04855c)
- runtime.tc の pool アロケータが固定バケット + 先頭追加しかできず
  カーネルで任意サイズの task RAM を確保できなかった → kmalloc/kfree
  (free-list + 10 bucket) に置き換え (d889401)
- kernel が bin2s で .rodata にタスクを埋め込んでいたので /bin/* という
  概念がなかった → mtfs + `loader.tc` + `vfs_xip_addr` で FS からロード
  するフローに差し替え (フェーズ6 Step 6.2 / 6.3、bb5ad5c / 4d082c3 /
  6955d8b)
- スケジューラが固定スロットで 1 度 done したら再利用不可だった →
  state 4 種 + sched_spawn / sched_wait を追加してプロセス管理の土台を
  作り、sh をループ化できるようにした (フェーズ6 Step 6.5)
- `load_task` / `sys_exec_handler` が task 画像 (frame_buf / ram /
  stack / img) を一切 free していなかった → スケジューラに per-slot
  の owning allocation arrays を追加。make_task が g_last_* に
  allocation base を記録し、sched_register/spawn/replace_current が
  slot に snapshot、sched_task_exit と sys_exec が古い slot を
  kfree するようにした。テストは 5× catfile spawn/wait で
  `KERN: live=36` が変わらないことを検証 (リーク時は spawn 毎に 4 ずつ
  増える)。runtime.tc に `kfree` / `km_live_count` / `km_dump_stats` の
  export を追加 (K1)
- typecheck のエラーメッセージが `"Type error\n"` 11 バイト固定だった
  → `check_call_site` の失敗時に関数名 + 引数型リスト + 直前 comment
  ノード (parse.tc が AST に埋め込む元ソース行) を印字するよう拡張。
  例: `Type error: no overload for 'append' matching (StringLiteral, i32)
  near: var s: String = append("hi", a);`。行番号なしでも位置特定
  できる。AST フォーマットは不変 (#5 段階 1)
- bootstrap C runtime の `"get/set: out of bounds"` メッセージが固定
  文字列で idx/len を含まなかった → `bootstrap/runtime_syscall.c` の
  get_bounds_check / set_bounds_check で `"get: <idx> out of bounds
  (len=<n>)"` を出すように修正。bootstrap/bcrun.c / interp.c の独立
  チェックも同じ書式に揃えた (#6 段階 1a)
- compiler/runtime.tc の get/set に境界チェックが一切なく Gen3 ターゲット
  (kernel / 各種 TC app) は OOB で silent corruption していた → `set`
  側のみ境界チェックを追加 (set は書き込み = 他領域を壊せるので
  こちらが致命的)。`(i as u32) >= (n as u32)` の unsigned 比較で
  "i<0 または i>=n" を 1 命令にまとめて hot-path コストを最小化。
  get 側は 60 秒テスト制約を超えたので残件 (#6 段階 1b 部分)
- trap_common.s の 8 つの ecall ハンドラが prologue / epilogue を
  コピペしていた (mv s0,sp; call _set_kern_gp; la t0,_kern_save;
  lw sp,4(t0) の 4 行 × 8 + 終端 5 行 × 8) → `_ecall_enter` /
  `_ecall_leave_advance` というヘルパラベルに括り出して各ハンドラを
  半分程度に縮めた。`.macro` / `.endm` のサポートを asm.tc に足さず
  ヘルパラベル (`call _ecall_enter` / `j _ecall_leave_advance`) で
  single-source 化。23 行減 (#7 短期)
- Gen2 ツールの再ビルドが「15 秒以上かかる」という問題と対処案が
  problem.md にあったが、実測で 1.6 秒 (6 ツール順次) になっていた。
  原因は特定しきれていないが、shr_u / u32 除算 / int32 canonicalization
  などの bootstrap 改善が積み重なった結果と推測。測定値が十分小さい
  ので #16 は閉じる。合わせて `tests/test_common.sh:build_gen2_tool`
  に残っていた `2>/dev/null` を削除して #14 (stderr 可視化) と一貫
  させた (#16)
- `/tmp/gen2` / `/tmp/gen3` のキャッシュが stale のまま使われると、
  古い overload テーブル経由で意味不明な実行時エラー (かつて
  "get: out of bounds" の発生源) になっていた → compile-gen2.sh /
  compile-gen3.sh の起動時に `find compiler/*.tc -newer
  $GEN2_DIR/typecheck` で検出し、stale 時に rebuild コマンドを含む
  警告を stderr に出すようにした。強制 rebuild はしない (開発者が
  stale build を意図的に使いたい場面もあるため)。make test は毎回
  fresh にビルドするので警告は出ない (#15)
- ツールチェーンの stderr が「成功時に 100 行以上のノイズ」で埋まっていて
  `compile-gen*.sh` が全パイプ段を `2>/dev/null` で潰していた (結果
  typecheck/codegen/bc2asm の失敗が開発者に見えなかった) → 3 箇所の
  無条件 stderr 出力を削除: (a) `compiler/runtime.tc` の `sys_exit` が
  `km_dump_stats` を呼んでいたのをやめた、(b) `compiler/asm.tc` の
  成功時ラベルマップダンプを削除、(c) `bootstrap/runtime_syscall.c` の
  `sys_exit__i32` が `pool_dump_stats` を呼んでいたのをやめた。これで
  compile-gen1/gen2/gen3.sh の `2>/dev/null` を全部外せて、成功時は
  完全無音・失敗時はエラーがそのまま見えるようになった。make test も
  副次効果で ~1s 速くなった (#14)
- スケジューラの max スロットが 8 ハードコード (旧 K2) は実害なしで
  削除。動的拡張は本当に必要になってから書く。
- virt の seeded タスクサイズが 64K/64K で他経路 (pico2 /
  sys_exec_handler / sys_spawn_handler) の 16K/8K と食い違っていた
  (旧 K3 のうち統一部分) → kernel.tc を 16K/8K に揃え、全経路で
  サイズ統一。タスク自身がサイズを宣言する仕組みは未実装で
  残件として K3 に残す
- bc2asm.tc の関数テーブルが 10-int flat I32Array で、R1 と同じ並列配列
  パターンを持っていた (R5) → `struct BcFunc { name_ss, name_sl,
  param_base, nparam, local_base, nlocal, instr_base, ninstr }` +
  BcFuncArray に畳んだ。旧レイアウトで未使用だった index 2/3 スロットも
  自動的に消滅
- asm.tc のラベル表も 5 並列配列 (g_lab_offs/lens/addrs/is_bss/section)
  だった (R6) → `struct Label { name_off, name_len, addr, section }` +
  LabelArray に整理。`g_lab_is_bss` は宣言されたまま読み書き皆無の dead
  code だったので削除
- asm.tc に書きかけの dead `parse_reg` (常に -1 を返すスケルトン) が
  残っていた (R8) → 削除
- bc2asm.tc が 524 KB の flat `src` バッファに stdin を丸ごと読み込んで
  から parse_bc が `g_in_pos` で indexing していた (R7) → SourceReader
  (4 KB の内部バッファ) でストリーミング処理に移行。 parse_lnum は
  random-access 前提だったので `parse_lnum_stream(stop)` に書き直し、
  スキャン中に桁を累積する 1-pass 版に。 main が sys_read でチャンク
  読みしていたループも消滅。520 KB のピークメモリ削減 (Pico 2 セルフ
  ホストの前提条件)
- codegen.tc / bc2asm.tc / typecheck.tc の asm/BC 出力が `emit_char(ob,
  'a'); emit_char(ob, 'd'); emit_char(ob, 'd');` のように 1 バイトずつ
  垂れ流していた (R4) → `emit_nl(ob)` ヘルパを `string_buffer.tc` に
  追加し、連続する `emit_char(VAR, 'X')` を Python スクリプトで機械的
  に `emit_string(VAR, "...")` に折りたたみ、`emit_char(VAR, 10u8)` を
  `emit_nl(VAR)` に統一。削減量: bc2asm.tc -6.2KB、codegen.tc -8.5KB。
  例: 4 行の emit_char 連鎖 → 1 行の `emit_string(ob, "  jump_ifnot __L");
  emit_int(ob, lend); emit_nl(ob);` になった
- 文字列比較が cmp2/cmp3/cmp4/cmp5/cmp6 という長さ別ヘルパに展開されて
  いて、`if len == N { if cmpN(atom,0, 'a','b','c',...) }` のような
  ネストで書かれていた (codegen.tc / typecheck.tc / extract_sigs.tc /
  bc2asm.tc / bcrun.tc / asm.tc の classify_kind / classify_op /
  `.rodata` 判定 / `load_base` 判定) → compiler/strlib.tc に
  `streq_lit(buf, offset, slice_len, StringLiteral)` と
  `cmp_lit(buf, offset, StringLiteral)` を追加、全箇所を 1 行ずつの
  `if streq_lit(atom, 0, len, "fn") { return NK_FN; }` 形式に統一。
  6 ファイルから自前 cmpN (5 関数 × 各 ~5 行) を削除。可読性
  大幅改善、classify_kind はネスト構造が完全に消えた (R3)
- compiler/{codegen,typecheck,extract_sigs}.tc が同じ AST ノードプール
  アクセサ (n_kind / n_ss / ...) と alloc_node を各自コピーしていて、
  かつ flat I32Array 上で 8-int レイアウトを hand-index していた
  (R1, R2) → 共有モジュール `compiler/ast_node.tc` を新設、`struct
  AstNode` + AstNodeArray に切り替えて 3 ファイルから自前 accessor を
  削除。export 前方宣言で synthetic fn を export 化する pattern
  (R1 phase 1 で document) を使ったので 218 callsite は無修正。
  メモリレイアウトも flat I32Array(N*8) → AstNodeArray(N) ref 配列 +
  per-node 36-byte struct 動的確保に変更。小さいファイルでは
  proportional に小さく済むので Pico 2 自己ホストの前提条件が満たせる。
  bootstrap C runtime の bucket-2 (64-byte) を 256 → 32768 slot に
  拡張 (typecheck.tc のノード instance 用)
- `struct` フィールドに `StringLiteral` 型を書けるか未検証だった (#18) →
  3 経路 (interp / bcrun / rv32) で動作確認。`struct Mount { prefix:
  StringLiteral, fs_type: i32 }` のような宣言・コンストラクト・
  field アクセスとも問題なし
- `compiler/bcrun.tc` の OP_SHR_U 実装が「1 ビット arithmetic shift +
  & 0x7FFFFFFF マスク + 残りシフト」という 5 行の trick だった → shr_u
  が bootstrap / Gen2 両方に実装済なので、`((a3 as u32) >> (b3 as u32))
  as i32` の 1 行に置き換え。以前の循環依存 (shr_u 実装に shr_u が
  必要) は解消済 (#11)
- asm.tc のエラーが「`asm: unknown instruction 'xxx'`」など mnemonic
  だけで行番号も元行もなかった → `g_cur_line` を `process_line` 冒頭
  でセットし、`asm_err_begin` / `asm_err_end` ヘルパで 3 つのエラー
  サイト (unknown instruction / undefined label / gp-relative out of
  range) を書き直した。新しい出力形式: `asm:<line>: <msg>\n  at:
  <verbatim line>`。pass 2 終了後は `g_cur_line = 0` でクリアし
  write_elf 段階のエラー (e.g. 未定義 _start) が過去の行を誤って
  参照しないようにした (#9)
