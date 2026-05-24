#include "lexer.h"
#include "parser.h"
#include "ast.h"
#include "typecheck.h"
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

    if (argc > 1 && ends_with(argv[1], ".tc")) {
        /* parse from source */
        char *source = read_file_str(argv[1]);
        Lexer lex;
        lexer_init(&lex, source, filename);
        lexer_tokenize(&lex);
        prog = parse(lex.tokens, lex.ntokens, filename, source);
        lexer_free(&lex);
        free(source);
    } else if (argc > 1) {
        /* read AST from file */
        FILE *f = fopen(argv[1], "r");
        if (!f) { fprintf(stderr, "cannot open '%s'\n", argv[1]); exit(1); }
        prog = ast_read(f);
        fclose(f);
    } else {
        prog = ast_read(stdin);
        /* If first node is (imports ...), process .th headers then read main AST */
        if (prog && strcmp(prog->kind, "imports") == 0) {
            AstNode *imports = prog;
            prog = ast_read(stdin);
            /* Register exported signatures from .th into typecheck env */
            /* (handled below via typecheck_imports) */
            if (!prog) { fprintf(stderr, "failed to read AST after imports\n"); exit(1); }
            typecheck_with_imports(prog, filename, imports);
            ast_print(prog, 0);
            putchar('\n');
            ast_free(imports);
            ast_free(prog);
            return 0;
        }
    }

    if (!prog) { fprintf(stderr, "failed to read AST\n"); exit(1); }

    typecheck(prog, filename);
    ast_print(prog, 0);
    putchar('\n');

    ast_free(prog);
    return 0;
}
