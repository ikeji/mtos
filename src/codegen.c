#include "codegen.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ---- Code generator state ---- */

typedef struct {
    FILE *out;
    int label_counter;
    /* string literal table */
    char **strings;
    int nstrings;
    int strings_cap;
} CG;

static int cg_add_string(CG *cg, const char *s) {
    for (int i = 0; i < cg->nstrings; i++)
        if (strcmp(cg->strings[i], s) == 0) return i;
    if (cg->nstrings >= cg->strings_cap) {
        cg->strings_cap = cg->strings_cap ? cg->strings_cap * 2 : 16;
        cg->strings = realloc(cg->strings, cg->strings_cap * sizeof(char*));
        if (!cg->strings) { fprintf(stderr, "out of memory\n"); exit(1); }
    }
    cg->strings[cg->nstrings] = strdup(s);
    return cg->nstrings++;
}

static int cg_new_label(CG *cg) { return cg->label_counter++; }

/* ---- String collection pass ---- */

static void collect_strings(CG *cg, AstNode *node) {
    if (!node) return;
    if (strcmp(node->kind, "str") == 0)
        cg_add_string(cg, node->sval ? node->sval : "");
    for (int i = 0; i < node->nchildren; i++)
        collect_strings(cg, node->children[i]);
}

/* ---- Local variable collection ---- */

typedef struct {
    char **names;
    char **types;
    int count, cap;
} LocalList;

static void local_add(LocalList *ll, const char *name, const char *type) {
    for (int i = 0; i < ll->count; i++)
        if (strcmp(ll->names[i], name) == 0) return;
    if (ll->count >= ll->cap) {
        ll->cap = ll->cap ? ll->cap * 2 : 8;
        ll->names = realloc(ll->names, ll->cap * sizeof(char*));
        ll->types = realloc(ll->types, ll->cap * sizeof(char*));
        if (!ll->names || !ll->types) { fprintf(stderr, "out of memory\n"); exit(1); }
    }
    ll->names[ll->count] = strdup(name);
    ll->types[ll->count] = strdup(type);
    ll->count++;
}

static void collect_locals_block(LocalList *ll, AstNode *block);

static void collect_locals_stmt(LocalList *ll, AstNode *stmt) {
    const char *k = stmt->kind;
    if (strcmp(k, "var_decl") == 0) {
        local_add(ll, stmt->sval, stmt->children[0]->sval);
    } else if (strcmp(k, "if") == 0) {
        collect_locals_block(ll, stmt->children[1]);
        if (stmt->nchildren > 2) collect_locals_block(ll, stmt->children[2]);
    } else if (strcmp(k, "while") == 0) {
        collect_locals_block(ll, stmt->children[1]);
    }
}

static void collect_locals_block(LocalList *ll, AstNode *block) {
    for (int i = 0; i < block->nchildren; i++)
        collect_locals_stmt(ll, block->children[i]);
}

static void local_list_free(LocalList *ll) {
    for (int i = 0; i < ll->count; i++) {
        free(ll->names[i]);
        free(ll->types[i]);
    }
    free(ll->names);
    free(ll->types);
}

/* ---- String escaping ---- */

static void print_escaped(FILE *out, const char *s) {
    for (; *s; s++) {
        unsigned char c = (unsigned char)*s;
        if (c == '"')       fputs("\\\"", out);
        else if (c == '\\') fputs("\\\\", out);
        else if (c == '\n') fputs("\\n",  out);
        else if (c == '\r') fputs("\\r",  out);
        else if (c == '\t') fputs("\\t",  out);
        else if (c < 0x20 || c == 0x7f)
            fprintf(out, "\\x%02x", c);
        else
            fputc(c, out);
    }
}

/* ---- Expression code generation ---- */

static void cg_expr(CG *cg, AstNode *node);
static void cg_stmt(CG *cg, AstNode *node);
static void cg_block(CG *cg, AstNode *block);

static void cg_expr(CG *cg, AstNode *node) {
    const char *k = node->kind;

    if (strcmp(k, "int") == 0) {
        fprintf(cg->out, "  push_int %ld\n", node->ival);
        return;
    }

    if (strcmp(k, "bool") == 0) {
        fprintf(cg->out, "  push_int %ld\n", node->ival);
        return;
    }

    if (strcmp(k, "str") == 0) {
        int idx = cg_add_string(cg, node->sval ? node->sval : "");
        fprintf(cg->out, "  push_str %d\n", idx);
        return;
    }

    if (strcmp(k, "var") == 0) {
        fprintf(cg->out, "  load %s\n", node->sval);
        return;
    }

    if (strcmp(k, "call") == 0) {
        for (int i = 0; i < node->nchildren; i++)
            cg_expr(cg, node->children[i]);
        fprintf(cg->out, "  call %s %d\n", node->sval, node->nchildren);
        return;
    }

    if (strcmp(k, "unary") == 0) {
        cg_expr(cg, node->children[0]);
        if (strcmp(node->sval, "-") == 0)      fprintf(cg->out, "  neg\n");
        else if (strcmp(node->sval, "!") == 0) fprintf(cg->out, "  lnot\n");
        return;
    }

    if (strcmp(k, "binop") == 0) {
        const char *op = node->sval;

        /* short-circuit && */
        if (strcmp(op, "&&") == 0) {
            int lf = cg_new_label(cg), le = cg_new_label(cg);
            cg_expr(cg, node->children[0]);
            fprintf(cg->out, "  jump_ifnot __L%d\n", lf);
            cg_expr(cg, node->children[1]);
            fprintf(cg->out, "  jump_ifnot __L%d\n", lf);
            fprintf(cg->out, "  push_int 1\n");
            fprintf(cg->out, "  jump __L%d\n", le);
            fprintf(cg->out, "__L%d:\n", lf);
            fprintf(cg->out, "  push_int 0\n");
            fprintf(cg->out, "__L%d:\n", le);
            return;
        }

        /* short-circuit || */
        if (strcmp(op, "||") == 0) {
            int lt = cg_new_label(cg), le = cg_new_label(cg);
            cg_expr(cg, node->children[0]);
            fprintf(cg->out, "  jump_if __L%d\n", lt);
            cg_expr(cg, node->children[1]);
            fprintf(cg->out, "  jump_if __L%d\n", lt);
            fprintf(cg->out, "  push_int 0\n");
            fprintf(cg->out, "  jump __L%d\n", le);
            fprintf(cg->out, "__L%d:\n", lt);
            fprintf(cg->out, "  push_int 1\n");
            fprintf(cg->out, "__L%d:\n", le);
            return;
        }

        cg_expr(cg, node->children[0]);
        cg_expr(cg, node->children[1]);

        if      (strcmp(op, "+")  == 0) fprintf(cg->out, "  add\n");
        else if (strcmp(op, "-")  == 0) fprintf(cg->out, "  sub\n");
        else if (strcmp(op, "*")  == 0) fprintf(cg->out, "  mul\n");
        else if (strcmp(op, "/")  == 0) fprintf(cg->out, "  div\n");
        else if (strcmp(op, "%")  == 0) fprintf(cg->out, "  mod\n");
        else if (strcmp(op, "&")  == 0) fprintf(cg->out, "  and\n");
        else if (strcmp(op, "|")  == 0) fprintf(cg->out, "  or\n");
        else if (strcmp(op, "^")  == 0) fprintf(cg->out, "  xor\n");
        else if (strcmp(op, "<<") == 0) fprintf(cg->out, "  shl\n");
        else if (strcmp(op, ">>") == 0) fprintf(cg->out, "  shr\n");
        else if (strcmp(op, "==") == 0) fprintf(cg->out, "  eq\n");
        else if (strcmp(op, "!=") == 0) fprintf(cg->out, "  ne\n");
        else if (strcmp(op, "<")  == 0) fprintf(cg->out, "  lt\n");
        else if (strcmp(op, "<=") == 0) fprintf(cg->out, "  le\n");
        else if (strcmp(op, ">")  == 0) fprintf(cg->out, "  gt\n");
        else if (strcmp(op, ">=") == 0) fprintf(cg->out, "  ge\n");
        else { fprintf(stderr, "codegen: unknown binop '%s'\n", op); exit(1); }
        return;
    }

    if (strcmp(k, "cast") == 0) {
        cg_expr(cg, node->children[0]);
        fprintf(cg->out, "  cast %s\n", node->children[1]->sval);
        return;
    }

    fprintf(stderr, "codegen: unknown expr kind '%s'\n", k);
    exit(1);
}

/* ---- Statement code generation ---- */

static void cg_stmt(CG *cg, AstNode *node) {
    const char *k = node->kind;

    if (strcmp(k, "var_decl") == 0) {
        if (node->nchildren > 1)
            cg_expr(cg, node->children[1]);
        else
            fprintf(cg->out, "  push_int 0\n");
        fprintf(cg->out, "  store %s\n", node->sval);
        return;
    }

    if (strcmp(k, "assign") == 0) {
        cg_expr(cg, node->children[0]);
        fprintf(cg->out, "  store %s\n", node->sval);
        return;
    }

    if (strcmp(k, "call_stmt") == 0) {
        for (int i = 0; i < node->nchildren; i++)
            cg_expr(cg, node->children[i]);
        fprintf(cg->out, "  call %s %d\n", node->sval, node->nchildren);
        fprintf(cg->out, "  pop\n"); /* always discard call_stmt result */
        return;
    }

    if (strcmp(k, "if") == 0) {
        if (node->nchildren > 2) {
            int lelse = cg_new_label(cg), lend = cg_new_label(cg);
            cg_expr(cg, node->children[0]);
            fprintf(cg->out, "  jump_ifnot __L%d\n", lelse);
            cg_block(cg, node->children[1]);
            fprintf(cg->out, "  jump __L%d\n", lend);
            fprintf(cg->out, "__L%d:\n", lelse);
            cg_block(cg, node->children[2]);
            fprintf(cg->out, "__L%d:\n", lend);
        } else {
            int lend = cg_new_label(cg);
            cg_expr(cg, node->children[0]);
            fprintf(cg->out, "  jump_ifnot __L%d\n", lend);
            cg_block(cg, node->children[1]);
            fprintf(cg->out, "__L%d:\n", lend);
        }
        return;
    }

    if (strcmp(k, "while") == 0) {
        int lloop = cg_new_label(cg), lend = cg_new_label(cg);
        fprintf(cg->out, "__L%d:\n", lloop);
        cg_expr(cg, node->children[0]);
        fprintf(cg->out, "  jump_ifnot __L%d\n", lend);
        cg_block(cg, node->children[1]);
        fprintf(cg->out, "  jump __L%d\n", lloop);
        fprintf(cg->out, "__L%d:\n", lend);
        return;
    }

    if (strcmp(k, "return") == 0) {
        if (node->nchildren > 0) {
            cg_expr(cg, node->children[0]);
            fprintf(cg->out, "  return\n");
        } else {
            fprintf(cg->out, "  return_void\n");
        }
        return;
    }

    fprintf(stderr, "codegen: unknown stmt kind '%s'\n", k);
    exit(1);
}

static void cg_block(CG *cg, AstNode *block) {
    for (int i = 0; i < block->nchildren; i++)
        cg_stmt(cg, block->children[i]);
}

/* ---- Function code generation ---- */

static void cg_fn(CG *cg, AstNode *node) {
    const char *fname = node->sval;
    AstNode *params  = node->children[0];
    AstNode *ret_nd  = node->children[1];
    AstNode *body    = node->children[2];

    const char *ret_type = "void";
    if (ret_nd->nchildren > 0 && ret_nd->children[0]->sval)
        ret_type = ret_nd->children[0]->sval;

    fprintf(cg->out, ".fn %s %d %s\n", fname, params->nchildren, ret_type);

    for (int i = 0; i < params->nchildren; i++) {
        AstNode *p = params->children[i];
        fprintf(cg->out, ".param %s %s\n", p->sval, p->children[0]->sval);
    }

    LocalList ll = {0};
    collect_locals_block(&ll, body);
    for (int i = 0; i < ll.count; i++)
        fprintf(cg->out, ".local %s %s\n", ll.names[i], ll.types[i]);

    cg_block(cg, body);

    /* implicit fall-through: return void */
    fprintf(cg->out, "  return_void\n");
    fprintf(cg->out, ".endfn\n\n");

    local_list_free(&ll);
}

/* ---- Top-level entry ---- */

void codegen(AstNode *program) {
    CG cg;
    memset(&cg, 0, sizeof(cg));
    cg.out = stdout;

    /* collect all string literals in one pass */
    collect_strings(&cg, program);

    /* emit string table */
    if (cg.nstrings > 0) {
        fprintf(cg.out, "; string table\n");
        for (int i = 0; i < cg.nstrings; i++) {
            fprintf(cg.out, ".string %d \"", i);
            print_escaped(cg.out, cg.strings[i]);
            fprintf(cg.out, "\"\n");
        }
        fprintf(cg.out, "\n");
    }

    /* emit global variable declarations */
    int has_global = 0;
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "var_decl") == 0) {
            if (!has_global) { fprintf(cg.out, "; globals\n"); has_global = 1; }
            fprintf(cg.out, ".global %s %s\n", d->sval, d->children[0]->sval);
        }
    }
    if (has_global) fprintf(cg.out, "\n");

    /* emit functions */
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "fn") == 0)
            cg_fn(&cg, d);
    }

    /* cleanup */
    for (int i = 0; i < cg.nstrings; i++) free(cg.strings[i]);
    free(cg.strings);
}
