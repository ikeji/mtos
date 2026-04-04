#ifndef AST_H
#define AST_H

#include <stdio.h>

typedef struct AstNode {
    char *kind;          /* node kind: "program","fn","var","binop", etc. */
    char *type_annot;    /* type annotation after typecheck, NULL before */
    char *sval;          /* string value: name, operator, type name, etc. */
    long ival;           /* integer value for int literals */
    struct AstNode **children;
    int nchildren;
    int line;
} AstNode;

AstNode *ast_node(const char *kind, int line);
void ast_add_child(AstNode *parent, AstNode *child);
void ast_print(AstNode *node, int indent);
void ast_print_with_source(AstNode *node, int indent, const char *source);
void ast_free(AstNode *node);
AstNode *ast_read(FILE *f);

#endif /* AST_H */
