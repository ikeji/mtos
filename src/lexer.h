#ifndef LEXER_H
#define LEXER_H

#include <stdint.h>

typedef enum {
    /* keywords */
    TK_FN, TK_STRUCT, TK_VAR, TK_IF, TK_ELSE, TK_WHILE, TK_RETURN,
    TK_IMPORT, TK_AS, TK_TRUE, TK_FALSE,
    /* type keywords */
    TK_U8, TK_U16, TK_U32, TK_I8, TK_I16, TK_I32, TK_BOOL, TK_VOID,
    /* operators */
    TK_PLUS, TK_MINUS, TK_STAR, TK_SLASH, TK_PERCENT,
    TK_AMP, TK_PIPE, TK_CARET, TK_LSHIFT, TK_RSHIFT,
    TK_AMPAMP, TK_PIPEPIPE, TK_BANG,
    TK_EQEQ, TK_BANGEQ, TK_LT, TK_LTEQ, TK_GT, TK_GTEQ,
    TK_EQ, TK_ARROW,
    /* delimiters */
    TK_LPAREN, TK_RPAREN, TK_LBRACE, TK_RBRACE,
    TK_COMMA, TK_SEMI, TK_COLON,
    /* literals */
    TK_INT_LIT, TK_STR_LIT,
    /* identifier */
    TK_IDENT,
    /* end of file */
    TK_EOF
} TokenKind;

typedef struct {
    TokenKind kind;
    int line;
    /* for identifiers/keywords */
    char *sval;
    /* for integer literals */
    long ival;
    char *int_suffix; /* "i8","i16","i32","u8","u16","u32", or NULL for default i32 */
    /* for string literals (unescaped content) */
    char *str_content;
} Token;

typedef struct {
    const char *source;
    const char *filename;
    int pos;
    int line;
    Token *tokens;
    int ntokens;
    int cap;
} Lexer;

void lexer_init(Lexer *l, const char *source, const char *filename);
void lexer_tokenize(Lexer *l);
void lexer_free(Lexer *l);
const char *token_kind_name(TokenKind k);

#endif /* LEXER_H */
