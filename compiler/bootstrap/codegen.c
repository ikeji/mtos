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
    /* loop label stack for break/continue (pairs: lloop, lend) */
    int loop_stack[64];
    int loop_depth;
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

/* String literals are now collected on-the-fly in cg_expr (cg_add_string)
   and emitted at the end of the .bc output. */

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
        if (stmt->nchildren > 2) {
            if (strcmp(stmt->children[2]->kind, "if") == 0)
                collect_locals_stmt(ll, stmt->children[2]);
            else
                collect_locals_block(ll, stmt->children[2]);
        }
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
        /* Narrow to int32 so values > INT32_MAX wrap to their signed
           32-bit form — Gen2's self-hosted codegen uses i32 and must
           agree with Gen1 textually. */
        fprintf(cg->out, "  push_int %d\n", (int32_t)node->ival);
        return;
    }

    if (strcmp(k, "bool") == 0) {
        fprintf(cg->out, "  push_int %d\n", (int32_t)node->ival);
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
        fprintf(cg->out, "  call %s", node->sval);
        for (int i = 0; i < node->nchildren; i++) {
            const char *ty = node->children[i]->type_annot;
            fprintf(cg->out, " %s", ty ? ty : "?");
        }
        fprintf(cg->out, "\n");
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
        else if (strcmp(op, "/")  == 0 || strcmp(op, "%")  == 0) {
            /* Unsigned LHS → div_u/mod_u; otherwise signed div/mod.
               The binop's type annotation matches the LHS type. */
            const char *ty = node->type_annot;
            int is_u = (ty && ty[0] == 'u');
            const char *suffix = is_u ? "_u" : "";
            if (op[0] == '/') fprintf(cg->out, "  div%s\n", suffix);
            else              fprintf(cg->out, "  mod%s\n", suffix);
        }
        else if (strcmp(op, "&")  == 0) fprintf(cg->out, "  and\n");
        else if (strcmp(op, "|")  == 0) fprintf(cg->out, "  or\n");
        else if (strcmp(op, "^")  == 0) fprintf(cg->out, "  xor\n");
        else if (strcmp(op, "<<") == 0) fprintf(cg->out, "  shl\n");
        else if (strcmp(op, ">>") == 0) {
            /* Unsigned LHS → logical shift (shr_u); otherwise arithmetic (shr).
               The binop's type annotation matches the LHS type for shift. */
            const char *ty = node->type_annot;
            if (ty && ty[0] == 'u') fprintf(cg->out, "  shr_u\n");
            else                    fprintf(cg->out, "  shr\n");
        }
        else if (strcmp(op, "==") == 0) fprintf(cg->out, "  eq\n");
        else if (strcmp(op, "!=") == 0) fprintf(cg->out, "  ne\n");
        else if (strcmp(op, "<")  == 0 || strcmp(op, "<=") == 0 ||
                 strcmp(op, ">")  == 0 || strcmp(op, ">=") == 0) {
            /* Unsigned LHS → lt_u/le_u/gt_u/ge_u; otherwise signed lt/le/gt/ge.
               The binop's result type is "bool", so we peek at children[0]'s
               own type_annot (set by typecheck) to decide. */
            const char *lty = node->children[0]->type_annot;
            int is_u = (lty && lty[0] == 'u');
            const char *suffix = is_u ? "_u" : "";
            if      (strcmp(op, "<")  == 0) fprintf(cg->out, "  lt%s\n", suffix);
            else if (strcmp(op, "<=") == 0) fprintf(cg->out, "  le%s\n", suffix);
            else if (strcmp(op, ">")  == 0) fprintf(cg->out, "  gt%s\n", suffix);
            else                            fprintf(cg->out, "  ge%s\n", suffix);
        }
        else { fprintf(stderr, "codegen: unknown binop '%s'\n", op); exit(1); }
        return;
    }

    if (strcmp(k, "cast") == 0) {
        cg_expr(cg, node->children[0]);
        const char *target = node->children[1]->sval;
        /* Emit cast only for primitive integer types. Casts involving
           reference types (struct <-> U32Array, String, etc.) are no-op
           because all references share the same 32-bit representation. */
        if (!strcmp(target, "u8")  || !strcmp(target, "u16") || !strcmp(target, "u32") ||
            !strcmp(target, "i8")  || !strcmp(target, "i16") || !strcmp(target, "i32") ||
            !strcmp(target, "bool")) {
            fprintf(cg->out, "  cast %s\n", target);
        }
        return;
    }

    fprintf(stderr, "codegen: unknown expr kind '%s'\n", k);
    exit(1);
}

/* ---- Statement code generation ---- */

static void cg_stmt(CG *cg, AstNode *node) {
    const char *k = node->kind;

    if (strcmp(k, "comment") == 0) {
        fprintf(cg->out, "; %s\n", node->sval ? node->sval : "");
        return;
    }

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
        fprintf(cg->out, "  call %s", node->sval);
        for (int i = 0; i < node->nchildren; i++) {
            const char *ty = node->children[i]->type_annot;
            fprintf(cg->out, " %s", ty ? ty : "?");
        }
        fprintf(cg->out, "\n");
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
            if (strcmp(node->children[2]->kind, "if") == 0)
                cg_stmt(cg, node->children[2]);
            else
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
        cg->loop_stack[cg->loop_depth * 2]     = lloop;
        cg->loop_stack[cg->loop_depth * 2 + 1] = lend;
        cg->loop_depth++;
        fprintf(cg->out, "__L%d:\n", lloop);
        cg_expr(cg, node->children[0]);
        fprintf(cg->out, "  jump_ifnot __L%d\n", lend);
        cg_block(cg, node->children[1]);
        fprintf(cg->out, "  jump __L%d\n", lloop);
        fprintf(cg->out, "__L%d:\n", lend);
        cg->loop_depth--;
        return;
    }

    if (strcmp(k, "break") == 0) {
        fprintf(cg->out, "  jump __L%d\n", cg->loop_stack[(cg->loop_depth-1)*2+1]);
        return;
    }

    if (strcmp(k, "continue") == 0) {
        fprintf(cg->out, "  jump __L%d\n", cg->loop_stack[(cg->loop_depth-1)*2]);
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

    fprintf(cg->out, ".fn %s", fname);
    for (int i = 0; i < params->nchildren; i++)
        fprintf(cg->out, " %s", params->children[i]->children[0]->sval);
    fprintf(cg->out, " %s\n", ret_type);

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

    /* emit header */
    fprintf(cg.out, ".bc\n");

    /* emit global variable declarations */
    int has_global = 0;
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "var_decl") == 0) {
            if (!has_global) { fprintf(cg.out, "; globals\n"); has_global = 1; }
            /* emit initial value if it's a simple integer literal */
            long initval = 0;
            if (d->nchildren > 1 && strcmp(d->children[1]->kind, "int") == 0)
                initval = d->children[1]->ival;
            fprintf(cg.out, ".global %s %s %d\n", d->sval, d->children[0]->sval, (int32_t)initval);
        }
    }
    if (has_global) fprintf(cg.out, "\n");

    /* emit functions (string literals collected on-the-fly by cg_add_string) */
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "fn") == 0)
            cg_fn(&cg, d);
    }

    /* emit string table at end */
    if (cg.nstrings > 0) {
        fprintf(cg.out, "; string table\n");
        for (int i = 0; i < cg.nstrings; i++) {
            fprintf(cg.out, ".string %d \"", i);
            print_escaped(cg.out, cg.strings[i]);
            fprintf(cg.out, "\"\n");
        }
        fprintf(cg.out, "\n");
    }

    /* mark end of bytecode so bcrun can detect where program stdin begins */
    fprintf(cg.out, ".endbc\n");

    /* cleanup */
    for (int i = 0; i < cg.nstrings; i++) free(cg.strings[i]);
    free(cg.strings);
}
