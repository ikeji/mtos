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

```bash
make -C compiler           # gen2 (default)
make -C compiler gen1      # compiler/build/gen1/ (C 製 Gen1)
make -C compiler gen2      # compiler/build/gen2/ (RV32 ELF + qemu-riscv32)
make -C compiler gen3      # compiler/build/gen3/ (Gen2 == Gen3 検証用)
make -C compiler test      # 140 tests (~60s)
make -C compiler test-warm # golden/gen3/consistency 抜き高速版
make -C compiler test-asm-bins  # build/test/asm/*.bin プリビルド
make -C compiler update-golden  # compiler/tests/golden/ 再生成
```

## 出力 (build/ 配下)

- `compiler/build/gen1/{parse,codegen,bc2asm,bcrun,interp,typecheck}` — x86 ELF
- `compiler/build/gen2/{parse,sigscan,tcheck,codegen,bc2asm,asm_pass{1,2,3},bcrun}` — RV32 ELF
- `compiler/build/gen3/*` — 同上 (Gen2 == Gen3 byte-exact 検証用)

詳細は `../docs/sources.md`、設計は `../docs/compiler.md` / `../docs/task/subproject_split.md`。
