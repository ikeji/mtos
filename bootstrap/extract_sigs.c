/* extract_sigs.c — Extract export signatures from AST to .th format
 *
 * Reads AST (S-expression) from stdin, outputs .th (tc header):
 * - export fn: header only (params + ret, no body/block)
 * - struct: name only (no fields)
 * - Everything else is stripped.
 */
#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Print a fn node without its body (block child) */
static void print_fn_header(AstNode *fn, int indent) {
    /* Build a shallow copy without block children */
    AstNode tmp = *fn;
    AstNode **filtered = NULL;
    int nf = 0;
    for (int i = 0; i < fn->nchildren; i++) {
        AstNode *c = fn->children[i];
        if (strcmp(c->kind, "block") == 0) continue;
        filtered = realloc(filtered, (nf + 1) * sizeof(AstNode*));
        filtered[nf++] = c;
    }
    tmp.children = filtered;
    tmp.nchildren = nf;
    ast_print(&tmp, indent);
    free(filtered);
}

/* Print a struct node without fields */
static void print_struct_name(AstNode *st, int indent) {
    AstNode tmp = *st;
    tmp.children = NULL;
    tmp.nchildren = 0;
    ast_print(&tmp, indent);
}

int main(void) {
    AstNode *prog = ast_read(stdin);
    if (!prog) {
        fprintf(stderr, "extract-sigs: failed to read AST\n");
        return 1;
    }

    /* Output filtered program */
    printf("(program\n");
    for (int i = 0; i < prog->nchildren; i++) {
        AstNode *d = prog->children[i];
        if (strcmp(d->kind, "fn") == 0 &&
            d->type_annot && strcmp(d->type_annot, "export") == 0) {
            print_fn_header(d, 1);
            putchar('\n');
        } else if (strcmp(d->kind, "struct") == 0) {
            print_struct_name(d, 1);
            putchar('\n');
        }
        /* skip: non-export fn, import, var, etc. */
    }
    printf(")\n");

    ast_free(prog);
    return 0;
}
