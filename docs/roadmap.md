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
- [ ] print_i32 / print_str / sys_read 等の runtime API を Pico 2 でも動作確認
- [ ] 複数ファイル import (`import "lib.tc"`) を Pico 2 ビルドで動かす
- [ ] PSRAM 初期化 (QMI CS1, 0x11000000〜) を crt0 に追加
- [ ] typecheck.tc / asm.tc のメモリ使用量を PSRAM 上で回せるレベルに最適化
      (ラベルテーブル・行バッファのストリーミング化、分割実行)
- [ ] TC コンパイラ自身を Pico 2 上で動かす (Pico 2 セルフホスト)

## フェーズ3: カーネル基盤（QEMUで開発・検証）

フェーズ2.5 で作った `crt0_pico2.s` / `virt_crt0.s` 系のベアメタル起動
コードを再利用しつつ、一般的な OS 機能を積み上げていく。

- [x] ブートスタブ (crt0_pico2.s / virt_crt0.s: _start, SP/GP/SRAM 初期化)
- [x] UARTドライバ (PL011 / 16550、bare-metal レベル)
- [x] メモリアロケータ（runtime.tc に kmalloc/kfree 実装済み、free-list first-fit + 10-bucket 小ブロック高速化）
- [x] 例外・割り込みハンドラ枠組み（trap vector、コンテキスト保存/復元、mscratch swap）
- [x] CSR 命令サポート（asm.tc に csrrw/csrrs/csrrc/csrr/csrw/mret 追加）
- [x] CSR アクセス組み込み関数（csr_read/write_mstatus/mie/mcause）
- [x] タイマ割り込み（mtime / mtimecmp、TC trap_handler で処理）
- [x] QEMU virt 上でタイマ割り込みハンドラが発火するところまで確認
- [ ] `print_*` / 文字列フォーマッタを runtime.tc から OS 向けに切り出し

## フェーズ4: プロセス管理（QEMUで開発・検証）

- [ ] プロセス構造体・状態管理
- [ ] コンテキストスイッチ（RISC-Vレジスタ保存/復元）
- [ ] ラウンドロビンスケジューラ
- [ ] システムコール（ecall）の枠組み
- [ ] sys_exit, sys_write（UARTへ）の実装
- [ ] QEMUで動作確認

## フェーズ5: ファイルシステム（QEMUで開発・検証）

- [ ] QEMUの仮想ブロックデバイス（virtio-blk）を使った開発・検証
- [ ] 独自FSの実装（フォーマット、マウント）
- [ ] fs_open/read/write/close の実装
- [ ] sys_open/read/write/close の実装
- [ ] RP2350用Flashドライバに差し替え

## フェーズ6: ユーザランド基盤

- [ ] 最小限のlibcポート（memcpy, strlen, printf等）
- [ ] ローダ（実行ファイルをメモリにロード）
- [ ] sys_exec, sys_fork, sys_wait の実装
- [ ] シェル（コマンド入力・実行）
- [ ] QEMUで動作確認

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
