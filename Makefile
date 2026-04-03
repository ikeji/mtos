CC = gcc
CFLAGS = -Wall -Wextra -g -I compiler

SRCS = compiler/lexer.c compiler/ast.c compiler/parser.c compiler/typecheck.c compiler/interp.c compiler/codegen.c
OBJS = $(SRCS:.c=.o)

all: parse typecheck interp codegen bcrun bc2asm

parse: $(OBJS) compiler/parse_main.o
	$(CC) -o $@ $^

typecheck: $(OBJS) compiler/typecheck_main.o
	$(CC) -o $@ $^

interp: $(OBJS) compiler/interp_main.o
	$(CC) -o $@ $^

codegen: $(OBJS) compiler/codegen_main.o
	$(CC) -o $@ $^

bcrun: compiler/bcrun.c
	$(CC) $(CFLAGS) -o bcrun compiler/bcrun.c

bc2asm: compiler/bc2asm.c
	$(CC) $(CFLAGS) -o bc2asm compiler/bc2asm.c

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) compiler/parse_main.o compiler/typecheck_main.o compiler/interp_main.o compiler/codegen_main.o parse typecheck interp codegen bcrun bc2asm

test: all
	./tests/run_tests.sh

update-golden: all
	./tests/update_golden.sh

.PHONY: all clean test update-golden
