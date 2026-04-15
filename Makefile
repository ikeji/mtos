CC = gcc
CFLAGS = -Wall -Wextra -g -I bootstrap

SRCS = bootstrap/lexer.c bootstrap/ast.c bootstrap/parser.c bootstrap/typecheck.c bootstrap/interp.c bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

# Gen1 ツール (C 製、repo 直下に置く。Phase A では build/gen1/ 移動
# はせず、後続 Phase で整理する)
GEN1_TOOLS = parse typecheck interp codegen bcrun bc2asm extract-sigs

# Gen2 ツール (compile-gen1.sh で compiler/*.tc を RV32 ELF に。
# build/gen2/ 固定にして make test 2 回目以降は再ビルドを避ける)
GEN2_NAMES = parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2
GEN2_TOOLS = $(addprefix build/gen2/,$(GEN2_NAMES))

all: $(GEN1_TOOLS)

parse: $(OBJS) bootstrap/parse_main.o
	$(CC) -o $@ $^

typecheck: $(OBJS) bootstrap/typecheck_main.o
	$(CC) -o $@ $^

interp: $(OBJS) bootstrap/interp_main.o
	$(CC) -o $@ $^

codegen: $(OBJS) bootstrap/codegen_main.o
	$(CC) -o $@ $^

bcrun: bootstrap/bcrun.c
	$(CC) $(CFLAGS) -o bcrun bootstrap/bcrun.c

bc2asm: bootstrap/bc2asm.c
	$(CC) $(CFLAGS) -o bc2asm bootstrap/bc2asm.c

extract-sigs: bootstrap/extract_sigs.c bootstrap/ast.o
	$(CC) $(CFLAGS) -o extract-sigs bootstrap/extract_sigs.c bootstrap/ast.o

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Gen2 ツールを compile-gen1.sh で build。transitive import 追跡は
# recipe 末尾で `tools/tc_deps_to_d.sh` が .d を書き出し、top Makefile
# が `-include` で取り込む (Phase B)。2 回目以降の make test はこの .d
# で「触っていない .tc 経由のツール」を正しくスキップできる。
build/gen2:
	mkdir -p $@

build/gen2/%: compiler/%.tc $(GEN1_TOOLS) tools/collect_imports.sh tools/tc_deps_to_d.sh | build/gen2
	./compile-gen1.sh -o $@ $<
	./tools/tc_deps_to_d.sh $@ $< > $@.d

gen2-tools: $(GEN2_TOOLS)

# .d の内容を取り込む。Phase B で導入。初回ビルドでは存在しないので
# `-include` (エラーにしない) を使う
-include $(addsuffix .d,$(GEN2_TOOLS))

clean:
	rm -f $(OBJS) bootstrap/parse_main.o bootstrap/typecheck_main.o bootstrap/interp_main.o bootstrap/codegen_main.o parse typecheck interp codegen bcrun bc2asm extract-sigs
	rm -rf build

test: all $(GEN2_TOOLS)
	./tests/test_all.sh

full-test: all $(GEN2_TOOLS)
	FULL_TEST=1 ./tests/test_all.sh

update-golden: all
	./tests/update_golden.sh

update-golden-and-run-test: all $(GEN2_TOOLS)
	./tests/update_golden.sh
	./tests/test_all.sh

.PHONY: all clean test full-test update-golden update-golden-and-run-test gen2-tools
