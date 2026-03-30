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
        AstNode *else_blk = parse_block(p);
        ast_add_child(n, else_blk);
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
        if (t->kind == TK_FN) {
            d = parse_fn_decl(&p);
        } else if (t->kind == TK_STRUCT) {
            d = parse_struct_decl(&p);
        } else if (t->kind == TK_VAR) {
            d = parse_var_decl(&p);
        } else {
            fprintf(stderr, "%s:%d: expected 'fn', 'struct', or 'var' at top level, got '%s'\n",
                    p.filename, t->line, token_kind_name(t->kind));
            exit(1);
        }
        ast_add_child(prog, d);
    }
    return prog;
}
