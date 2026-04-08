# 自作アセンブラ: riscv-gcc を排除

## 動機

現在のコンパイルパイプラインは riscv-gcc に依存している:

```
.tc → parse → typecheck → codegen → bc2asm → .s → riscv-gcc → ELF → qemu
```

riscv-gcc の役割:
1. `.s` (アセンブリ) → 機械語へのアセンブル
2. `runtime_syscall.c` → `.s` へのコンパイル
3. 複数 `.s` + `crt0.s` のリンク → ELF 生成

自作アセンブラを作り、riscv-gcc のリンカ機能を不要にする。

## 方針

- **runtime_syscall.c** は毎回 `riscv-gcc -S` で `.s` に変換する
  （GCC はコンパイラとしてのみ使用、リンカ/アセンブラは不要に）
- **自作アセンブラ** が `.s` ファイルを読み、ELF バイナリを出力する
- crt0.s + runtime_syscall.s + ユーザーコード.s を1つの ELF にまとめる
- 将来的に runtime を .tc で書き直せば GCC 完全不要になる

## サポートする命令

### bc2asm の出力で使用される命令 (ユーザーコード)

| 命令 | フォーマット | 出現数 |
|------|------------|--------|
| `addi rd, rs1, imm` | I-type | 34862 |
| `lw rd, off(rs1)` | I-type (load) | 27031 |
| `sw rs2, off(rs1)` | S-type (store) | 23694 |
| `li rd, imm` | 疑似命令 (lui+addi) | 5080 |
| `call label` | 疑似命令 (auipc+jalr) | 4175 |
| `beqz rs, label` | 疑似命令 (beq rs,x0,off) | 1657 |
| `mv rd, rs` | 疑似命令 (addi rd,rs,0) | 1326 |
| `la rd, label` | 疑似命令 (auipc+addi) | 1316 |
| `sub rd, rs1, rs2` | R-type | 1025 |
| `ret` | 疑似命令 (jalr x0,ra,0) | 987 |
| `seqz rd, rs` | 疑似命令 (sltiu rd,rs,1) | 838 |
| `j label` | 疑似命令 (jal x0,off) | 679 |
| `add rd, rs1, rs2` | R-type | 672 |
| `slt rd, rs1, rs2` | R-type | 339 |
| `mul rd, rs1, rs2` | R-type (M ext) | 142 |
| `bnez rs, label` | 疑似命令 (bne rs,x0,off) | 134 |
| `xori rd, rs1, imm` | I-type | 119 |
| `snez rd, rs` | 疑似命令 (sltu rd,x0,rs) | 104 |
| `neg rd, rs` | 疑似命令 (sub rd,x0,rs) | 20 |
| `andi rd, rs1, imm` | I-type | 12 |
| `and rd, rs1, rs2` | R-type | 10 |
| `rem rd, rs1, rs2` | R-type (M ext) | 9 |
| `ecall` | システム命令 | 7 |
| `div rd, rs1, rs2` | R-type (M ext) | 5 |
| `sra rd, rs1, rs2` | R-type | 3 |
| `sll rd, rs1, rs2` | R-type | 1 |
| `or rd, rs1, rs2` | R-type | 1 |
| `xor rd, rs1, rs2` | R-type | 1 |

### runtime_syscall.s で追加される命令

| 命令 | フォーマット |
|------|------------|
| `lui rd, imm` | U-type |
| `blt rs1, rs2, label` | B-type |
| `beq rs1, rs2, label` | B-type |
| `ble rs1, rs2, label` | B-type (疑似: bge rs2,rs1) |
| `bne rs1, rs2, label` | B-type |
| `bge rs1, rs2, label` | B-type |
| `slli rd, rs1, imm` | I-type (shift) |
| `srli rd, rs1, imm` | I-type (shift) |
| `srai rd, rs1, imm` | I-type (shift) |
| `sb rs2, off(rs1)` | S-type (store byte) |
| `lbu rd, off(rs1)` | I-type (load byte unsigned) |
| `jr rs` | 疑似命令 (jalr x0,rs,0) |
| `tail label` | 疑似命令 (auipc+jalr) |
| `mulhu rd, rs1, rs2` | R-type (M ext) |

### ディレクティブ

| ディレクティブ | 意味 |
|--------------|------|
| `.text` | テキストセクション開始 |
| `.data` | データセクション開始 |
| `.section .rodata` | rodata セクション開始 |
| `.section .text.init` | テキスト初期化セクション |
| `.bss` | BSS セクション開始 |
| `.globl name` | シンボルをグローバルにする |
| `.type name, @function` | シンボル型宣言（無視可） |
| `.align N` | N バイト境界にアライン |
| `.word value` | 4 バイト値を出力 |
| `.string "..."` | NUL 終端文字列を出力 |
| `.space N` | N バイトのゼロ領域 |
| `.option push/pop/norelax` | リンカ最適化制御（無視可） |
| `.attribute ...` | アーキテクチャ属性（無視可） |
| `.file "..."` | ファイル名（無視可） |
| `label:` | ラベル定義 |

## ELF 出力

ベアメタル Linux (qemu-riscv32) 用の最小 ELF:

- ELF32 little-endian, RISC-V, exec
- エントリポイント: `_start`
- テキストセグメント: 0x10000 固定
- セクション: .text + .rodata + .data + .bss
- プログラムヘッダ: LOAD セグメント 1〜2 個

リンカスクリプトは不要（固定アドレス配置）。

## 2パスアセンブラ

- **パス1**: 全ラベルのアドレスを収集
- **パス2**: 命令をエンコード、ラベル参照を解決

`call` や `la` などの疑似命令は 2 命令（auipc+jalr / auipc+addi）に
展開するので、パス1 でサイズを正しく計算する必要がある。

## 実装計画

### ステップ 1: アセンブラの実装 (bootstrap/asm.c)

C で書く（Gen1 ツール）。入力: 複数 `.s` ファイル → 出力: ELF バイナリ

1. パーサー: `.s` テキストをトークン化、命令・ディレクティブ・ラベルを認識
2. パス1: アドレス割り当て（.text, .rodata, .data, .bss のサイズ計算）
3. パス2: 命令エンコード + ラベル解決
4. ELF 出力: ヘッダ + セクション + プログラムヘッダ

### ステップ 2: テスト

```bash
riscv64-unknown-elf-gcc -S -march=rv32im -mabi=ilp32 -O2 \
    bootstrap/runtime_syscall.c -o /tmp/runtime.s
./asm bootstrap/crt0.s /tmp/runtime.s user.s -o output.elf
qemu-riscv32 output.elf
```

- riscv-gcc 版と同じ実行結果を確認
- Gen2/Gen3 テストを asm 版でも実行

### ステップ 3: 自己ホスト版アセンブラ (compiler/asm.tc)

C 版を TinyC で書き直し。これにより:
```
.tc → parse.tc → typecheck.tc → codegen.tc → bc2asm.tc → asm.tc → ELF
```
GCC 完全不要のフルパイプラインが完成。

## メモリレイアウト

```
0x00010000  .text     (コード: crt0 + runtime + ユーザー関数)
            .rodata   (文字列リテラル、定数)
0x000xxxxx  .data     (グローバル変数、初期値あり)
            .bss      (ゼロ初期化領域: スタック、ヒープ)
```

.text + .rodata は 1つの LOAD セグメント (RX)。
.data + .bss は 1つの LOAD セグメント (RW)。

## 命令エンコーディング参照

### RV32I 基本フォーマット

```
R-type: [funct7(7) | rs2(5) | rs1(5) | funct3(3) | rd(5)  | opcode(7)]
I-type: [imm[11:0](12)      | rs1(5) | funct3(3) | rd(5)  | opcode(7)]
S-type: [imm[11:5](7) | rs2(5) | rs1(5) | funct3(3) | imm[4:0](5) | opcode(7)]
B-type: [imm[12|10:5](7) | rs2(5) | rs1(5) | funct3(3) | imm[4:1|11](5) | opcode(7)]
U-type: [imm[31:12](20)                               | rd(5)  | opcode(7)]
J-type: [imm[20|10:1|11|19:12](20)                    | rd(5)  | opcode(7)]
```

### レジスタ番号

```
x0=zero  x1=ra   x2=sp   x3=gp   x4=tp
x5=t0    x6=t1   x7=t2
x8=s0/fp x9=s1
x10=a0   x11=a1  x12=a2  x13=a3  x14=a4  x15=a5  x16=a6  x17=a7
x18=s2 .. x27=s11
x28=t3   x29=t4  x30=t5  x31=t6
```
