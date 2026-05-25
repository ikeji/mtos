# compiler/

TinyC 言語コンパイラ。Gen1 (C 製、x86 ホスト) でブートストラップし、
Gen2/3 (TC 自己ホスト) で RV32 ELF + MTOS raw bin を生成する。

## 構成

- `bootstrap/` — Gen1: C 実装 (parse, codegen, bc2asm, bcrun, ...)
- `src/` — Gen2/3: TC 実装 (parse.tc, sigscan.tc, tcheck.tc, ...)
- `runtime/linux/` — Linux ELF + qemu-riscv32 用 crt0
- `runtime/mtos/` — MTOS bin 用 crt0 (userland と compiler-on-MTOS 共用)
- `scripts/` — compile-gen{1,2,3}.sh + helper
- `tests/` — compiler 単体テスト

## ビルド

ルート Makefile を経由するのが標準。

```bash
make gen2-tools     # build/gen2/* (RV32 ELF)
make gen3-tools     # build/gen3/* (Gen2==Gen3 検証用)
```

`compiler/Makefile` 単独でも:

```bash
make -C compiler         # gen2-tools 相当
make -C compiler test    # compiler テストのみ (~60s, 140 tests)
make -C compiler test-warm  # golden/gen3 抜き高速版
```

## 出力 (build/ 配下)

- `build/gen1/{parse,codegen,bc2asm,bcrun,interp,typecheck}` — x86 ELF
- `build/gen2/{parse,sigscan,tcheck,codegen,bc2asm,asm_pass{1,2,3},bcrun}` — RV32 ELF
- `build/gen3/*` — 同上 (Gen2 == Gen3 byte-exact 検証用)

詳細は `../docs/sources.md`、設計は `../docs/compiler.md` / `../docs/task/subproject_split.md`。
