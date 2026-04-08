CC = gcc
CFLAGS = -Wall -Wextra -g -I bootstrap

SRCS = bootstrap/lexer.c bootstrap/ast.c bootstrap/parser.c bootstrap/typecheck.c bootstrap/interp.c bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

all: parse typecheck interp codegen bcrun bc2asm

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

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) bootstrap/parse_main.o bootstrap/typecheck_main.o bootstrap/interp_main.o bootstrap/codegen_main.o parse typecheck interp codegen bcrun bc2asm

test: all
	./tests/test_all.sh

update-golden: all
	./tests/update_golden.sh

update-golden-and-run-test: all
	./tests/update_golden.sh
	./tests/test_all.sh

.PHONY: all clean test update-golden update-golden-and-run-test
