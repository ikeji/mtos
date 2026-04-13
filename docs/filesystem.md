# ファイルシステム設計

## 目的

- Flash 上に置いた読み取り専用のファイルシステムと、RAM 上の tmpfs・
  カーネル駆動の devfs・procfs をまとめる **VFS 層** を用意する。
- `sys_openat` / `sys_read` / `sys_write` / `sys_close` の syscall を
  追加し、タスクからファイルを読み書きできるようにする。
- qemu virt 上では virtio-blk を backend に開発し、Pico 2 実機では
  XIP Flash を backend にする。ブロック層を差し替えられるよう抽象化する。

## 全体構成

```
  task (ecall)
       │  sys_openat(56) / sys_read(63) / sys_write(64) / sys_close(57)
       ▼
  trap_common.s  (ecall ハンドラを TC 呼び出しにブリッジ)
       │
       ▼  vfs_open / vfs_read / vfs_write / vfs_close / vfs_xip_addr
  kernel/vfs.tc                   ← mount table + fd table + ディスパッチ
       │
       ▼  mtfs_open / mtfs_read      tmpfs_* / devfs_* / procfs_*
  kernel/mtfs.tc                  kernel/tmpfs.tc / devfs.tc / procfs.tc
       │
       ▼  block_read(sector, buf)
  kernel/block_virtio.tc          (qemu virt)
  kernel/block_flash.tc           (Pico 2)
       │
       ▼  MMIO
  virtio-blk @ 0x10001000〜       or   XIP Flash @ 0x10100000〜
```

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
コンパイラをパイプで繋ぐ場合、中間データはパイプ（IPC）で受け渡されるため
ファイルシステムを経由しない。`make` やシェルスクリプトで中間ファイルを
明示的に作る場合は `/tmp` に置き、ユーザが削除する。

**PSRAM が無い環境での扱い**: 現在接続している Pico 2 は PSRAM 非搭載
なので、tmpfs は SRAM 上の固定領域に置く。PSRAM を繋いだら
`tmpfs_init(base, size)` の引数だけ差し替えて切り替えられるよう、
初期化でアドレスを注入する。

## VFS（仮想ファイルシステム層）

各 FS の違いを吸収する薄い共通レイヤ。`open`/`read`/`write`/`close`
はパスを見てどの FS に委譲するか決める。

TC には関数ポインタが無いので、FS ごとに関数テーブルを持たせる代わりに
**mount table + fs_type タグ + switch ディスパッチ** 方式を取る。

マウントテーブルと fd テーブルは struct + XxxArray で持つ。
parallel array よりも追加フィールドが増えた時の改変が小さい。

```tinyc
// マウントエントリ
//   prefix  : マウントポイント (例 "/tmp")
//   fs_type : 1=mtfs, 2=tmpfs, 3=devfs, 4=procfs
//   handle  : FS ごとの不透明なハンドル (state インデックス等)
struct Mount {
    prefix:  StringLiteral,
    fs_type: i32,
    handle:  i32,
}

// fd エントリ
//   fs_type : 開いたときの fs_type (0 = UART 特別扱い)
//   inner   : 各 FS 内での fd (or inode 番号)
//   offset  : 読み書きポジション
struct FD {
    fs_type: i32,
    inner:   i32,
    offset:  i32,
}

// カーネル内グローバル
var g_mount: MountArray = 0 as MountArray;
var g_fd:    FDArray    = 0 as FDArray;
```

`vfs_read` などは fd の `fs_type` で if-else ディスパッチする。fd 0/1/2
は標準入出力として UART に直結する特別扱い:

```tinyc
export fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32 {
    if fd < 3 { return do_uart_read(buf as u32, n); }
    var e: FD = get(g_fd, fd);
    var t: i32 = fs_type(e);
    var inner: i32 = inner(e);
    if t == 1 { return mtfs_read(inner, buf, n); }
    if t == 2 { return tmpfs_read(inner, buf, n); }
    if t == 3 { return devfs_read(inner, buf, n); }
    if t == 4 { return procfs_read(inner, buf, n); }
    return -1;
}
```

`fs_type(e)` / `inner(e)` は struct 宣言で自動生成されるゲッター
(`docs/language.md` の「構造体」参照)。

FS を増やすたびに分岐を追加する必要はあるが、数が少ないので許容する。

パスの先頭で委譲先を決定する:

- `/tmp/...` → tmpfs
- `/dev/...` → devfs
- `/proc/...` → procfs
- それ以外 → MyTinyFS (mtfs)

### exec 用の XIP アドレス取得 API

Flash 上の mtfs は XIP なので、ファイル内容が Flash ROM の物理アドレスに
そのまま現れる。exec / ローダが「ファイル内容の先頭アドレスをそのまま
ジャンプ先にしたい」ケース用に以下の API を提供する:

```tinyc
// 成功: XIP 上の物理アドレス (≠0)
// 失敗: 0 (FS が XIP 非対応、fd が開いていない等)
export fn vfs_xip_addr(fd: i32) -> u32
```

- mtfs (Flash) の場合: `flash_base + inode.start_block * block_size`
- tmpfs / devfs / procfs の場合: 0 を返す (コピーして実行する必要あり)

## MyTinyFS (mtfs)

### 方針

- 独自フラット FS（シンプルさ優先）、名前は **MyTinyFS** (mtfs)
- 読み取り専用マウント（Flash の寿命消耗を避ける）
- ディレクトリは複数階層対応（inode に parent を持たせる）
- 開発フェーズでは qemu virt の virtio-blk を backend にして検証し、
  その後 Pico 2 の XIP Flash に差し替える（インタフェースは同じ）

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

inode 番号 0 はルートディレクトリ予約。inode 1 以降を通常ファイル / dir
に使う。1 ブロック = 8 inode。

### ストレージバックエンド

- Pico 2 実機: XIP で直接読み出し（Flash 0x10100000 をそのままアドレス参照）
- qemu virt 開発時: virtio-blk でセクタ単位に読み込み、カーネル側でキャッシュ
- 書き込みは不要（読み取り専用）
- PC でイメージを作成して picotool / qemu `-drive` でロードする

### 実装上の詳細

- **ディレクトリ走査**: まずはルート直下のファイルしか扱わない。
  `parent == 0` の inode を順に見て名前一致したものを返す単純な線形
  スキャンで良い。将来の多階層化に備え、`lookup(parent, name)` の
  シグネチャにしておく。
- **inode キャッシュ**: 最小実装として superblock + inode table 全体を
  カーネル側 `U8Array` にキャッシュする。inode_count が数十なら数 KB で
  済む。将来のサイズ拡大時は on-demand block_read にする。
- **mtfs 内 fd テーブル**: `MtfsFD { inode: i32, offset: i32 }` の
  `MtfsFDArray` を持つ。offset は次回 read の開始位置。size を超えたら
  0 バイト返し。

### mtfs インタフェース

```tinyc
export fn mtfs_mount() -> i32;                         // superblock 読込
export fn mtfs_lookup(parent_inode: u32,
                      name: U8Array, name_len: i32) -> i32;  // inode 番号 / -1
export fn mtfs_open(inode: u32) -> i32;                // mtfs 内の fd / -1
export fn mtfs_read(fd: i32, buf: U8Array, n: i32) -> i32;
export fn mtfs_close(fd: i32) -> i32;
export fn mtfs_size(fd: i32) -> i32;
export fn mtfs_xip_addr(fd: i32) -> u32;               // Flash の場合のみ有効
```

## ブロック層

```tinyc
// kernel/block.tc — signature only (platform ごとに別ファイルで実装)
export fn block_init() -> i32;             // 0 = OK, -1 = device not found
export fn block_sector_size() -> i32;      // 512 固定
export fn block_count() -> u32;            // 総セクタ数
export fn block_read(sector: u32, buf: U8Array) -> i32;   // 512B 読み込み
export fn block_write(sector: u32, buf: U8Array) -> i32;  // Flash では未実装
```

- qemu virt 用: `kernel/block_virtio.tc`（virtio-mmio スキャン、legacy
  mode polling）。
- Pico 2 用: `kernel/block_flash.tc`（XIP アドレスから memcpy 相当）。

### virtio-blk 最小ドライバ計画（qemu virt）

qemu virt は virtio-mmio を 0x10001000 から 8 個並べる。DeviceID=2 が
block デバイス。qemu のデフォルトは modern (v2)。

主な MMIO レジスタ (オフセット):

| Offset | 名前 | 用途 |
|---|---|---|
| 0x000 | MagicValue | `0x74726976` ("virt") |
| 0x004 | Version | 1=legacy, 2=modern |
| 0x008 | DeviceID | 2=block |
| 0x010 | DeviceFeatures | feature bits |
| 0x020 | DriverFeatures | driver ack |
| 0x028 | GuestPageSize (legacy) | 4096 |
| 0x030 | QueueSel | 0 固定 |
| 0x034 | QueueNumMax | 最大 descriptor 数 |
| 0x038 | QueueNum | 実際に使う数 |
| 0x03C | QueueAlign (legacy) | 4096 |
| 0x040 | QueuePFN (legacy) | 物理ページ番号 |
| 0x050 | QueueNotify | sector kick |
| 0x060 | InterruptStatus | IRQ 状態 |
| 0x064 | InterruptACK |  |
| 0x070 | Status | driver state |

最小フロー（polling、IRQ 不使用）:

1. Status ← ACKNOWLEDGE | DRIVER
2. feature bits を確認（legacy は 0 で OK）、Status ← FEATURES_OK
3. Queue 0 を初期化
   - descriptor ring / avail ring / used ring を確保
   - legacy は 4KB アライン 1 ページに [desc|avail|used] を連続配置
   - modern は split virtqueue の 3 領域を別個に配置可（アライン要件は
     16B と緩い）
   - QueueNum ← 8（小さく）
4. Status ← DRIVER_OK
5. 読み書き
   - `virtio_blk_req { type, reserved, sector(u64), data(512B), status }`
     を 3 つの descriptor に分けて書く（header / data / status）
   - `avail.ring[idx] ← desc head`; `avail.idx += 1`; `QueueNotify ← 0`
   - `used.idx` をポーリングで待ち、status バイトを確認

virt マシンでは物理アドレス = 仮想アドレス（ID mapping）なので、TC の
`U8Array` の内部バッファアドレスをそのまま descriptor に書けば OK。
ただし legacy では 4KB アラインが必要な構造体は arena 上で手動アライン
（もしくは専用 BSS）。

**4KB アラインの確保**: `U8Array` は `.length + data` 構造で動的確保では
アライン保証が無い。対策:

- **案 A**: `asm.tc` に `.align 12` (= 4096) を追加し、`.bss` に静的に
  4KB バッファを置く。TC 側は `peek8/poke8` でアクセス。
- **案 B**: 8KB の `U8Array` を確保し、`(addr + 0xFFF) & ~0xFFF` で
  開始位置を決める（TC で手動アライン）。

**案 B を採用**: `asm.tc` を触らずに済む。ただし virtio-modern は 16 バイト
アラインまで緩いので、modern を使えば案 B すら不要。step 2 で DeviceID /
Version を実測してから決める。

## tmpfs

- PSRAM 上の固定領域（2MB）を使用（PSRAM 非搭載環境では SRAM）
- Flash FS と同じ inode ベースの構造をメモリ上で実装
- 書き込み可能、電源断で消える
- `/tmp` 以下のファイルの管理はユーザの責任（カーネルは自動削除しない）

## devfs

カーネルドライバが提供するファイル。通常のファイル操作で読み書きできる。

| パス | 説明 |
|---|---|
| `/dev/uart0` | UART シリアル。`read` で入力、`write` で出力 |
| `/dev/null` | 読むと EOF、書くと捨てる |

標準入出力（fd 0, 1, 2）は起動時に `/dev/uart0` に紐付けられる。

## procfs

カーネル内部の情報をテキストファイルとして提供する。読み取り専用。

| パス | 内容 |
|---|---|
| `/proc/{pid}/status` | pid, state, heap_start, heap_end |
| `/proc/{pid}/maps` | メモリ領域一覧 |
| `/proc/meminfo` | SRAM・PSRAM の使用量 |

## syscall

Linux ABI 準拠。a7 に番号、a0..a5 に引数。

| a7 | name | signature (kernel から見た形) |
|---|---|---|
| 56 | openat | `(dirfd, path_u32, flags) -> fd` |
| 57 | close  | `(fd) -> i32` |
| 63 | read   | 既存（UART → VFS に変更） |
| 64 | write  | 既存（UART → VFS に変更） |
| 93 | exit   | 既存 |

- 初期実装では openat の dirfd / flags は無視（常に AT_FDCWD 扱い、
  フラグは READONLY 固定）。
- path はタスクの null 終端バイト列のアドレスを u32 で受け取り、
  kernel 側で `strnlen` 相当で長さを求める。
- `_ecall_read` / `_ecall_write` は `do_uart_*` を直接呼んでいるので、
  これを `vfs_read` / `vfs_write` に差し替える。fd 0/1/2 の UART
  フォールバックは vfs 側で面倒を見る。

## カーネル内部 API (VFS)

```tinyc
fn vfs_init() -> i32;
fn vfs_open(path: U8Array, path_len: i32, flags: i32) -> i32;
fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32;
fn vfs_write(fd: i32, buf: U8Array, n: i32) -> i32;
fn vfs_close(fd: i32) -> i32;
fn vfs_seek(fd: i32, offset: i32, whence: i32) -> i32;
fn vfs_readdir(fd: i32, buf: U8Array) -> i32;          // 1 エントリずつ
fn vfs_stat(path: U8Array, path_len: i32, out: U8Array) -> i32;
fn vfs_xip_addr(fd: i32) -> u32;                       // exec / loader 用、0=非対応
```

syscall はバッファを `U8Array + len` で受け渡すので、カーネル内部 API も
`String` ではなく `U8Array + len` に揃える。

## 実装フェーズ (本プロジェクトでのフェーズ5、完了)

> **Status:** フェーズ5 は step 1〜9 まで完了。続くフェーズ6 で mtfs 上に
> `/bin/hello`, `/bin/hello2`, `/bin/catfile`, `/bin/sh` 等のゲストタスク
> を配置し、`kernel/loader.tc` + `vfs_xip_addr` 経由で起動する形になった。
> 以下は当時の計画メモを残してある。

### スコープ

- フェーズ5 では **MyTinyFS の read-only マウント** と **最小 VFS 層**
  までを実装する。
- tmpfs / devfs / procfs は別フェーズに回す（VFS のディスパッチ分岐
  だけ用意）。
- ブロック層は qemu virt の virtio-blk で開発し、Pico 2 向け XIP Flash
  バックエンドはフェーズ5 の最後に差し替える。

### 段階的コミット計画

| # | 内容 | 成果物 |
|---|---|---|
| 1 | 設計ドキュメント統合（本書） | docs/filesystem.md |
| 2 | virtio-mmio スキャン | kernel/block_virtio.tc（MagicValue/DeviceID 検出、block_init が TX/RX しない状態で 0 を返す） |
| 3 | virtio-blk queue 初期化 + sector 0 read | kernel/block_virtio.tc 完成、kernel main で sector 0 先頭 16B を hex 出力 |
| 4 | test_fs.sh で qemu に `-drive` を渡して sector 0 出力を golden 比較 | tests/test_fs.sh |
| 5 | tools/mkfs.py + mtfs superblock/inode 作成 | tools/mkfs.py |
| 6 | kernel/mtfs.tc: mount + lookup + read | inode 線形スキャン、root 直下のみ |
| 7 | kernel/vfs.tc + syscall 追加（openat/close + read/write 経路差し替え） | ecall ハンドラ拡張 |
| 8 | kernel/tasks/catfile: `/hello.txt` を読んで UART 出力 | 実動テスト |
| 9 | Pico 2 向け block_flash.tc（XIP memcpy）に差し替え | kernel/block_flash.tc、build.sh で backend 選択 |

各ステップ完了で `make test` / 必要に応じて `make full-test` を走らせる。

### 追加・変更ファイル一覧（予定）

```
kernel/block_virtio.tc   (新規)
kernel/block_flash.tc    (新規、step 9)
kernel/mtfs.tc           (新規)
kernel/vfs.tc            (新規)
kernel/kernel.tc         (main から vfs_init / block_init 呼び出し)
kernel/trap_common.s     (ecall で sys_openat/close/read/write → VFS)
kernel/build.sh          (新しい TC ファイルを投入)
tools/mkfs.py            (新規)
tests/test_fs.sh         (新規)
tests/golden/test_fs/    (出力 golden)
docs/roadmap.md          (フェーズ5 チェック)
```

### テスト方針

- virtio-blk + mtfs は qemu-system-riscv32 起動が必要で数百 ms〜かかる。
- `make test` は 60 秒上限を維持したいので、当面は `FULL_TEST=1` 限定に
  して `tests/test_os.sh` 的な扱いにする。安定したら `make test` 側への
  移動を検討。

#### test_fs.sh の手順

1. `python3 tools/mkfs.py $TMP/disk.img hello.txt greet.txt` でイメージ作成
2. `kernel/build.sh --target virt -o $TMP/kernel_fs.bin`
3. `qemu-system-riscv32 ... -drive file=$TMP/disk.img,format=raw,if=none,id=blk0 -device virtio-blk-device,drive=blk0`
4. kernel がブート時に mount → `/hello.txt` を読んで UART 出力
5. 期待文字列を grep で確認

## 懸念と未決事項

- **virtio-mmio modern vs legacy**: qemu virt のデフォルトは modern (v2)。
  modern は queue buffer のアライン要件が緩い (16B) ので 4KB アライン
  対策が要らなくなる可能性がある。step 2 で実測して判断。
- **`U8Array` 参照の物理アドレス**: `(arr as u32)` は `.length` 先頭。
  データは `+4`。FS / virtio で素直に扱うには薄いラッパを作る。
- **openat の path 長**: syscall は null 終端バイト列（u32 addr）を
  受け取り、kernel 側で `strnlen` 相当で長さを求める方針。
- **fd 割り当ての一意性**: タスク間で共有 fd テーブルにするか、タスク
  ローカルにするかはフェーズ6（プロセス）の話。本フェーズではグローバル
  で OK。
- **runtime.tc の kmalloc と共存**: VFS / mtfs のキャッシュは `__arena`
  から kmalloc することになる。virt は 4.6MB 確保済みなので問題なし。
  Pico 2 は 256KB しかないので、キャッシュサイズを絞る必要がある。
- **Pico 2 向け差し替え**: `block_flash.tc` は同じインタフェース
  (`block_init`/`block_read`) を提供し、build.sh で backend を切り替える。
