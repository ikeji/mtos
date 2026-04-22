# Naming / Type-abuse リファクタリング

作業ルール:
- **A. 関数名に型名を入れない** (`eq_lit`, `print_u32`, `copy_range_u8` 等)
- **B. ある型を別の型として abuse しない** (`I32Array` を struct の packed 配列として使う等)

## レビュー結果

全項目レビュー完了 (2026-04-22)。以下の通り決定:

### A パート (関数名)

| ID | 項目 | 決定 | 備考 |
|---|---|---|---|
| A1 | `print_i32` / `print_u32` / `print_bool` / `print_str` (runtime.tc) | **採用** | overload `print` に統合。u32 は桁落ち回避のため独立実装 |
| A2 | `copy_range` / `copy_range_u8` (sh.tc, msh.tc) | **採用** | 前者を `substr`、後者を `subcstr` に rename |
| A3 | `scan_eot_u8` (cat.tc) | **採用** | ファイル内 rename (→ `scan_eot`) |
| A4 | `copy_task_name_lit` / `copy_task_name_addr` (loader.tc) | **採用** | `copy_task_name_lit` → `to_cstr_raw`、`copy_task_name_addr` → `basename_copy` (private `copy_task_name` は吸収)。u32 戻り値を U8Array に変更 |
| A5 | `load_str_nul` (loader.tc) / `str_u8_nul` (kernel.tc) | **採用** | kernel_common.tc に `to_cstr(StringLiteral)` を export、重複削除 |
| A6 | `bc_fatal_lit` / `bc_fatal_name` (bcrun.tc) | **採用** | `bc_fatal` overload に統合 |
| A7 | `lab_hash_name_u8` (asm_common.tc) | **採用** | `lab_hash_name` overload (2 引数版) |
| A8 | `emit_param_lit/struct/arr` / `emit_ret_lit/struct/arr` (parse.tc) | **採用** | `_lit` と `_struct` は `emit_param` / `emit_ret` overload に統合、`_arr` は操作が違うので残す |
| A9 | `set_annot_lit` / `resolve_overload_lit` / `err_lit` (tcheck.tc) | **採用** | suffix 削除して overload 化 (`err_slice` もペア) |
| A10 | `le_u32` / `inode_u32` / `read_u32_le` / `write_u32_le` (mtfs.tc, fatfs.tc) | **採用** | `kernel_common.tc` に `read_le32` / `write_le32` / `read_le16` / `write_le16` を export、重複削除。`inode_u32` は inline |
| A11 | `tc_*` prefix (sh.tc) | **採用** | `tab_*` prefix に変更 |
| A12 | `write_i32_stderr` / `write_str_stderr` (runtime.tc) | **採用** | `eprint(i32)` / `eprint(StringLiteral)` overload |
| A13 | `str_to_nul` 残存確認 | **スキップ** | 既に削除済 (actionable なし) |

### B パート (型 abuse)

| ID | 項目 | 決定 | 備考 |
|---|---|---|---|
| B1 | `g_hist: I32Array` (sh.tc) | **採用** | `StringArray` に変更、エントリを `String` で管理 |
| B2 | `g_pipe_*` parallel arrays (vfs.tc) | **採用** | `struct Pipe` + `PipeArray` に統合 |
| B3 | `params_pool` / `locals_pool` / `instrs` (bc2asm.tc + bcrun.tc) | **部分採用** | pools のみ struct 化 (bc2asm: `StrRef` / bcrun: `VarRef`)。`instrs` は dense に 16 K slot × 4 i32 で流れているため、struct array 化するとポインタ間接 + ヘッダで ~320 KB になり現在 (260 KB) より悪化するので見送り |
| B4 | `vartab` / `fntab` (tcheck.tc) | **部分採用** | vartab のみ struct 化 (`VarEntry` + `VarEntryArray`)。fntab は np 依存の可変長レコードで、固定部 + params 別アロケーションに分割すると kmalloc が 1→2 に増え節約にならないので見送り |
| B5 | `fi: I32Array` (parse.tc) | **採用** | `struct FieldInfo` + `FieldInfoArray` |
| B6 | `string_lits` / `global_vars` / `global_inits` (bc2asm.tc) | **採用** | `StrRef` 再利用、`struct GlobalVar { name, ty, init }` で 3 配列を 1 本化 |
| B7 | `g_cfg_inits: U32Array` (kernel_common.tc) | **採用** | `StringArray` に変更 |
| B8 | `as u32 as i32` round-trip (vfs.tc:552) | **採用 (B2 で自動解消)** | 独立 action 不要 |

## 実装順 (小→大)

リスクの小さい順に実装、各項目ごとに commit。

1. A11 sh.tc `tc_*` → `tab_*` (local)
2. A3 cat.tc `scan_eot_u8` → `scan_eot` (local)
3. A5 kernel_common.tc `to_cstr`、loader.tc / kernel.tc 側重複削除
4. A4 loader.tc の 3 関数再編 (`to_cstr_raw` / `basename_copy`、戻り値 U8Array 化)
5. A7 asm_common.tc `lab_hash_name_u8` 統合
6. A6 bcrun.tc `bc_fatal` overload
7. A9 tcheck.tc `set_annot` / `resolve_overload` / `err` overload
8. A2 sh.tc / msh.tc `copy_range` → `substr`、`copy_range_u8` → `subcstr`
9. A12 runtime.tc `eprint` overload
10. A1 runtime.tc `print` overload (bcrun builtin dispatch + tcheck 登録も更新)
11. A10 kernel_common.tc に `read_le32` / `write_le32` / `read_le16` / `write_le16`
12. A8 parse.tc `emit_param` / `emit_ret` overload
13. B7 kernel_common.tc `g_cfg_inits` → StringArray
14. B1 sh.tc `g_hist` → StringArray
15. B2 vfs.tc `g_pipe_*` → `struct Pipe` + `PipeArray` (B8 解消)
16. B5 parse.tc `fi` → `FieldInfo`
17. B6 bc2asm.tc `string_lits` / `global_vars` / `global_inits` 統合
18. B3 bc2asm.tc + bcrun.tc `StrRef` + `BcInstr`
19. B4 tcheck.tc `VarEntry` + `FnEntry`

## 除外 / 却下

- `is_digit` / `is_alpha` / `is_ws` / `parse_int` — 概念名
- `heap_new_u8` / `heap_new_i32` / `heap_new_str` — 要素サイズが異なる別アロケータ
- `base_name_len` / `tok_len` など `_len` / `_ss` / `_sl` — フィールド名
- `e_addi` / `e_sw` / `eregt0` — RISC-V ニーモニック / レジスタ名
