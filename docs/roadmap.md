# 開発ロードマップ

## ブートストラップ戦略

自己ホストを達成するには、以下の順序で処理系を育てる必要がある。

```
ステップ1: インタプリタ（ホストPC上、Cで実装）  [完了]
           独自言語のソースを直接解釈して実行

ステップ2: インタプリタ上でコンパイラを動かす  [完了]
           コンパイラ自体を独自言語で書き、インタプリタで実行
           → RISC-Vアセンブリを出力できるコンパイラが誕生

ステップ3: そのコンパイラで自分自身をコンパイル  [完了]
           独自言語製コンパイラ → ネイティブなコンパイラ実行ファイル
           (Gen2==Gen3 の自己ホスト検証は tests/test_gen3.sh で CI 化)

ステップ3.5: 独自言語製プログラムを実機 RP2350 で直接動かす  [hello 完了]
           asm.tc をセクション並べ替えリンカ化し、gp 相対 la で
           Flash/SRAM 分離に対応。pico2/hello.tc が実機で UART 出力
           するところまで到達。コンパイラ自体を Pico 2 で動かすには
           PSRAM 初期化と typecheck/asm.tc のメモリ削減が未着手。

ステップ4: ネイティブコンパイラでOSをビルド
           OS全体を独自言語で記述し、ネイティブコンパイラでビルド
```

### インタプリタの位置づけ

自己ホスト達成後もインタプリタはリポジトリに残し、**常にテストが通る状態を維持する**。

- コンパイラパイプライン（`parse`→`typecheck`→`codegen`→`bc2asm`）とインタプリタの両方で
  同一テストスイートを走らせ、出力が一致することを確認する
- 言語仕様の変更時はインタプリタも合わせて更新する
- インタプリタはリファレンス実装として、挙動の正しさを確認する基準になる

---

## フェーズ0: 言語仕様と環境整備

- [ ] 独自言語の文法を確定（language.md を固める）
- [x] クロスコンパイル環境構築（riscv64-unknown-elf-gcc, qemu-riscv32）
- [x] QEMU環境構築（`qemu-system-riscv32 -M virt`、`tests/test_asm.sh` で CI 化）
- [x] QEMUでHello World（virt、16550 UART、TC ソースから UART 出力確認）
- [x] RP2350実機でもHello World（`pico2/hello.tc` → `pico2/build.sh` → `pico2/hello.uf2`、実機動作確認）
- [x] hex / binary 整数リテラル (`0xFF`, `0b1010`) サポート
- [x] `shr_u` 論理右シフト opcode 追加（`u32 >> n` が算術シフトになるバグ修正）
- [x] Struct array (`XxxArray`) を parser 合成で完全サポート（asm リンカ経路込み）
- [x] 配列コンストラクタを `u32` サイズに統一 (`XxxArray(n: u32)`)
- [x] trailing comma (struct フィールド / fn パラメータ / 関数呼び出し) サポート
- [x] 本体なし関数宣言 (`fn foo() -> void;`) でアセンブリ関数を呼び出し可能に

## フェーズ1: ツールチェーン基盤（ホストPC上、C実装）

目的: 独自言語のコンパイラを独自言語で書くための足場を作る。
C言語でフルパイプラインを実装し、動作を検証する。

- [x] `parse`: レキサ＋LL(1)パーサ、AST テキストを出力（C実装）
- [x] `typecheck`: 意味解析・型検査、型付きAST テキストを出力（C実装）
- [x] `interp`: 型付きASTをツリーウォーキングで実行（C実装）
- [x] 標準関数のバインディング（print_i32/u32/bool/str, sys_write/read/exit, 配列・文字列操作）
- [x] FizzBuzz等の動作確認
- [x] `codegen`: 型付きAST → スタック機械バイトコード（.bc）生成（C実装）
- [x] `bcrun`: .bcバイトコードインタプリタ（C実装、検証用）
- [x] `bc2asm`: バイトコード → RISC-V 32bit アセンブリ生成（C実装、GAS構文）
- [x] `runtime_syscall.c`: bc2asm出力を動かすC言語ランタイム（ecall直接、libc不要）
- [x] `crt0.s`: ベアメタル起動スタブ
- [x] FizzBuzz を `codegen | bc2asm | riscv64-elf-gcc | qemu-riscv32` で動作確認

## フェーズ2: コンパイラ（独自言語で実装、自己ホスト）

目的: ブートストラップ。コンパイラ自体を独自言語で書く。

**互換性方針**: コンパイラが出力するアセンブリは `riscv32-unknown-elf-as` が読める形式にする。
自作アセンブラ・リンカは GAS/GNU ld の出力と比較しながら開発し、
同じ入力に対して同じオブジェクト・実行ファイルが生成されることを確認する。

- [x] `parse.tc`: レキサ＋LL(1)パーサ（独自言語で実装）
- [x] `typecheck.tc`: 意味解析・型検査・オーバーロード解決（独自言語で実装）
- [x] `codegen.tc`: 型付きAST → バイトコード生成（独自言語で実装、ストリーミング処理）
- [x] `bcrun.tc`: バイトコードインタプリタ（独自言語で実装、デバッグ・検証用）
- [x] `bc2asm.tc`: バイトコード → RISC-V アセンブリ生成（独自言語で実装）
- [x] インタプリタ上で各ツールを動かし、パイプラインを通してRISC-Vアセンブリを出力
- [x] 出力アセンブリを `riscv64-unknown-elf-gcc` でアセンブルして qemu-riscv32 で動作確認
- [x] アセンブラ兼リンカ `asm.tc` を実装（セクション並べ替え、gp 相対 la、
      PIC、`; raw` / `; load_base` ディレクティブ、自動 `__global_pointer$`）
- [x] `compile-gen2.sh` (Gen1 parse + Gen2 via qemu) で TC ソースを RV32 ELF/raw に
- [x] `compile-gen3.sh` で Gen3 (= Gen2 がコンパイルした Gen2) を生成
- [x] 自己コンパイル検証 (`tests/test_gen3.sh` が Gen2 == Gen3 の BC/ASM 一致を CI で検証)
- [x] `tests/test_asm.sh` で TC ソースから qemu-system-riscv32 -M virt での end-to-end 検証

## フェーズ2.5: TC プログラムを Pico 2 実機で動かす

目的: OS なしで TC プログラムがベアメタル Pico 2 で走る最小構成を先に
通しておき、Flash/SRAM 分離、picobin IMAGE_DEF、UART、メモリアロケータ
のどこに落とし穴があるかを洗い出す。

- [x] picobin IMAGE_DEF ブロック (RP2350 RISC-V family ID 0xE48BFF5A)
- [x] `pico2/crt0_pico2.s`: core1 park、XOSC/clk_peri/RESETS/GPIO/UART0 初期化
- [x] SRAM ゼロクリア、gp 設定、runtime_init 呼び出し
- [x] `pico2/crt0_pico2_data.s`: .bss (__arena)
- [x] `compile-pico2.sh`: compile-gen2.sh に `ASM_PROLOGUE="; raw"` + crt0 差し替え
- [x] `pico2/bin2uf2.py`: raw bin → UF2 (family_id=0xe48bff5a)
- [x] `pico2/hello.tc` が実機 Pico 2 の UART0 に "Hello, Pico 2!\r\n" を出力
- [x] sys_write / sys_read / 複数ファイル import が Pico 2 でも動作 (kernel/ で確認)
- [ ] PSRAM 初期化 (QMI CS1, 0x11000000〜) を crt0 に追加
- [ ] typecheck.tc / asm.tc のメモリ使用量を PSRAM 上で回せるレベルに最適化
      (ラベルテーブル・行バッファのストリーミング化、分割実行)
- [ ] TC コンパイラ自身を Pico 2 上で動かす (Pico 2 セルフホスト)

## フェーズ3: カーネル基盤（QEMU virt + Pico 2 実機で検証）

フェーズ2.5 で作ったベアメタル起動コードを再利用し、
trap/scheduler を加えてマルチタスク OS の足場を築く。

- [x] ブートスタブ (kernel/platform_{virt,pico2}.s: _start, SP/GP/SRAM 初期化)
- [x] UARTドライバ (16550 / PL011、do_uart_write/read で抽象化)
- [x] メモリアロケータ (runtime.tc kmalloc/kfree、free-list first-fit + 10-bucket)
- [x] 例外・割り込みハンドラ枠組み (trap vector、132B コンテキスト保存/復元、mscratch swap)
- [x] CSR 命令サポート (asm.tc に csrrw/csrrs/csrrc/csrr/csrw/mret)
- [x] CSR アクセス組み込み関数 (csr_read/write_mstatus/mie/mcause を本体なし宣言)
- [x] タイマ割り込み (virt CLINT mtime + Pico 2 SIO MTIME)
- [x] QEMU virt + Pico 2 実機の両方でタイマプリエンプション動作確認
- [ ] `print_*` / 文字列フォーマッタを runtime.tc から OS 向けに切り出し

## フェーズ4: プロセス管理（QEMU virt + Pico 2 実機で検証）

- [x] ゲストタスクを独立 raw バイナリとしてコンパイル（tasks/task_crt0.s + ecall ABI）
- [x] bin2s.sh でタスクバイナリをカーネル .rodata に埋め込み（`_PREFIX_addr()` 自動生成）
- [x] ecall ハンドラ（アセンブリ）: sys_write(64) / sys_read(63) / sys_exit(93)
- [x] カーネルがタスク用 RAM (data+bss+arena) を確保し gp を設定
- [x] per-task トラップフレーム（132B: 31レジスタ + mepc）
- [x] kern_run_task: 単一タスク協調実行（カーネルコンテキスト保存/復元）
- [x] 複数タスク逐次実行・同一タスクの複数インスタンス起動
- [x] sched_start + init_task_frame: mret でタスク起動（MPP=M-mode 必須）
- [x] タイマ割り込みによるプリエンプティブ・ラウンドロビンスケジューラ
- [x] _switch_frame によるコンテキストスイッチ（trap_restore で mscratch 切り替え）
- [x] sched_task_exit: タスク終了時に次タスクへ切り替え、全完了でカーネル復帰
- [x] QEMU virt で動作確認（2タスクが交互に A/B を出力）
- [x] タスクの初期化済みデータコピー（task_crt0.s で PC 相対 la + gp 相対コピー）
- [x] sys_read (16550 UART / PL011 UART の RX)
- [x] Pico 2 向けカーネル (kernel/platform_pico2.s + .data Flash→SRAM コピー)
- [x] Pico 2 実機でプリエンプティブマルチタスク動作確認（SIO MTIME + 64-bit mtimecmp）
- [x] Debug Probe + openocd-rpi (Raspberry Pi fork) で実機フラッシュ・デバッグ環境
- [x] **カーネル共通化**: trap_common.s + platform_{virt,pico2}.s,
      kernel_common.tc 共有, 統一 build.sh --target で重複排除
      （docs/task/kernel_platform_split.md）

## フェーズ5: ファイルシステム（QEMUで開発・検証）

全体設計は `docs/filesystem.md`。段階的に実装中（step 1..9）。

- [x] 設計ドキュメント統合 (`docs/filesystem.md`, VFS + mtfs 層)
- [x] virtio-mmio スキャン (`kernel/block_virtio.tc` block_init、legacy v1)
- [x] virtio-blk queue 初期化 + sector 0 read (polling、split virtqueue)
- [x] `tests/test_os.sh` fs_virtio: kernel が mkfs.py image の sector 0 を hex 出力
- [x] `tools/mkfs.py`: MyTinyFS (mtfs) ディスクイメージ生成
- [x] `kernel/mtfs.tc`: mount + lookup + open + read + close
      (root 直下のみ、inode table 全キャッシュ、MtfsFDArray で fd 管理)
- [x] `kernel/vfs.tc` + syscall 追加（sys_openat=56/sys_close=57/
      sys_read=63/sys_write=64 を VFS 経由で dispatch。fd<3 は UART）
- [x] タスクから `/hello.txt` を open/read する catfile ゲストタスク
      (sys_openat/close/read/write を task_crt0.s のスタブ経由で発行、
      `kernel/tasks/catfile/catfile.tc`、`tests/test_os.sh` で CAT: 出力を検証)
- [x] `kernel/block_flash.tc` (Pico 2 XIP memcpy) に差し替え
      (mtfs.tc/vfs.tc から block_virtio.tc の import を外して backend 中立化、
      build.sh --target pico2 が mkfs.py で mtfs イメージを生成して
      bin2s.sh 経由で `_mtfs_image` として .rodata に埋め込み、
      kernel_pico2.tc が block_flash.tc + mtfs + vfs + catfile task を
      組み込む。Pico 2 実機 (Debug Probe + openocd) で
      `BLOCK: flash backend ready / MTFS: mounted / CAT:hello, mtfs` まで
      動作確認済み)

## フェーズ6: ユーザランド基盤

実装計画は `docs/task/phase6_userland.md` にまとめる。

- [x] Step 6.1: 最小限の libc 相当 (`kernel/tasks/libtc/libtc.tc`、
      `puts` / `str_nul` / `strlen`)。catfile の重複ヘルパを集約、
      以後 launcher と sh でも使用。
- [x] Step 6.2: ゲストバイナリを mtfs に格納 (`/bin/hello` 等)。
      `tools/mkfs.py` をディレクトリ指定に拡張 (1 階層のサブディレクトリ
      対応)、`vfs_open` が `/bin/hello` のような多階層パスを解決、
      `kernel/loader.tc` の `load_task` が VFS からタスクバイナリを読み
      `make_task` でフレーム化。virt (fs_virtio テスト) / pico2 実機
      (test_pico2.sh) 両方で動作確認済み。
- [x] Step 6.3: sys_exec + ローダ
      - `vfs_xip_addr` / `mtfs_xip_addr` 実装 (block_xip_base 経由で
        flash は `_mtfs_image_addr + (data_start + start_block)*512`、
        virtio-blk は 0)
      - `kernel/loader.tc` の `load_task` が vfs_xip_addr を見て
        XIP 直接実行 / RAM コピーを切り替え
      - `sys_exec(path)` ecall (a7=221) + `sys_exec_handler` が
        `sched_replace_current` で呼び出し元スロットを新バイナリに
        差し替え、`_switch_frame` 経由で mret で飛ぶ
      - `kernel/tasks/launcher/launcher.tc` が `/bin/catfile` を
        sys_exec するデモとして virt / pico2 実機の両方で動作確認
- [x] Step 6.4: `/bin/sh` 最小シェル (UART 1 行読み → sys_exec)
      virt slot 2 に登録。`fs_virtio` テストが `printf 'catfile\n' | qemu`
      でコマンドをパイプ入力し、シェル経由の sys_exec → catfile 起動を
      end-to-end で検証。pico2 はハードテストに stdin がないので launcher
      を据え置き (build.sh が target 別にタスクリストを切り替える)。
- [x] Step 6.5: `sys_spawn` + `sys_wait` による親子同期
      - スケジューラに state 4 種 (ready/done/unused/waiting) と
        `g_wait_on` を追加。`sched_init(max)` で全スロットを unused に
      - `sched_spawn(frame) -> i32` が unused / done スロットに挿入、
        `sched_wait(target) -> u32` が呼び出し元を waiting にし、次の
        ready フレームを返す
      - `sched_task_exit` が target を done にしつつ、`wait_on == 自分`
        の waiter を ready に戻す (ウェイクアップ)
      - `trap_common.s` に `_ecall_spawn` (220) / `_ecall_wait` (260)、
        `task_crt0.s` に `do_spawn` / `do_wait` スタブを追加
      - `/bin/sh` をループ化: "quit" コマンドで終了するまで毎回
        プロンプト→spawn→wait→次プロンプト
      - virt は `sched_init(8)` で 3 スロット事前登録 + 5 スロット空き
        (spawn 用)。pico2 も `sched_init(8)` でレイアウトを揃えたが
        launcher 経路は変更なし
      - `fs_virtio` が "catfile\nquit\n" をパイプしてシェルループ + 2
        コマンド処理 (spawn/wait → exit) + SH: bye を検証

## フェーズ7: ネイティブコンパイラをOS上で動かす

フェーズ2.5 で Pico 2 ベアメタル上で動く TC プログラムの足場は確認済み。
ここではその上に OS の syscall 層 (open/read/write 等) を乗せ、
compiler/ 配下のツールをそのまま OS 上のプロセスとして起動できるようにする。

- [ ] フェーズ2で作ったコンパイラ・アセンブラ・リンカをOS上に移植
      (runtime.tc の do_write/do_read/do_exit を OS syscall に差し替え)
- [ ] OS上でコンパイラが動作することを確認
- [ ] OS上でHello Worldプログラムをコンパイル・実行

## フェーズ8: 自己ホスト

- [ ] OS全体のソースコードを独自言語で記述
- [ ] OS上のコンパイラ＋アセンブラ＋リンカでOSをビルド
- [ ] 生成したOSイメージをQEMUで動作確認
- [ ] RP2350実機にフラッシュして動作確認
- [ ] 自己ホスト完成

## 技術的リスクと対策

| リスク | 対策 |
|---|---|
| インタプリタとコンパイラの挙動が一致しない | `tests/test_consistency.sh` / `tests/test_gen3.sh` で常に両方を比較する。Gen2==Gen3 の BC/ASM 一致は CI で検証済み |
| LL(1)で表現できない構文が欲しくなる | 文法制約を文書化し、設計段階で確認 |
| メモリ不足（520KB SRAM） | `asm.tc` はセクション並べ替えで data/bss を最小化済み。runtime.tc は kmalloc/kfree（free-list + bucket）に移行し pool 制約を解消。`typecheck.tc` / `asm.tc` のラベル・行バッファは PSRAM 前提で拡張予定（フェーズ2.5） |
| gp 相対 `la` の 12-bit 制約 | hello レベルでは余裕。将来必要なら 12 byte 形式 (`lui+addi+add gp`) に拡張 |
| QEMUと実機の挙動差異 | `pico2/hello.tc` で既に実機 Pico 2 上の挙動を検証。ペリフェラル依存は crt0_pico2.s に集約 |
| Flash書き込みが遅い・壊れやすい | picotool UF2 経由の書き込みのみ使用。書き換え頻度は開発サイクルで問題ないレベル |
| デバッグが困難 | UART 出力 (Linux: syscall、virt: 16550、Pico 2: PL011) を `do_write` で統一、`asm.tc` は pass 2 でラベルマップを stderr に出す |
