# UART マルチプレクシング設計

## 目的

Pico 2 (単一 UART) 上でカーネルデバッグ出力・複数タスクの stdout/stderr
・ホストからのタスク stdin が一本の TX/RX ラインで混線しているので、
ホスト側の Python が **どの source から来たか** を判別してファイル分け
できるようにする。入力側も同様にプリフィックスで「どのタスクに届ける
か」を指定できるようにする。

現状の問題:
- `[sw 2>0]` / `[kmem peak=...]` のようなカーネルトレースがタスク出力
  (cat /hello.txt の `hello, mtfs` など) に byte 単位で混ざる
- 特に **バイナリダンプ** (asm_pass2 の出力等) が走ると scheduler
  トレーサが途中に混入して破壊される
- host からの入力は読む順に早いもの勝ちなので、sh が自分宛のコマンド
  を読むつもりが asm_pass1 に奪われる等の race が起きる
- phase 7 の pico2 self-compile pipeline は intermediate data を UART
  で往復させる必要があるが、今の raw UART ではデバッグ困難

## 設計方針

### プリフィックスフォーマット (テキスト行単位)

各 UART 行 (LF で区切られた 1 行) の先頭に **6 文字のタグ + `: `**
(計 8 文字) を付ける。

| タグ | 出力元 | 説明 |
|---|---|---|
| `KERN  ` | kernel kputs / kdbg_* | `KERN  : BLOCK: flash backend ready` |
| `PR00  `〜`PR07  ` | slot N のタスク | `PR02  : sh$ ` |
| `STDERR` | タスク fd=2 | `STDERR: [kmem peak=12 live=0]` (slot 情報は行後方) |

2 桁スロット番号は scheduler slot index と一致。`sched_init(8)` で
slot 0-7。拡張するときは `PR0N` の長さを増やす (e.g., `PR10`)。

タグ + `: ` は **ちょうど 8 byte**、固定幅でホスト側パースが単純:
```
byte 0-5  : タグ (6 bytes, space padding 例 `KERN  `)
byte 6    : `:`
byte 7    : space
byte 8..  : payload (0..N bytes)
byte N    : `\n` (payload 末尾)
```

### 行の境界と行越え content

タスクが `sys_write(1, "hello", 5)` のように **改行を含まない** 書き込みを
したら、その時点ではタグを付けた上で改行を入れずに次回 write を待つ…
ではなく、**毎 sys_write 呼び出しで 1 行 + 末尾 `\n`** とする単純化を採用。

- `sys_write(1, "hello", 5)` → UART には `PR01  : hello\n` が出る
- `sys_write(1, "hello\n", 6)` → `PR01  : hello\n` (末尾 `\n` は重複回避)
- `sys_write(1, "a\nb\n", 4)` → `PR01  : a\n` + `PR01  : b\n` (内部 `\n`
  で分割してそれぞれタグ付け)

こうすると sys_write の境界が行区切りになり、行越え content は自動的に
「連続行」としてタグ付きで並ぶ。ホスト側は単純に行ごとにタグでソート
するだけで良い。

### バイナリデータは対象外

コンパイル済みバイナリを UART で送受信する場合 (asm_pass2 の出力等)、
プリフィックス方式は破綻する。そこは別途 base64 / length-prefix
フレーミングを使うか、tmpfs 経由にする。今回の設計ではテキスト
ストリームのみ多重化する。

### 入力のルーティング

ホストが `PR02  : catfile\n` を UART に送ると、kernel は:
1. 頭 8 byte を読んで target slot を決定 (スロット 2 = sh)
2. payload をスロット 2 の **per-task input buffer** に enqueue
3. Task 2 の `sys_read(0, ...)` は自分の buffer から読む

これにより:
- sh 宛 (slot 2) のコマンドと、asm_pass1 宛 (例えば slot 4) の source
  stream を **並列に** 送っても混線しない
- `PR02  : ` / `PR04  : ` を適切に振り分ければ、sh が自分のコマンドを
  入力している間 asm_pass1 に大量の source byte を注ぎ込める

`PR00  : ` のように **0 padding の 2 桁** を採用するので slot 0..99
までカバー (実装上は 0..7 のみ有効)。

### 改行内バイナリ文字の扱い

`: ` / `\n` といった frame-critical な文字が payload に現れたら?
- payload 内の `\n` は「改行」= 行終わり扱い。書き手が複数行書きたい
  なら複数の logical line を sys_write すること
- payload 内の `: ` はタグ部分と衝突しない (byte 0-7 は固定)
- payload 内の `\r` は host 側で LF に正規化

## 実装計画

### Phase 0: 設計 (本ドキュメント)

- [x] フォーマット決定 (8-byte fixed-width prefix)
- [x] 行単位 / 毎 sys_write 方針
- [x] 入力ルーティング方針

### Phase 1: 出力多重化

**カーネル側**:
1. `kernel_common.tc` に `uart_emit_line(tag: StringLiteral, buf_addr: u32, n: i32)`
   を追加。タグ + `: ` + payload + `\n` を連続で `do_uart_write` する
2. `kputs` / `kdbg_chr` を `uart_emit_line("KERN  ", ...)` に切替
3. `vfs_write` で fd=1 / fd=2 の UART 行きを intercept し、
   タスクの現在 slot を `sched_current_idx()` で取って
   `uart_emit_line("PR0N  ", ...)` に切替 (fd=2 は `STDERR` タグ)
4. 連続 `sys_write` (LF なし) が来たら、tag は毎回だけ付けて payload
   を出す。payload 内 `\n` で分割してそれぞれタグ付け

**テスト**:
- virt / pico2 で `cat /hello.txt` が `PR0N  : hello, mtfs\n` の形で
  出ることを確認
- 2 タスク並行時にタグが正しく slot 番号を反映することを確認
- scheduler 起動時の `KERN  : starting` 等が `KERN` タグで出ることを確認

### Phase 2: 入力多重化

**カーネル側**:
1. `Task` 構造体に `in_buf: U8Array` (256 byte ring)、`in_head`/`in_tail`
   を追加
2. UART RX polling (現状は `do_uart_read` が直接 PL011 叩くが、今後は
   UART → `uart_rx_dispatch(byte)` でルーティングする)
3. Host が送ってきた行の頭 8 byte をパースして、target slot の in_buf
   に enqueue
4. `sys_read(0, ...)` は current slot の in_buf から読む

**ホスト側**:
- 既存 driver は `os.write(fd, "cmd\n")` だが、今後は
  `os.write(fd, b"PR02  : cmd\n")` と書く

### Phase 3: Python ホスト demuxer

`tests/pico2_demux.py` を新設:
- UART から行単位で読む
- タグ別にファイルに追記: `log.kern`, `log.pr00`, `log.pr02`, ...
- `--tee stderr` で選択タグを同時に stdout 表示

使い方:
```bash
python3 tests/pico2_demux.py /dev/ttyACM0 --out-dir /tmp/pico2_logs \
    --tee pr02  # sh の出力だけ stdout にも流す
```

既存 `pico2_hw_driver.py` を demuxer 込みに書き直す。

## 将来拡張

- **バイナリ転送モード**: フラッシュや SRAM ダンプ時は、一度
  `KERN  : BEGIN_BIN size=NNNN\n` を出してから `size` バイトのバイナリ
  を raw でストリーム、`\nKERN  : END_BIN\n` で締める。ホスト側の
  demuxer は `BEGIN_BIN` と `END_BIN` の間を特別扱い
- **タグ幅拡張**: 8 byte 固定 → 可変にして `TASK_very_long_name: `
  のような人間可読タグにしたくなったら改める
- **圧縮**: 115200 bps だと冗長なタグで帯域食うので、short ID
  (`#0\t`) に切り替えてサイズ節約の余地あり

## 代替案検討

- **Netstring-like フレーミング** (`<LEN>:<TAG><payload>,`) :
  バイナリデータにも対応できるが host/kernel 両側の state machine が
  複雑化。行境界で切れない stream に対する追従も必要
- **COBS エンコード** : バイナリ透過で高効率だが実装コストが高い
- **JSON-lines** (`{"tag":"PR02","msg":"sh$ "}\n`) : 人間可読だが
  kernel 側の JSON escape が重い

いずれも今回の用途 (phase 7 デバッグ) にはオーバーキル。8-byte fixed
prefix を採用。

## 参考

- 現状の scheduler tracer: `kernel/kernel_common.tc::kdbg_*` (これも
  Phase 1 で `KERN` タグに吸収される)
- UART driver: `kernel/platform_pico2.s::do_uart_write / do_uart_read`
  (PL011)
- タスク VFS write: `kernel/vfs.tc::vfs_write` (fd == 1 の redirect
  判定が既にあるので、UART 行きの場合だけ多重化を挿入する)
