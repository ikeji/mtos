# 関数オーバーロード実装計画

## 概要

引数の型が異なる同名関数（オーバーロード）をサポートする。
typecheck フェーズは既にオーバーロード解決ロジック（`resolve_overload`）を持っているが、
codegen が型情報を破棄しているため .bc に型情報が残らない。

## 設計方針

### .bc フォーマット変更

**変更前:**
```
.fn to_buf 1 U8Array
.param str String
  call to_buf 1
```

**変更後:**
```
.fn to_buf String U8Array     ← マングルなし名前 + 引数の型リスト + 戻り値の型
.param str String
  call to_buf String          ← マングルなし名前 + 引数の型リスト
```

**.bc ファイルにはマングルされた名前は出てこない。**

`.fn` のフォーマット: `NAME ARG_TYPE1 ... ARG_TYPEn RET_TYPE`（最後のトークンが戻り値の型）

### マングリングの場所

マングリングは **bc2asm と bcrun の内部** で行う。

```
.bc ファイル（マングルなし）
  ↓
bc2asm / bcrun が内部でマングル:
  .fn to_buf String U8Array → 実体名 "to_buf__String"
  call to_buf String        → "to_buf__String" を呼び出す
  ↓
アセンブリ / 実行: マングルされた名前を使用
```

### マングリング規則

`関数名 + "__" + 型1 + "__" + 型2 + ...`（引数なしはマングリングなし）

| 関数シグネチャ | マングル名（内部のみ） |
|----------------|----------------------|
| `main()` | `main` |
| `to_buf(str: String)` | `to_buf__String` |
| `len(a: U8Array)` | `len__U8Array` |
| `add(x: i32, y: i32)` | `add__i32__i32` |
| `append(s: String, c: u8)` | `append__String__u8` |

### 整数型の自動変換を廃止

現在 `resolve_overload` は「いずれかが整数型なら互換」と扱う `types_compatible`
の fallback を持つ。これを削除し、厳密な型一致のみを要求する。

**変更前 (typecheck.c):**
```c
/* Try with integer coercion */
for (FnSig *s = e->fns; ...) {
    if (!types_compatible(s->param_types[i], arg_types[i])) { ... }
}
```

**変更後:** exact match のみ（2 回目のループを削除）。

これを保証するテストを追加する（詳細は後述）。

### pipeline モードを完全自己ホストにする

**現在の pipeline モード:**
```
parse.tc(BC) → parse(source) → AST
codegen.tc(BC) → codegen(AST) → BC
```

**変更後の pipeline モード:**
```
parse.tc(BC)    → parse(source)    → AST
typecheck.tc(BC)→ typecheck(AST)   → Typed AST   ← 新規
codegen.tc(BC)  → codegen(TAST)    → BC
```

typecheck.tc を新規作成し、C 実装の `./typecheck` バイナリに依存しない。

## 実装ステップ

---

### Step 1: bootstrap/typecheck.c — 整数型自動変換の削除

`resolve_overload` から integer coercion の fallback を削除する。
exact match のみ残す。

```c
// 削除するコード (typecheck.c ~line 183-194):
/* Try with integer coercion */
for (FnSig *s = e->fns; s; s = s->next) { ... types_compatible ... }
if (nmatch == 1) return matched;
```

`types_compatible` 関数自体も削除する（他で使われていなければ）。

---

### Step 2: bootstrap/codegen.c — call 命令の型リスト出力

#### 2a. call / call_stmt のフォーマット変更

引数の数ではなく各引数の `type_annot` を出力する。

```c
// 変更前 (line 149):
fprintf(cg->out, "  call %s %d\n", node->sval, node->nchildren);

// 変更後:
fprintf(cg->out, "  call %s", node->sval);
for (int i = 0; i < node->nchildren; i++) {
    const char *ty = node->children[i]->type_annot;
    fprintf(cg->out, " %s", ty ? ty : "?");
}
fprintf(cg->out, "\n");
```

call_stmt (line 254) も同様。

#### 2b. `.fn` 定義のフォーマット変更

`NPARAMS`（引数の数）を廃止し、引数の型リストを出力する。

```c
// 変更前 (cg_fn, line 338):
fprintf(cg->out, ".fn %s %d %s\n", fname, params->nchildren, ret_type);

// 変更後:
fprintf(cg->out, ".fn %s", fname);
for (int i = 0; i < params->nchildren; i++) {
    fprintf(cg->out, " %s", params->children[i]->children[0]->sval);  // param type
}
fprintf(cg->out, " %s\n", ret_type);
```

---

### Step 3: bootstrap/codegen_main.c — stdin でも typecheck を実行

```c
// 変更前:
} else {
    /* stdin: assume typed AST */
    prog = ast_read(stdin);
}

// 変更後:
} else {
    /* stdin: run typecheck */
    prog = ast_read(stdin);
    typecheck(prog, filename);
}
```

---

### Step 4: bootstrap/bcrun.c — .fn のマングル + call のマングルルックアップ

#### 4a. `.fn` 読み込み時: 型リストからマングル名を即計算

`.fn` 行の形式が `NAME ARG_TYPE... RET_TYPE` になる。
最後のトークンを戻り値の型とし、それ以前を引数の型として読む。
**`.fn` 行だけでマングル名が確定するため、`.param` を待つ必要がない。**

```c
} else if (strcmp(dir, "fn") == 0) {
    // トークンをすべて読んで最後を rettype、それ以前を arg types とする
    char toks[16][64]; int ntok = 0;
    const char *p = s;
    while (*p && ntok < 16) {
        p = skip_ws(p);
        if (!*p) break;
        p = next_tok(p, toks[ntok], sizeof(toks[0]));
        if (toks[ntok][0]) ntok++;
    }
    // toks[0]=name, toks[1..ntok-2]=arg_types, toks[ntok-1]=ret_type
    const char *fname = toks[0];
    int nargs = ntok - 2;  // ntok >= 2 (name + rettype)
    const char *argtypes[16]; for (int i = 0; i < nargs; i++) argtypes[i] = toks[1+i];
    const char *rettype = toks[ntok-1];

    char mangled[512];
    build_mangled(mangled, sizeof(mangled), fname, argtypes, nargs);

    cur = prog_new_func(p_prog);
    cur->name     = strdup(mangled);
    cur->ret_type = strdup(rettype);
    label_free(&lt);
}
```

#### 4b. `call` パース変更: 型リストを読んでマングル

```c
// 変更前:
else if (!strcmp(op, "call")) {
    char nm[128], na[16];
    s = skip_ws(next_tok(s, nm, sizeof(nm)));
    next_tok(s, na, sizeof(na));
    ins.sarg = strdup(nm);
    ins.ival = atol(na);
}

// 変更後:
else if (!strcmp(op, "call")) {
    char nm[128];
    s = skip_ws(next_tok(s, nm, sizeof(nm)));
    // 残りのトークンを型リストとして読む
    char types[8][64]; int ntypes = 0;
    const char *p = s;
    while (*p && ntypes < 8) {
        p = skip_ws(p);
        if (!*p) break;
        char tok[64]; p = next_tok(p, tok, sizeof(tok));
        if (tok[0]) { strncpy(types[ntypes++], tok, 63); }
    }
    char *tptrs[8];
    for (int i = 0; i < ntypes; i++) tptrs[i] = types[i];
    char mangled[512];
    build_mangled(mangled, sizeof(mangled), nm, (const char**)tptrs, ntypes);
    ins.sarg = strdup(mangled);
    ins.ival = ntypes;
}
```

`build_mangled` は共通ヘルパー関数として追加する。

#### 4c. is_builtin もマングル名で管理

`is_builtin("len__U8Array")` が true になるよう更新、
または dispatch 時にマングル→ビルトイン対応テーブルを参照する。

---

### Step 5: bootstrap/bc2asm.c — 同様の変更

#### 5a. `.fn` 読み込み: `.fn` 行でマングル名を計算してラベルを emit

`.fn` 行から bcrun と同様に `NAME ARG_TYPE... RET_TYPE` をパースし、
マングル名を計算してアセンブリラベルとして出力する。

```asm
; 変更前:
to_buf:

; 変更後:
to_buf__String:
```

#### 5b. `call` パース: 型リスト → マングル名 → RISC-V call

```c
// call 命令の emit:
E("    call %s\n", mangled_name);   // already mangled
```

---

### Step 6: テスト — 整数型自動変換がないことを確認

`tests/` に新規テストファイルを追加:

```
tests/golden/no_coercion.tc
```

```tinyc
// 整数型の自動変換が行われないことを確認するテスト
fn take_u8(x: u8) -> u8 { return x; }
fn take_i32(x: i32) -> i32 { return x; }

fn main() -> i32 {
    var a: u8 = take_u8(42u8);      // OK: u8 → u8
    var b: i32 = take_i32(100);      // OK: i32 → i32
    return 0;
}
```

また、型不一致でコンパイルエラーになることを確認するネガティブテスト
（exit code が 0 以外になること）も追加する。

---

### Step 7: compiler/typecheck.tc — 新規作成（最大の作業）

typecheck.c の機能を TinyC で実装する。

#### 実装する機能

1. **関数シグネチャ収集** (collect_fn): 全 fn ノードを走査し FnSig テーブルを構築
2. **型チェック** (check_expr, check_stmt, check_fn): AST を走査して型注釈
3. **オーバーロード解決** (resolve_overload): 厳密な型一致のみ
4. **組み込み関数登録** (register_builtins): len, get, set, peek8, etc.
5. **型注釈の出力**: type_annot が設定された AST を stdout に出力

#### 入出力

```
stdin:  テキスト形式の AST (parse.tc の出力)
stdout: type_annot が設定されたテキスト形式の AST
```

AST はテキスト形式（S 式）なので、typecheck.tc は:
1. AST テキストをパース（ast_read 相当）
2. 型チェックして type_annot を設定
3. AST テキストを出力（ast_print 相当）

**注意:** AST テキストのパース/出力は parse.tc / codegen.tc が既に実装している
パーサーを流用できる。typecheck.tc は AST の読み書きモジュールが必要。

#### ファイル構成

```
compiler/typecheck.tc     — メインの型チェッカー
```

#### 実装上の制約

- TinyC には連想配列がないため、関数テーブルは配列で実装
- 文字列比較は stab_eq など既存のユーティリティを参考にする
- parse.tc の AST 読み書きコードを参考/流用する

---

### Step 8: tc_run.sh — pipeline モードに typecheck.tc を追加

```bash
# 変更前
pipeline)
    PARSE_TC_BC=$("$CODEGEN" "$TC_DIR/parse.tc")
    CODEGEN_TC_BC=$("$CODEGEN" "$TC_DIR/codegen.tc")
    AST=$({ echo "$PARSE_TC_BC"; cat "$TC_FILE"; } | "$BCRUN")
    BC=$({ echo "$CODEGEN_TC_BC"; echo "$AST"; } | "$BCRUN")
    { echo "$BC"; emit_stdin; } | "$BCRUN"

# 変更後
pipeline)
    PARSE_TC_BC=$("$CODEGEN" "$TC_DIR/parse.tc")
    TYPECHECK_TC_BC=$("$CODEGEN" "$TC_DIR/typecheck.tc")  # 新規
    CODEGEN_TC_BC=$("$CODEGEN" "$TC_DIR/codegen.tc")
    AST=$({ echo "$PARSE_TC_BC"; cat "$TC_FILE"; } | "$BCRUN")
    TAST=$({ echo "$TYPECHECK_TC_BC"; echo "$AST"; } | "$BCRUN")  # 新規
    BC=$({ echo "$CODEGEN_TC_BC"; echo "$TAST"; } | "$BCRUN")
    { echo "$BC"; emit_stdin; } | "$BCRUN"
```

---

### Step 9: compiler/codegen.tc — call 命令の型リスト出力

Step 2 の変更を TinyC で実装。
各引数の type_annot を読んで `call NAME TYPE1 TYPE2...` を出力する。

codegen.tc が現在 type_annot を読んでいるか確認し、読んでいない場合は
AST ノード読み込み部分に type_annot の読み取りを追加する。

---

### Step 10: compiler/bc2asm.tc — call パースとマングリング

Step 5 の変更を TinyC で実装。

---

### Step 11: compiler/bcrun.tc — .fn マングルと call ルックアップ

Step 4 の変更を TinyC で実装。

---

### Step 12: テストスクリプトの更新

`tests/run_example_tests.sh`, `tests/run_compiler_tests.sh` で
pipeline に typecheck.tc を挿入する。

---

### Step 13: ドキュメント更新 + golden 再生成

```bash
make update-golden
make test
```

`docs/bc_format.md` の `call` 命令仕様を更新。

---

## 実装順序まとめ

| # | ファイル | 変更内容 | サイズ |
|---|---------|---------|--------|
| 1 | `bootstrap/typecheck.c` | 整数型強制変換を削除 | 小 |
| 2 | `bootstrap/codegen.c` | call: 型リスト出力 | 小 |
| 3 | `bootstrap/codegen_main.c` | stdin でも typecheck | 小 |
| 4 | `bootstrap/bcrun.c` | .fn マングル + call マングルルックアップ | 中 |
| 5 | `bootstrap/bc2asm.c` | 同上 | 中 |
| 6 | テスト追加 | no_coercion.tc, negative test | 小 |
| 7 | `compiler/typecheck.tc` | 新規作成（AST 読み書き + 型チェック） | **大** |
| 8 | `tc_run.sh` | pipeline に typecheck.tc | 小 |
| 9 | `compiler/codegen.tc` | call: 型リスト出力 | 小 |
| 10 | `compiler/bc2asm.tc` | call マングル | 中 |
| 11 | `compiler/bcrun.tc` | .fn マングル + call マングルルックアップ | 中 |
| 12 | テストスクリプト更新 | typecheck.tc を pipeline に | 小 |
| 13 | docs + golden 更新 | bc_format.md + make update-golden | 小 |

---

## リスク・注意点

1. **typecheck.tc が最大の作業:** TinyC で型チェッカーを書くには AST テキストの
   読み書き（parse.tc の AST パーサー相当）も実装が必要。

2. **ビルトイン関数のマングル:** `len__U8Array`, `get__U8Array__u32` などが
   bc2asm/bcrun のビルトイン判定で正しく扱われる必要がある。
   ビルトイン判定はマングル前の名前で行い、マングル名から元の名前に逆引きするか、
   マングル済み名前のテーブルを持つ。

3. **整数型変換なしの影響:** 既存コードで `u8` と `i32` を混在させている場合、
   明示的な cast が必要になる。compiler/ の .tc ファイルを先に確認。

4. **golden ファイルは全件更新:** .bc の call 形式が変わるため大量更新が必要。
