CC = gcc
CFLAGS = -Wall -Wextra -g -I src

SRCS = src/lexer.c src/ast.c src/parser.c src/typecheck.c src/interp.c
OBJS = $(SRCS:.c=.o)

all: parse typecheck interp

parse: $(OBJS) src/parse_main.o
	$(CC) -o $@ $^

typecheck: $(OBJS) src/typecheck_main.o
	$(CC) -o $@ $^

interp: $(OBJS) src/interp_main.o
	$(CC) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) src/parse_main.o src/typecheck_main.o src/interp_main.o parse typecheck interp

.PHONY: all clean
