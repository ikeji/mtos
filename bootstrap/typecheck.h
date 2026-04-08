#ifndef TYPECHECK_H
#define TYPECHECK_H

#include "ast.h"

/* Type-check the AST in place, annotating all nodes with type_annot.
   Returns the same node (root of program). */
AstNode *typecheck(AstNode *program, const char *filename);
/* Set to 1 before calling typecheck to skip array/string/sys builtin registration.
   Used when compiling runtime.tc which defines these functions itself. */
extern int typecheck_no_builtins;

#endif /* TYPECHECK_H */
