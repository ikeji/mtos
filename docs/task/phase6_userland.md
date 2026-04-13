# フェーズ6: ユーザランド基盤 実装計画

`docs/roadmap.md` のフェーズ6「ユーザランド基盤」を段階的に実装するための
作業計画。フェーズ5 (ファイルシステム) が完了し、mtfs + VFS + catfile
ゲストタスクまで動いている状態からの続き。

## 現状

- hello / hello2 / catfile の 3 タスクがカーネル `.rodata` に `bin2s.sh`
  で焼き込まれ、起動時に `_task_<name>_addr()` で位置を取って
  `make_task` で RAM を確保・実行される。
- 各タスクは自前の `main` + `task_crt0.s` (ecall スタブ) で動き、
  `str_u8_nul` / `write_lit` 相当のヘルパが各 `.tc` に複製されている。
- mtfs は読み取り専用マウントで、`vfs_open`/`vfs_read` からファイルを
  読める。ただし「プログラムを FS から起動する」経路はない。
- `docs/filesystem.md` で `vfs_xip_addr(fd) -> u32` / `mtfs_xip_addr` を
  exec / ローダ向けに予約済みだが、実装はまだ無い。

## ゴール

ユーザランドを **「FS 上のファイル → loader → 実行」** の流れに寄せる。
最終的には Pico 2 / virt の両方で、シェルに `hello` と打つとファイル
システムから `/bin/hello` を読んで実行できる状態を目指す。

- 最小限 libc 相当の共有ライブラリ (`libtc`)
- ゲストプログラムを mtfs に格納
- `sys_exec(path)` + カーネル側ローダ (`vfs_xip_addr` を活用)
- 最小シェル
- (オプション) `sys_wait` による親子同期

`fork` は当面実装しない。`exec` が新しいアドレス空間を作る設計にしておき、
親は呼ぶ前に子の完了を待つ (= 同期 exec) 形で進める。

## ステップ分解

各ステップを 1 コミットで仕上げ、完了ごとに `make test` (60 秒以内)
+ 必要に応じて Pico 2 実機 (`tests/test_pico2.sh`) で動作確認する。

### Step 6.1: libtc 抽出 (refactor)

`kernel/tasks/libtc/libtc.tc` を新設し、以下を集約:

```tinyc
// 文字列リテラルを stdout に書く (既存 write_lit 相当)
export fn puts(s: StringLiteral) -> void;

// 文字列リテラルを U8Array + NUL 付きでコピー (caller が delete)
export fn str_nul(s: StringLiteral) -> U8Array;

// raw バッファ中の NUL 終端位置を返す (read() 結果の長さ計算用)
export fn strlen(buf: U8Array) -> i32;
```

ユーザ空間ライブラリなので関数名にプレフィックスは付けない。タスクの
バイナリはカーネルとは別 ELF/raw bin で、同名シンボルがあってもリンクは
衝突しないので、カーネル側の `kputs` 等と多少名前が被っても問題ない。

`hello.tc` / `hello2.tc` / `catfile.tc` を `import "../libtc/libtc.tc";`
に書き換え、重複ヘルパを削除。動作は全く同じにし、`make test` の
`fs_virtio` テストで `CAT:hello, mtfs` が通ることを確認。

将来 `putint` / `printf` などを足していく前提で置き場を確定させる
リファクタリング中心のステップ。

### Step 6.2: ゲストバイナリを mtfs に格納

現在 `tools/mkfs.py` は単一ファイルしか扱えないので、ディレクトリを
丸ごと取り込める形に拡張する:

```
python3 tools/mkfs.py disk.img rootdir/
```

`rootdir/` 以下の構造を mtfs にそのまま写し、たとえば
`rootdir/bin/hello` なら `/bin/hello` という inode になる。
mtfs 側はまだルート直下の線形スキャンしかサポートしていないので、
最低限ルート直下のサブディレクトリ 1 階層は `parent` フィールドで
解決できるように mtfs.tc / mkfs.py 双方を拡張する。

build フロー:

- `kernel/build.sh` 内で一時ディレクトリを作り、`bin/hello`、
  `bin/hello2`、`bin/catfile`、`hello.txt` をそこに並べてから
  `mkfs.py tmp.img tmproot/` を実行する。
- 既存の single-file 引数との後方互換は不要 (mkfs.py の呼び出し元は
  build.sh と test_os.sh だけなので同時に更新する)。

ターゲット別の取り扱い:

- virt: `fs_virtio` テストが `-drive` で disk イメージを渡す。
  test_os.sh が mkfs.py にビルド済みタスクを含むツリーを渡すように
  変更する。
- pico2: build.sh が mkfs.py で mtfs イメージを作り、現行の
  `bin2s.sh _mtfs_image` 経路で `.rodata` に埋め込む
  (タスク本体は .rodata から消える)。

カーネル側 (`kernel.tc` / `kernel_pico2.tc`) は `_task_*_addr()` の参照を
やめ、mtfs から各タスクを読み込むように変更する。実装の都合上、
Step 6.2 の時点では「カーネル自身がループで `/bin/*` を列挙して
`make_task` に渡す」という最小ローダまで含めるのがわかりやすい。

### Step 6.3: sys_exec + ローダ (vfs_xip_addr 含む)

#### 6.3.1: `vfs_xip_addr` / `mtfs_xip_addr` 実装

`docs/filesystem.md` で予約済みだが未実装だったインタフェースを埋める。

- `mtfs_xip_addr(fd)`: block backend が XIP の場合、
  `flash_base + (data_start_block + inode.start_block) * block_size`
  を返す。Flash backend では `_mtfs_image_addr()` が返すアドレス +
  inode のオフセットで即値が出る。
- `virtio-blk` 側は `mtfs_xip_addr` が常に 0 を返す (XIP 不能)。
- `vfs_xip_addr(fd)`: `fd < 3` は 0、`fd >= 3` は対応する
  `mtfs_xip_addr` を呼ぶ。

バックエンド中立化のため、`block_virtio.tc` / `block_flash.tc` に
`block_xip_base() -> u32` (0 なら XIP 非対応) を追加し、`mtfs.tc` から
呼ぶ形にする。

#### 6.3.2: ローダ

新規モジュール `kernel/loader.tc`:

```tinyc
// path のファイルを load し、新しいタスクフレームを返す。
// 失敗時は 0。
fn loader_load(path_addr: u32) -> u32;
```

ローダの動作:

1. `vfs_open(path)` で fd 取得。
2. `vfs_xip_addr(fd)` が非 0 → その値を `entry` にして RAM にコピー
   せず直接使う (Pico 2 の fast path)。
3. `vfs_xip_addr` が 0 → `vfs_size` 分の RAM を確保し、`vfs_read`
   でコピーして `entry = ram + 0` を使う (virt 経路)。
4. `make_task(entry, ram_size, stack_size)` と同様に新 task 用 RAM /
   stack / frame を確保し、`init_task_frame` を呼ぶ。
5. `vfs_close(fd)`。

タスクのバイナリは `; raw` 出力なので PIC。`.data` は `task_crt0.s`
が実行時に gp 相対でコピーしているため、XIP 直接起動でも問題ない。

#### 6.3.3: `sys_exec` ecall

新 syscall 番号 (例: `221 = SYS_execve` の Linux 互換番号を流用) を
追加する:

```
a7 = 221
a0 = path (NUL 終端, ユーザ空間アドレス)
a1 = argv (当面無視、0 推奨)
a2 = envp (当面無視、0 推奨)
→ a0 = 0 / -1  (成功時は呼び出し元に戻らず子を実行、-1 = エラー)
```

カーネル側ハンドラ (`trap_common.s` の ecall ディスパッチ):

1. `loader_load(path_addr)` で新 frame を作る。
2. 成功したら現 task を DONE マークし (= 同期 exec 相当)、
   scheduler に新 frame を ready で追加。
3. `set_switch_frame` で新 frame に切り替え、`mret` で飛ばす。

同期 exec なので親は戻ってこない。fork/wait が必要になったら後で
別途追加する。

launcher タスクとして、hello/hello2/catfile を順番に exec するだけの
デモを書き、`make test` の fs_virtio テストで従来と同じ UART 出力に
なることを確認する。

### Step 6.4: 最小シェル

`/bin/sh` タスクを実装する:

- プロンプト `$ ` を出す。
- `sys_read(0, buf, n)` で 1 行読み (改行まで)。
- 空白分割で最初のトークンを取り出し、`/bin/<token>` を
  `sys_exec` する。
- 終了したら再びプロンプトへ。

カーネルの起動タスクを launcher から shell に差し替える。
テストでは QEMU virt の stdin に `hello\n` などをパイプで流して
シェル経由起動が動くことを確認する (プリエンプションテストとは別の
テストケースとして追加し、合計で 60 秒以内に収める)。

### Step 6.5: sys_wait (オプション)

`sys_exec` が同期的なので必須ではないが、複数子タスクを並行に走らせたい
場合に備えて `sys_wait(pid) -> i32` を追加する案。スケジューラに
`parent` ポインタを持たせて終了時に起こす。`fork` まで広げると
大工事になるため、本フェーズでは優先度を下げる。

## 既存テストとの整合

- `tests/test_os.sh` の `fs_virtio`:
  - Step 6.2 で mtfs に `/bin/*` を追加しても従来の `FILE:` 出力は
    カーネル側 `cat_hello_txt` が出す。Step 6.3 で launcher に
    切り替えるので期待出力の形が変わる。ここで grep 条件を更新する。
- `tests/test_pico2.sh`:
  - Step 6.3 以降、BLOCK / MTFS / CAT の期待行は同じ内容が出るように
    launcher → catfile の経路で維持する。
- `make test` 60 秒上限:
  - ゲストバイナリの bin2s を 1 本減らせるので、build 時間は概ね
    同じか少し短くなる見込み。

## 関連ドキュメント

- `docs/roadmap.md` フェーズ6
- `docs/filesystem.md` (vfs_xip_addr / mtfs_xip_addr の API 定義)
- `docs/task/kernel_design.md` (スケジューラ・trap frame)
- `docs/task/kernel_platform_split.md` (platform 分離)
