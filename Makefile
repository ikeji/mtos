CC = gcc
CFLAGS = -Wall -Wextra -g -I src

SRCS = src/lexer.c src/ast.c src/parser.c src/typecheck.c src/interp.c src/codegen.c
OBJS = $(SRCS:.c=.o)

all: parse typecheck interp codegen bcrun bc2asm

parse: $(OBJS) src/parse_main.o
	$(CC) -o $@ $^

typecheck: $(OBJS) src/typecheck_main.o
	$(CC) -o $@ $^

interp: $(OBJS) src/interp_main.o
	$(CC) -o $@ $^

codegen: $(OBJS) src/codegen_main.o
	$(CC) -o $@ $^

bcrun: src/bcrun.c
	$(CC) $(CFLAGS) -o bcrun src/bcrun.c

bc2asm: src/bc2asm.c
	$(CC) $(CFLAGS) -o bc2asm src/bc2asm.c

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) src/parse_main.o src/typecheck_main.o src/interp_main.o src/codegen_main.o parse typecheck interp codegen bcrun bc2asm

test: all
	./tests/run_tests.sh

update-golden: all
	./tests/update_golden.sh

.PHONY: all clean test update-golden
