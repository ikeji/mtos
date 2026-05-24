#ifndef PARSER_H
#define PARSER_H

#include "lexer.h"
#include "ast.h"

AstNode *parse(Token *tokens, int ntokens, const char *filename, const char *source);

#endif /* PARSER_H */
