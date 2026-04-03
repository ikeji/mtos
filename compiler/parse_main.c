#include "lexer.h"
#include "parser.h"
#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *read_file(const char *path) {
    FILE *f = path ? fopen(path, "r") : stdin;
    if (!f) { fprintf(stderr, "cannot open '%s'\n", path); exit(1); }
    size_t cap = 4096, len = 0;
    char *buf = malloc(cap);
    if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
    int c;
    while ((c = fgetc(f)) != EOF) {
        if (len + 1 >= cap) {
            cap *= 2;
            buf = realloc(buf, cap);
            if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
        }
        buf[len++] = (char)c;
    }
    buf[len] = '\0';
    if (path) fclose(f);
    return buf;
}

int main(int argc, char *argv[]) {
    const char *filename = argc > 1 ? argv[1] : "<stdin>";
    char *source = argc > 1 ? read_file(argv[1]) : read_file(NULL);

    Lexer lex;
    lexer_init(&lex, source, filename);
    lexer_tokenize(&lex);

    AstNode *prog = parse(lex.tokens, lex.ntokens, filename);
    ast_print(prog, 0);
    putchar('\n');

    ast_free(prog);
    lexer_free(&lex);
    free(source);
    return 0;
}
