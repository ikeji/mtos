# フェーズ5: ファイルシステム設計

## 目的

- qemu virt の virtio-blk でブロックデバイスを操作し、その上に独自 FS を
  構築する。
- カーネルに `fs_open/read/write/close` + syscall の `sys_openat/close` を
  追加し、タスクからファイルを読み書きできるようにする。
- 後日 Pico 2 の QSPI Flash ドライバに差し替えられるよう、ブロック層を
  抽象化しておく。

## 全体構成

```
  task (ecall)
       │
       ▼  sys_openat / sys_read / sys_write / sys_close
  kernel ecall handler (trap_common.s)
       │
       ▼  fs_open / fs_read / fs_write / fs_close (TC)
  fs layer  (kernel/fs.tc)
       │
       ▼  block_read / block_write  (TC)
  block layer  (kernel/block_virtio.tc  or  kernel/block_flash.tc)
       │
       ▼  MMIO
  virtio-blk   (qemu virt)     or    QSPI Flash (Pico 2)
```

段階的に下から積む:

1. ブロック層 (virtio-blk) だけで「セクタ 0 を読んで先頭数バイトを hex 出力」
2. 独自 FS の設計 + mkfs.py でイメージ作成
3. fs.tc で read-only マウント + fs_open/fs_read
4. タスクから sys_openat/sys_read/sys_close で `/hello.txt` を読んで出力
5. fs_write/sys_write (書き込み) 対応
6. Pico 2 向けの block_flash.tc に差し替え (フェーズ5の最後 or 別フェーズ)

各段階を個別にコミットし、`make test` が通る状態を維持する。

## ブロック層インタフェース

```tinyc
// kernel/block.tc (共通シグネチャ、実装は virtio / flash で別ファイル)
export fn block_init() -> i32;             // 0 = OK
export fn block_count() -> u32;            // 総セクタ数
export fn block_read(sector: u32, buf: U8Array) -> i32;
export fn block_write(sector: u32, buf: U8Array) -> i32;
// buf は 512 バイト固定 (セクタサイズ)
```

セクタサイズは 512 固定。FS 層がブロックサイズを変えたくなったら倍数として
扱う。

## virtio-blk ドライバ (qemu virt)

qemu virt は virtio-mmio を 0x10001000 から 8 個並べる。deviceID=2 が
block。最小のレガシー (legacy virtio) モードを使う。

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

最小フロー (polling、IRQ 不使用):

1. Status ← ACKNOWLEDGE | DRIVER
2. features 読み、使える分だけ DriverFeatures に書く (legacy は 0 で OK)
3. Status ← FEATURES_OK
4. Queue 0 を初期化
   - descriptor ring / avail ring / used ring を確保
   - legacy は単一ページ (4KB) に [desc|avail|used] を連続配置
   - QueueNum ← 8 (小さく)
   - QueuePFN ← (queue 物理アドレス >> 12)
5. Status ← DRIVER_OK
6. 読み書き
   - virtio_blk_req { type, reserved, sector(u64), data(512B), status } を
     3 つの descriptor に分けて書く (header / data / status)
   - avail.ring[idx] ← desc head ; avail.idx += 1 ; QueueNotify ← 0
   - used.idx をポーリングで待つ ; status バイトを確認

virt マシンでは物理アドレス = 仮想アドレス (ID mapping) なので、TC の
`U8Array` の内部バッファアドレスをそのまま descriptor に書けば OK。
ただし 4KB アラインが必要な構造体は arena 上で手動アライン (or 専用 BSS)。

- まずは **read のみ** で動かす
- 書き込みは read が通ってから

### スキャンについて

virt は 8 個の virtio-mmio スロットがあるので、`0x10001000`, `0x10002000`,
... と順に MagicValue/DeviceID をチェックして block (DeviceID=2) を探す。
qemu のコマンドラインで `-drive file=disk.img,format=raw,if=none,id=blk0
-device virtio-blk-device,drive=blk0` を付けた時だけ見つかる想定。

## FS 設計 (tcfs v1)

### レイアウト

```
+---------+---------+-----------+-----------------+
| sb (1)  | ent (N) | data (M)  |                 |
| 512B    |         |           |                 |
+---------+---------+-----------+-----------------+
block 0   block 1..  block K..
```

### Superblock (block 0)

| offset | size | 名前 | 説明 |
|---|---|---|---|
| 0 | 4 | magic | `0x54434653` = "TCFS" |
| 4 | 4 | version | 1 |
| 8 | 4 | block_count | 全ブロック数 |
| 12| 4 | entry_count | file entry 数 |
| 16| 4 | entry_blocks | ディレクトリエントリ占有ブロック数 |
| 20| 4 | data_start | データブロック開始位置 (block index) |
| 24 | 488 | reserved | 0 埋め |

### ディレクトリエントリ (block 1..entry_blocks)

固定 32 バイト/エントリ、16 エントリ/ブロック。

| offset | size | 名前 |
|---|---|---|
| 0 | 24 | name (NUL 終端) |
| 24 | 4 | size (バイト数) |
| 28 | 4 | start_block (データブロック番号、0 = 空きスロット) |

単一ディレクトリ (root 固定)、サブディレクトリなし。

### データ領域

- 各ファイルは **連続配置**。start_block から size/512 (切り上げ) ブロック。
- 書き込みで追記・更新する場合は先頭からリフレッシュする単純実装を想定。
- 断片化するほど多くのファイルを扱う段階になったらブロックマップに拡張。

### 制限

- 最大ファイル数: `entry_blocks * 16`。初期は 1 ブロック (16 ファイル) で十分。
- 最大ファイルサイズ: データ領域全体。
- 追加・削除は全スキャンで対応。

## mkfs.py (ホスト PC)

Python スクリプトで:
- superblock を埋める
- ディレクトリエントリを詰める
- データを後ろに連続配置
- 余りは 0 埋め
- 出力をファイルに書き、qemu の `-drive file=...` に渡せるようにする

```
python3 tools/mkfs.py disk.img hello.txt greet.txt ...
```

## fs.tc レイヤ

```tinyc
// kernel/fs.tc
export fn fs_mount() -> i32;                     // superblock を読む
export fn fs_count() -> i32;                     // 登録ファイル数
export fn fs_name(idx: i32, out: U8Array) -> i32;
export fn fs_size(idx: i32) -> i32;

export fn fs_open(path: U8Array, path_len: i32) -> i32;   // fd (-1 失敗)
export fn fs_read(fd: i32, buf: U8Array, len: i32) -> i32;
export fn fs_close(fd: i32) -> i32;

export fn fs_write(fd: i32, buf: U8Array, len: i32) -> i32; // 後日
```

- **オープンテーブル** はカーネル内グローバル: 最大 8 個まで。
- `sys_read(fd, ...)` は fd=0 を UART、fd>=3 を FS に振り分ける (簡易実装)。
- フェーズ6 以降で `current task` ごとの fd テーブルに拡張する。

## syscall 追加

Linux ABI 準拠。a7 に番号、a0..a5 に引数。

| a7 | name | signature |
|---|---|---|
| 56 | openat | `openat(dirfd: i32, path: U8Array, flags: i32) -> i32` |
| 57 | close | `close(fd: i32) -> i32` |
| 63 | read | 既存 |
| 64 | write | 既存 |
| 93 | exit | 既存 |

初期実装は openat の dirfd / flags は無視。

## 変更ファイル一覧 (予定)

- `kernel/block_virtio.tc`      : virtio-mmio スキャン + blk ops
- `kernel/fs.tc`                : tcfs マウント / read
- `kernel/kernel.tc`            : main で block_init/fs_mount
- `kernel/trap_common.s`        : ecall に openat/close ディスパッチ追加
- `kernel/platform_virt.s`      : do_fs_open/read/close ブリッジ (TC 呼び出し)
- `tools/mkfs.py`               : ホスト側 mkfs
- `tests/test_fs.sh`            : disk.img を作って kernel を qemu で実行
- `docs/roadmap.md`             : 進捗更新

## テスト方針

### test_fs.sh

1. `tools/mkfs.py /tmp/disk.img hello.txt greet.txt` で disk image 作成
2. `kernel/build.sh --target virt` で kernel.bin ビルド
3. qemu で kernel.bin を起動、`-drive file=/tmp/disk.img,...` で virtio-blk
4. kernel main でファイル一覧を UART に出力し、`hello.txt` の内容を出力
5. 期待される出力を golden 比較

`make test` の対象に入れるか `make full-test` 限定にするかは実行時間を見て
決める (最初は full-test 限定にして様子見)。

## 段階的コミット計画

| # | 内容 | 成果物 |
|---|---|---|
| 1 | 設計ドキュメント (本書) | docs/task/filesystem.md |
| 2 | virtio-blk 最小 driver (read のみ) | kernel/block_virtio.tc、MagicValue 検出 + sector 0 読み |
| 3 | disk image を qemu に渡し、sector 0 を hex 出力するテスト | tests/test_virtio.sh |
| 4 | tcfs 設計実装 + mkfs.py | tools/mkfs.py |
| 5 | fs.tc マウント + ファイル一覧出力 | kernel/fs.tc |
| 6 | fs_open/fs_read (sys_openat/close/read wiring) | ecall handler 拡張 |
| 7 | タスク hello3 で `/hello.txt` を読んで UART 出力 | kernel/tasks/hello3 |
| 8 | fs_write + sys_write 拡張 | |
| 9 | (別機会) Pico 2 QSPI Flash ドライバ | kernel/block_flash.tc |

各ステップ完了で `make test` を走らせ、golden 破壊がないか確認する。

## 懸念点

- **4KB アライン**: virtio-legacy の queue buffer は 4KB アラインが必要。
  `U8Array` の内部は `.length + data` 形式なのでアライン保証がない。
  → `.bss` に 4KB アラインの静的バッファを持ち、asm.tc で `.align 12` を
  サポートする必要がある。現状 asm.tc は `.align 4` (= 16 byte) までの
  サポートなので、`.align` ディレクティブの拡張か、専用の `.queue` セクション
  を追加する必要があるかも。
- **U8Array 参照の物理アドレス**: `(arr as u32)` は `.length` 先頭。data は
  `+4`。FS/virtio で素直に扱うには薄い wrapper を作る。
- **カーネル RAM 制約**: virtio queue + FS キャッシュ + タスク RAM を
  __arena の 4.6MB に収める必要がある。virt なら余裕だが Pico 2 (256KB)
  の 将来を考えて FS キャッシュは最小化する。
- **Pico 2 向けの差し替え**: block_flash.tc は今回のフェーズでは実装しない
  が、インタフェースが同じなら将来差し替え可能になるよう設計を分離する。
