#ifndef INTERP_H
#define INTERP_H

#include "ast.h"

/* Interpret the typed AST. Returns the exit code. */
int interpret(AstNode *program);

#endif /* INTERP_H */
