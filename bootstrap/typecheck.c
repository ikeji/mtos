#include "typecheck.h"
#include "lexer.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ---- type utilities ---- */

static int is_int_type(const char *t) {
    return t && (strcmp(t,"u8")==0 || strcmp(t,"u16")==0 || strcmp(t,"u32")==0 ||
                 strcmp(t,"i8")==0 || strcmp(t,"i16")==0 || strcmp(t,"i32")==0);
}

static int is_ref_type(const char *t) {
    if (!t) return 0;
    if (strcmp(t,"String")==0 || strcmp(t,"StringLiteral")==0 || strcmp(t,"StringArray")==0) return 1;
    /* ends in Array */
    int len = strlen(t);
    if (len > 5 && strcmp(t + len - 5, "Array") == 0) return 1;
    /* if starts uppercase it could be a struct/array */
    if (t[0] >= 'A' && t[0] <= 'Z') return 1;
    return 0;
}

static void set_annot(AstNode *n, const char *ty) {
    free(n->type_annot);
    n->type_annot = ty ? strdup(ty) : NULL;
}

/* ---- symbol table ---- */

/* A function overload */
typedef struct FnSig {
    char *name;
    char **param_types;
    int nparam;
    char *ret_type;
    struct FnSig *next;
} FnSig;

/* A variable entry */
typedef struct VarEntry {
    char *name;
    char *type;
    struct VarEntry *next;
} VarEntry;

/* A struct definition */
typedef struct StructField {
    char *name;
    char *type;
} StructField;

typedef struct StructDef {
    char *name;
    StructField *fields;
    int nfields;
    struct StructDef *next;
} StructDef;

/* Scope frame for local variables */
typedef struct Scope {
    VarEntry *vars;
    struct Scope *parent;
} Scope;

typedef struct {
    FnSig *fns;
    VarEntry *globals;
    StructDef *structs;
    Scope *scope;
    const char *filename;
    const char *cur_fn_ret; /* return type of current function */
} TypeEnv;

static void env_init(TypeEnv *e, const char *filename) {
    memset(e, 0, sizeof(*e));
    e->filename = filename;
}

static FnSig *fn_sig_new(const char *name, int nparam) {
    FnSig *s = calloc(1, sizeof(FnSig));
    s->name = strdup(name);
    s->nparam = nparam;
    if (nparam > 0) s->param_types = calloc(nparam, sizeof(char*));
    return s;
}

static void register_fn(TypeEnv *e, const char *name,
                         const char **ptypes, int np, const char *ret) {
    FnSig *s = fn_sig_new(name, np);
    for (int i = 0; i < np; i++)
        s->param_types[i] = strdup(ptypes[i]);
    s->ret_type = strdup(ret);
    s->next = e->fns;
    e->fns = s;
}

static void register_var_global(TypeEnv *e, const char *name, const char *type) {
    VarEntry *v = calloc(1, sizeof(VarEntry));
    v->name = strdup(name);
    v->type = strdup(type);
    v->next = e->globals;
    e->globals = v;
}

static StructDef *find_struct(TypeEnv *e, const char *name) {
    for (StructDef *s = e->structs; s; s = s->next)
        if (strcmp(s->name, name) == 0) return s;
    return NULL;
}

static void push_scope(TypeEnv *e) {
    Scope *s = calloc(1, sizeof(Scope));
    s->parent = e->scope;
    e->scope = s;
}

static void pop_scope(TypeEnv *e) {
    Scope *s = e->scope;
    if (!s) return;
    VarEntry *v = s->vars;
    while (v) {
        VarEntry *nx = v->next;
        free(v->name); free(v->type); free(v);
        v = nx;
    }
    e->scope = s->parent;
    free(s);
}

static void scope_add_var(TypeEnv *e, const char *name, const char *type) {
    VarEntry *v = calloc(1, sizeof(VarEntry));
    v->name = strdup(name);
    v->type = strdup(type);
    v->next = e->scope->vars;
    e->scope->vars = v;
}

static const char *scope_lookup(TypeEnv *e, const char *name) {
    for (Scope *s = e->scope; s; s = s->parent) {
        for (VarEntry *v = s->vars; v; v = v->next)
            if (strcmp(v->name, name) == 0) return v->type;
    }
    for (VarEntry *v = e->globals; v; v = v->next)
        if (strcmp(v->name, name) == 0) return v->type;
    return NULL;
}

/* Match args to overloads. Return matched FnSig or NULL */
static FnSig *resolve_overload(TypeEnv *e, const char *name,
                                const char **arg_types, int nargs) {
    FnSig *matched = NULL;
    int nmatch = 0;
    /* Exact match only — no integer coercion */
    for (FnSig *s = e->fns; s; s = s->next) {
        if (strcmp(s->name, name) != 0) continue;
        if (s->nparam != nargs) continue;
        int ok = 1;
        for (int i = 0; i < nargs; i++) {
            if (strcmp(s->param_types[i], arg_types[i]) != 0) { ok = 0; break; }
        }
        if (ok) { matched = s; nmatch++; }
    }
    if (nmatch == 1) return matched;
    if (nmatch > 1) return NULL; /* ambiguous */
    return NULL;
}

/* ---- register built-ins ---- */

static void register_array_builtins(TypeEnv *e, const char *arr_type,
                                     const char *elem_type) {
    /* XxxArray(size: i32) -> XxxArray  (constructor has same name as type) */
    const char *pt_i32[] = {"i32"};
    register_fn(e, arr_type, pt_i32, 1, arr_type);

    const char *pt_arr[] = {arr_type};
    const char *pt_arr_idx[] = {arr_type, "i32"};
    const char *pt_arr_idx_val[3];
    pt_arr_idx_val[0] = arr_type; pt_arr_idx_val[1] = "i32"; pt_arr_idx_val[2] = elem_type;

    register_fn(e, "len", pt_arr, 1, "i32");
    register_fn(e, "get", pt_arr_idx, 2, elem_type);
    register_fn(e, "set", pt_arr_idx_val, 3, "void");
    register_fn(e, "delete", pt_arr, 1, "void");
}

static void register_builtins(TypeEnv *e) {
    /* Only low-level primitives remain as builtins.
     * Everything else (arrays, strings, sys calls, print) is provided
     * by runtime.tc via import. */

    /* peek/poke — direct memory access */
    const char *p32[] = {"u32"};
    register_fn(e, "peek8", p32, 1, "u8");
    register_fn(e, "peek16", p32, 1, "u16");
    register_fn(e, "peek32", p32, 1, "u32");
    const char *p32_u8[] = {"u32","u8"};
    const char *p32_u16[] = {"u32","u16"};
    const char *p32_u32[] = {"u32","u32"};
    register_fn(e, "poke8", p32_u8, 2, "void");
    register_fn(e, "poke16", p32_u16, 2, "void");
    register_fn(e, "poke32", p32_u32, 2, "void");

    /* raw ecall stubs (implemented in crt0.s) */
    const char *dw[] = {"i32","u32","i32"};
    const char *dr[] = {"i32","u32","i32"};
    const char *de[] = {"i32"};
    register_fn(e, "do_write", dw, 3, "i32");
    register_fn(e, "do_read", dr, 3, "i32");
    register_fn(e, "do_exit", de, 1, "void");
}

/* ---- forward pass: collect all function/struct/global signatures ---- */

/* Register struct as type name only (for imports — no auto-generated functions) */
static void collect_struct_type_only(TypeEnv *e, AstNode *node) {
    const char *sname = node->sval;
    if (find_struct(e, sname)) return; /* already registered */
    StructDef *sd = calloc(1, sizeof(StructDef));
    sd->name = strdup(sname);
    sd->nfields = 0;
    sd->fields = NULL;
    sd->next = e->structs;
    e->structs = sd;
}

static void collect_struct(TypeEnv *e, AstNode *node) {
    const char *sname = node->sval;
    StructDef *sd = calloc(1, sizeof(StructDef));
    sd->name = strdup(sname);
    sd->nfields = node->nchildren;
    sd->fields = calloc(sd->nfields, sizeof(StructField));
    for (int i = 0; i < node->nchildren; i++) {
        AstNode *field = node->children[i];
        sd->fields[i].name = strdup(field->sval);
        sd->fields[i].type = strdup(field->children[0]->sval);
    }
    sd->next = e->structs;
    e->structs = sd;

    /* delete(s: StructName) is now generated as a synthetic fn by the parser */

    /* array type: StructNameArray — all ops resolve to U32Array builtins at runtime */
    char arr_type[128];
    snprintf(arr_type, sizeof(arr_type), "%sArray", sname);
    register_array_builtins(e, arr_type, sname);

    /* Constructor, getters, and setters are NOT registered here —
       they come from synthetic fn AST nodes generated by the parser
       and are registered via collect_fn. */
}

static void collect_fn(TypeEnv *e, AstNode *node) {
    /* node: (fn name (params ...) (ret (type ty)) (block ...)) */
    const char *fname = node->sval;
    /* children[0] = params, children[1] = ret, children[2] = block */
    AstNode *params = node->children[0];
    AstNode *ret_node = node->children[1]; /* (ret (type ty)) */
    const char *ret_type = "void";
    if (ret_node->nchildren > 0 && ret_node->children[0]->sval)
        ret_type = ret_node->children[0]->sval;

    int np = params->nchildren;
    const char **ptypes = np > 0 ? calloc(np, sizeof(char*)) : NULL;
    for (int i = 0; i < np; i++) {
        AstNode *param = params->children[i];
        ptypes[i] = param->children[0]->sval;
    }
    register_fn(e, fname, ptypes, np, ret_type);
    free(ptypes);
}

/* ---- typecheck expressions ---- */

static const char *check_expr(TypeEnv *e, AstNode *node);

static const char *check_call(TypeEnv *e, AstNode *node, const char *fname) {
    int nargs = node->nchildren;
    const char **arg_types = nargs > 0 ? calloc(nargs, sizeof(char*)) : NULL;
    for (int i = 0; i < nargs; i++) {
        arg_types[i] = check_expr(e, node->children[i]);
    }
    FnSig *sig = resolve_overload(e, fname, arg_types, nargs);
    if (!sig) {
        fprintf(stderr, "%s:%d: no matching overload for '%s' with %d args (",
                e->filename, node->line, fname, nargs);
        for (int i = 0; i < nargs; i++) {
            if (i) fprintf(stderr, ", ");
            fprintf(stderr, "%s", arg_types[i] ? arg_types[i] : "?");
        }
        fprintf(stderr, ")\n");
        /* print available overloads */
        for (FnSig *s = e->fns; s; s = s->next) {
            if (strcmp(s->name, fname) == 0) {
                fprintf(stderr, "  candidate: %s(", fname);
                for (int i = 0; i < s->nparam; i++) {
                    if (i) fprintf(stderr, ", ");
                    fprintf(stderr, "%s", s->param_types[i]);
                }
                fprintf(stderr, ") -> %s\n", s->ret_type);
            }
        }
        free(arg_types);
        exit(1);
    }
    set_annot(node, sig->ret_type);
    free(arg_types);
    return sig->ret_type;
}

static const char *check_expr(TypeEnv *e, AstNode *node) {
    if (!node) return "void";
    const char *k = node->kind;

    if (strcmp(k, "int") == 0) {
        /* default type is i32, unless suffix (sval or pre-existing type_annot) overrides */
        const char *ty = "i32";
        const char *suffix = node->type_annot ? node->type_annot : node->sval;
        if (suffix) {
            if (strcmp(suffix, "u8") == 0) ty = "u8";
            else if (strcmp(suffix, "u16") == 0) ty = "u16";
            else if (strcmp(suffix, "u32") == 0) ty = "u32";
            else if (strcmp(suffix, "i8") == 0) ty = "i8";
            else if (strcmp(suffix, "i16") == 0) ty = "i16";
            else if (strcmp(suffix, "i32") == 0) ty = "i32";
        }
        set_annot(node, ty);
        return node->type_annot;
    }

    if (strcmp(k, "bool") == 0) {
        set_annot(node, "bool");
        return "bool";
    }

    if (strcmp(k, "str") == 0) {
        set_annot(node, "StringLiteral");
        return "StringLiteral";
    }

    if (strcmp(k, "var") == 0) {
        const char *ty = scope_lookup(e, node->sval);
        if (!ty) {
            fprintf(stderr, "%s:%d: undefined variable '%s'\n",
                    e->filename, node->line, node->sval);
            exit(1);
        }
        set_annot(node, ty);
        return ty;
    }

    if (strcmp(k, "call") == 0) {
        return check_call(e, node, node->sval);
    }

    if (strcmp(k, "unary") == 0) {
        const char *operand_type = check_expr(e, node->children[0]);
        const char *ty;
        if (strcmp(node->sval, "!") == 0) {
            ty = "bool";
        } else {
            ty = operand_type; /* - */
        }
        set_annot(node, ty);
        return ty;
    }

    if (strcmp(k, "binop") == 0) {
        const char *op = node->sval;
        const char *lt = check_expr(e, node->children[0]);
        const char *rt = check_expr(e, node->children[1]);
        const char *ty;

        if (strcmp(op, "==") == 0 || strcmp(op, "!=") == 0 ||
            strcmp(op, "<") == 0 || strcmp(op, "<=") == 0 ||
            strcmp(op, ">") == 0 || strcmp(op, ">=") == 0 ||
            strcmp(op, "&&") == 0 || strcmp(op, "||") == 0) {
            ty = "bool";
        } else {
            /* arithmetic/bitwise: use left type (no promotion) */
            ty = lt;
            (void)rt;
        }
        set_annot(node, ty);
        return ty;
    }

    if (strcmp(k, "cast") == 0) {
        check_expr(e, node->children[0]);
        const char *target = node->children[1]->sval;
        set_annot(node, target);
        return target;
    }

    fprintf(stderr, "%s:%d: unknown expression node kind '%s'\n",
            e->filename, node->line, k);
    exit(1);
}

/* ---- typecheck statements ---- */

static void check_stmt(TypeEnv *e, AstNode *node);
static void check_block(TypeEnv *e, AstNode *block);

static void check_stmt(TypeEnv *e, AstNode *node) {
    const char *k = node->kind;

    if (strcmp(k, "var_decl") == 0) {
        /* children[0] = type node, children[1] = optional init expr */
        const char *ty = node->children[0]->sval;
        if (node->nchildren > 1) {
            const char *init_ty = check_expr(e, node->children[1]);
            (void)init_ty; /* allow some type flexibility */
        }
        scope_add_var(e, node->sval, ty);
        set_annot(node, ty);
        return;
    }

    if (strcmp(k, "assign") == 0) {
        /* node->sval = var name, children[0] = rhs */
        const char *var_ty = scope_lookup(e, node->sval);
        if (!var_ty) {
            fprintf(stderr, "%s:%d: undefined variable '%s'\n",
                    e->filename, node->line, node->sval);
            exit(1);
        }
        check_expr(e, node->children[0]);
        set_annot(node, var_ty);
        return;
    }

    if (strcmp(k, "call_stmt") == 0) {
        check_call(e, node, node->sval);
        return;
    }

    if (strcmp(k, "if") == 0) {
        check_expr(e, node->children[0]);
        push_scope(e);
        check_block(e, node->children[1]);
        pop_scope(e);
        if (node->nchildren > 2) {
            if (strcmp(node->children[2]->kind, "if") == 0) {
                check_stmt(e, node->children[2]);
            } else {
                push_scope(e);
                check_block(e, node->children[2]);
                pop_scope(e);
            }
        }
        return;
    }

    if (strcmp(k, "while") == 0) {
        check_expr(e, node->children[0]);
        push_scope(e);
        check_block(e, node->children[1]);
        pop_scope(e);
        return;
    }

    if (strcmp(k, "break") == 0 || strcmp(k, "continue") == 0) return;

    if (strcmp(k, "comment") == 0) return;

    if (strcmp(k, "return") == 0) {
        if (node->nchildren > 0) {
            const char *ty = check_expr(e, node->children[0]);
            set_annot(node, ty);
        } else {
            set_annot(node, "void");
        }
        return;
    }

    fprintf(stderr, "%s:%d: unknown statement kind '%s'\n",
            e->filename, node->line, k);
    exit(1);
}

static void check_block(TypeEnv *e, AstNode *block) {
    for (int i = 0; i < block->nchildren; i++)
        check_stmt(e, block->children[i]);
}

static void check_fn(TypeEnv *e, AstNode *node) {
    AstNode *params = node->children[0];
    AstNode *ret_node = node->children[1];
    AstNode *body = node->children[2];

    const char *ret_type = "void";
    if (ret_node->nchildren > 0 && ret_node->children[0]->sval)
        ret_type = ret_node->children[0]->sval;

    e->cur_fn_ret = ret_type;
    push_scope(e);
    for (int i = 0; i < params->nchildren; i++) {
        AstNode *param = params->children[i];
        const char *pty = param->children[0]->sval;
        scope_add_var(e, param->sval, pty);
        set_annot(param, pty);
    }
    check_block(e, body);
    pop_scope(e);
    e->cur_fn_ret = NULL;
}

/* ---- import handling ---- */

static char *path_relative_to(const char *base_file, const char *rel) {
    /* get directory of base_file */
    const char *slash = strrchr(base_file, '/');
    if (!slash) return strdup(rel);
    int dir_len = (int)(slash - base_file) + 1;
    char *result = malloc(dir_len + strlen(rel) + 1);
    memcpy(result, base_file, dir_len);
    strcpy(result + dir_len, rel);
    return result;
}

static char *read_file(const char *path) {
    FILE *f = fopen(path, "r");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long sz = ftell(f);
    fseek(f, 0, SEEK_SET);
    char *buf = malloc(sz + 1);
    if (!buf) { fclose(f); return NULL; }
    fread(buf, 1, sz, f);
    buf[sz] = '\0';
    fclose(f);
    return buf;
}

static void process_import(TypeEnv *e, const char *import_path) {
    char *src = read_file(import_path);
    if (!src) {
        fprintf(stderr, "cannot open import '%s'\n", import_path);
        exit(1);
    }
    Lexer lex;
    lexer_init(&lex, src, import_path);
    lexer_tokenize(&lex);
    AstNode *prog = parse(lex.tokens, lex.ntokens, import_path, NULL);
    lexer_free(&lex);
    free(src);

    /* collect exported signatures only */
    for (int i = 0; i < prog->nchildren; i++) {
        AstNode *d = prog->children[i];
        if (strcmp(d->kind, "fn") == 0 && d->type_annot &&
            strcmp(d->type_annot, "export") == 0) {
            collect_fn(e, d);
        } else if (strcmp(d->kind, "struct") == 0) {
            /* register struct as type name only (no auto-generated functions) */
            collect_struct_type_only(e, d);
        }
    }
    ast_free(prog);
}

/* ---- main entry ---- */

AstNode *typecheck(AstNode *program, const char *filename) {
    TypeEnv e;
    env_init(&e, filename);
    register_builtins(&e);

    /* first pass: collect all top-level declarations */
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "import") == 0) {
            char *path = path_relative_to(filename, d->sval);
            process_import(&e, path);
            free(path);
        } else if (strcmp(d->kind, "struct") == 0) {
            collect_struct(&e, d);
        } else if (strcmp(d->kind, "fn") == 0) {
            collect_fn(&e, d);
        } else if (strcmp(d->kind, "var_decl") == 0) {
            register_var_global(&e, d->sval, d->children[0]->sval);
        }
    }

    /* second pass: typecheck bodies */
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "fn") == 0) {
            check_fn(&e, d);
        } else if (strcmp(d->kind, "var_decl") == 0) {
            if (d->nchildren > 1) {
                check_expr(&e, d->children[1]);
            }
        }
    }

    return program;
}
