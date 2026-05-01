# .idx フォーマット (per-file pre-link 中間ファイル)

## 概要

`asm-pass1` の **per-file 抽出モード** が `.s` を 1 回読んで集めた
**ファイル単位**のメタデータをテキストで吐く。コードバイト本体は
含めない（`.s` をそのまま `.s` としてリンカに渡す）。

リンカ (= asm-pass1 の link モード) が `.idx × N + .s × N` を入力に
取り、merge → BFS → アドレス確定 → `.lab` 出力する。`.lab` は
asm-pass2 (encode) がそのまま現状フォーマットで読む。

**主な用途は prelude キャッシュ**: kernel build 時に host 側で
`prelude.s` を `.idx` 化して mtfs に staging しておけば、OS 上の
`asm-pass1` は user.s だけ source walk すれば済む。pico2 で
prelude 部の source walk が ~90 秒占めるので、ここを定数時間に
できるのが大きな利点。

## .idx と .lab の違い

| | `.idx` | `.lab` |
|---|---|---|
| 単位 | per-file | 最終リンク済み (全ファイル分マージ後) |
| label addr | intra (= section 内 offset) | 絶対 (section_base + intra) |
| label の範囲 | 全部 (liveness 未確定) | live のみ |
| ref エッジ | あり (BFS で必要) | なし (BFS 後なので不要) |
| section size | このファイルの寄与分 | 全 file 合計 (live のみ) |
| numeric label | あり (per-file) | あり (merge 後 source 順) |

## 行の種別

各行は 1 個のキーワード (空白区切りの先頭トークン) で識別する。
基本的な書式は `.lab` と同じで、加わるのは `ref` と
`secsize` の 2 種、`sec` の base は使わない (常に 0 を出す)。

| key | 形式 | 意味 |
|---|---|---|
| `;`  | `; ...` | 行コメント。`; idx v1` で仕様バージョンを示す |
| `secsize` | `secsize <id> <size>` | このファイルが各 section に寄与する byte 数 |
| `lab` | `lab <intra> <section> <name>` | 通常ラベル。**intra = section 内 offset** |
| `num` | `num <digit> <intra> <section>` | 数値ラベル。section 情報を持つのは merge 時に絶対値へ変換するため |
| `ref` | `ref <owner_name> <target_name>` | 参照エッジ (owner → target)。owner は label name で記録 (idx は merge 後に再採番されるため) |

行末は LF。空行は無視。

### `secsize` (4 個必須)

```
secsize <id> <size>
```

- `id`: 0=text, 1=rodata, 2=data, 3=bss
- `size`: このファイルの section 寄与 byte 数 (16-byte align 後)

リンカは `.idx` を順に読んで各 section の寄与を累積していくと
最終 section size が出る。ファイル間の継ぎ目で 16-byte align は
そのまま (asm-pass1 の section pad と同じセマンティクス)。

### `lab` (任意個)

```
lab <intra> <section> <name>
```

- `intra`: そのファイル内・そのセクション内での offset (10 進)
- `section`: 0..3
- `name`: 空白を含まない識別子

リンカは複数 `.idx` を読むとき、ファイル順で `prev_secsize[s]` を
累積し、`absolute_intra = sum_prev_secsize_for_section[s] + intra`
とする。これに最終 `section_base` を足したものが絶対アドレス。

**重複する label 名**は merge 時に **後勝ち** (asm-pass1 の現挙動)。
task_crt0 の fallback `main` が user の `main` で上書きされる挙動を
維持する。

### `num` (任意個)

```
num <digit> <intra> <section>
```

`.lab` の `num` には section が無いが、`.idx` 時点ではまだ section
base が確定していないので intra + section の組で持つ。merge 時に
絶対値へ変換して `.lab` の `num <digit> <addr>` 形式に落とす。

ソース順を保つため、リンカは `.idx` のファイル順 × ファイル内の
出現順で `numlab_back` / `numlab_fwd` の前提を再現する。

### `ref` (任意個)

```
ref <owner_name> <target_name>
```

- `owner_name`: そのバイトを所有する label 名 (`define_label` の
  最後に setting した g_owner_idx の名前)
- `target_name`: 参照先 label 名

owner / target いずれも文字列で持つ。merge 後は
`find_label(owner_name)` / `find_label(target_name)` で idx を引き
直して BFS の入力にする。

`.L_FNAME_pcN` 形式の local label は owner にも target にもなり得る
が、owner にはならない (define_label が owner を更新しない)。
target としては記録される (`j .L_xxx_pcN`)。

ref 行の owner が見つからない場合は無視 (= section root) — Phase 5
の strip 中など、現状でも owner=-1 のまま record_ref を呼ぶケースが
あるが、これは省略する。

## サンプル

```asm
.text
add_one__i32:
    addi a0, a0, 1
    ret
.data
COUNT:
    .word 42
```

```
; idx v1
secsize 0 16
secsize 1 0
secsize 2 16
secsize 3 0
lab 0 0 add_one__i32
lab 0 2 COUNT
```

`add_one__i32` は .text の 0 から、`COUNT` は .data の 0 から始まる
(intra)。`ret` 命令と `addi` で 8 byte 使い、16-byte align で
secsize 16。`.word 42` は 4 byte だが secsize 16 (align)。

参照は無いので `ref` 行なし。

## 設計判断

### なぜ owner/target を idx でなく name で持つか

`.idx` 単独では idx の global 採番が決まらない (merge 後に確定)。
file ごとに idx が独立だと merge で破綻する。string で持って
merge 後に再 lookup するのが一番安全 (find_label のコスト ≈ 1 度の
ハッシュ照会で済む)。

### なぜ section size を per-file で持つか

merge 時に section_base を計算するため。
- ファイル N の section S での絶対 base = sum_{i < N} secsize_i[S]
- 全ファイル分の合計を取れば最終 section_size

`.lab` の `sec base size` はこの最終形。

### なぜ ref を `.lab` には残さないか

asm-pass2 (encode) は live ラベルの **アドレス**だけ知れば良く、
誰が誰を呼んでいるかは要らない。BFS は merge 段階で済んでいる。

### バージョン

- v1: 本書記載の形式 (`; idx v1`)

互換性のない変更時にバージョンを上げる。

## 4 段パスとの対応

[asm dead-strip + .idx の改装案 (docs/task/asm_pass_split.md)](task/asm_pass_split.md)
を参照。

```
[Pass 1: extract]  per-file:    .s  → .idx
[Pass 2: cull]     in-memory:   .idx × N → live set (BFS)
[Pass 3: addr]     in-memory:   .idx × N + live → .lab (絶対 addr)
[Pass 4: encode]   asm-pass2:   .lab + .s × N → ELF/raw
```

実装は当面、Pass 1 を asm-pass1 の `--emit-idx` モード、Pass 2-3 を
asm-pass1 の `--load-idx` モード (現 .lab 出力経路に合流)、Pass 4
を既存 asm-pass2 で表現する。
