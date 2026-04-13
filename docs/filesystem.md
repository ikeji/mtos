# ファイルシステム設計（案）

## ディレクトリ構成

```
/                   MyTinyFS / mtfs（Flash、読み取り専用）
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
| `/` | MyTinyFS (mtfs) | Flash 0x10100000〜 (Pico 2) / virtio-blk (qemu virt) | 読み取り専用 |
| `/tmp` | tmpfs | PSRAM 0x11200000〜 | 読み書き |
| `/dev` | devfs | カーネルドライバ | デバイス依存 |
| `/proc` | procfs | カーネル内部 | 読み取り専用 |

`/` が読み取り専用のため、実行時に書き込みが必要なファイルは `/tmp` に置く。
コンパイラをパイプで繋ぐ場合、中間データはパイプ（IPC）で受け渡されるためファイルシステムを経由しない。
`make` やシェルスクリプトで中間ファイルを明示的に作る場合は `/tmp` に置き、ユーザが削除する。

**PSRAM が無い環境での扱い**: 現在接続している Pico 2 は PSRAM 非搭載なので、
tmpfs は SRAM 上の固定領域に置く。PSRAM を繋いだら `tmpfs_init(base, size)`
の引数だけ差し替えて切り替えられるよう、初期化でアドレスを注入する。

## VFS（仮想ファイルシステム層）

各FSの違いを吸収する薄い共通レイヤ。
`open`/`read`/`write`/`close` はパスを見てどのFSに委譲するか決める。

TC には関数ポインタが無いので、FS ごとに関数テーブルを持たせる代わりに
**mount table + fs_type タグ + switch ディスパッチ** 方式を取る。

```tinyc
// マウントテーブル (カーネル内グローバル)
//   prefix      : マウントポイント (例 "/tmp")
//   fs_type     : 0=mtfs, 1=tmpfs, 2=devfs, 3=procfs
//   fs_handle   : FS ごとの不透明なハンドル (state インデックス等)
var g_mount_prefix: StringArray = 0 as StringArray;
var g_mount_type:   I32Array    = 0 as I32Array;
var g_mount_handle: I32Array    = 0 as I32Array;

// fd テーブル
//   fs_type     : 開いたときの fs_type
//   fs_fd       : 各 FS 内での fd (or inode 番号)
//   offset      : 読み書きポジション
```

`vfs_open/read/write/close` は `fs_type` で if-else ディスパッチする:

```tinyc
export fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32 {
    var t: i32 = get(g_fd_type, fd);
    if t == 0 { return mtfs_read(get(g_fd_inner, fd), buf, n); }
    if t == 1 { return tmpfs_read(get(g_fd_inner, fd), buf, n); }
    if t == 2 { return devfs_read(get(g_fd_inner, fd), buf, n); }
    if t == 3 { return procfs_read(get(g_fd_inner, fd), buf, n); }
    return -1;
}
```

FS を増やすたびに分岐を追加する必要はあるが、数が少ないので許容する。

### exec 用の XIP アドレス取得 API

Flash FS は XIP なので、ファイル内容が Flash ROM の物理アドレスに
そのまま現れる。exec / ローダが「ファイル内容の先頭アドレスをそのまま
ジャンプ先にしたい」ケース用に以下の API を提供する:

```tinyc
// 成功: XIP 上の物理アドレス (≠0)
// 失敗: 0 (FS が XIP 非対応、fd が開いていない等)
export fn vfs_xip_addr(fd: i32) -> u32
```

- mtfs (Flash) の場合: `flash_base + inode.start_block * block_size`
- tmpfs / devfs / procfs の場合: 0 を返す (コピーして実行する必要あり)

パスの先頭で委譲先を決定:
- `/tmp/...` → tmpfs
- `/dev/...` → devfs
- `/proc/...` → procfs
- それ以外 → MyTinyFS (Flash)


## MyTinyFS (mtfs) — Flash 用フラット FS

### 方針

- 独自フラットFS（シンプルさ優先）、名前は **MyTinyFS** (mtfs)
- 読み取り専用マウント（Flash の寿命消耗を避ける）
- ディレクトリは複数階層対応（inode に parent を持たせる）
- 開発フェーズでは qemu virt の virtio-blk を backend にして検証し、
  その後 Pico 2 の XIP Flash に差し替える (インタフェースは同じ)

### フォーマット

```
[スーパーブロック 512B]
  magic:        u32   // 'M''T''F''S' = 0x5346544D (LE)
  version:      u32   // 1
  block_size:   u32   // 512
  total_blocks: u32
  inode_count:  u32
  inode_start:  u32   // inode テーブル開始ブロック番号
  data_start:   u32   // データ領域開始ブロック番号
  (以下 0 埋め)

[inodeテーブル (inode_count * 64B)]
  name:        u8[32]  // ファイル名 (NUL 終端)
  parent:      u32     // 親ディレクトリの inode 番号（ルートは 0、自己参照）
  size:        u32     // バイト数
  start_block: u32     // データ領域先頭からのブロック番号 (file) / 0 (dir)
  flags:       u32     // 0=file, 1=dir
  reserved:    u8[12]  // 0 埋め (64B に揃える)

[データ領域]
  各ファイルの内容（block_size 単位で連続配置）
```

inode 番号 0 はルートディレクトリ予約。inode 1 以降を通常ファイル / dir に使う。
1 ブロック = 8 inode。

### ストレージバックエンド

- Pico 2 実機: XIP で直接読み出し（Flash 0x10100000 をそのままアドレス参照）
- qemu virt 開発時: virtio-blk でセクタ単位に読み込み、カーネル側でキャッシュ
- 書き込みは不要（読み取り専用）
- PC でイメージを作成して picotool / qemu `-drive` でロードする

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
fn vfs_open(path: U8Array, path_len: i32, flags: u32) -> i32
fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32
fn vfs_write(fd: i32, buf: U8Array, n: i32) -> i32
fn vfs_close(fd: i32) -> i32
fn vfs_seek(fd: i32, offset: i32, whence: i32) -> i32
fn vfs_readdir(fd: i32, buf: U8Array) -> i32   // 1 エントリずつ
fn vfs_stat(path: U8Array, path_len: i32, out: U8Array) -> i32
fn vfs_xip_addr(fd: i32) -> u32                // exec / loader 用、0=非対応
```

syscall はバッファを `U8Array + len` で受け渡すので、
カーネル内部 API も String ではなく `U8Array + len` に揃える。
