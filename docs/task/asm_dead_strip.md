# asm_pass2/2 dead-strip 計画

**ステータス: 設計検討中 (2026-04-30)**

## 背景

`prelude.s` (= task_crt0.s + 全 runtime.s) は 234 KB あるが、Hello
World の user .s が実際に呼ぶシンボルは `print__StringLiteral` の
1 個だけ。残り 200+ KB は **dead code** として linker (asm_pass2/2)
にそのまま通し、コードサイズと SD I/O 時間を浪費している。

実機 pipeline の per-stage timing (`tests/test_pico2_bench.sh` の
2026-04-30 baseline):

| 段 | 所要 | 主な作業 |
|---|---:|---|
| cat-link  |   6.0 s | prelude(234KB) + user(1KB) + tail を SD に書く |
| asm_pass2 |  26.2 s | full.s (235 KB) を 1 回 stream read |
| cat-p2    |  22.5 s | lab + full.s × 3 を SD 経由で連結 |
| asm_pass3 |  80.5 s | full.s × 3 を再 read、emit |
| **小計**  | **135 s** | |

Dead code を削れれば **prelude.s 234 → 数 KB**、cat / pass1 / pass2
の I/O コストもほぼ全部消える見込み。

runtime.s 234 KB の内訳 (227 個の export symbol、上位):

```
print__i32:           691 行
print__u32:           557 行
large_free:           488 行
append__String_String: 447 行
kmalloc:              434 行
... (全部 230 KB)
```

Hello World で実際 reachable なのは `print__StringLiteral` →
`sys_write__i32__String` → `do_write` (ecall stub) のみ。+
`__runtime_init` が crt0 から root として呼ばれる。残り 200+ KB
は dead。

---

## 現行の asm_pass2 / asm_pass3 構造

参考: `docs/lab_format.md`、`docs/compiler.md` § asm_pass2/asm_pass3。

### asm_pass2 (1 pass over source)

入力: `full.s` (stdin)
処理:
1. 行ごとに section / mnemonic / operand を tokenize
2. **section cursor 進行**: 各 instruction / `.word` / `.string` /
   `.space` で `g_sec_pos[g_current_section]` を進める
3. **ラベル定義収集**: `name:` を `define_label(name, addr, sec)` で
   `g_labels[]` に記録
4. **数値ラベル定義**: `0:` 〜 `9:` を `define_numlab(d, addr)` で
   `g_numlab[]`
5. 全行読了後 `asm_compute_sec_bases()` で各 section の最終 base /
   size を確定、`asm_fixup_labels()` で各 ラベルの intra-offset を
   absolute address に変換
6. `asm_dump_lab_state()` で `.lab` に出力 (sec / lab / num 行)

出力: `.lab` (stdin から 1 回読みで生成)

### asm_pass3 (3 passes over source)

入力: `cat full.lab full.s full.s full.s` (stdin)
処理:
1. **`.lab` 読み**: sec/lab/num を in-memory に展開、ELF header
   準備
2. **pass 0 (text)**: source を再 read、`g_current_section==0` の
   命令だけを encode → stdout に stream emit
3. **pass 1 (rodata)**: 同じ source を再 read、target=1 で emit
4. **pass 2 (data)**: 同じく target=2

bss は `.space N` のみで file bytes は無いため emit pass 不要。

---

## dead-strip を入れる場所: pass 1 と pass 2 の間に "pass 1.5"

### 案: 3 段階構成 (asm_pass2 → asm_strip → asm_pass3)

```
full.s ─→ asm_pass2 ─→ full.lab + full.refs ─→ asm_strip ─→ full.lab.live + skip ranges
                                                           ↘
full.s ─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→─→ asm_pass3 ─→ out.bin
```

asm_strip は live symbol set を計算し、

- `full.lab` に **live フラグを付けたラベルテーブル**を出力
- 死シンボルが定義されていた **ソース行範囲** (= "skip ranges") を
  出力

asm_pass3 は skip ranges を読んで、その範囲の bytes を出力に含めない
(section cursor も進めない)。

**メリット**: pass1/pass2 を大きくいじらない。新ツール 1 個追加。

**デメリット**: asm_pass2 が新フォーマット (`.refs`) を吐く必要あり。
.lab が live フラグ付きで非互換になる。3-binary 構成で OS 上で
`asm_strip` をもう一段 spawn することになり時間 / メモリオーバヘッド。

### 案: asm_pass2 内部で済ます (新ツール無し)

asm_pass2 が:
1. 既存通り 1 pass で source を読む
2. その間に **per-symbol reference graph** を構築 (どの symbol が
   どの symbol を参照しているか)
3. 全体読了後、roots (`_start` 等) から BFS で live set を計算
4. `.lab` に **live = true な symbol だけ**書く + 死 symbol が
   定義されていたソース範囲を `skip` 行として書く

asm_pass3 は `.lab` の skip 行を見て、対応するソース範囲を emit
時にスキップ。section cursor もスキップ範囲分は進めない。

**メリット**: ツール 1 個で済む。OS 上の追加 spawn なし。`.lab`
バージョンが上がるだけ。

**デメリット**: asm_pass2 のメモリが少し増える (reference graph
記録)。pass1 自体のロジックが複雑化。

→ **後者を採用**。OS 上で動かすときの spawn コストが大きいので
ツール数を増やしたくない。

---

## 詳細設計

### 1. roots (always live)

以下を unconditionally live としてマーク:

| Root | 由来 |
|---|---|
| `_start` | crt0 のエントリ。ELF entry point |
| `main` | crt0_tc.s が `call main` する |
| `main__StringArray` | task_crt0.s が `call main__StringArray` する。本体無し fallback も live にしないとリンク漏れ |
| `__runtime_init__u32__i32` | crt0 が呼ぶ |
| `__global_pointer$` | crt0 が `la gp, __global_pointer$` で参照 |
| `__data_end` | task_crt0.s が `la t2, __data_end` で参照 |

ハードコードしたリストを asm_pass2 に持たせる。

### 2. reference graph

asm_pass2 が source を読む間、**現在 section の "owning symbol"**
を track する。所有関係は:

- ある symbol `X:` が定義された後、次の symbol が定義されるまで、
  この section に emit されるすべての参照は `X` の依存とみなす
- データセクションも同様 (`g_count: .word other_label` は g_count
  → other_label の参照)

参照種別 (asm-level):
1. `call <sym>` / `jal <sym>` — 関数呼び出し
2. `la <reg>, <sym>` — アドレスロード (gp 相対 / PC 相対)
3. `.word <sym>` — リロケーション (jump table、function pointer等)
4. `j <sym>` / `bnez <sym>, <sym>` etc — ジャンプ (但し数値ラベル
   `0f`/`0b` は per-function なので無視)
5. `.byte` / `.string` 内に名前は入らない (数値のみ)

### 3. reference graph データ構造

```
struct SymRef {
    from_idx: i32,  // 参照元の symbol index (g_labels)
    to_idx:   i32,  // 参照先の symbol index
}
var g_refs: SymRefArray = ...    // append-only
var g_nrefs: i32 = 0;
```

参照先名 → index 変換は pass1 中に label table が増えるので
**遅延 resolve**:

- 参照を見たとき、`(from_idx, to_name string)` を一旦 byte pool に保存
- 全行読了後、name → index に解決して `g_refs` に正規化

または逆に: 全 label 定義を先に収集 (pass1 をさらに 2 pass 化)
してから references を二度目で resolve。コスト的には 1 pass 内
での lazy resolve のほうが安い。

メモリ: 平均 5 ref / symbol × 3000 symbols = 15000 refs × 8 byte
= 120 KB。**asm_pass2 peak (現在 149 KB) を倍近くに押し上げる**。

→ この構造のまま入れると asm_pass2 が 250+ KB に逆戻り。
**サブセット化が要る**:

- 参照先を name pool offset (16 bit) で持てば 4 byte/ref に減る
  → 60 KB に
- そもそも全 reference を記録しなくても、live set に効く参照のみで
  十分

### 4. owning symbol の決定

asm_pass2 が行を処理するとき、その行の所有者 (`current_owner_sym`)
を以下で更新:

```
on `name:` line:                 current_owner_sym = name
on section change directive:     current_owner_sym = section sentinel
                                 ("$text" / "$rodata" / "$data" / "$bss")
                                 — section 直下の bare instruction を
                                 root として扱う
on `.size` etc:                  no change
on instruction / .word / .string: this line "belongs to" current_owner_sym
```

セクション直後で symbol 定義無しの bare 命令は、section root
"$text" 等を挟むことで roots に紐付ける (= 常に live)。これは
`_start:` の前の crt0 prologue 行などで稀に発生する。

### 5. BFS

全 source 読了後:
1. live set = roots
2. queue = roots
3. while queue:
   - sym = queue.pop()
   - for ref in g_refs where from == sym:
     - if !live(ref.to): live(ref.to) = true; queue.push(ref.to)

実装: `g_label_live: I32Array(MAX_LABELS)` を bitmap として持つ
(MAX_LABELS=4096 → 4 KB)。queue は `I32Array(MAX_LABELS)` で十分。
合計 16 KB の peak 増。

### 6. .lab フォーマット拡張 (v2)

`; lab v2` ヘッダで切り替え。新しい行種別:

```
sec <id> <base> <size>          # 既存
lab <addr> <section> <name>     # 既存 — live なシンボルのみ出力
num <digit> <addr>              # 既存
skip <section> <intra_start> <intra_end>  # ★新規
```

`skip` 行: pass1 が、死シンボル (live set に居ない) が emit する
バイトの section 内 intra-offset 範囲を吐く。例: section 0 (text)
の offset 1024..2048 が dead なら `skip 0 1024 2048`。

asm_pass3 は emit pass 中、`g_sec_pos[sec]` がスキップ範囲に入って
いる間は **emit を抑制**し、出力 cursor も進めない。section base
/ size の再計算は asm_pass2 が live のみで行うので pass2 は単純に
従う。

### 7. asm_pass3 への影響

最小限で済む:
- skip 行を読んで `g_skip_ranges[]` に保存
- emit pass の `emit8` で `is_in_skip(g_current_section, intra_pos)`
  なら no-op 化
- intra_pos の更新は通常通り (pass1 と整合させるため)

ただし: `g_sec_pos[sec]` は live のみで進むようにすると、ELF
ヘッダの memsz / filesz は live のみのサイズになる。これは正しい
(死コードを物理的に出力しない)。

注意: **数値ラベル `0:`〜`9:`** はソース順なので、死関数内の `0f`
は live 関数の `0f` 解決と混ざらないよう、live set の関数ごとに
binding を再計算する必要あり。← per-function reset の境界が
シンボル境界なので、live set ベースで filtered numlab table を
作る必要が生じる。設計上の最大の難所。

簡略策: **死コードを skip するだけで数値ラベル table はそのまま**。
死関数内の `0:` 定義は table に残るが、live コードからは参照され
ないので無害。但しエンコード時に `numlab_back/fwd` は live set
を見て filter する必要あり。あるいは pass1 でラベル定義時、その
行が live owner に属するときだけ table に追加する。

→ **ラベル定義時に owner の live フラグを参照する** ですべて済む。
pass1 の symbol live 計算後、もう 1 pass で source を読んで死
owner の labels (普通 + 数値) を skip 出力。**asm_pass2 が 2 pass
になる**。

→ または pass1 はそのまま 1 pass で done。最後に live 計算 → live
list を出力。asm_pass3 が source を読み始めたところで、現在の
owner が live でなければ全行 skip。owner が live になったら通常
emit。これは asm_pass3 の 3 pass それぞれで行う。

→ **後者で**。pass1 のメモリを増やさず、pass2 が live set 既知
の状態で source を再 read するときに動的に skip する。

### 8. asm_pass3 emit pass の擬似コード (新)

```
for each emit pass (text / rodata / data):
    current_owner_live = false
    for each line in source:
        if line is `name:`:
            current_owner_live = is_live(name)
            ; label define still happens (intra=0 since we don't emit)
            continue
        if line is section directive:
            switch to new section
            current_owner_live = is_section_root_live(new_section)
            continue
        if !current_owner_live:
            ; skip (no emit, no g_pos increment for THIS pass)
            continue
        ; otherwise emit normally
        emit_instruction(line)
```

**注意**: section base 計算が pass1 / pass2 で一致しないといけない。
pass1 の `asm_compute_sec_bases()` も live のみで集計する必要あり。
これが要るので **pass1 は live 計算後にもう 1 source pass** を回す
ことになる。実質 asm_pass2 が 2-pass 化:

```
asm_pass2 phase 1: source 1回読み、label定義収集 + reference graph 構築
asm_pass2 phase 2: live set BFS
asm_pass2 phase 3: source 2回目、live owner の bytes だけ section
                   cursor を進めて intra-offset を再計算
asm_pass2 phase 4: .lab 出力 (live label のみ、live のみで計算した
                   sec base/size、skip range 不要 — pass2 が source
                   を読みながら同じ判定で skip)
```

asm_pass3 は per-pass で source を読みながら、現在の owner の
live フラグを参照して emit するか決める。

### 9. メモリ予算 (asm_pass2)

新規 buffer:

| 名前 | サイズ | 用途 |
|---|---:|---|
| `g_refs`           | 64 KB | 参照グラフ (~16k entries × 4 byte) |
| `g_label_live`    |  1 KB | live bitmap (MAX_LABELS=4096 / 8 = 512 byte) |
| BFS queue         |  4 KB | live BFS の作業領域 |

合計 ~70 KB 増。現 asm_pass2 peak 149 KB → 220 KB。**150 KB target
を超える**。

→ `g_refs` の参照先を symbol-index (16 bit) ではなく `name pool offset`
にすれば、from/to 各 16 bit = 4 byte/ref。同じく 60-64 KB。

→ さらに reference graph を **on-the-fly でファイル化** (一時
中間ファイル `full.refs` に書き出して BFS は再 read で行う) すれば
peak メモリは増えない。ただしファイル I/O が増えて時間が悪化。

### 10. 時間予算 (asm_pass2)

source を 2 回読む (現状 1 回)。SD 経由 235 KB を 2 回 = 1 回追加で
~13 秒増。**asm_pass2 が 26 → 40 秒 になる**。

→ Step 2.1 (XIP 直読み) と組合せれば 2 回読みでも ~3 秒に収まる。

---

## 期待効果

Hello World ベース:

| 項目 | 現状 | dead-strip 後 |
|---|---:|---:|
| user.s + prelude.s 合計 | 235 KB | ~10 KB (live のみ) |
| cat-link | 6 s | < 1 s |
| asm_pass2 (1-pass + live) | 26 s | 40 s (2-pass) → 5 s (XIP) |
| cat-p2 | 22 s | < 1 s |
| asm_pass3 | 80 s | < 5 s |
| **total** | **135 s** | **~10 s** (with XIP), **~50 s** (without) |

OS 全体コンパイル時 (バイナリ毎に異なる live set):
- ライブラリ重い task → 削減効果 50-70%
- 軽量 task (hello / echo) → 90%+

---

## 実装フェーズ

### Phase 1: reference graph 構築 (asm_pass2)

- `asm_common.tc` に `g_refs` バッファ + `record_ref(from_name, to_name)`
- 各 instruction tokenize 時に `call/jal/la/.word` の operand が
  名前ならば `record_ref(current_owner, operand)`
- "current_owner" track: `name:` 行 / section 切替 で更新

### Phase 2: live set BFS (asm_pass2)

- BFS implementation
- roots ハードコード
- live bitmap 出力

### Phase 3: pass1 phase 3 — section base 再計算

- live owner の bytes だけで sec_pos を進める 2nd source pass
- live label の addr を再計算
- 新 .lab v2 出力

### Phase 4: asm_pass3 skip emit

- source pass で current_owner の live を判定
- 死 owner の行は `g_pos` も `g_sec_pos[sec]` も進めない (pass1 の
  集計と整合)
- 数値ラベル参照 (`0f`/`0b`) も live filter

### Phase 5: テスト

- `tests/bench_pipeline.sh` で peak が目標下になるか確認
- `tests/test_pico2_phase7_sd.sh` (実機) で full pipeline が完走
- `make test` ホスト側で全 task / kernel build がリンク変化なし
  (= 同じ ELF が出力される — section size / address は変わって OK、
   実行結果が同じなら良い)

### Phase 6: docs 更新

- `docs/lab_format.md` を v2 に更新 (skip 行 / live フラグ)
- `docs/compiler.md` § asm_pass2/2 を更新 (3-phase 化)
- `docs/scaling.md` に削減結果を記録

---

## リスク / 未解決

1. **`@global_pointer$` のような特殊 symbol** をハードコード root
   リストから漏らすとリンクが壊れる。実装時に
   `crt0_tc.s` / `task_crt0.s` 中の参照を grep して網羅
2. **アセンブリの間接参照** (関数ポインタを `.word` で table 化、
   `lw` で読んで `jr`) は call graph に現れない。task_crt0.s や
   runtime.s で使ってないか要確認 (現状は使用なしと推定)
3. **重複 symbol** (last-wins) の扱い。死の方が先に定義されると
   BFS で訪れず、後の live が認識されない可能性。`define_label`
   が duplicate 時に live フラグを OR で merge する
4. **Gen2 ホスト build の互換**。`compile-gen2.sh` も新 .lab v2 を
   読む必要あり。同じ asm_pass3 binary を使うので自動的に追従
5. **asm_pass2 メモリ予算**: g_refs + bitmap で 70 KB 増は痛い。
   XIP 直読み (Step 2.1) と同時にやれば I/O ペナルティを相殺
   できるが、メモリは増えたまま。150 KB target を 200 KB target
   に緩める判断が要る

---

## 関連

- `docs/lab_format.md` — `.lab` 中間形式 (v2 で skip 行 + live
  フラグを追加予定)
- `docs/compiler.md` § asm_pass2/asm_pass3 — 現行 2-pass 構成
- `docs/scaling.md` — pico2 timing baseline (asm_pass2+pass2 が
  pipeline の 80% を占める)
- `docs/task/pipeline_100kb.md` — メモリ削減経緯 (これと併せて
  時間 + メモリ両面で attack)
