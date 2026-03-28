# ファイルシステム設計（案）

## ディレクトリ構成

```
/                   Flash FS（読み取り専用）
├── bin/            実行ファイル（shell, compile, as, ld, ...）
├── lib/            ライブラリファイル
├── src/            OSのソースコード
├── dev/            デバイスファイル（カーネルが提供）
│   ├── uart0       シリアルポート
│   └── null        /dev/null
├── tmp/            tmpfs（PSRAM上、揮発性）
└── proc/           procfs（カーネル内部情報、読み取り専用）
    ├── 1/          PID 1 のプロセス情報
    │   ├── status  状態（pid, state, heap使用量など）
    │   └── maps    メモリマップ
    ├── 2/
    │   └── ...
    └── meminfo     メモリ使用状況
```

## マウント構成

| パス | 種別 | バックエンド | 読み書き |
|---|---|---|---|
| `/` | Flash FS | Flash 0x10100000〜 | 読み取り専用 |
| `/tmp` | tmpfs | PSRAM 0x11200000〜 | 読み書き |
| `/dev` | devfs | カーネルドライバ | デバイス依存 |
| `/proc` | procfs | カーネル内部 | 読み取り専用 |

`/` が読み取り専用のため、実行時に書き込みが必要なファイルは `/tmp` に置く。
コンパイラをパイプで繋ぐ場合、中間データはパイプ（IPC）で受け渡されるためファイルシステムを経由しない。
`make` やシェルスクリプトで中間ファイルを明示的に作る場合は `/tmp` に置き、ユーザが削除する。

## VFS（仮想ファイルシステム層）

各FSの違いを吸収する薄い共通レイヤ。
`open`/`read`/`write`/`close` はパスを見てどのFSに委譲するか決める。

```
// VFS操作テーブル（FSごとに実装）
struct FsOps {
    open:    fn(path: String, flags: u32) -> i32
    read:    fn(fd: i32, buf: U8Array, n: u32) -> i32
    write:   fn(fd: i32, buf: U8Array, n: u32) -> i32
    close:   fn(fd: i32) -> i32
    seek:    fn(fd: i32, offset: i32, whence: u32) -> i32
    readdir: fn(path: String, buf: DirEntryArray) -> i32
    stat:    fn(path: String, buf: Stat) -> i32
}
```

パスの先頭で委譲先を決定:
- `/tmp/...` → tmpfs
- `/dev/...` → devfs
- `/proc/...` → procfs
- それ以外 → Flash FS

## Flash FS

### 方針

- 独自フラットFS（シンプルさ優先）
- 読み取り専用マウント（Flash の寿命消耗を避ける）
- ディレクトリは複数階層対応

### フォーマット

```
[スーパーブロック 512B]
  magic:        u32   // 識別マジック
  block_size:   u32   // 512
  total_blocks: u32
  inode_count:  u32

[inodeテーブル (N * 64B)]
  name:        u8[32]  // ファイル名
  parent:      u32     // 親ディレクトリの inode 番号（ルートは0）
  size:        u32     // バイト数
  start_block: u32     // データ領域の先頭ブロック番号
  flags:       u32     // ファイル(0)/ディレクトリ(1)

[データ領域]
  各ファイルの内容（block_size単位）
```

### ストレージバックエンド

- XIP で直接読み出し（Flash 0x10100000 をそのままアドレス参照）
- 書き込みは不要（読み取り専用）
- PCでイメージを作成して picotool でフラッシュする

## tmpfs

- PSRAM 上の固定領域（2MB）を使用
- Flash FS と同じ inode ベースの構造をメモリ上で実装
- 書き込み可能、電源断で消える
- `/tmp` 以下のファイルの管理はユーザの責任（カーネルは自動削除しない）

## devfs

カーネルドライバが提供するファイル。通常のファイル操作で読み書きできる。

| パス | 説明 |
|---|---|
| `/dev/uart0` | UARTシリアル。`read`で入力、`write`で出力 |
| `/dev/null` | 読むと EOF、書くと捨てる |

標準入出力（fd 0, 1, 2）は起動時に `/dev/uart0` に紐付けられる。

## procfs

カーネル内部の情報をテキストファイルとして提供する。読み取り専用。

| パス | 内容 |
|---|---|
| `/proc/{pid}/status` | pid, state, heap_start, heap_end |
| `/proc/{pid}/maps` | メモリ領域一覧 |
| `/proc/meminfo` | SRAM・PSRAM の使用量 |

## カーネル内部 API

```
fn vfs_open(path: String, flags: u32) -> i32
fn vfs_read(fd: i32, buf: U8Array, n: u32) -> i32
fn vfs_write(fd: i32, buf: U8Array, n: u32) -> i32
fn vfs_close(fd: i32) -> i32
fn vfs_seek(fd: i32, offset: i32, whence: u32) -> i32
fn vfs_readdir(path: String, buf: DirEntryArray) -> i32
fn vfs_stat(path: String, buf: Stat) -> i32
```
