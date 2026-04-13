# フェーズ5: ファイルシステム実装計画

全体設計は `docs/filesystem.md` を参照。本書はその設計を実装に落とすための
段階的な作業計画と、実装上の細かい判断をまとめる。

## スコープ

- `docs/filesystem.md` のうち、**MyTinyFS (mtfs) の read-only マウント**
  と **最小 VFS 層** までをフェーズ5 で実装する。
- tmpfs / devfs / procfs は別フェーズに回す (VFS のディスパッチだけ用意)。
- ブロック層は qemu virt の **virtio-blk** で開発し、Pico 2 の XIP Flash
  バックエンドは本フェーズの最後に差し替える。

## アーキテクチャ (本フェーズの範囲)

```
  task (ecall)
       │  sys_openat(56) / sys_read(63) / sys_write(64) / sys_close(57)
       ▼
  trap_common.s  (ecall ハンドラを TC 呼び出しにブリッジ)
       │
       ▼  vfs_open / vfs_read / vfs_close / vfs_xip_addr
  kernel/vfs.tc                   ← mount table + fd table + ディスパッチ
       │
       ▼  mtfs_open / mtfs_read
  kernel/mtfs.tc                  ← superblock / inode スキャン
       │
       ▼  block_read(sector, buf)
  kernel/block_virtio.tc          (virt)
  kernel/block_flash.tc           (pico2、本フェーズ最後)
       │
       ▼  MMIO
  virtio-blk @ 0x10001000〜       or   XIP Flash @ 0x10100000〜
```

## インタフェース

### block 層

```tinyc
// kernel/block.tc — signature only (platform ごとに別ファイルで実装)
export fn block_init() -> i32;             // 0 = OK, -1 = device not found
export fn block_sector_size() -> i32;      // 512 固定
export fn block_count() -> u32;            // 総セクタ数
export fn block_read(sector: u32, buf: U8Array) -> i32;   // 512B 読み込み
export fn block_write(sector: u32, buf: U8Array) -> i32;  // Flash では未実装
```

qemu virt 用: `kernel/block_virtio.tc` (virtio-mmio スキャン、legacy mode
polling)。

Pico 2 用: `kernel/block_flash.tc` (XIP アドレスから memcpy 相当)。

### mtfs 層

```tinyc
// kernel/mtfs.tc
export fn mtfs_mount() -> i32;                         // superblock 読込
export fn mtfs_lookup(parent_inode: u32,
                      name: U8Array, name_len: i32) -> i32;  // inode 番号 / -1
export fn mtfs_open(inode: u32) -> i32;                // mtfs 内の fd / -1
export fn mtfs_read(fd: i32, buf: U8Array, n: i32) -> i32;
export fn mtfs_close(fd: i32) -> i32;
export fn mtfs_size(fd: i32) -> i32;
export fn mtfs_xip_addr(fd: i32) -> u32;               // Flash の場合のみ有効
```

### VFS 層

```tinyc
// kernel/vfs.tc
export fn vfs_init() -> i32;
export fn vfs_open(path: U8Array, path_len: i32, flags: i32) -> i32;
export fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32;
export fn vfs_write(fd: i32, buf: U8Array, n: i32) -> i32;
export fn vfs_close(fd: i32) -> i32;
```

- fd 0,1,2 は VFS 側で UART にデフォルト割り当て (fd 0/1/2 が来たら
  既存の do_uart_read / do_uart_write にフォールバック)。
- fd 3 以降が本来の open で割り当てられる。
- 本フェーズでは max_fd = 16 程度で十分。

## MyTinyFS 実装詳細

### ディレクトリ走査

- 本フェーズは **ルート直下** のファイルしか扱わない。
- `parent == 0` の inode を順に見て名前一致したものを返す、という
  単純な線形スキャンで良い。
- 将来の多階層化に備え、`lookup(parent, name)` シグネチャにしておく。

### inode キャッシュ

- 最小実装: superblock + inode table 全体をカーネル側 U8Array にキャッシュ。
  inode_count が数十なら数 KB で済む。
- 将来のサイズ拡大時は on-demand block_read にする。

### fd テーブル (mtfs 内)

```tinyc
var g_mtfs_fd_inode:  I32Array = ...;   // -1 = 空き
var g_mtfs_fd_offset: I32Array = ...;
```

offset は次回 read の開始位置。サイズを超えたら 0 バイト返し。

## VFS ディスパッチ

TC に関数ポインタが無いので、fd テーブルに `fs_type` を持たせて
if-else 分岐する (docs/filesystem.md と同方針)。

```tinyc
// fs_type 定数
//   0 = UART (stdio 用特別扱い)
//   1 = mtfs
//   2 = tmpfs  (本フェーズ未実装、分岐だけ用意)
//   3 = devfs  (未)
//   4 = procfs (未)

var g_fd_type:  I32Array = ...;
var g_fd_inner: I32Array = ...;   // 各 FS 内の fd

export fn vfs_read(fd: i32, buf: U8Array, n: i32) -> i32 {
    if fd < 3 { return do_uart_read(buf as u32, n); }
    var t: i32 = get(g_fd_type, fd);
    var inner: i32 = get(g_fd_inner, fd);
    if t == 1 { return mtfs_read(inner, buf, n); }
    return -1;
}
```

## syscall 追加

Linux ABI 準拠:

| a7 | name | signature (kernel から見た形) |
|---|---|---|
| 56 | openat | `(dirfd, path_u32, flags) -> fd` |
| 57 | close  | `(fd) -> i32` |
| 63 | read   | 既存 (UART → VFS に変更) |
| 64 | write  | 既存 (UART → VFS に変更) |
| 93 | exit   | 既存 |

- 初期実装では openat の dirfd / flags は無視 (常に AT_FDCWD 扱い、
  フラグは READONLY 固定)。
- path はタスクの U8Array のアドレス。カーネル側はそのままバイト列として
  読む (virt は ID マップなので翻訳不要)。
- kernel 側 `_ecall_read` / `_ecall_write` は `do_uart_*` を呼んでいる。
  これを `vfs_read__i32__u32__i32` 相当 (TC) に差し替える。fd=1,2 の
  UART フォールバックは vfs 側で面倒を見る。

## virtio-blk 最小ドライバ計画

1. `0x10001000..0x10008000` を走査して DeviceID=2 の MMIO 領域を見つける
2. Version=1 (legacy) / Version=2 (modern) どちらで来るか確認 → まずは
   qemu virt 既定 (modern) を想定
3. queue 0 を 8 descriptor で初期化
   - legacy: 4KB アライン 1 ページに desc/avail/used を連続配置
   - modern: split virtqueue の 3 領域を別個に配置可
4. 1 read request を投げて polling で完了を待つ
5. status バイトを確認

### 4KB アラインの確保

`U8Array` は `.length + data` 構造 (先頭 +4 にデータ) なので、動的確保では
アライン保証ができない。対策:

- **案A**: `asm.tc` に `.align 12` (= 4096) を追加し、`.bss` に静的に
  4KB バッファを置く。TC 側は `peek8/poke8` でアクセス。
- **案B**: 大きめの U8Array を確保し、先頭から 4KB 境界までの余白を
  スキップして使う (TC で手動アライン)。

**案B を採用**: asm.tc を触らずに済む。8KB の U8Array を確保し、
`(addr + 0xFFF) & ~0xFFF` で開始位置を決める。

この方針で進めるが、virtio-modern は 16 バイトアラインまで緩いので
modern を使えば案B すら不要かもしれない。先に DeviceID / Version を
見てから決める。

## 段階的コミット計画

| # | 内容 | 成果物 |
|---|---|---|
| 1 | 本フェーズの計画書 (本書更新) | docs/task/filesystem.md |
| 2 | virtio-mmio スキャン | kernel/block_virtio.tc: MagicValue/DeviceID 検出、`block_init` が TX/RX しない状態で 0 を返す |
| 3 | virtio-blk queue 初期化 + sector 0 read | kernel/block_virtio.tc 完成、kernel の main で sector 0 先頭 16B を hex 出力 |
| 4 | test_fs.sh で qemu に `-drive` を渡して sector 0 出力を golden 比較 | tests/test_fs.sh |
| 5 | tools/mkfs.py + mtfs superblock/inode 作成 | tools/mkfs.py |
| 6 | kernel/mtfs.tc: mount + lookup + read | inode 線形スキャン、root 直下のみ |
| 7 | kernel/vfs.tc + syscall 追加 (openat/close + read/write 経路差し替え) | ecall ハンドラ拡張 |
| 8 | kernel/tasks/catfile: `/hello.txt` を読んで UART 出力 | 実動テスト |
| 9 | Pico 2 向け block_flash.tc (XIP memcpy) に差し替え | kernel/block_flash.tc、build.sh で backend 選択 |

各ステップ完了で `make test` / 必要に応じて `make full-test` を走らせる。

## ファイル追加・変更一覧 (予定)

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

## テスト方針

### 速さ優先: 本フェーズ中は `make full-test` 側に置く

- virtio-blk + mtfs は qemu-system-riscv32 起動が必要で数百 ms〜かかる
- `make test` は 60 秒上限を維持したいので、当面は `FULL_TEST=1` 限定にする
- 安定したら `make test` に移動を検討

### test_fs.sh の手順

1. `python3 tools/mkfs.py $TMP/disk.img hello.txt greet.txt` で image 作成
2. `kernel/build.sh --target virt -o $TMP/kernel_fs.bin`
3. `qemu-system-riscv32 ... -drive file=$TMP/disk.img,format=raw,if=none,id=blk0 -device virtio-blk-device,drive=blk0`
4. kernel がブート時に mount → `/hello.txt` を読んで UART 出力
5. 期待文字列を grep で確認

## 懸念と未決事項

- **virtio-mmio modern vs legacy**: qemu virt のデフォルトは modern (v2)。
  modern は queue buffer のアライン要件が緩い (16B) ので案B が要らなく
  なる可能性がある。step 2 で実測して判断。
- **openat の path 長**: タスク側で null 終端 String を渡すか、
  `U8Array + len` を渡すか統一する必要がある。OS syscall ABI としては
  null 終端の方が Linux 寄り。ただし TC の String は `.buf + .len + .lit`
  のヒープオブジェクトなので、ユーザ側から渡しやすいのは U8Array。
  **方針**: syscall は null 終端バイト列 (u32 addr) を受け取り、
  kernel 側で `strnlen` 相当で長さを求める。
- **fd 割り当ての一意性**: タスク間で共有 fd テーブルにするか、タスク
  ローカルにするかはフェーズ6 (プロセス) の話。本フェーズではグローバル
  で OK。
- **runtime.tc の kmalloc と共存**: VFS / mtfs のキャッシュは __arena
  から kmalloc することになる。virt は 4.6MB 確保済みなので問題なし。
