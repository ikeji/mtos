#include "lexer.h"
#include "parser.h"
#include "ast.h"
#include "typecheck.h"
#include "interp.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *read_file_str(const char *path) {
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

static int ends_with(const char *s, const char *suf) {
    int sl = strlen(s), sufl = strlen(suf);
    return sl >= sufl && strcmp(s + sl - sufl, suf) == 0;
}

int main(int argc, char *argv[]) {
    const char *filename = argc > 1 ? argv[1] : "<stdin>";
    AstNode *prog = NULL;

    if (argc > 1 && ends_with(argv[1], ".tast")) {
        /* read typed AST from file */
        FILE *f = fopen(argv[1], "r");
        if (!f) { fprintf(stderr, "cannot open '%s'\n", argv[1]); exit(1); }
        prog = ast_read(f);
        fclose(f);
    } else if (argc > 1 && ends_with(argv[1], ".tc")) {
        /* parse + typecheck */
        char *source = read_file_str(argv[1]);
        Lexer lex;
        lexer_init(&lex, source, filename);
        lexer_tokenize(&lex);
        prog = parse(lex.tokens, lex.ntokens, filename);
        lexer_free(&lex);
        free(source);
        typecheck(prog, filename);
    } else if (argc > 1) {
        /* assume typed AST text */
        FILE *f = fopen(argv[1], "r");
        if (!f) { fprintf(stderr, "cannot open '%s'\n", argv[1]); exit(1); }
        prog = ast_read(f);
        fclose(f);
    } else {
        /* stdin: assume typed AST */
        prog = ast_read(stdin);
    }

    if (!prog) { fprintf(stderr, "failed to read program\n"); exit(1); }

    int code = interpret(prog);
    ast_free(prog);
    return code;
}
