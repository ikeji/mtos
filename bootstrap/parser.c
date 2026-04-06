#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    Token *tokens;
    int ntokens;
    int pos;
    const char *filename;
} Parser;

static Token *cur_tok(Parser *p) {
    if (p->pos < p->ntokens) return &p->tokens[p->pos];
    return &p->tokens[p->ntokens - 1]; /* EOF */
}

static Token *peek_tok(Parser *p, int offset) {
    int idx = p->pos + offset;
    if (idx < p->ntokens) return &p->tokens[idx];
    return &p->tokens[p->ntokens - 1]; /* EOF */
}

static void advance_p(Parser *p) {
    if (p->pos < p->ntokens - 1) p->pos++;
}

static Token *expect(Parser *p, TokenKind k) {
    Token *t = cur_tok(p);
    if (t->kind != k) {
        fprintf(stderr, "%s:%d: expected '%s' but got '%s'",
                p->filename, t->line, token_kind_name(k), token_kind_name(t->kind));
        if (t->kind == TK_IDENT && t->sval) fprintf(stderr, " ('%s')", t->sval);
        fprintf(stderr, "\n");
        exit(1);
    }
    advance_p(p);
    return t;
}

static int check(Parser *p, TokenKind k) {
    return cur_tok(p)->kind == k;
}

static int match(Parser *p, TokenKind k) {
    if (check(p, k)) { advance_p(p); return 1; }
    return 0;
}

/* forward declarations */
static AstNode *parse_expr(Parser *p);
static AstNode *parse_block(Parser *p);

/* parse a type name, returns AstNode with kind="type" sval=typename */
static AstNode *parse_type(Parser *p) {
    Token *t = cur_tok(p);
    int line = t->line;
    const char *tname = NULL;
    switch (t->kind) {
        case TK_U8: tname = "u8"; break;
        case TK_U16: tname = "u16"; break;
        case TK_U32: tname = "u32"; break;
        case TK_I8: tname = "i8"; break;
        case TK_I16: tname = "i16"; break;
        case TK_I32: tname = "i32"; break;
        case TK_BOOL: tname = "bool"; break;
        case TK_VOID: tname = "void"; break;
        case TK_IDENT: tname = t->sval; break;
        default:
            fprintf(stderr, "%s:%d: expected type name, got '%s'\n",
                    p->filename, t->line, token_kind_name(t->kind));
            exit(1);
    }
    advance_p(p);
    AstNode *n = ast_node("type", line);
    n->sval = strdup(tname);
    return n;
}

static AstNode *parse_primary(Parser *p) {
    Token *t = cur_tok(p);
    int line = t->line;

    if (t->kind == TK_INT_LIT) {
        AstNode *n = ast_node("int", line);
        n->ival = t->ival;
        /* store type suffix in sval */
        if (t->int_suffix) n->sval = strdup(t->int_suffix);
        advance_p(p);
        return n;
    }

    if (t->kind == TK_STR_LIT) {
        AstNode *n = ast_node("str", line);
        n->sval = strdup(t->str_content ? t->str_content : "");
        advance_p(p);
        return n;
    }

    if (t->kind == TK_TRUE) {
        AstNode *n = ast_node("bool", line);
        n->ival = 1;
        n->sval = strdup("true");
        advance_p(p);
        return n;
    }
    if (t->kind == TK_FALSE) {
        AstNode *n = ast_node("bool", line);
        n->ival = 0;
        n->sval = strdup("false");
        advance_p(p);
        return n;
    }

    if (t->kind == TK_LPAREN) {
        advance_p(p);
        AstNode *e = parse_expr(p);
        expect(p, TK_RPAREN);
        return e;
    }

    if (t->kind == TK_IDENT) {
        /* look ahead: if next is '(', it's a function call */
        if (peek_tok(p, 1)->kind == TK_LPAREN) {
            char *name = strdup(t->sval);
            advance_p(p); /* consume ident */
            advance_p(p); /* consume '(' */
            AstNode *call = ast_node("call", line);
            call->sval = name;
            /* parse arg_list */
            if (!check(p, TK_RPAREN)) {
                do {
                    AstNode *arg = parse_expr(p);
                    ast_add_child(call, arg);
                } while (match(p, TK_COMMA));
            }
            expect(p, TK_RPAREN);
            return call;
        }
        /* simple variable reference */
        AstNode *n = ast_node("var", line);
        n->sval = strdup(t->sval);
        advance_p(p);
        return n;
    }

    fprintf(stderr, "%s:%d: unexpected token '%s' in expression\n",
            p->filename, t->line, token_kind_name(t->kind));
    exit(1);
}

static AstNode *parse_postfix(Parser *p) {
    AstNode *n = parse_primary(p);
    /* postfix: ('as' type)* */
    while (check(p, TK_AS)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *ty = parse_type(p);
        AstNode *cast = ast_node("cast", line);
        ast_add_child(cast, n);
        ast_add_child(cast, ty);
        n = cast;
    }
    return n;
}

static AstNode *parse_unary(Parser *p) {
    int line = cur_tok(p)->line;
    if (check(p, TK_BANG)) {
        advance_p(p);
        AstNode *n = ast_node("unary", line);
        n->sval = strdup("!");
        ast_add_child(n, parse_unary(p));
        return n;
    }
    if (check(p, TK_MINUS)) {
        advance_p(p);
        AstNode *n = ast_node("unary", line);
        n->sval = strdup("-");
        ast_add_child(n, parse_unary(p));
        return n;
    }
    return parse_postfix(p);
}

static AstNode *parse_mul(Parser *p) {
    AstNode *left = parse_unary(p);
    while (check(p, TK_STAR) || check(p, TK_SLASH) || check(p, TK_PERCENT)) {
        int line = cur_tok(p)->line;
        const char *op = token_kind_name(cur_tok(p)->kind);
        advance_p(p);
        AstNode *right = parse_unary(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup(op);
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_add(Parser *p) {
    AstNode *left = parse_mul(p);
    while (check(p, TK_PLUS) || check(p, TK_MINUS)) {
        int line = cur_tok(p)->line;
        const char *op = token_kind_name(cur_tok(p)->kind);
        advance_p(p);
        AstNode *right = parse_mul(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup(op);
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_shift(Parser *p) {
    AstNode *left = parse_add(p);
    while (check(p, TK_LSHIFT) || check(p, TK_RSHIFT)) {
        int line = cur_tok(p)->line;
        const char *op = token_kind_name(cur_tok(p)->kind);
        advance_p(p);
        AstNode *right = parse_add(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup(op);
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_bit_and(Parser *p) {
    AstNode *left = parse_shift(p);
    while (check(p, TK_AMP)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *right = parse_shift(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup("&");
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_bit_xor(Parser *p) {
    AstNode *left = parse_bit_and(p);
    while (check(p, TK_CARET)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *right = parse_bit_and(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup("^");
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_bit_or(Parser *p) {
    AstNode *left = parse_bit_xor(p);
    while (check(p, TK_PIPE)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *right = parse_bit_xor(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup("|");
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_compare(Parser *p) {
    AstNode *left = parse_bit_or(p);
    TokenKind k = cur_tok(p)->kind;
    if (k == TK_EQEQ || k == TK_BANGEQ || k == TK_LT ||
        k == TK_LTEQ || k == TK_GT || k == TK_GTEQ) {
        int line = cur_tok(p)->line;
        const char *op = token_kind_name(k);
        advance_p(p);
        AstNode *right = parse_bit_or(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup(op);
        ast_add_child(n, left);
        ast_add_child(n, right);
        return n;
    }
    return left;
}

static AstNode *parse_logic_and(Parser *p) {
    AstNode *left = parse_compare(p);
    while (check(p, TK_AMPAMP)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *right = parse_compare(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup("&&");
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_logic_or(Parser *p) {
    AstNode *left = parse_logic_and(p);
    while (check(p, TK_PIPEPIPE)) {
        int line = cur_tok(p)->line;
        advance_p(p);
        AstNode *right = parse_logic_and(p);
        AstNode *n = ast_node("binop", line);
        n->sval = strdup("||");
        ast_add_child(n, left);
        ast_add_child(n, right);
        left = n;
    }
    return left;
}

static AstNode *parse_expr(Parser *p) {
    return parse_logic_or(p);
}

static AstNode *parse_var_decl(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_VAR);
    Token *name = expect(p, TK_IDENT);
    expect(p, TK_COLON);
    AstNode *ty = parse_type(p);
    AstNode *n = ast_node("var_decl", line);
    n->sval = strdup(name->sval);
    ast_add_child(n, ty);
    if (match(p, TK_EQ)) {
        AstNode *init = parse_expr(p);
        ast_add_child(n, init);
    }
    expect(p, TK_SEMI);
    return n;
}

static AstNode *parse_if_stmt(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_IF);
    AstNode *cond = parse_expr(p);
    AstNode *then_blk = parse_block(p);
    AstNode *n = ast_node("if", line);
    ast_add_child(n, cond);
    ast_add_child(n, then_blk);
    if (match(p, TK_ELSE)) {
        if (check(p, TK_IF)) {
            AstNode *elif = parse_if_stmt(p);
            ast_add_child(n, elif);
        } else {
            AstNode *else_blk = parse_block(p);
            ast_add_child(n, else_blk);
        }
    }
    return n;
}

static AstNode *parse_while_stmt(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_WHILE);
    AstNode *cond = parse_expr(p);
    AstNode *body = parse_block(p);
    AstNode *n = ast_node("while", line);
    ast_add_child(n, cond);
    ast_add_child(n, body);
    return n;
}

static AstNode *parse_return_stmt(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_RETURN);
    AstNode *n = ast_node("return", line);
    if (!check(p, TK_SEMI)) {
        AstNode *val = parse_expr(p);
        ast_add_child(n, val);
    }
    expect(p, TK_SEMI);
    return n;
}

static AstNode *parse_ident_stmt(Parser *p) {
    /* ident_stmt: IDENT '=' expr ';'  OR  IDENT '(' ... ')' ';' */
    Token *t = cur_tok(p);
    int line = t->line;
    char *name = strdup(t->sval);
    advance_p(p);

    if (check(p, TK_EQ)) {
        advance_p(p);
        AstNode *val = parse_expr(p);
        expect(p, TK_SEMI);
        AstNode *n = ast_node("assign", line);
        n->sval = name;
        ast_add_child(n, val);
        return n;
    } else if (check(p, TK_PLUS_EQ) || check(p, TK_MINUS_EQ) ||
               check(p, TK_STAR_EQ) || check(p, TK_SLASH_EQ) || check(p, TK_PERCENT_EQ)) {
        /* desugar: a OP= b  →  assign a (OP (var a) b) */
        TokenKind op = cur_tok(p)->kind;
        advance_p(p);
        AstNode *rhs = parse_expr(p);
        expect(p, TK_SEMI);
        const char *opname = (op == TK_PLUS_EQ) ? "+" :
                             (op == TK_MINUS_EQ) ? "-" :
                             (op == TK_STAR_EQ)  ? "*" :
                             (op == TK_SLASH_EQ) ? "/" : "%";
        AstNode *lhs_var = ast_node("var", line);
        lhs_var->sval = strdup(name);
        AstNode *binop = ast_node("binop", line);
        binop->sval = strdup(opname);
        ast_add_child(binop, lhs_var);
        ast_add_child(binop, rhs);
        AstNode *n = ast_node("assign", line);
        n->sval = name;
        ast_add_child(n, binop);
        return n;
    } else if (check(p, TK_LPAREN)) {
        advance_p(p);
        AstNode *call = ast_node("call_stmt", line);
        call->sval = name;
        if (!check(p, TK_RPAREN)) {
            do {
                AstNode *arg = parse_expr(p);
                ast_add_child(call, arg);
            } while (match(p, TK_COMMA));
        }
        expect(p, TK_RPAREN);
        expect(p, TK_SEMI);
        return call;
    } else {
        fprintf(stderr, "%s:%d: expected '=' or '(' after identifier in statement\n",
                p->filename, line);
        free(name);
        exit(1);
    }
}

static AstNode *parse_stmt(Parser *p) {
    Token *t = cur_tok(p);
    if (t->kind == TK_VAR) return parse_var_decl(p);
    if (t->kind == TK_IF) return parse_if_stmt(p);
    if (t->kind == TK_WHILE) return parse_while_stmt(p);
    if (t->kind == TK_RETURN) return parse_return_stmt(p);
    if (t->kind == TK_BREAK) {
        int line = t->line; advance_p(p); expect(p, TK_SEMI);
        return ast_node("break", line);
    }
    if (t->kind == TK_CONTINUE) {
        int line = t->line; advance_p(p); expect(p, TK_SEMI);
        return ast_node("continue", line);
    }
    if (t->kind == TK_IDENT) return parse_ident_stmt(p);
    fprintf(stderr, "%s:%d: unexpected token '%s' in statement\n",
            p->filename, t->line, token_kind_name(t->kind));
    exit(1);
}

static AstNode *parse_block(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_LBRACE);
    AstNode *block = ast_node("block", line);
    while (!check(p, TK_RBRACE) && !check(p, TK_EOF)) {
        AstNode *s = parse_stmt(p);
        ast_add_child(block, s);
    }
    expect(p, TK_RBRACE);
    return block;
}

static AstNode *parse_fn_decl(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_FN);
    Token *name = expect(p, TK_IDENT);
    expect(p, TK_LPAREN);
    AstNode *params = ast_node("params", line);
    if (!check(p, TK_RPAREN)) {
        do {
            Token *pname = expect(p, TK_IDENT);
            expect(p, TK_COLON);
            AstNode *pty = parse_type(p);
            AstNode *param = ast_node("param", pname->line);
            param->sval = strdup(pname->sval);
            ast_add_child(param, pty);
            ast_add_child(params, param);
        } while (match(p, TK_COMMA));
    }
    expect(p, TK_RPAREN);

    AstNode *ret_ty;
    if (match(p, TK_ARROW)) {
        ret_ty = parse_type(p);
    } else {
        ret_ty = ast_node("type", line);
        ret_ty->sval = strdup("void");
    }

    AstNode *body = parse_block(p);

    AstNode *n = ast_node("fn", line);
    n->sval = strdup(name->sval);
    /* children: params, ret_type, body */
    ast_add_child(n, params);
    AstNode *ret_wrapper = ast_node("ret", line);
    ast_add_child(ret_wrapper, ret_ty);
    ast_add_child(n, ret_wrapper);
    ast_add_child(n, body);
    return n;
}

/* ---- synthetic function generation for struct ---- */

/* Create a (type T) node. */
static AstNode *mk_type(const char *tname, int line) {
    AstNode *n = ast_node("type", line);
    n->sval = strdup(tname);
    return n;
}

/* Create a (var name) node. */
static AstNode *mk_var(const char *name, int line) {
    AstNode *n = ast_node("var", line);
    n->sval = strdup(name);
    return n;
}

/* Create a (param name (type T)) node. */
static AstNode *mk_param(const char *name, const char *tname, int line) {
    AstNode *n = ast_node("param", line);
    n->sval = strdup(name);
    ast_add_child(n, mk_type(tname, line));
    return n;
}

/* Create an (int N) node with optional u32 suffix marker. */
static AstNode *mk_int(long v, int line) {
    AstNode *n = ast_node("int", line);
    n->ival = v;
    return n;
}

/* Create a (cast expr (type T)) node. */
static AstNode *mk_cast(AstNode *expr, const char *tname, int line) {
    AstNode *n = ast_node("cast", line);
    ast_add_child(n, expr);
    ast_add_child(n, mk_type(tname, line));
    return n;
}

/* Create a call/call_stmt node. varargs are AstNode* children ending in NULL. */
static AstNode *mk_call(const char *kind, const char *fname, int line, int nargs, AstNode **args) {
    AstNode *n = ast_node(kind, line);
    n->sval = strdup(fname);
    for (int i = 0; i < nargs; i++) ast_add_child(n, args[i]);
    return n;
}

/* Generate synthetic fn AST nodes for a struct and add them to `prog`.
   For struct Point { x: i32, y: i32 }, generates:
     fn Point(__a0: i32, __a1: i32) -> Point { ... }
     fn x(__p: Point) -> i32 { ... }    (getter)
     fn y(__p: Point) -> i32 { ... }
     fn x(__p: Point, __v: i32) -> void { ... }   (setter)
     fn y(__p: Point, __v: i32) -> void { ... }
*/
static void gen_struct_synthetic_fns(AstNode *prog, AstNode *struct_node) {
    const char *sname = struct_node->sval;
    int nfields = struct_node->nchildren;
    int line = struct_node->line;

    /* --- constructor: StructName(__a0: t0, __a1: t1, ...) -> StructName --- */
    {
        AstNode *fn = ast_node("fn", line);
        fn->sval = strdup(sname);

        AstNode *params = ast_node("params", line);
        for (int i = 0; i < nfields; i++) {
            AstNode *field = struct_node->children[i];
            const char *ftype = field->children[0]->sval;
            char pname[32];
            snprintf(pname, sizeof(pname), "__a%d", i);
            ast_add_child(params, mk_param(pname, ftype, line));
        }
        ast_add_child(fn, params);

        AstNode *ret = ast_node("ret", line);
        ast_add_child(ret, mk_type(sname, line));
        ast_add_child(fn, ret);

        AstNode *block = ast_node("block", line);

        /* var __p: U32Array = U32Array(nfields); */
        {
            AstNode *sz = mk_int(nfields, line);
            AstNode *args[] = {sz};
            AstNode *call = mk_call("call", "U32Array", line, 1, args);
            AstNode *vd = ast_node("var_decl", line);
            vd->sval = strdup("__p");
            ast_add_child(vd, mk_type("U32Array", line));
            ast_add_child(vd, call);
            ast_add_child(block, vd);
        }

        /* set(__p, i, __ai as u32); */
        for (int i = 0; i < nfields; i++) {
            char pname[32];
            snprintf(pname, sizeof(pname), "__a%d", i);
            AstNode *pvar = mk_var("__p", line);
            AstNode *idx = mk_int(i, line);
            AstNode *val = mk_cast(mk_var(pname, line), "u32", line);
            AstNode *args[] = {pvar, idx, val};
            AstNode *cs = mk_call("call_stmt", "set", line, 3, args);
            ast_add_child(block, cs);
        }

        /* return __p as StructName; */
        {
            AstNode *ret_stmt = ast_node("return", line);
            ast_add_child(ret_stmt, mk_cast(mk_var("__p", line), sname, line));
            ast_add_child(block, ret_stmt);
        }

        ast_add_child(fn, block);
        ast_add_child(prog, fn);
    }

    /* --- getters: fieldName(__p: StructName) -> fieldType --- */
    for (int i = 0; i < nfields; i++) {
        AstNode *field = struct_node->children[i];
        const char *fname = field->sval;
        const char *ftype = field->children[0]->sval;

        AstNode *fn = ast_node("fn", line);
        fn->sval = strdup(fname);

        AstNode *params = ast_node("params", line);
        ast_add_child(params, mk_param("__p", sname, line));
        ast_add_child(fn, params);

        AstNode *ret = ast_node("ret", line);
        ast_add_child(ret, mk_type(ftype, line));
        ast_add_child(fn, ret);

        AstNode *block = ast_node("block", line);
        /* return get(__p as U32Array, i) as FieldType; */
        AstNode *p_as_arr = mk_cast(mk_var("__p", line), "U32Array", line);
        AstNode *idx = mk_int(i, line);
        AstNode *getargs[] = {p_as_arr, idx};
        AstNode *getcall = mk_call("call", "get", line, 2, getargs);
        AstNode *casted = mk_cast(getcall, ftype, line);
        AstNode *ret_stmt = ast_node("return", line);
        ast_add_child(ret_stmt, casted);
        ast_add_child(block, ret_stmt);

        ast_add_child(fn, block);
        ast_add_child(prog, fn);
    }

    /* --- setters: fieldName(__p: StructName, __v: fieldType) -> void --- */
    for (int i = 0; i < nfields; i++) {
        AstNode *field = struct_node->children[i];
        const char *fname = field->sval;
        const char *ftype = field->children[0]->sval;

        AstNode *fn = ast_node("fn", line);
        fn->sval = strdup(fname);

        AstNode *params = ast_node("params", line);
        ast_add_child(params, mk_param("__p", sname, line));
        ast_add_child(params, mk_param("__v", ftype, line));
        ast_add_child(fn, params);

        AstNode *ret = ast_node("ret", line);
        ast_add_child(ret, mk_type("void", line));
        ast_add_child(fn, ret);

        AstNode *block = ast_node("block", line);
        /* set(__p as U32Array, i, __v as u32); */
        AstNode *p_as_arr = mk_cast(mk_var("__p", line), "U32Array", line);
        AstNode *idx = mk_int(i, line);
        AstNode *val_cast = mk_cast(mk_var("__v", line), "u32", line);
        AstNode *setargs[] = {p_as_arr, idx, val_cast};
        AstNode *setcall = mk_call("call_stmt", "set", line, 3, setargs);
        ast_add_child(block, setcall);

        /* return; */
        AstNode *ret_stmt = ast_node("return", line);
        ast_add_child(block, ret_stmt);

        ast_add_child(fn, block);
        ast_add_child(prog, fn);
    }

    /* --- delete: delete(__p: StructName) -> void --- */
    {
        AstNode *fn = ast_node("fn", line);
        fn->sval = strdup("delete");

        AstNode *params = ast_node("params", line);
        ast_add_child(params, mk_param("__p", sname, line));
        ast_add_child(fn, params);

        AstNode *ret = ast_node("ret", line);
        ast_add_child(ret, mk_type("void", line));
        ast_add_child(fn, ret);

        AstNode *block = ast_node("block", line);
        /* delete(__p as U32Array); */
        AstNode *p_as_arr = mk_cast(mk_var("__p", line), "U32Array", line);
        AstNode *args[] = {p_as_arr};
        AstNode *cs = mk_call("call_stmt", "delete", line, 1, args);
        ast_add_child(block, cs);

        /* return; */
        AstNode *ret_stmt = ast_node("return", line);
        ast_add_child(block, ret_stmt);

        ast_add_child(fn, block);
        ast_add_child(prog, fn);
    }
}

static AstNode *parse_struct_decl(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_STRUCT);
    Token *name = expect(p, TK_IDENT);
    expect(p, TK_LBRACE);
    AstNode *n = ast_node("struct", line);
    n->sval = strdup(name->sval);
    if (!check(p, TK_RBRACE)) {
        do {
            Token *fname = expect(p, TK_IDENT);
            expect(p, TK_COLON);
            AstNode *fty = parse_type(p);
            AstNode *field = ast_node("field", fname->line);
            field->sval = strdup(fname->sval);
            ast_add_child(field, fty);
            ast_add_child(n, field);
        } while (match(p, TK_COMMA));
    }
    expect(p, TK_RBRACE);
    return n;
}

static AstNode *parse_import(Parser *p) {
    int line = cur_tok(p)->line;
    expect(p, TK_IMPORT);
    Token *path = cur_tok(p);
    if (path->kind != TK_STR_LIT) {
        fprintf(stderr, "%s:%d: expected string literal after 'import'\n",
                p->filename, line);
        exit(1);
    }
    AstNode *n = ast_node("import", line);
    n->sval = strdup(path->str_content);
    advance_p(p);
    expect(p, TK_SEMI);
    return n;
}

AstNode *parse(Token *tokens, int ntokens, const char *filename) {
    Parser p;
    p.tokens = tokens;
    p.ntokens = ntokens;
    p.pos = 0;
    p.filename = filename;

    AstNode *prog = ast_node("program", 1);

    /* parse imports */
    while (check(&p, TK_IMPORT)) {
        AstNode *imp = parse_import(&p);
        ast_add_child(prog, imp);
    }

    /* parse declarations */
    while (!check(&p, TK_EOF)) {
        Token *t = cur_tok(&p);
        AstNode *d = NULL;
        if (t->kind == TK_EXPORT) {
            advance_p(&p);
            if (!check(&p, TK_FN)) {
                fprintf(stderr, "%s:%d: expected 'fn' after 'export'\n",
                        p.filename, t->line);
                exit(1);
            }
            d = parse_fn_decl(&p);
            d->type_annot = strdup("export");
        } else if (t->kind == TK_FN) {
            d = parse_fn_decl(&p);
        } else if (t->kind == TK_STRUCT) {
            d = parse_struct_decl(&p);
            ast_add_child(prog, d);
            gen_struct_synthetic_fns(prog, d);
            continue;
        } else if (t->kind == TK_VAR) {
            d = parse_var_decl(&p);
        } else {
            fprintf(stderr, "%s:%d: expected 'fn', 'struct', 'export', or 'var' at top level, got '%s'\n",
                    p.filename, t->line, token_kind_name(t->kind));
            exit(1);
        }
        ast_add_child(prog, d);
    }
    return prog;
}
