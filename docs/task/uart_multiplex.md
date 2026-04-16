# UART マルチプレクシング設計

## 目的

Pico 2 (単一 UART) 上でカーネルデバッグ出力・複数タスクの stdout/stderr
・ホストからのタスク stdin が一本の TX/RX ラインで混線しているので、
ホスト側の Python が **どの source から来たか** を判別してファイル分け
できるようにする。入力側も同様にプリフィックスで「どのタスクに届ける
か」を指定できる。バイナリデータ (raw binary dump 等) も通せる。

現状の問題:
- `[sw 2>0]` / `[kmem peak=...]` のようなカーネルトレースがタスク出力
  (cat /hello.txt の `hello, mtfs` など) に byte 単位で混ざる
- **バイナリダンプ** (asm_pass2 の output 等) が走ると scheduler トレーサ
  が途中に混入して破壊される
- host からの入力は読む順に早いもの勝ちなので、sh が自分宛のコマンド
  を読むつもりが asm_pass1 に奪われる等の race が起きる
- phase 7 の pico2 self-compile pipeline は intermediate data を UART
  で往復させる必要があるが、今の raw UART ではデバッグ困難

## フレームフォーマット

各フレームは **5 byte header + 最大 255 byte payload**、合計 6〜260 byte:

```
offset | size | field
0-3    | 4    | tag (ASCII、スペースパディング、例 "PR02", "KERN")
4      | 1    | len (0-255、payload byte 数)
5..    | len  | payload (任意バイト列、バイナリ可)
```

- **バイナリ完全透過**: payload は long-prefix で byte-counted、escape 不要
- **固定ヘッダ**: tag 4 byte が常に ASCII の範囲にあるので、ストリームの
  途中から見てもタグを手がかりに同期取り直しが可能
- **header-only フレーム** (`len=0`) は EOF マーカとして使える (後述)

### タグ割り当て

| tag | 方向 | 意味 |
|---|---|---|
| `KERN` | out | Kernel kputs / kdbg_switch / kdbg_exit etc. |
| `PR00`..`PR07` | out | スロット N のタスク stdout (fd=1、UART 行き) |
| `SE00`..`SE07` | out | スロット N のタスク stderr (fd=2) |
| `PR00`..`PR07` | in | スロット N のタスク stdin (fd=0) 宛 data |
| `EOF0`..`EOF7` | in | スロット N の stdin を EOF マーク (len=0 必須) |

スロット番号は `sched_current_idx()` が返す整数を 2 桁 10 進で埋める。
8 slots (`sched_init(8)`) なので PR00..PR07 まで使用。将来 slot 99 まで
拡張可能 (タグ再設計不要)。

### フレーミング例

タスク (slot 2, /bin/sh) が `puts("sh$ ")` を呼ぶ:
```
byte: 'P' 'R' '0' '2' 0x04 's' 'h' '$' ' '
       [tag=PR02][len=4 ][payload "sh$ "        ]
```

Kernel が `kdbg_switch(2, 3)` で `[sw 2>3]\n` (9 byte) を吐く:
```
byte: 'K' 'E' 'R' 'N' 0x09 '[' 's' 'w' ' ' '2' '>' '3' ']' '\n'
       [tag=KERN][len=9 ][payload "[sw 2>3]\n"                  ]
```

ホストが slot 2 に "catfile\n" (8 byte) を送る:
```
byte: 'P' 'R' '0' '2' 0x08 'c' 'a' 't' 'f' 'i' 'l' 'e' '\n'
       [tag=PR02][len=8 ][payload "catfile\n"               ]
```

ホストが slot 4 (asm_pass1) に full.s (224300 byte) を送る場合、255
byte 毎に複数フレームに分割:
```
[tag=PR04][len=255][payload 255 bytes]
[tag=PR04][len=255][payload 255 bytes]
...
[tag=PR04][len=X  ][payload X bytes, X=224300 mod 255 = 80]
[tag=EOF4][len=0  ]                               ← EOF
```

**224300 / 255 = 880 フレーム** (平均 260 byte/frame)、オーバーヘッド
5/260 ≈ 1.9%。悪くない。

## 出力側 (kernel → host)

### 書き込みパス

1. `kputs` / `kdbg_chr` / task の `sys_write(fd=1)` / `sys_write(fd=2)`
   のいずれもいずれ `do_uart_write` を叩く
2. `do_uart_write` の手前に `uart_emit_frame(tag, data, len)` を挟む
3. `uart_emit_frame` は `len` が 255 を超えたら 255 byte 毎に分割し、
   それぞれ `[tag][len][data]` を 1 回の `do_uart_write_raw` で一気に
   送る (既存の do_uart_write の inner 実装を raw として残す)

### タグ選定

| 書き込み元 | タグ |
|---|---|
| `kputs("...")` | `KERN` |
| `kdbg_*` (scheduler tracer) | `KERN` |
| task slot N の `sys_write(1, ...)` → UART | `PR0N` |
| task slot N の `sys_write(2, ...)` → UART | `SE0N` |
| task slot N の `sys_write(1, ...)` → tmpfs/mtfs redirect | タグ無し (UART を経由しない) |

`vfs_write(fd=1)` で redirect 有無を判定した後、UART に行く場合だけ
タグ付き frame を出す。redirect 時は既存通り `tmpfs_write` に渡すだけ。

### "タスク現在 slot" の取得

`sched_current_idx()` は既存関数。`vfs_write` の中で呼ぶとそのまま使える。
Kernel code (kdbg_*) からの write は `KERN` 固定。

### framing 実装の注意

- `do_uart_write` の呼び出しがアトミックでない (途中で timer preempt
  されると他タスクの write が割り込む) 可能性があると、tag + len + data
  の 3 部分が byte 交互に出てフレーミングが壊れる
- 現状 PL011 `do_uart_write` は M-mode assembly で、polling-wait ベース
  で **割り込み無効** のまま実行される。ecall handler 内部なので preempt
  されない。つまり 1 回の `do_uart_write_raw` は atomic
- だから **1 frame = 1 do_uart_write_raw** にすれば OK。ヘッダ 5 byte +
  payload max 255 byte を 1 つの u8 array にまとめて 1 回で送る

## 入力側 (host → kernel → task)

### 受信パス

1. PL011 RX FIFO にバイトが届く
2. Kernel `uart_rx_dispatch` (新設) が **ストリームを frame 単位で
   パース**。tag 4 byte + len 1 byte を読み、len byte の payload を読み込む
3. tag が `PR0N` なら slot N の **per-task input buffer** (ring) に enqueue
4. tag が `EOFN` なら slot N の **in_eof flag** を立てる
5. Task の `sys_read(0, buf, n)` は自分の input buffer から最大 n byte
   読む。空で `!in_eof` ならブロック、空で `in_eof` なら 0 を返す

### per-task buffer

`Task` 構造体に追加:
```tc
struct Task {
    ...
    in_buf:  U8Array,   // ring buffer, capacity e.g. 4096
    in_head: i32,       // 次に read する位置
    in_tail: i32,       // 次に write する位置
    in_eof:  i32,       // 1 なら EOF マーク受信済み
}
```

capacity 4096 にしておくと 16 frames 分の buffer (frame 平均 260 byte)。
sh / コンパイラタスク共にこの程度で実用十分。足りなければ拡張可能。

### RX dispatch 実装戦略

**polling 方式** (シンプル):
- `sys_read(0, ...)` が呼ばれたとき、`uart_rx_dispatch()` を呼んで FIFO
  を吸い出し buffer に溜める
- 他のタスクの sys_read が届いた byte を奪う心配無し (タグで分ける)

**割り込み方式** (高スループット):
- UART RX 割り込みを enable して、`trap_handler` で `uart_rx_dispatch` を
  呼ぶ。全タスクの buffer が常に追いつく
- 実装工数 UP、RX 割り込みハンドリング追加が必要

最初は polling でスタート。phase 7 の大 byte 転送で FIFO オーバーフロー
が出たら割り込み化を検討。

### EOF の扱い

source_reader.tc の既存の EOT (0x04) 対応は kernel 側のフレーミングで
代替されるので撤去可能。ただし既存の virt 経路 (tmpfs / mtfs 経由の
sys_read はサイズ既知で 0 返却) との整合性を保つため、kernel は `in_eof`
を立てたら payload の末尾に 0x04 を自動付加する (source_reader が
0x04 を EOF と解釈) 案もあり。簡潔さのため後者採用予定。

## ホスト側 Python demuxer

### 読み取り (UART → ログファイル)

`tests/pico2_demux.py` (新設):
```python
# frame 読み取り
tag = uart.read(4)
n = uart.read(1)[0]
data = uart.read(n)

# ログファイル分岐
log_files[tag].write(data)
log_files[tag].flush()
```

- タグ毎に `/tmp/pico2_logs/log.KERN`, `log.PR00`, `log.PR02`, ... を open
- frame が欠けると再同期困難なので、最初は assume-in-sync で実装し、
  デバッグが必要になったら magic byte を入れる

### 書き込み (ホスト → UART)

driver は:
```python
def send_frame(tag: str, data: bytes):
    assert len(tag) == 4
    assert len(data) <= 255
    uart.write(tag.encode() + bytes([len(data)]) + data)

# slot 2 (sh) に "catfile\n" 送信
send_frame("PR02", b"catfile\n")
```

大きい data は 255 byte 単位で分割:
```python
def send_stream(tag: str, data: bytes, eof_tag: str = None):
    i = 0
    while i < len(data):
        chunk = data[i:i+255]
        send_frame(tag, chunk)
        i += 255
    if eof_tag:
        send_frame(eof_tag, b"")  # len=0 EOF
```

## 実装計画

### Phase 0: 設計 (本ドキュメント) — 完了

- [x] フォーマット決定: 4-byte tag + 1-byte len + ≤255 byte data
- [x] タグ命名規則: KERN / PR0N / SE0N / EOFN
- [x] 出力: vfs_write / kputs に injection
- [x] 入力: per-task in_buf + uart_rx_dispatch + polling で開始

### Phase 1: 出力多重化 (kernel → host)

1. `kernel/kernel_common.tc` に:
   - `uart_emit_frame(tag: StringLiteral, buf: U8Array, len: i32)` 新設
   - `do_uart_write_raw` (現在の do_uart_write をリネーム)
   - `do_uart_write(buf, len)` を「KERN タグで raw emit する wrapper」に
2. `kdbg_chr` の sys_write(1, ...) を uart_emit_frame("KERN", ...) に切替
3. `vfs_write` で UART 行き判定時に uart_emit_frame("PR0N", ...) / SE0N
4. Python host 側 `pico2_demux.py` を出力読み取り部分だけ先に実装
5. 回帰: `make test` 141 passed 維持、test_pico2.sh を demuxer 版に書き換え

### Phase 2: 入力多重化 (host → task)

1. `Task` 構造体に in_buf / in_head / in_tail / in_eof 追加
2. `kernel_common.tc` に `uart_rx_dispatch()` を実装:
   - PL011 から frame を読んで parse
   - tag が PR0N → slot N の in_buf に enqueue
   - tag が EOFN → slot N の in_eof = 1 (payload 末尾に 0x04 付加)
3. `vfs_read(fd=0)` を per-task in_buf から読むように切替
4. Python driver 側: `os.write("catfile\n")` → `send_frame("PR02", b"catfile\n")`
5. test_pico2.sh / test_pico2_hw.sh を demuxer 対応に書き換え
6. source_reader.tc の 0x04 EOT 自動処理は継続 (EOFN frame が kernel
   経由で 0x04 に変換される形で)

### Phase 3: pico2 Hello World 再挑戦

多重化が整うと、並行ストリーミングが可能になる:
- sh に次コマンドを予約送信しつつ、別タスクに stream を注げる
- cat + redirect の hang バグも、タグで分離されるので診断しやすくなる
- scheduler tracer が `KERN` タグに分離されるので binary dump が
  そのまま通る

## 将来拡張

- **magic byte sync**: 各 frame 頭に 0x1F 追加 (6+N byte フレーム)
  再同期をロバストに
- **圧縮 / コンパクト化**: `#0\t` のような short-ID 化で帯域節約
- **RX 割り込み**: polling 枯渇したら UART RX 割り込み駆動に
- **flow control**: ホスト -> pico2 の送信を RTS/CTS で止められると
  長大転送が確実に (pico2 PL011 hardware flow control サポート有り)

## 参考

- 現状 scheduler tracer: `kernel/kernel_common.tc::kdbg_*`
- UART driver: `kernel/platform_pico2.s::do_uart_write / do_uart_read`
- task VFS write: `kernel/vfs.tc::vfs_write`
- 前代の line-based design はバイナリ不可で採用見送り (commit efb90f8)
