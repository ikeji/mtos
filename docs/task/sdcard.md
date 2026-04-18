# SD カード (SPI) 接続計画

## 目的

Pico 2 に SD カードを SPI 接続し、永続ストレージとして使う。

- K7 解決: tmpfs (SRAM kmalloc) の代わりに SD 上に中間ファイルを
  書くことで SRAM 480 KB の制約を回避。コンパイラパイプラインを
  順次実行 (1 タスクずつ) すれば各タスクの arena だけで済む
- 永続ストレージ: SD カードに書いたファイルは電源を切っても残る
- PC 互換: FAT32 なので PC から SD カードを直接読める

## ハードウェア

### 使用ペリフェラル

- **SPI0** (RP2350)
- ベースアドレス: `0x40080000`

### ピン配置

| 信号       | GPIO  | Pico 2 ピン | FUNCSEL | SD カード側 |
|------------|-------|-------------|---------|-------------|
| MISO (RX)  | GPIO4 | Pin 6       | 1       | DO          |
| CS         | GPIO5 | Pin 7       | (GPIO)  | CS          |
| SCK        | GPIO6 | Pin 9       | 1       | CLK         |
| MOSI (TX)  | GPIO7 | Pin 10      | 1       | DI          |
| 3V3        | —     | Pin 36      | —       | VCC         |
| GND        | —     | Pin 8       | —       | GND         |

CS は SPI ハードウェア CS ではなく GPIO 出力で制御する
(SD カードプロトコルの要件上、ソフトウェア CS が一般的)。

### 配線図

```
Pico 2                SD Card Module
──────                ──────────────
Pin 36 (3V3)  ───────  VCC
Pin 6  (GP4)  ───────  DO  (MISO)
Pin 7  (GP5)  ───────  CS
Pin 8  (GND)  ───────  GND
Pin 9  (GP6)  ───────  CLK
Pin 10 (GP7)  ───────  DI  (MOSI)
```

### 注意事項

- SD カードモジュールは 3.3V ロジックのものを使う (RP2350 は 3.3V IO)
- GPIO0 (UART TX) / GPIO1 (UART RX) とは干渉しない
- Debug Probe の SWD ピンとも干渉しない

## ファイルシステム: FAT32

### 方針

- OS が FAT32 を read/write する
- PC からは read-only で使う (標準の FAT32 として認識される)
- 8.3 ファイル名のみ (LFN 非対応)
- サブディレクトリ 1 階層対応

### OS 側の書き込み戦略

書き込みサイズが事前にわからない (コンパイラ出力はストリーム) ため、
1 クラスタずつ追記して FAT チェーンを繋ぐ:

1. ファイル open (O_CREAT): ディレクトリエントリを作成、クラスタ未割当
2. 最初の write: 空きクラスタを 1 つ確保、FAT にマーク、データ書き込み
3. クラスタ境界を超える write: 次の空きクラスタを確保、FAT チェーンで
   前クラスタと繋ぐ
4. close: ディレクトリエントリにファイルサイズを書き込み

OS が書いたファイルは**なるべく連続クラスタ**になるが、削除で穴が空くと
フラグメントする可能性がある。read 時は FAT チェーンを辿るので問題ない。

### OS 側の読み込み

FAT チェーンを辿って読む:

1. ディレクトリエントリから先頭クラスタ番号とサイズを取得
2. FAT テーブルで次のクラスタを辿りながらセクタ単位で読む
3. EOF (FAT エントリ >= 0x0FFFFFF8) で終了

### 削除

1. FAT チェーンを辿って全エントリを 0 にする
2. ディレクトリエントリの先頭バイトを 0xE5 にする

### オンディスク構造

標準 FAT32 フォーマット。PC で `mkfs.fat -F 32` した SD カードを
そのまま使える:

```
セクタ 0          MBR (パーティションテーブル)
                  └→ パーティション 1 開始セクタ
セクタ N          BPB (BIOS Parameter Block) / Boot Sector
セクタ N+1..      予約領域 (BPB.RsvdSecCnt)
セクタ N+R        FAT 1 (BPB.FATSz32 セクタ)
セクタ N+R+F      FAT 2 (バックアップ、書き込み時は両方更新)
セクタ N+R+2F     データ領域 (クラスタ 2 から開始)
                  └→ クラスタ 2 = ルートディレクトリ (BPB.RootClus)
```

### BPB から必要な情報

| オフセット | サイズ | フィールド          | 用途                        |
|-----------|--------|--------------------|-----------------------------|
| 0x00B     | 2      | BytsPerSec         | セクタサイズ (通常 512)       |
| 0x00D     | 1      | SecPerClus          | クラスタあたりセクタ数        |
| 0x00E     | 2      | RsvdSecCnt          | 予約セクタ数                 |
| 0x010     | 1      | NumFATs             | FAT の数 (通常 2)            |
| 0x024     | 4      | FATSz32             | FAT 1 つあたりのセクタ数     |
| 0x02C     | 4      | RootClus            | ルートディレクトリのクラスタ  |
| 0x1FE     | 2      | Signature           | 0xAA55 (検証用)              |

### ディレクトリエントリ (32 バイト)

| オフセット | サイズ | フィールド     | 内容                      |
|-----------|--------|---------------|---------------------------|
| 0x00      | 8      | Name           | ファイル名 (スペース埋め)   |
| 0x08      | 3      | Ext            | 拡張子 (スペース埋め)       |
| 0x0B      | 1      | Attr           | 属性 (0x10=dir, 0x20=file) |
| 0x14      | 2      | FstClusHI      | 先頭クラスタ上位 16 bit     |
| 0x1A      | 2      | FstClusLO      | 先頭クラスタ下位 16 bit     |
| 0x1C      | 4      | FileSize       | ファイルサイズ (バイト)     |

### SRAM 使用量

カーネル側で必要な SRAM:
- BPB パラメータ: ~20 バイト (グローバル変数)
- セクタバッファ: 512 バイト × 1〜2 (read/write 用)
- FD 構造体: ~20 バイト × fd 数

FAT テーブル自体は SD 上にあるので SRAM に載せない。
クラスタ辿りのたびに FAT セクタを読む (遅いが SRAM 節約)。

## 実装ステップ

### Step 1: SPI ドライバ (platform_pico2.s)

- RESETS で SPI0 のリセット解除
- SPI0 の SSPCR0/SSPCR1 で 8bit, SPI mode 0, 400 kHz (初期化用)
- GPIO4-7 の FUNCSEL 設定、GPIO5 は GPIO 出力 (CS)
- `spi_xfer(tx) -> rx`: 1 バイト送受信
- `sd_cs_low()` / `sd_cs_high()`: CS 制御
- 初期化後に SCK を数 MHz に上げる

### Step 2: SD カードドライバ (kernel/block_sd.tc)

SPI モードでの SD カード初期化と読み書き:

- 初期化シーケンス:
  1. 74 クロック以上 CS=H で送出 (カード起動)
  2. CMD0 (GO_IDLE_STATE) → R1=0x01
  3. CMD8 (SEND_IF_COND, 0x1AA) → R7 で電圧確認
  4. ACMD41 (SD_SEND_OP_COND, HCS=1) → R1=0x00 まで繰り返し
  5. CMD58 (READ_OCR) → CCS bit で SDHC/SDXC 判定
  6. SCK を高速に切り替え
- セクタ read: CMD17 (READ_SINGLE_BLOCK)
- セクタ write: CMD24 (WRITE_BLOCK)
- SDHC/SDXC はセクタアドレス、SD はバイトアドレス

### Step 3: FAT32 ドライバ (kernel/fatfs.tc)

- `fatfs_mount()`: MBR → パーティション → BPB 読み込み、パラメータ保存
- `fatfs_open(path, flags)`: ディレクトリエントリ検索/作成
- `fatfs_read(fd, buf, len)`: FAT チェーンを辿ってクラスタ単位で読む
- `fatfs_write(fd, buf, len)`: クラスタ追記、FAT 更新
- `fatfs_close(fd)`: ディレクトリエントリにサイズ書き戻し
- `fatfs_delete(path)`: FAT チェーン解放 + エントリ 0xE5
- `fatfs_readdir(path)`: ディレクトリ列挙

### Step 4: VFS 統合

- `/sd/` マウントポイントで VFS に統合
- `FS_FATFS` タイプを追加
- sh から `parse > /sd/1.ast` のように使える

### Step 5: virt 対応 (テスト用)

- virt では virtio-blk に FAT32 イメージをマウント
- SD SPI ドライバの代わりに virtio block read/write を使う
- `block_sd.tc` と `block_virtio.tc` を同じインターフェースで抽象化
- `make test` で FAT32 read/write を自動テスト可能にする

## テスト計画

1. **Step 2 完了後**: SD カード初期化 + 1 セクタ read/write の smoke test
2. **Step 3 完了後**: PC で `mkfs.fat` した SD にファイルを置き、
   OS で `cat /sd/hello.txt` して読めることを確認
3. **Step 3 write 完了後**: OS で `echo hello > /sd/test.txt` して
   PC で SD カードを読んで中身を確認
4. **Step 5 完了後**: `make test` に FAT32 テストを追加
5. **K7 検証**: コンパイラパイプラインを `/sd/` 経由で実行
