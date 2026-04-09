# asm.tc codegen.tc SEGV 調査ノート

## 症状

`tc_asm.sh` でビルドした codegen.tc の ELF が SIGSEGV (si_addr=0x8) でクラッシュ。
parse.tc, typecheck.tc, fib.tc, fizzbuzz.tc 等は正常動作。

## クラッシュの直接原因

```
emit_char(ob, 'r') → pos(sb) → get(sb as U32Array, 1) → peek32(0x8) → SEGV
```

StringBuffer `ob` がNULL(0)の状態で `emit_char` が呼ばれている。
cg_stmt のフレーム内では `ob = 0x30570`（正しい値）が保持されているが、
emit_char に渡される時点で a0 = 0 になっている。

## 確定事項

### asm.tc の call リロケーションは正しい
- **誤認の経緯**: デバッグコード追加版のラベルマップと比較していたため、
  アドレスずれがあると誤認していた
- クリーン版で再検証: call __runtime_init, call main ともに正しいターゲットに到達
- `_start` の最初の64バイトは GCC リンク版と**完全一致**
- pass1/pass2 の g_pos は全行で一致（per-line チェック済み）

### GCC リンクでは正常動作
- 同一アセンブリ (`crt0_tc.s + runtime.tc asm + codegen.tc asm + crt0_tc_data.s`) を
  `riscv64-unknown-elf-gcc --no-relax` でリンク → **正常動作**
- つまりアセンブリ（bc2asm 出力）自体は正しい
- 問題は GCC リンクと asm.tc リンクの**配置の違い**にのみ起因

### bcrun 経由では正常
- codegen.tc を bcrun で実行すると正常に動作（同じ BC、同じロジック）
- rv32 ネイティブ（asm.tc ELF）でのみクラッシュ

### セクション配置の違いが唯一の差分
- **GCC**: `.text`（コード） → `.data`（.word） → `.rodata`（.string） → `.bss`
  各セクションが独立したアドレス範囲に配置される
- **asm.tc**: セクションディレクティブを無視。全てが1つの連続領域に配置。
  bc2asm が `.text` 内に出力する `.word`（グローバル変数）と `.string`（文字列リテラル）が
  命令コードと混在する

### スタック状態の詳細
- cg_stmt の NK_RETURN ハンドリングで `cg_expr(nodes, strtab, slits, ob, v)` を呼んだ後、
  `emit_char(ob, ' ')` → `emit_char(ob, ' ')` → `emit_char(ob, 'r')` と呼ぶ
- 3番目の `emit_char(ob, 'r')` の直前: sp = base_sp - 4（期待値は base_sp - 8）
- sp が4バイト多い → push ob の結果が1つ足りない（または先行の pop が1つ多い）
- stack上: `[sp] = 0x72 ('r')`, `[sp+4] = 0x0` ← ob がゼロに見える

## 試したこと

1. **crt0_tc.s の .data/.bss 分離** → crt0_tc_data.s に分離。
   asm.tc がセクションを無視する問題への対処。根本原因ではなかった。

2. **bc2asm の eval stack フレーム予約** → C版 bc2asm に max_eval_depth 計算を追加。
   frame_size 拡大したが SEGV は解決しない。

3. **GDB でスタックトレース** → gdb-multiarch + qemu -g でフレームチェーン追跡。
   peek32(0x8) = NULL struct フィールドアクセスを特定。

4. **asm.tc ラベルマップ出力** → stderr にラベル→アドレスのマップをダンプ。
   スタックトレースの正確なシンボル解決に使用。

5. **call ターゲット全スキャン** → ELF 内の全 auipc+jalr をスキャンし、
   ラベルマップと照合。22個のcallがずれていると判定 → **誤認**（後で訂正）。

6. **pass1/pass2 g_pos per-line 比較** → 全行一致。

7. **hi20/lo12 reconstruction & enc_i decode** → asm.tc 内部では正しい値。

8. **codegen.tc にデバッグ出力追加** → bcrun の cast i32 バグ発見（別件）。

9. **g_code バイトダンプ** → write_elf 直前で g_code[0x4c..0x4f] を確認。
   emit8 が書き込む値が既に間違っていた → **実はラベルマップが
   デバッグ版で変わっていたための誤認**。

10. **クリーン版で再検証** → asm.tc の call リロケーションは正しいと確定。
    _start コードバイトは GCC 版と完全一致。

11. **MAX_CODE 縮小テスト** → 67MB → 1MB。結果変わらず。

12. **GCC + tc_runtime 同一アセンブリテスト** → **正常動作**。
    コード自体は正しく、リンカの配置のみが問題。

## 仮説

### 有力: bc2asm がグローバル変数を .text 内に出力する問題

bc2asm は `.data` セクションを出力せず、グローバル変数の `.word` と
文字列リテラルの `.string` を `.text` セクション内に配置する。

GCC リンカはこれらを `.data`/`.rodata` に再配置するが、
asm.tc はセクションを区別しないためコード領域に混在する。

**仮説**: コード内に混在する `.word 0` データが、何らかの理由で
隣接する関数のスタック操作やメモリアクセスに影響を与えている。

ただし `.word` はラベル付きのデータ領域であり、命令として実行されることはない。
`la label; lw/sw ...` でアクセスされるだけ。なぜこれが問題になるかは不明。

### 代替仮説: bc2asm のスタックマシンコード生成のeval stack管理
- cg_expr(5引数) 呼び出し → return → pop → emit_char(ob, ' ') × 2 → emit_char(ob, 'r')
- 3番目のemit_charの時点でspが期待値より4バイト多い（push obが欠落？）
- eval stack の不整合がある可能性
- ただし GCC リンク版では同じコードが正常動作するため、
  コード生成自体の問題ではなくメモリ配置の問題

## 次に試すこと

1. **bc2asm に .data セクション出力を追加**
   - グローバル変数の `.word` を `.text` ではなく `.data` セクションに出力
   - これにより GCC リンクと asm.tc リンクのメモリ配置が同等になる
   - asm.tc はセクションを無視するが、.data がコード末尾に来るよう
     bc2asm の出力順序を変えれば解決する可能性

2. **GCC リンク版と asm.tc 版の特定関数バイナリ比較**
   - cg_stmt の NK_RETURN 付近の数百バイトを比較
   - コードが完全一致するなら、問題はデータ配置のみ

3. **asm.tc の .data サポート追加**
   - `.data`/`.text` のセクション切替を認識し、
     .data を .text の後ろに配置するようにする

## 関連バグ（発見済み・別件）

### bcrun の cast i32 バグ
- `cast i32` で VAL_REF を変換せずそのまま返す
- VAL_REF.ival は常に 0 のため、`ref as i32 == 0` が常に true になる
- codegen.tc の NULL チェック `if ob as i32 == 0` が bcrun で誤動作
- rv32 ネイティブでは正常（参照型 = メモリアドレス）
