#include "lexer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

static void lexer_push(Lexer *l, Token t) {
    if (l->ntokens >= l->cap) {
        l->cap = l->cap ? l->cap * 2 : 64;
        l->tokens = realloc(l->tokens, l->cap * sizeof(Token));
        if (!l->tokens) { fprintf(stderr, "out of memory\n"); exit(1); }
    }
    l->tokens[l->ntokens++] = t;
}

static Token make_token(TokenKind k, int line) {
    Token t;
    memset(&t, 0, sizeof(t));
    t.kind = k;
    t.line = line;
    return t;
}

static int is_ident_start(char c) {
    return isalpha((unsigned char)c) || c == '_';
}
static int is_ident_cont(char c) {
    return isalnum((unsigned char)c) || c == '_';
}

static char cur(Lexer *l) { return l->source[l->pos]; }
static char peek_c(Lexer *l) { return l->source[l->pos + 1]; }
static void advance(Lexer *l) {
    if (l->source[l->pos] == '\n') l->line++;
    l->pos++;
}

static char *strdup_n(const char *s, int n) {
    char *r = malloc(n + 1);
    if (!r) { fprintf(stderr, "out of memory\n"); exit(1); }
    memcpy(r, s, n);
    r[n] = '\0';
    return r;
}

struct Keyword {
    const char *word;
    TokenKind kind;
};

static struct Keyword keywords[] = {
    {"fn", TK_FN}, {"struct", TK_STRUCT}, {"var", TK_VAR},
    {"if", TK_IF}, {"else", TK_ELSE}, {"while", TK_WHILE},
    {"return", TK_RETURN}, {"import", TK_IMPORT}, {"as", TK_AS},
    {"true", TK_TRUE}, {"false", TK_FALSE},
    {"break", TK_BREAK}, {"continue", TK_CONTINUE}, {"export", TK_EXPORT},
    {"u8", TK_U8}, {"u16", TK_U16}, {"u32", TK_U32},
    {"i8", TK_I8}, {"i16", TK_I16}, {"i32", TK_I32},
    {"bool", TK_BOOL}, {"void", TK_VOID},
    {NULL, TK_EOF}
};

static TokenKind lookup_keyword(const char *s) {
    for (int i = 0; keywords[i].word; i++) {
        if (strcmp(s, keywords[i].word) == 0)
            return keywords[i].kind;
    }
    return TK_IDENT;
}

static char unescape_char(char c) {
    switch (c) {
        case 'n': return '\n';
        case 't': return '\t';
        case 'r': return '\r';
        case '\\': return '\\';
        case '"': return '"';
        case '0': return '\0';
        default: return c;
    }
}

void lexer_init(Lexer *l, const char *source, const char *filename) {
    memset(l, 0, sizeof(*l));
    l->source = source;
    l->filename = filename;
    l->line = 1;
}

void lexer_tokenize(Lexer *l) {
    while (1) {
        /* skip whitespace */
        while (cur(l) && isspace((unsigned char)cur(l))) advance(l);
        if (!cur(l)) break;

        /* skip line comments */
        if (cur(l) == '/' && peek_c(l) == '/') {
            while (cur(l) && cur(l) != '\n') advance(l);
            continue;
        }

        /* skip block comments */
        if (cur(l) == '/' && peek_c(l) == '*') {
            advance(l); advance(l);
            while (cur(l) && !(cur(l) == '*' && peek_c(l) == '/')) advance(l);
            if (cur(l)) { advance(l); advance(l); }
            continue;
        }

        int line = l->line;

        /* string literal */
        if (cur(l) == '"') {
            advance(l);
            int start = l->pos;
            int cap = 64, len = 0;
            char *buf = malloc(cap);
            if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
            while (cur(l) && cur(l) != '"') {
                char c;
                if (cur(l) == '\\') {
                    advance(l);
                    c = unescape_char(cur(l));
                } else {
                    c = cur(l);
                }
                if (len + 1 >= cap) {
                    cap *= 2;
                    buf = realloc(buf, cap);
                    if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
                }
                buf[len++] = c;
                advance(l);
            }
            (void)start;
            if (cur(l) == '"') advance(l);
            buf[len] = '\0';
            Token t = make_token(TK_STR_LIT, line);
            t.str_content = buf;
            lexer_push(l, t);
            continue;
        }

        /* character literal: 'X' → u8 integer */
        if (cur(l) == '\'') {
            advance(l);  /* skip opening ' */
            long val = 0;
            if (cur(l) == '\\') {
                advance(l);
                val = (unsigned char)unescape_char(cur(l));
                advance(l);
            } else {
                val = (unsigned char)cur(l);
                advance(l);
            }
            if (cur(l) == '\'') advance(l);  /* skip closing ' */
            Token t = make_token(TK_INT_LIT, line);
            t.ival = val;
            t.int_suffix = strdup("u8");
            lexer_push(l, t);
            continue;
        }

        /* integer literal */
        if (isdigit((unsigned char)cur(l))) {
            long val = 0;
            if (cur(l) == '0' && (l->source[l->pos+1] == 'x' || l->source[l->pos+1] == 'X')) {
                /* hex literal: 0x... */
                advance(l); advance(l); /* skip '0x' */
                while (isxdigit((unsigned char)cur(l))) {
                    char c = cur(l);
                    int d = (c >= '0' && c <= '9') ? c - '0' :
                            (c >= 'a' && c <= 'f') ? c - 'a' + 10 : c - 'A' + 10;
                    val = val * 16 + d;
                    advance(l);
                }
            } else if (cur(l) == '0' && (l->source[l->pos+1] == 'b' || l->source[l->pos+1] == 'B')) {
                /* binary literal: 0b... */
                advance(l); advance(l); /* skip '0b' */
                while (cur(l) == '0' || cur(l) == '1') {
                    val = val * 2 + (cur(l) - '0');
                    advance(l);
                }
            } else {
                while (isdigit((unsigned char)cur(l))) {
                    val = val * 10 + (cur(l) - '0');
                    advance(l);
                }
            }
            /* check for suffix */
            char *suffix = NULL;
            if (cur(l) == 'i' || cur(l) == 'u') {
                char sign = cur(l);
                advance(l);
                if (isdigit((unsigned char)cur(l))) {
                    long bits = 0;
                    while (isdigit((unsigned char)cur(l))) {
                        bits = bits * 10 + (cur(l) - '0');
                        advance(l);
                    }
                    /* build suffix string */
                    char sbuf[8];
                    snprintf(sbuf, sizeof(sbuf), "%c%ld", sign, bits);
                    suffix = strdup(sbuf);
                } else {
                    /* not a suffix, push back */
                    l->pos--;
                }
            }
            Token t = make_token(TK_INT_LIT, line);
            t.ival = val;
            t.int_suffix = suffix;
            lexer_push(l, t);
            continue;
        }

        /* identifier or keyword */
        if (is_ident_start(cur(l))) {
            int start = l->pos;
            while (is_ident_cont(cur(l))) advance(l);
            int len = l->pos - start;
            char *word = strdup_n(l->source + start, len);
            TokenKind kind = lookup_keyword(word);
            Token t = make_token(kind, line);
            if (kind == TK_IDENT) {
                t.sval = word;
            } else {
                free(word);
            }
            lexer_push(l, t);
            continue;
        }

        /* operators and delimiters */
        char c = cur(l);
        char n = peek_c(l);
        Token t = make_token(TK_EOF, line); /* placeholder */

        switch (c) {
            case '+':
                if (n == '=') { t.kind = TK_PLUS_EQ; advance(l); advance(l); }
                else { t.kind = TK_PLUS; advance(l); }
                break;
            case '-':
                if (n == '>') { t.kind = TK_ARROW; advance(l); advance(l); }
                else if (n == '=') { t.kind = TK_MINUS_EQ; advance(l); advance(l); }
                else { t.kind = TK_MINUS; advance(l); }
                break;
            case '*':
                if (n == '=') { t.kind = TK_STAR_EQ; advance(l); advance(l); }
                else { t.kind = TK_STAR; advance(l); }
                break;
            case '/':
                if (n == '=') { t.kind = TK_SLASH_EQ; advance(l); advance(l); }
                else { t.kind = TK_SLASH; advance(l); }
                break;
            case '%':
                if (n == '=') { t.kind = TK_PERCENT_EQ; advance(l); advance(l); }
                else { t.kind = TK_PERCENT; advance(l); }
                break;
            case '&':
                if (n == '&') { t.kind = TK_AMPAMP; advance(l); advance(l); }
                else { t.kind = TK_AMP; advance(l); }
                break;
            case '|':
                if (n == '|') { t.kind = TK_PIPEPIPE; advance(l); advance(l); }
                else { t.kind = TK_PIPE; advance(l); }
                break;
            case '^': t.kind = TK_CARET; advance(l); break;
            case '<':
                if (n == '<') { t.kind = TK_LSHIFT; advance(l); advance(l); }
                else if (n == '=') { t.kind = TK_LTEQ; advance(l); advance(l); }
                else { t.kind = TK_LT; advance(l); }
                break;
            case '>':
                if (n == '>') { t.kind = TK_RSHIFT; advance(l); advance(l); }
                else if (n == '=') { t.kind = TK_GTEQ; advance(l); advance(l); }
                else { t.kind = TK_GT; advance(l); }
                break;
            case '!':
                if (n == '=') { t.kind = TK_BANGEQ; advance(l); advance(l); }
                else { t.kind = TK_BANG; advance(l); }
                break;
            case '=':
                if (n == '=') { t.kind = TK_EQEQ; advance(l); advance(l); }
                else { t.kind = TK_EQ; advance(l); }
                break;
            case '(': t.kind = TK_LPAREN; advance(l); break;
            case ')': t.kind = TK_RPAREN; advance(l); break;
            case '{': t.kind = TK_LBRACE; advance(l); break;
            case '}': t.kind = TK_RBRACE; advance(l); break;
            case ',': t.kind = TK_COMMA; advance(l); break;
            case ';': t.kind = TK_SEMI; advance(l); break;
            case ':': t.kind = TK_COLON; advance(l); break;
            default:
                fprintf(stderr, "%s:%d: unexpected character '%c'\n",
                        l->filename, line, c);
                advance(l);
                continue;
        }
        lexer_push(l, t);
    }

    Token eof = make_token(TK_EOF, l->line);
    lexer_push(l, eof);
}

void lexer_free(Lexer *l) {
    for (int i = 0; i < l->ntokens; i++) {
        free(l->tokens[i].sval);
        free(l->tokens[i].int_suffix);
        free(l->tokens[i].str_content);
    }
    free(l->tokens);
    memset(l, 0, sizeof(*l));
}

const char *token_kind_name(TokenKind k) {
    switch (k) {
        case TK_FN: return "fn";
        case TK_STRUCT: return "struct";
        case TK_VAR: return "var";
        case TK_IF: return "if";
        case TK_ELSE: return "else";
        case TK_WHILE: return "while";
        case TK_RETURN: return "return";
        case TK_IMPORT: return "import";
        case TK_AS: return "as";
        case TK_TRUE: return "true";
        case TK_FALSE: return "false";
        case TK_U8: return "u8"; case TK_U16: return "u16"; case TK_U32: return "u32";
        case TK_I8: return "i8"; case TK_I16: return "i16"; case TK_I32: return "i32";
        case TK_BOOL: return "bool"; case TK_VOID: return "void";
        case TK_PLUS: return "+"; case TK_MINUS: return "-";
        case TK_STAR: return "*"; case TK_SLASH: return "/"; case TK_PERCENT: return "%";
        case TK_AMP: return "&"; case TK_PIPE: return "|"; case TK_CARET: return "^";
        case TK_LSHIFT: return "<<"; case TK_RSHIFT: return ">>";
        case TK_AMPAMP: return "&&"; case TK_PIPEPIPE: return "||"; case TK_BANG: return "!";
        case TK_EQEQ: return "=="; case TK_BANGEQ: return "!=";
        case TK_LT: return "<"; case TK_LTEQ: return "<=";
        case TK_GT: return ">"; case TK_GTEQ: return ">=";
        case TK_EQ: return "="; case TK_ARROW: return "->";
        case TK_PLUS_EQ: return "+="; case TK_MINUS_EQ: return "-=";
        case TK_STAR_EQ: return "*="; case TK_SLASH_EQ: return "/="; case TK_PERCENT_EQ: return "%=";
        case TK_LPAREN: return "("; case TK_RPAREN: return ")";
        case TK_LBRACE: return "{"; case TK_RBRACE: return "}";
        case TK_COMMA: return ","; case TK_SEMI: return ";"; case TK_COLON: return ":";
        case TK_INT_LIT: return "INT_LIT"; case TK_STR_LIT: return "STR_LIT";
        case TK_IDENT: return "IDENT"; case TK_EOF: return "EOF";
        case TK_BREAK: return "break"; case TK_CONTINUE: return "continue";
        case TK_EXPORT: return "export";
        default: return "?";
    }
}
