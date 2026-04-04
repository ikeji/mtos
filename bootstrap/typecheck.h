#ifndef TYPECHECK_H
#define TYPECHECK_H

#include "ast.h"

/* Type-check the AST in place, annotating all nodes with type_annot.
   Returns the same node (root of program). */
AstNode *typecheck(AstNode *program, const char *filename);

#endif /* TYPECHECK_H */
