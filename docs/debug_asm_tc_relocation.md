# asm.tc リロケーションバグ調査ノート

## 症状

`tc_asm.sh` でビルドした codegen.tc の ELF が SIGSEGV (si_addr=0x8) でクラッシュ。
parse.tc, typecheck.tc, fib.tc, fizzbuzz.tc 等の小さなプログラムは正常動作。

## わかっていること

### 1. asm.tc の内部計算は正しい
- pass1/pass2 の g_pos は全行で一致（per-lineチェック済み）
- hi20/lo12 の reconstruction チェック: `recon = pc + (hi20 << 12) + lo12 == target` → パス
- enc_i のデコード検証: `(i_insn >> 20) & 0xFFF == lo12` → パス
- つまり asm.tc の TinyC コード内では正しい値が計算されている

### 2. ELF のバイトが間違っている
- `call main` の JALR 即値: expected=596 (0x254), actual=180 (0x0B4), diff=416
- 22個の call 命令が一様でないずれを持つ (-320, -416, 204, -20, 24, -356 等)
- `call __runtime_init` (最初の call) は正しい
- AUIPC 部分は全て正しい。JALR 部分のみずれる

### 3. GCC リンクでは正常
- 同一アセンブリを `riscv64-unknown-elf-gcc --no-relax` でリンク → 正常動作
- tc runtime (runtime.tc) のアセンブリ + GCC リンク → 正常動作
- つまりアセンブリ（bc2asm出力）自体は正しい

### 4. bcrun 上のasm.tc実行
- asm.tc は bcrun 経由で実行される（tc_asm.sh の最終ステップ）
- bcrun の i32 演算は正常（& 4095, >> 12 等を個別テスト済み）
- bcrun の sys_write は正常（バイト出力テスト済み）
- asm.tc 内でのデバッグチェック（recon != target）はエラーを検出しない

### 5. コードサイズとの関係
- 小さいプログラム（fib.tc 等）では問題なし
- codegen.tc（アセンブリ33000行、コードサイズ~200KB）で問題発生
- アセンブリ行数またはコードサイズに依存するバグ

## 試したこと

1. **crt0_tc.s の .data/.bss 分離** → セクション配置問題を修正したが、根本原因ではなかった
2. **bc2asm の eval stack フレーム予約** → frame_size 拡大で SEGV の原因が変わるが解決しない
3. **GDB でスタックトレース取得** → peek32(0x8) = NULL struct アクセスを特定
4. **asm.tc にラベルマップ出力追加** → 正確なアドレス解決が可能に
5. **ELF バイト直接解析** → AUIPC は正しく JALR 即値のみずれることを確認
6. **pass1/pass2 g_pos per-line 比較** → 全行一致、g_pos のずれはない
7. **hi20/lo12 reconstruction チェック** → asm.tc 内部では正しい
8. **enc_i デコード検証** → asm.tc 内部では正しい
9. **codegen.tc にデバッグ出力追加** → bcrun の cast i32 バグ（VAL_REF.ival=0）を発見（別件）

### 6. asm.tc の call ターゲットは実は正しかった
- デバッグコード追加版のラベルマップと比較していたため、ずれがあると誤認
- クリーン版のラベルマップとELFバイトは一致
- call __runtime_init, call main は共に正しいターゲットに飛んでいる

### 7. 真の問題: get__U32Array__i32 内の peek32 呼び出しで ra=0x8
- peek32 は leaf function (ra保存なし)
- get→peek32 の call 命令の auipc+jalr が不正な ra 値を生成
- AUIPC部分ではなく、**get関数内のcall peek32のエンコーディング**にバグ
- get は runtime.tc のコード（bc2asm経由）

## 仮説と次のステップ

### 有力仮説: emit32 → g_code → sys_write のどこかで値が壊れる

asm.tc 内部で計算した i_insn は正しいが、emit32 で g_code に書き込んだ後、
sys_write で読み出すときに異なる値が出る。

考えられる原因:
1. **bcrun の大きな配列 (67M要素) でのメモリ管理の問題**
   - U8Array(67108864) は bcrun 内で 67M 個の Value 構造体 (~1GB) を確保
   - calloc が部分的に失敗しているか、アドレス空間の問題
   
2. **emit8 で書いた後、別のコードが同じ g_code 位置を上書き**
   - .space/.zero の零フィルが重なる？ → 位置的に重ならないはず
   - 他のディレクティブが g_code を変更？

3. **g_pos が正しくても emit8 の呼び出し時の g_pos が異なる**
   - per-line チェックでは一致したが、asm_instr 内部の命令途中でずれる？
   - call 命令: emit32(auipc) → g_pos+=4 → emit32(jalr) → g_pos+=4
   - auipc 書き込み位置は正しいが、jalr 書き込み位置がずれる？

### 次に試すこと

1. **emit32 直後に g_code の値を検証**
   - call 命令の emit32(i_insn) 直後に `get(g_code, g_pos-4..g_pos-1)` を読み返して
     書き込んだ値と一致するか確認

2. **sys_write 直前に特定位置の g_code 値をダンプ**
   - write_elf の直前で `call main` の JALR 位置 (g_pos=0x4C..0x4F) の4バイトを確認
   - 期待値 0x254080E7 と比較

3. **MAX_CODE を小さくして再テスト**
   - 67MB → 1MB に減らして、bcrun のメモリ使用量を削減
   - メモリ管理の問題ならこれで解決する可能性

4. **hello.tc 相当の小さいプログラムで call 命令のバイト検証**
   - 正常ケースでも同じ検証を行い、差分を特定

## 関連バグ（発見済み・別件）

### bcrun の cast i32 バグ
- `cast i32` で VAL_REF を変換せずそのまま返す
- VAL_REF.ival は常に 0 のため、`ref as i32 == 0` が常に true になる
- codegen.tc の NULL チェック `if ob as i32 == 0` が bcrun で誤動作
- rv32 ネイティブでは正常（参照型 = メモリアドレス）
