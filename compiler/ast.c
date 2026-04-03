#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

AstNode *ast_node(const char *kind, int line) {
    AstNode *n = calloc(1, sizeof(AstNode));
    if (!n) { fprintf(stderr, "out of memory\n"); exit(1); }
    n->kind = strdup(kind);
    n->line = line;
    return n;
}

void ast_add_child(AstNode *parent, AstNode *child) {
    if (!child) return;
    parent->nchildren++;
    parent->children = realloc(parent->children,
                                parent->nchildren * sizeof(AstNode*));
    if (!parent->children) { fprintf(stderr, "out of memory\n"); exit(1); }
    parent->children[parent->nchildren - 1] = child;
}

void ast_free(AstNode *node) {
    if (!node) return;
    for (int i = 0; i < node->nchildren; i++)
        ast_free(node->children[i]);
    free(node->children);
    free(node->kind);
    free(node->type_annot);
    free(node->sval);
    free(node);
}

static void print_indent(int indent) {
    for (int i = 0; i < indent * 2; i++) putchar(' ');
}

static void print_escaped_str(const char *s) {
    putchar('"');
    for (; *s; s++) {
        switch ((unsigned char)*s) {
            case '\n': fputs("\\n", stdout); break;
            case '\t': fputs("\\t", stdout); break;
            case '\r': fputs("\\r", stdout); break;
            case '\\': fputs("\\\\", stdout); break;
            case '"':  fputs("\\\"", stdout); break;
            default:   putchar(*s); break;
        }
    }
    putchar('"');
}

void ast_print(AstNode *node, int indent) {
    if (!node) return;
    print_indent(indent);
    putchar('(');
    fputs(node->kind, stdout);
    if (node->type_annot) {
        putchar(':');
        fputs(node->type_annot, stdout);
    }
    if (strcmp(node->kind, "int") == 0) {
        /* always print ival; sval holds suffix */
        printf(" %ld", node->ival);
        if (node->sval) {
            /* suffix as annotation if not already annotated */
        }
    } else if (strcmp(node->kind, "str") == 0 && node->sval) {
        putchar(' ');
        print_escaped_str(node->sval);
    } else if (node->sval) {
        putchar(' ');
        fputs(node->sval, stdout);
    }
    if (node->nchildren == 0) {
        putchar(')');
    } else {
        for (int i = 0; i < node->nchildren; i++) {
            putchar('\n');
            ast_print(node->children[i], indent + 1);
        }
        putchar('\n');
        print_indent(indent);
        putchar(')');
    }
}

/* ---- S-expression reader ---- */

typedef struct {
    FILE *f;
    int ch;  /* lookahead char */
    int line;
} Reader;

static void reader_advance(Reader *r) {
    r->ch = fgetc(r->f);
    if (r->ch == '\n') r->line++;
}

static void reader_skip_ws(Reader *r) {
    while (r->ch != EOF && isspace((unsigned char)r->ch))
        reader_advance(r);
}

static char *reader_read_atom(Reader *r) {
    /* read until whitespace, ')', '(' */
    int cap = 64, len = 0;
    char *buf = malloc(cap);
    if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
    while (r->ch != EOF && !isspace((unsigned char)r->ch)
           && r->ch != ')' && r->ch != '(') {
        if (len + 1 >= cap) {
            cap *= 2;
            buf = realloc(buf, cap);
            if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
        }
        buf[len++] = (char)r->ch;
        reader_advance(r);
    }
    buf[len] = '\0';
    return buf;
}

static AstNode *reader_read_node(Reader *r);

static AstNode *reader_read_node(Reader *r) {
    reader_skip_ws(r);
    if (r->ch == EOF) return NULL;
    if (r->ch != '(') {
        /* bare atom (shouldn't happen in well-formed input) */
        char *atom = reader_read_atom(r);
        AstNode *n = ast_node(atom, r->line);
        free(atom);
        return n;
    }
    reader_advance(r); /* consume '(' */
    reader_skip_ws(r);

    /* read kind[:type_annot] */
    char *kind_full = reader_read_atom(r);
    char *kind = kind_full;
    char *type_annot = NULL;
    char *colon = strchr(kind_full, ':');
    if (colon) {
        *colon = '\0';
        type_annot = strdup(colon + 1);
    }
    AstNode *n = ast_node(kind, r->line);
    free(kind_full);
    if (type_annot) {
        n->type_annot = type_annot;
    }

    /* read optional sval or ival, then children */
    reader_skip_ws(r);
    while (r->ch != EOF && r->ch != ')') {
        if (r->ch == '(') {
            AstNode *child = reader_read_node(r);
            ast_add_child(n, child);
        } else if (r->ch == '"' && strcmp(n->kind, "str") == 0 && n->sval == NULL) {
            /* quoted string literal for str nodes */
            reader_advance(r); /* consume opening '"' */
            int cap = 64, len = 0;
            char *buf = malloc(cap);
            if (!buf) { fprintf(stderr, "out of memory\n"); exit(1); }
            while (r->ch != EOF && r->ch != '"') {
                char c;
                if (r->ch == '\\') {
                    reader_advance(r);
                    switch (r->ch) {
                        case 'n': c = '\n'; break;
                        case 't': c = '\t'; break;
                        case 'r': c = '\r'; break;
                        case '\\': c = '\\'; break;
                        case '"': c = '"'; break;
                        default: c = (char)r->ch; break;
                    }
                } else {
                    c = (char)r->ch;
                }
                if (len + 1 >= cap) { cap *= 2; buf = realloc(buf, cap); }
                buf[len++] = c;
                reader_advance(r);
            }
            buf[len] = '\0';
            if (r->ch == '"') reader_advance(r); /* consume closing '"' */
            n->sval = buf;
            reader_skip_ws(r);
            continue;
        } else {
            /* atom: could be sval or ival */
            char *atom = reader_read_atom(r);
            if (!atom || atom[0] == '\0') { free(atom); break; }
            /* check if it's the first non-child atom (sval/ival) */
            /* heuristic: if it looks like a number and kind=="int", set ival */
            if (strcmp(n->kind, "int") == 0 && (isdigit((unsigned char)atom[0])
                    || (atom[0] == '-' && isdigit((unsigned char)atom[1])))) {
                n->ival = atol(atom);
                free(atom);
            } else if (strcmp(n->kind, "bool") == 0) {
                n->ival = (strcmp(atom, "true") == 0) ? 1 : 0;
                free(atom);
            } else if (n->sval == NULL) {
                n->sval = atom;
            } else {
                /* extra atoms become leaf children */
                AstNode *leaf = ast_node(atom, r->line);
                free(atom);
                ast_add_child(n, leaf);
            }
        }
        reader_skip_ws(r);
    }
    if (r->ch == ')') reader_advance(r);
    return n;
}

AstNode *ast_read(FILE *f) {
    Reader r;
    r.f = f;
    r.line = 1;
    reader_advance(&r); /* prime lookahead */
    return reader_read_node(&r);
}
