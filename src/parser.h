#ifndef PARSER_H
#define PARSER_H

#include "lexer.h"
#include "ast.h"

AstNode *parse(Token *tokens, int ntokens, const char *filename);

#endif /* PARSER_H */
