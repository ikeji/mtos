    .section .rodata
    .align 4
__tc_strobj0:
    .word 2
    .string "<<"
    .align 4
__tc_strobj1:
    .word 2
    .string ">>"
    .align 4
__tc_strobj2:
    .word 2
    .string "&&"
    .align 4
__tc_strobj3:
    .word 2
    .string "||"
    .align 4
__tc_strobj4:
    .word 2
    .string "=="
    .align 4
__tc_strobj5:
    .word 2
    .string "!="
    .align 4
__tc_strobj6:
    .word 2
    .string "<="
    .align 4
__tc_strobj7:
    .word 2
    .string ">="
    .align 4
__tc_strobj8:
    .word 2
    .string "u8"
    .align 4
__tc_strobj9:
    .word 3
    .string "u16"
    .align 4
__tc_strobj10:
    .word 3
    .string "u32"
    .align 4
__tc_strobj11:
    .word 2
    .string "i8"
    .align 4
__tc_strobj12:
    .word 3
    .string "i16"
    .align 4
__tc_strobj13:
    .word 3
    .string "i32"
    .align 4
__tc_strobj14:
    .word 4
    .string "bool"
    .align 4
__tc_strobj15:
    .word 4
    .string "void"
    .align 4
__tc_strobj16:
    .word 2
    .string "fn"
    .align 4
__tc_strobj17:
    .word 2
    .string "as"
    .align 4
__tc_strobj18:
    .word 2
    .string "if"
    .align 4
__tc_strobj19:
    .word 3
    .string "var"
    .align 4
__tc_strobj20:
    .word 4
    .string "else"
    .align 4
__tc_strobj21:
    .word 4
    .string "true"
    .align 4
__tc_strobj22:
    .word 5
    .string "while"
    .align 4
__tc_strobj23:
    .word 5
    .string "false"
    .align 4
__tc_strobj24:
    .word 5
    .string "break"
    .align 4
__tc_strobj25:
    .word 6
    .string "return"
    .align 4
__tc_strobj26:
    .word 6
    .string "struct"
    .align 4
__tc_strobj27:
    .word 6
    .string "import"
    .align 4
__tc_strobj28:
    .word 6
    .string "export"
    .align 4
__tc_strobj29:
    .word 8
    .string "continue"
    .align 4
__tc_strobj30:
    .word 17
    .string "parse: unexpected"
    .align 4
__tc_strobj31:
    .word 5
    .string "binop"
    .align 4
__tc_strobj32:
    .word 3
    .string "int"
    .align 4
__tc_strobj33:
    .word 3
    .string "str"
    .align 4
__tc_strobj34:
    .word 4
    .string "call"
    .align 4
__tc_strobj35:
    .word 4
    .string "cast"
    .align 4
__tc_strobj36:
    .word 5
    .string "unary"
    .align 4
__tc_strobj37:
    .word 4
    .string "type"
    .align 4
__tc_strobj38:
    .word 8
    .string "var_decl"
    .align 4
__tc_strobj39:
    .word 6
    .string "assign"
    .align 4
__tc_strobj40:
    .word 9
    .string "call_stmt"
    .align 4
__tc_strobj41:
    .word 7
    .string "comment"
    .align 4
__tc_strobj42:
    .word 5
    .string "block"
    .align 4
__tc_strobj43:
    .word 6
    .string "params"
    .align 4
__tc_strobj44:
    .word 5
    .string "param"
    .align 4
__tc_strobj45:
    .word 3
    .string "ret"
    .align 4
__tc_strobj46:
    .word 3
    .string "__a"
    .align 4
__tc_strobj47:
    .word 3
    .string "__p"
    .align 4
__tc_strobj48:
    .word 8
    .string "U32Array"
    .align 4
__tc_strobj49:
    .word 3
    .string "set"
    .align 4
__tc_strobj50:
    .word 3
    .string "get"
    .align 4
__tc_strobj51:
    .word 3
    .string "__v"
    .align 4
__tc_strobj52:
    .word 5
    .string "field"
    .align 4
__tc_strobj53:
    .word 6
    .string "delete"
    .align 4
__tc_strobj54:
    .word 7
    .string "program"

    .data
    .globl TK_FN
TK_FN:
    .word 0
    .globl TK_STRUCT
TK_STRUCT:
    .word 1
    .globl TK_VAR
TK_VAR:
    .word 2
    .globl TK_IF
TK_IF:
    .word 3
    .globl TK_ELSE
TK_ELSE:
    .word 4
    .globl TK_WHILE
TK_WHILE:
    .word 5
    .globl TK_RETURN
TK_RETURN:
    .word 6
    .globl TK_IMPORT
TK_IMPORT:
    .word 7
    .globl TK_AS
TK_AS:
    .word 8
    .globl TK_TRUE
TK_TRUE:
    .word 9
    .globl TK_FALSE
TK_FALSE:
    .word 10
    .globl TK_U8
TK_U8:
    .word 11
    .globl TK_U16
TK_U16:
    .word 12
    .globl TK_U32
TK_U32:
    .word 13
    .globl TK_I8
TK_I8:
    .word 14
    .globl TK_I16
TK_I16:
    .word 15
    .globl TK_I32
TK_I32:
    .word 16
    .globl TK_BOOL
TK_BOOL:
    .word 17
    .globl TK_VOID
TK_VOID:
    .word 18
    .globl TK_PLUS
TK_PLUS:
    .word 19
    .globl TK_MINUS
TK_MINUS:
    .word 20
    .globl TK_STAR
TK_STAR:
    .word 21
    .globl TK_SLASH
TK_SLASH:
    .word 22
    .globl TK_PERCENT
TK_PERCENT:
    .word 23
    .globl TK_AMP
TK_AMP:
    .word 24
    .globl TK_PIPE
TK_PIPE:
    .word 25
    .globl TK_CARET
TK_CARET:
    .word 26
    .globl TK_LSHIFT
TK_LSHIFT:
    .word 27
    .globl TK_RSHIFT
TK_RSHIFT:
    .word 28
    .globl TK_AMPAMP
TK_AMPAMP:
    .word 29
    .globl TK_PIPEPIPE
TK_PIPEPIPE:
    .word 30
    .globl TK_BANG
TK_BANG:
    .word 31
    .globl TK_EQEQ
TK_EQEQ:
    .word 32
    .globl TK_BANGEQ
TK_BANGEQ:
    .word 33
    .globl TK_LT
TK_LT:
    .word 34
    .globl TK_LTEQ
TK_LTEQ:
    .word 35
    .globl TK_GT
TK_GT:
    .word 36
    .globl TK_GTEQ
TK_GTEQ:
    .word 37
    .globl TK_EQ
TK_EQ:
    .word 38
    .globl TK_ARROW
TK_ARROW:
    .word 39
    .globl TK_PLUS_EQ
TK_PLUS_EQ:
    .word 40
    .globl TK_MINUS_EQ
TK_MINUS_EQ:
    .word 41
    .globl TK_STAR_EQ
TK_STAR_EQ:
    .word 42
    .globl TK_SLASH_EQ
TK_SLASH_EQ:
    .word 43
    .globl TK_PERCENT_EQ
TK_PERCENT_EQ:
    .word 44
    .globl TK_LPAREN
TK_LPAREN:
    .word 45
    .globl TK_RPAREN
TK_RPAREN:
    .word 46
    .globl TK_LBRACE
TK_LBRACE:
    .word 47
    .globl TK_RBRACE
TK_RBRACE:
    .word 48
    .globl TK_COMMA
TK_COMMA:
    .word 49
    .globl TK_SEMI
TK_SEMI:
    .word 50
    .globl TK_COLON
TK_COLON:
    .word 51
    .globl TK_INT_LIT
TK_INT_LIT:
    .word 52
    .globl TK_STR_LIT
TK_STR_LIT:
    .word 53
    .globl TK_IDENT
TK_IDENT:
    .word 54
    .globl TK_EOF
TK_EOF:
    .word 55
    .globl TK_BREAK
TK_BREAK:
    .word 56
    .globl TK_CONTINUE
TK_CONTINUE:
    .word 57
    .globl TK_EXPORT
TK_EXPORT:
    .word 58
    .globl g_line
g_line:
    .word 1
    .globl g_tok
g_tok:
    .word 55
    .globl g_tok_ival
g_tok_ival:
    .word 0
    .globl g_tok_slen
g_tok_slen:
    .word 0
    .globl g_tok_neg
g_tok_neg:
    .word 0
    .globl g_tok_line
g_tok_line:
    .word 1
    .globl g_last_comment_line
g_last_comment_line:
    .word 0
    .globl FI_STRIDE
FI_STRIDE:
    .word 4

    .text

    .globl StringBuffer__U8Array__i32__i32
    .type  StringBuffer__U8Array__i32__i32, @function
StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of StringBuffer__U8Array__i32__i32

    .globl buf__StringBuffer
    .type  buf__StringBuffer, @function
buf__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf__StringBuffer

    .globl pos__StringBuffer
    .type  pos__StringBuffer, @function
pos__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pos__StringBuffer

    .globl fd__StringBuffer
    .type  fd__StringBuffer, @function
fd__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fd__StringBuffer

    .globl buf__StringBuffer__U8Array
    .type  buf__StringBuffer__U8Array, @function
buf__StringBuffer__U8Array:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf__StringBuffer__U8Array

    .globl pos__StringBuffer__i32
    .type  pos__StringBuffer__i32, @function
pos__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pos__StringBuffer__i32

    .globl fd__StringBuffer__i32
    .type  fd__StringBuffer__i32, @function
fd__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fd__StringBuffer__i32

    .globl delete__StringBuffer
    .type  delete__StringBuffer, @function
delete__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of delete__StringBuffer

    .globl StringBuffer_new
    .type  StringBuffer_new, @function
StringBuffer_new:
    # prologue: frame_size=16, params=0, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call StringBuffer__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of StringBuffer_new

    .globl StringBuffer_new__i32
    .type  StringBuffer_new__i32, @function
StringBuffer_new__i32:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call StringBuffer__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of StringBuffer_new__i32

    .globl destroy__StringBuffer
    .type  destroy__StringBuffer, @function
destroy__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of destroy__StringBuffer

    .globl grow__StringBuffer
    .type  grow__StringBuffer, @function
grow__StringBuffer:
    # prologue: frame_size=32, params=1, locals=5
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f11_pc15:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f11_pc31
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    j    .L_f11_pc15
  .L_f11_pc31:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call buf__StringBuffer__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of grow__StringBuffer

    .globl emit_char__StringBuffer__u8
    .type  emit_char__StringBuffer__u8, @function
emit_char__StringBuffer__u8:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call len__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f12_pc28
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fd__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f12_pc25
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fd__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f12_pc28
  .L_f12_pc25:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call grow__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f12_pc28:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_char__StringBuffer__u8

    .globl emit_string__StringBuffer__StringLiteral
    .type  emit_string__StringBuffer__StringLiteral, @function
emit_string__StringBuffer__StringLiteral:
    # prologue: frame_size=32, params=2, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f13_pc5:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f13_pc20
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    j    .L_f13_pc5
  .L_f13_pc20:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_string__StringBuffer__StringLiteral

    .globl emit_string__StringBuffer__String
    .type  emit_string__StringBuffer__String, @function
emit_string__StringBuffer__String:
    # prologue: frame_size=32, params=2, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__String
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f14_pc5:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f14_pc20
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__String__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    j    .L_f14_pc5
  .L_f14_pc20:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_string__StringBuffer__String

    .globl emit_int__StringBuffer__i32
    .type  emit_int__StringBuffer__i32, @function
emit_int__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f15_pc12
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
  .L_f15_pc12:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f15_pc21
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f15_pc21:
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f15_pc28:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f15_pc51
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    rem  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    andi t0, t0, 0xff
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    div  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f15_pc28
  .L_f15_pc51:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f15_pc55:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f15_pc70
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    j    .L_f15_pc55
  .L_f15_pc70:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_int__StringBuffer__i32

    .globl emit_n__StringBuffer__U8Array__i32__i32
    .type  emit_n__StringBuffer__U8Array__i32__i32, @function
emit_n__StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=32, params=4, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f16_pc2:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f16_pc19
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f16_pc2
  .L_f16_pc19:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_n__StringBuffer__U8Array__i32__i32

    .globl emit_indent__StringBuffer__i32
    .type  emit_indent__StringBuffer__i32, @function
emit_indent__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f17_pc6:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f17_pc19
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f17_pc6
  .L_f17_pc19:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_indent__StringBuffer__i32

    .globl append__StringBuffer__StringBuffer
    .type  append__StringBuffer__StringBuffer, @function
append__StringBuffer__StringBuffer:
    # prologue: frame_size=32, params=2, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f18_pc5:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f18_pc21
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f18_pc5
  .L_f18_pc21:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of append__StringBuffer__StringBuffer

    .globl length__StringBuffer
    .type  length__StringBuffer, @function
length__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of length__StringBuffer

    .globl char_at__StringBuffer__i32
    .type  char_at__StringBuffer__i32, @function
char_at__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of char_at__StringBuffer__i32

    .globl reset__StringBuffer
    .type  reset__StringBuffer, @function
reset__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of reset__StringBuffer

    .globl write__StringBuffer__i32
    .type  write__StringBuffer__i32, @function
write__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of write__StringBuffer__i32

    .globl SourceReader__i32__U8Array__i32__i32__i32__StringBuffer__i32
    .type  SourceReader__i32__U8Array__i32__i32__i32__StringBuffer__i32, @function
SourceReader__i32__U8Array__i32__i32__i32__StringBuffer__i32:
    # prologue: frame_size=48, params=7, locals=1
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   zero, -40(s0)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of SourceReader__i32__U8Array__i32__i32__i32__StringBuffer__i32

    .globl rfd__SourceReader
    .type  rfd__SourceReader, @function
rfd__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of rfd__SourceReader

    .globl buf__SourceReader
    .type  buf__SourceReader, @function
buf__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf__SourceReader

    .globl buf_pos__SourceReader
    .type  buf_pos__SourceReader, @function
buf_pos__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf_pos__SourceReader

    .globl buf_len__SourceReader
    .type  buf_len__SourceReader, @function
buf_len__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf_len__SourceReader

    .globl is_eof__SourceReader
    .type  is_eof__SourceReader, @function
is_eof__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_eof__SourceReader

    .globl line__SourceReader
    .type  line__SourceReader, @function
line__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of line__SourceReader

    .globl lnum__SourceReader
    .type  lnum__SourceReader, @function
lnum__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of lnum__SourceReader

    .globl rfd__SourceReader__i32
    .type  rfd__SourceReader__i32, @function
rfd__SourceReader__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of rfd__SourceReader__i32

    .globl buf__SourceReader__U8Array
    .type  buf__SourceReader__U8Array, @function
buf__SourceReader__U8Array:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf__SourceReader__U8Array

    .globl buf_pos__SourceReader__i32
    .type  buf_pos__SourceReader__i32, @function
buf_pos__SourceReader__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf_pos__SourceReader__i32

    .globl buf_len__SourceReader__i32
    .type  buf_len__SourceReader__i32, @function
buf_len__SourceReader__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf_len__SourceReader__i32

    .globl is_eof__SourceReader__i32
    .type  is_eof__SourceReader__i32, @function
is_eof__SourceReader__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_eof__SourceReader__i32

    .globl line__SourceReader__StringBuffer
    .type  line__SourceReader__StringBuffer, @function
line__SourceReader__StringBuffer:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of line__SourceReader__StringBuffer

    .globl lnum__SourceReader__i32
    .type  lnum__SourceReader__i32, @function
lnum__SourceReader__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of lnum__SourceReader__i32

    .globl delete__SourceReader
    .type  delete__SourceReader, @function
delete__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of delete__SourceReader

    .globl SourceReader_new__i32
    .type  SourceReader_new__i32, @function
SourceReader_new__i32:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4092
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    call SourceReader__i32__U8Array__i32__i32__i32__StringBuffer__i32
    addi sp, sp, 28
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of SourceReader_new__i32

    .globl close__SourceReader
    .type  close__SourceReader, @function
close__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of close__SourceReader

    .globl fill__SourceReader
    .type  fill__SourceReader, @function
fill__SourceReader:
    # prologue: frame_size=16, params=1, locals=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_pos__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_len__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc8
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f41_pc8:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc15
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f41_pc15:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call rfd__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 4092
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_read__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc32
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call is_eof__SourceReader__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f41_pc32:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call buf_pos__SourceReader__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call buf_len__SourceReader__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fill__SourceReader

    .globl peek__SourceReader
    .type  peek__SourceReader, @function
peek__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fill__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc7
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f42_pc7:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_pos__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of peek__SourceReader

    .globl next__SourceReader
    .type  next__SourceReader, @function
next__SourceReader:
    # prologue: frame_size=16, params=1, locals=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fill__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc7
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f43_pc7:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_pos__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_pos__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call buf_pos__SourceReader__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc36
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call lnum__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lnum__SourceReader__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call reset__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f43_pc41
  .L_f43_pc36:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f43_pc41:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of next__SourceReader

    .globl at_eof__SourceReader
    .type  at_eof__SourceReader, @function
at_eof__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fill__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of at_eof__SourceReader

    .globl line_num__SourceReader
    .type  line_num__SourceReader, @function
line_num__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call lnum__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of line_num__SourceReader

    .globl line_buf_reset__SourceReader
    .type  line_buf_reset__SourceReader, @function
line_buf_reset__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call reset__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of line_buf_reset__SourceReader

    .globl line_buf__SourceReader__StringBuffer
    .type  line_buf__SourceReader__StringBuffer, @function
line_buf__SourceReader__StringBuffer:
    # prologue: frame_size=48, params=2, locals=7
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call length__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f47_pc8:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc23
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call char_at__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f47_pc8
  .L_f47_pc23:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fill__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc76
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_pos__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf_len__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f47_pc36:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc46
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc46
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc47
  .L_f47_pc46:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc47:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc76
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc60
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    j    .L_f47_pc75
  .L_f47_pc60:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f47_pc67
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    j    .L_f47_pc75
  .L_f47_pc67:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f47_pc75:
    j    .L_f47_pc36
  .L_f47_pc76:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of line_buf__SourceReader__StringBuffer

    .globl is_digit__u8
    .type  is_digit__u8, @function
is_digit__u8:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f48_pc10
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f48_pc10
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f48_pc11
  .L_f48_pc10:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f48_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_digit__u8

    .globl is_alpha__u8
    .type  is_alpha__u8, @function
is_alpha__u8:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f49_pc10
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f49_pc10
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f49_pc11
  .L_f49_pc10:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f49_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f49_pc26
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f49_pc22
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 90
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f49_pc22
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f49_pc23
  .L_f49_pc22:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f49_pc23:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f49_pc26
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f49_pc27
  .L_f49_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f49_pc27:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f49_pc34
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f49_pc34
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f49_pc35
  .L_f49_pc34:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f49_pc35:
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_alpha__u8

    .globl is_alnum__u8
    .type  is_alnum__u8, @function
is_alnum__u8:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_alpha__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f50_pc8
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_digit__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f50_pc8
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f50_pc9
  .L_f50_pc8:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f50_pc9:
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_alnum__u8

    .globl is_wspace__u8
    .type  is_wspace__u8, @function
is_wspace__u8:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc10
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc10
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f51_pc11
  .L_f51_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f51_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc18
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc18
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f51_pc19
  .L_f51_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f51_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc26
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f51_pc26
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f51_pc27
  .L_f51_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f51_pc27:
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_wspace__u8

    .globl tok_cmp__U8Array__i32__StringLiteral
    .type  tok_cmp__U8Array__i32__StringLiteral, @function
tok_cmp__U8Array__i32__StringLiteral:
    # prologue: frame_size=32, params=3, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f52_pc7
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f52_pc7:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f52_pc9:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f52_pc28
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f52_pc23
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f52_pc23:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f52_pc9
  .L_f52_pc28:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of tok_cmp__U8Array__i32__StringLiteral

    .globl emit_op__StringBuffer__i32
    .type  emit_op__StringBuffer__i32, @function
emit_op__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PLUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc9
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc9:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_MINUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc18
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc18:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc27
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc27:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_SLASH
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc36
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc36:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PERCENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc45
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc45:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_AMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc54
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc54:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc63
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc63:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_CARET
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc72
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 94
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc72:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc81
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc81:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc90
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc90:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_AMPAMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc99
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc99:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PIPEPIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc108
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc108:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BANG
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc117
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 33
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc117:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EQEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc126
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc126:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BANGEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc135
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc135:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc144
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 60
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc144:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc153
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc153:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_GT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc162
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 62
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc162:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_GTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f53_pc171
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f53_pc171:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_op__StringBuffer__i32

    .globl emit_type_kw__StringBuffer__i32
    .type  emit_type_kw__StringBuffer__i32, @function
emit_type_kw__StringBuffer__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc9
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc9:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc18
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc18:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc27
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc27:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc36
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj11
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc36:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc45
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc45:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc54
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc54:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BOOL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc63
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc63:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_VOID
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f54_pc72
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f54_pc72:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_type_kw__StringBuffer__i32

    .globl is_type_tok__i32
    .type  is_type_tok__i32, @function
is_type_tok__i32:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc10
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc10
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc11
  .L_f55_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc18
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc18
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc19
  .L_f55_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc26
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc26
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc27
  .L_f55_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc27:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc34
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc34
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc35
  .L_f55_pc34:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc35:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc42
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc42
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc43
  .L_f55_pc42:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc43:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc50
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BOOL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc50
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc51
  .L_f55_pc50:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc51:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc58
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_VOID
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc58
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc59
  .L_f55_pc58:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc59:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc66
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f55_pc66
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f55_pc67
  .L_f55_pc66:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f55_pc67:
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of is_type_tok__i32

    .globl classify_ident__U8Array__i32
    .type  classify_ident__U8Array__i32, @function
classify_ident__U8Array__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc39
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc11
    la   t1, TK_FN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc11:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj17
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc18
    la   t1, TK_AS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc18:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj18
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc25
    la   t1, TK_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc25:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc32
    la   t1, TK_U8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc32:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj11
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc39
    la   t1, TK_I8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc39:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc78
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc50
    la   t1, TK_VAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc50:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc57
    la   t1, TK_U16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc57:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc64
    la   t1, TK_U32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc64:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc71
    la   t1, TK_I16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc71:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc78
    la   t1, TK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc78:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc110
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj20
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc89
    la   t1, TK_ELSE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc89:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc96
    la   t1, TK_BOOL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc96:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc103
    la   t1, TK_VOID
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc103:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj21
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc110
    la   t1, TK_TRUE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc110:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc135
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj22
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc121
    la   t1, TK_WHILE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc121:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj23
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc128
    la   t1, TK_FALSE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc128:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj24
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc135
    la   t1, TK_BREAK
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc135:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc167
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc146
    la   t1, TK_RETURN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc146:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj26
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc153
    la   t1, TK_STRUCT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc153:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj27
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc160
    la   t1, TK_IMPORT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc160:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj28
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc167
    la   t1, TK_EXPORT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc167:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc178
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj29
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call tok_cmp__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f56_pc178
    la   t1, TK_CONTINUE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f56_pc178:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of classify_ident__U8Array__i32

    .globl skip_ws__SourceReader
    .type  skip_ws__SourceReader, @function
skip_ws__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
  .L_f57_pc0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f57_pc11
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_wspace__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f57_pc11
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f57_pc12
  .L_f57_pc11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f57_pc12:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f57_pc17
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f57_pc0
  .L_f57_pc17:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line_num__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_line
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of skip_ws__SourceReader

    .globl skip_line_comment__SourceReader
    .type  skip_line_comment__SourceReader, @function
skip_line_comment__SourceReader:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
  .L_f58_pc0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f58_pc12
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f58_pc12
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f58_pc13
  .L_f58_pc12:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f58_pc13:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f58_pc18
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f58_pc0
  .L_f58_pc18:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of skip_line_comment__SourceReader

    .globl lex_tok__SourceReader__U8Array
    .type  lex_tok__SourceReader__U8Array, @function
lex_tok__SourceReader__U8Array:
    # prologue: frame_size=64, params=2, locals=10
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
  .L_f59_pc2:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc76
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_ws__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc21
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc21
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc22
  .L_f59_pc21:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc22:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc73
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc38
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc38
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc39
  .L_f59_pc38:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc39:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc44
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line_comment__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f59_pc72
  .L_f59_pc44:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call line_num__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_line
    sw   t0, 0(t1)
    la   t1, g_line
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_line
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc61
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc61
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc62
  .L_f59_pc61:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc62:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SLASH_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    j    .L_f59_pc71
  .L_f59_pc69:
    la   t1, TK_SLASH
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
  .L_f59_pc71:
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc72:
    j    .L_f59_pc75
  .L_f59_pc73:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
  .L_f59_pc75:
    j    .L_f59_pc2
  .L_f59_pc76:
    la   t1, g_line
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_line
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc86
    la   t1, TK_EOF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc86:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_alpha__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc125
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f59_pc94:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc105
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_alnum__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc105
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc106
  .L_f59_pc105:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc106:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc118
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f59_pc94
  .L_f59_pc118:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call classify_ident__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc125:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_digit__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc203
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f59_pc130:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc141
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_digit__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc141
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc142
  .L_f59_pc141:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc142:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc154
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    j    .L_f59_pc130
  .L_f59_pc154:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc165
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_alpha__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc165
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc166
  .L_f59_pc165:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc166:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc196
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f59_pc169:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc180
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_alnum__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc180
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc181
  .L_f59_pc180:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc181:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc193
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_f59_pc169
  .L_f59_pc193:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
    j    .L_f59_pc198
  .L_f59_pc196:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
  .L_f59_pc198:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_ival
    sw   t0, 0(t1)
    la   t1, TK_INT_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc203:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc316
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f59_pc212:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc224
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc224
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc225
  .L_f59_pc224:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc225:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc303
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc240
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc240
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc241
  .L_f59_pc240:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc241:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc293
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc253
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc253:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc259
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc259:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc265
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc265:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc271
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc271:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc277
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc277:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc283
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f59_pc283:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_f59_pc302
  .L_f59_pc293:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f59_pc302:
    j    .L_f59_pc212
  .L_f59_pc303:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc311
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f59_pc311:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
    la   t1, TK_STR_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc316:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc451
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc337
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc337
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc338
  .L_f59_pc337:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc338:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc408
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc407
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc360
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc360:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc368
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc368:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc376
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc376:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc384
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc384:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc392
    li   t0, 39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc392:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc400
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f59_pc400:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc407
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_f59_pc407:
    j    .L_f59_pc417
  .L_f59_pc408:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc417
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_f59_pc417:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc429
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc429
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc430
  .L_f59_pc429:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc430:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc434
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f59_pc434:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    sw   t0, 0(t1)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_ival
    sw   t0, 0(t1)
    la   t1, TK_INT_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc451:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc481
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc470
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc470
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc471
  .L_f59_pc470:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc471:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc478
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_PLUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc478:
    la   t1, TK_PLUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc481:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc508
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc497
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc497
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc498
  .L_f59_pc497:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc498:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc505
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_PERCENT_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc505:
    la   t1, TK_PERCENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc508:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 94
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc515
    la   t1, TK_CARET
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc515:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc522
    la   t1, TK_LPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc522:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc529
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc529:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 123
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc536
    la   t1, TK_LBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc536:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 125
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc543
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc543:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc550
    la   t1, TK_COMMA
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc550:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc557
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc557:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc564
    la   t1, TK_COLON
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc564:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc591
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc580
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc580
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc581
  .L_f59_pc580:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc581:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc588
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_STAR_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc588:
    la   t1, TK_STAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc591:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc618
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc607
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc607
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc608
  .L_f59_pc607:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc608:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc615
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_AMPAMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc615:
    la   t1, TK_AMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc618:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc645
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc634
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc634
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc635
  .L_f59_pc634:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc635:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc642
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_PIPEPIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc642:
    la   t1, TK_PIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc645:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 33
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc672
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc661
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc661
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc662
  .L_f59_pc661:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc662:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc669
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_BANGEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc669:
    la   t1, TK_BANG
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc672:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc699
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc688
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc688
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc689
  .L_f59_pc688:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc689:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc696
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_EQEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc696:
    la   t1, TK_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc699:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 60
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc746
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc715
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc715
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc716
  .L_f59_pc715:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc716:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc723
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_LTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc723:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc735
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 60
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc735
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc736
  .L_f59_pc735:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc736:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc743
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_LSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc743:
    la   t1, TK_LT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc746:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 62
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc793
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc762
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc762
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc763
  .L_f59_pc762:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc763:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc770
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_GTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc770:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc782
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 62
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc782
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc783
  .L_f59_pc782:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc783:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc790
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_RSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc790:
    la   t1, TK_GT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc793:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc840
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc809
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 62
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc809
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc810
  .L_f59_pc809:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc810:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc817
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_ARROW
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc817:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call at_eof__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc829
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call peek__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc829
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f59_pc830
  .L_f59_pc829:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f59_pc830:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f59_pc837
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call next__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_MINUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc837:
    la   t1, TK_MINUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f59_pc840:
    la   t1, TK_EOF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of lex_tok__SourceReader__U8Array

    .globl print_error__StringLiteral
    .type  print_error__StringLiteral, @function
print_error__StringLiteral:
    # prologue: frame_size=16, params=1, locals=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call write__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of print_error__StringLiteral

    .globl expect_tok__i32__SourceReader__U8Array
    .type  expect_tok__i32__SourceReader__U8Array, @function
expect_tok__i32__SourceReader__U8Array:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f61_pc10
    la   t0, __tc_strobj30
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call print_error__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    li   a7, 93
    ecall
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f61_pc10:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of expect_tok__i32__SourceReader__U8Array

    .globl wrap_binop__U8Array__i32__i32__SourceReader__U8Array__StringBuffer
    .type  wrap_binop__U8Array__i32__i32__SourceReader__U8Array__StringBuffer, @function
wrap_binop__U8Array__i32__i32__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=6, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_op__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of wrap_binop__U8Array__i32__i32__SourceReader__U8Array__StringBuffer

    .globl pars_primary__SourceReader__U8Array__StringBuffer
    .type  pars_primary__SourceReader__U8Array__StringBuffer, @function
pars_primary__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=48, params=3, locals=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_INT_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc43
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc26
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f63_pc26:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc43:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STR_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc147
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj33
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f63_pc65:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc134
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc86
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc129
  .L_f63_pc86:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc99
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc129
  .L_f63_pc99:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc112
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc129
  .L_f63_pc112:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc125
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc129
  .L_f63_pc125:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f63_pc129:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f63_pc65
  .L_f63_pc134:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc147:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_TRUE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc176
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj21
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc176:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_FALSE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc205
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj23
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc205:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc224
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc224:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc350
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f63_pc237:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc253
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f63_pc237
  .L_f63_pc253:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc324
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc314
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f63_pc289:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc314
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_COMMA
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc311
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc313
  .L_f63_pc311:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f63_pc313:
    j    .L_f63_pc289
  .L_f63_pc314:
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f63_pc346
  .L_f63_pc324:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f63_pc346:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f63_pc350:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    li   a7, 93
    ecall
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_primary__SourceReader__U8Array__StringBuffer

    .globl pars_postfix__SourceReader__U8Array__StringBuffer
    .type  pars_postfix__SourceReader__U8Array__StringBuffer, @function
pars_postfix__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_primary__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f64_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_AS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f64_pc53
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_type__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f64_pc7
  .L_f64_pc53:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_postfix__SourceReader__U8Array__StringBuffer

    .globl pars_unary__SourceReader__U8Array__StringBuffer
    .type  pars_unary__SourceReader__U8Array__StringBuffer, @function
pars_unary__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BANG
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc38
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj36
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 33
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_unary__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f65_pc38:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_MINUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc76
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj36
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_unary__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f65_pc76:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_postfix__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_unary__SourceReader__U8Array__StringBuffer

    .globl pars_mul__SourceReader__U8Array__StringBuffer
    .type  pars_mul__SourceReader__U8Array__StringBuffer, @function
pars_mul__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=48, params=3, locals=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_unary__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f66_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f66_pc17
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_SLASH
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f66_pc17
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f66_pc18
  .L_f66_pc17:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f66_pc18:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f66_pc25
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PERCENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f66_pc25
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f66_pc26
  .L_f66_pc25:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f66_pc26:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f66_pc87
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_unary__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_op__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f66_pc7
  .L_f66_pc87:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_mul__SourceReader__U8Array__StringBuffer

    .globl pars_add__SourceReader__U8Array__StringBuffer
    .type  pars_add__SourceReader__U8Array__StringBuffer, @function
pars_add__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=48, params=3, locals=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_mul__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f67_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PLUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f67_pc17
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_MINUS
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f67_pc17
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f67_pc18
  .L_f67_pc17:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f67_pc18:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f67_pc79
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_mul__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_op__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f67_pc7
  .L_f67_pc79:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_add__SourceReader__U8Array__StringBuffer

    .globl pars_shift__SourceReader__U8Array__StringBuffer
    .type  pars_shift__SourceReader__U8Array__StringBuffer, @function
pars_shift__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=48, params=3, locals=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_add__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f68_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f68_pc17
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RSHIFT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f68_pc17
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc18
  .L_f68_pc17:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc18:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc79
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_add__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_op__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f68_pc7
  .L_f68_pc79:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_shift__SourceReader__U8Array__StringBuffer

    .globl pars_bitand__SourceReader__U8Array__StringBuffer
    .type  pars_bitand__SourceReader__U8Array__StringBuffer, @function
pars_bitand__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_shift__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_AMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_shift__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f69_pc7
  .L_f69_pc69:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_bitand__SourceReader__U8Array__StringBuffer

    .globl pars_bitxor__SourceReader__U8Array__StringBuffer
    .type  pars_bitxor__SourceReader__U8Array__StringBuffer, @function
pars_bitxor__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitand__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f70_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_CARET
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f70_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitand__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 94
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f70_pc7
  .L_f70_pc69:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_bitxor__SourceReader__U8Array__StringBuffer

    .globl pars_bitor__SourceReader__U8Array__StringBuffer
    .type  pars_bitor__SourceReader__U8Array__StringBuffer, @function
pars_bitor__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitxor__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f71_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f71_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitxor__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f71_pc7
  .L_f71_pc69:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_bitor__SourceReader__U8Array__StringBuffer

    .globl pars_compare__SourceReader__U8Array__StringBuffer
    .type  pars_compare__SourceReader__U8Array__StringBuffer, @function
pars_compare__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitor__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EQEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc19
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BANGEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc19
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f72_pc20
  .L_f72_pc19:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f72_pc20:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc27
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc27
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f72_pc28
  .L_f72_pc27:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f72_pc28:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc35
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc35
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f72_pc36
  .L_f72_pc35:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f72_pc36:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc43
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_GT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc43
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f72_pc44
  .L_f72_pc43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f72_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc51
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_GTEQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f72_pc51
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f72_pc52
  .L_f72_pc51:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f72_pc52:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f72_pc107
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_bitor__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_op__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f72_pc107:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_compare__SourceReader__U8Array__StringBuffer

    .globl pars_logic_and__SourceReader__U8Array__StringBuffer
    .type  pars_logic_and__SourceReader__U8Array__StringBuffer, @function
pars_logic_and__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_compare__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f73_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_AMPAMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f73_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_compare__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f73_pc7
  .L_f73_pc69:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_logic_and__SourceReader__U8Array__StringBuffer

    .globl pars_expr__SourceReader__U8Array__StringBuffer
    .type  pars_expr__SourceReader__U8Array__StringBuffer, @function
pars_expr__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_logic_and__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f74_pc7:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PIPEPIPE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f74_pc69
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_logic_and__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f74_pc7
  .L_f74_pc69:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call append__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_expr__SourceReader__U8Array__StringBuffer

    .globl pars_type__SourceReader__U8Array__StringBuffer__i32
    .type  pars_type__SourceReader__U8Array__StringBuffer__i32, @function
pars_type__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_type_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f75_pc21
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f75_pc21
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f75_pc22
  .L_f75_pc21:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f75_pc22:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f75_pc32
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_type_kw__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f75_pc46
  .L_f75_pc32:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f75_pc46
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f75_pc46:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_type__SourceReader__U8Array__StringBuffer__i32

    .globl pars_var_decl__SourceReader__U8Array__StringBuffer__i32
    .type  pars_var_decl__SourceReader__U8Array__StringBuffer__i32, @function
pars_var_decl__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=48, params=4, locals=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    la   t1, TK_VAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f76_pc14:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f76_pc30
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_f76_pc14
  .L_f76_pc30:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_COLON
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_type__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f76_pc102
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f76_pc102:
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_var_decl__SourceReader__U8Array__StringBuffer__i32

    .globl pars_break_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_break_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_break_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_BREAK
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj24
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_break_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_continue_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_continue_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_continue_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_CONTINUE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj29
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_continue_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_return_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_return_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_return_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_RETURN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f79_pc32
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f79_pc32:
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_return_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_if_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_if_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_if_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj18
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_block__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_ELSE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f80_pc85
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f80_pc77
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_if_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f80_pc85
  .L_f80_pc77:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_block__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f80_pc85:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_if_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_while_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_while_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_while_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_WHILE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj22
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_block__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_while_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_ident_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_ident_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_ident_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=48, params=4, locals=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f82_pc9:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc25
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_f82_pc9
  .L_f82_pc25:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc89
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f82_pc357
  .L_f82_pc89:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PLUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc99
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_MINUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc99
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f82_pc100
  .L_f82_pc99:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f82_pc100:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc107
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STAR_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc107
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f82_pc108
  .L_f82_pc107:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f82_pc108:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc115
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_SLASH_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc115
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f82_pc116
  .L_f82_pc115:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f82_pc116:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc123
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PERCENT_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f82_pc123
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f82_pc124
  .L_f82_pc123:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f82_pc124:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc268
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PLUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc179
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc179:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_MINUS_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc187
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc187:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STAR_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc195
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc195:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_SLASH_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc203
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc203:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_PERCENT_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc211
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc211:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f82_pc357
  .L_f82_pc268:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_LPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc354
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc331
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
  .L_f82_pc300:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc331
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_expr__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_COMMA
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f82_pc328
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f82_pc330
  .L_f82_pc328:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
  .L_f82_pc330:
    j    .L_f82_pc300
  .L_f82_pc331:
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f82_pc357
  .L_f82_pc354:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    li   a7, 93
    ecall
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f82_pc357:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_ident_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl emit_comment_sb__StringBuffer__StringBuffer
    .type  emit_comment_sb__StringBuffer__StringBuffer, @function
emit_comment_sb__StringBuffer__StringBuffer:
    # prologue: frame_size=48, params=2, locals=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call length__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f83_pc7:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc17
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc17
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f83_pc18
  .L_f83_pc17:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f83_pc18:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc43
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call char_at__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc33
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc33
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f83_pc34
  .L_f83_pc33:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f83_pc34:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc38
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f83_pc42
  .L_f83_pc38:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f83_pc42:
    j    .L_f83_pc7
  .L_f83_pc43:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc48
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f83_pc48:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f83_pc66:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc109
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call char_at__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc87
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f83_pc104
  .L_f83_pc87:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f83_pc100
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f83_pc104
  .L_f83_pc100:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f83_pc104:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_f83_pc66
  .L_f83_pc109:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_comment_sb__StringBuffer__StringBuffer

    .globl emit_comment_src__StringBuffer__SourceReader
    .type  emit_comment_src__StringBuffer__SourceReader, @function
emit_comment_src__StringBuffer__SourceReader:
    # prologue: frame_size=32, params=2, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    la   t1, g_tok_line
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_last_comment_line
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f84_pc5
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f84_pc5:
    la   t1, g_tok_line
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_last_comment_line
    sw   t0, 0(t1)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call line_buf__SourceReader__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_comment_sb__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_comment_src__StringBuffer__SourceReader

    .globl pars_stmt__SourceReader__U8Array__StringBuffer__i32
    .type  pars_stmt__SourceReader__U8Array__StringBuffer__i32, @function
pars_stmt__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_VAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc11
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_var_decl__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc11:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc22
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_if_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc22:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_WHILE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc33
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_while_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc33:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RETURN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc44
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_return_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc44:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BREAK
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc55
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_break_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc55:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_CONTINUE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc66
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_continue_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc66:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f85_pc77
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_ident_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f85_pc77:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    li   a7, 93
    ecall
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_stmt__SourceReader__U8Array__StringBuffer__i32

    .globl pars_block__SourceReader__U8Array__StringBuffer__i32
    .type  pars_block__SourceReader__U8Array__StringBuffer__i32, @function
pars_block__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_LBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f86_pc13:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f86_pc23
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EOF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f86_pc23
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f86_pc24
  .L_f86_pc23:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f86_pc24:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f86_pc58
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_comment_src__StringBuffer__SourceReader
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_stmt__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f86_pc13
  .L_f86_pc58:
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_block__SourceReader__U8Array__StringBuffer__i32

    .globl pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32
    .type  pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32, @function
pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32:
    # prologue: frame_size=64, params=5, locals=7
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    la   t1, TK_FN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f87_pc14:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc30
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    j    .L_f87_pc14
  .L_f87_pc30:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_LPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc60
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj28
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f87_pc60:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc211
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
  .L_f87_pc97:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc211
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f87_pc110:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc126
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    j    .L_f87_pc110
  .L_f87_pc126:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_COLON
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_type__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_COMMA
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc208
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f87_pc210
  .L_f87_pc208:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
  .L_f87_pc210:
    j    .L_f87_pc97
  .L_f87_pc211:
    la   t1, TK_RPAREN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_ARROW
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f87_pc275
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_type__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f87_pc295
  .L_f87_pc275:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f87_pc295:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_block__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32

    .globl buf_set_str__U8Array__i32__StringLiteral
    .type  buf_set_str__U8Array__i32__StringLiteral, @function
buf_set_str__U8Array__i32__StringLiteral:
    # prologue: frame_size=32, params=3, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f88_pc5:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f88_pc23
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_f88_pc5
  .L_f88_pc23:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of buf_set_str__U8Array__i32__StringLiteral

    .globl type_tok_name__U8Array__U8Array__i32
    .type  type_tok_name__U8Array__U8Array__i32, @function
type_tok_name__U8Array__U8Array__i32:
    # prologue: frame_size=32, params=3, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc11
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc11:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I8
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc20
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj11
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc20:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc29
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc29:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_U32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc38
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc38:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I16
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc47
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc47:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc56
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc56:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_BOOL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc65
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc65:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_VOID
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc74
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call buf_set_str__U8Array__i32__StringLiteral
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc74:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc100
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f89_pc80:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f89_pc98
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    j    .L_f89_pc80
  .L_f89_pc98:
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f89_pc100:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of type_tok_name__U8Array__U8Array__i32

    .globl emit_param__StringBuffer__i32__StringLiteral__U8Array__i32__i32
    .type  emit_param__StringBuffer__i32__StringLiteral__U8Array__i32__i32, @function
emit_param__StringBuffer__i32__StringLiteral__U8Array__i32__i32:
    # prologue: frame_size=32, params=6, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_param__StringBuffer__i32__StringLiteral__U8Array__i32__i32

    .globl emit_type__StringBuffer__U8Array__i32__i32
    .type  emit_type__StringBuffer__U8Array__i32__i32, @function
emit_type__StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_type__StringBuffer__U8Array__i32__i32

    .globl emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral
    .type  emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral, @function
emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral

    .globl emit_cast_var_tbuf__StringBuffer__i32__StringLiteral__U8Array__i32__i32
    .type  emit_cast_var_tbuf__StringBuffer__i32__StringLiteral__U8Array__i32__i32, @function
emit_cast_var_tbuf__StringBuffer__i32__StringLiteral__U8Array__i32__i32:
    # prologue: frame_size=32, params=6, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_cast_var_tbuf__StringBuffer__i32__StringLiteral__U8Array__i32__i32

    .globl emit_comment_line__StringBuffer__i32__StringBuffer
    .type  emit_comment_line__StringBuffer__i32__StringBuffer, @function
emit_comment_line__StringBuffer__i32__StringBuffer:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_comment_sb__StringBuffer__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_comment_line__StringBuffer__i32__StringBuffer

    .globl fi_name_off__I32Array__i32
    .type  fi_name_off__I32Array__i32, @function
fi_name_off__I32Array__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fi_name_off__I32Array__i32

    .globl fi_name_len__I32Array__i32
    .type  fi_name_len__I32Array__i32, @function
fi_name_len__I32Array__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fi_name_len__I32Array__i32

    .globl fi_type_off__I32Array__i32
    .type  fi_type_off__I32Array__i32, @function
fi_type_off__I32Array__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fi_type_off__I32Array__i32

    .globl fi_type_len__I32Array__i32
    .type  fi_type_len__I32Array__i32, @function
fi_type_len__I32Array__i32:
    # prologue: frame_size=16, params=2, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fi_type_len__I32Array__i32

    .globl fi_set__I32Array__i32__i32__i32__i32__i32
    .type  fi_set__I32Array__i32__i32__i32__i32__i32, @function
fi_set__I32Array__i32__i32__i32__i32__i32:
    # prologue: frame_size=32, params=6, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of fi_set__I32Array__i32__i32__i32__i32__i32

    .globl emit_struct_ctor__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    .type  emit_struct_ctor__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32, @function
emit_struct_ctor__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32:
    # prologue: frame_size=64, params=9, locals=2
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    lw   t0, 0(s0)
    sw   t0, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f100_pc46:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f100_pc119
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_off__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_len__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_type__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    j    .L_f100_pc46
  .L_f100_pc119:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_f100_pc364:
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f100_pc576
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    j    .L_f100_pc364
  .L_f100_pc576:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_struct_ctor__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32

    .globl emit_struct_getter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    .type  emit_struct_getter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32, @function
emit_struct_getter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32:
    # prologue: frame_size=64, params=9, locals=4
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    lw   t0, 0(s0)
    sw   t0, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_name_off__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_name_len__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_off__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_len__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj50
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_struct_getter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32

    .globl emit_struct_setter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    .type  emit_struct_setter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32, @function
emit_struct_setter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32:
    # prologue: frame_size=64, params=9, locals=4
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    lw   t0, 0(s0)
    sw   t0, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_name_off__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_name_len__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_off__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fi_type_len__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj51
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_int__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj51
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_cast_var__StringBuffer__i32__StringLiteral__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of emit_struct_setter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32

    .globl pars_struct_decl__SourceReader__U8Array__StringBuffer__i32
    .type  pars_struct_decl__SourceReader__U8Array__StringBuffer__i32, @function
pars_struct_decl__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=96, params=4, locals=17
    addi sp, sp, -96
    sw   ra, 92(sp)
    sw   s0, 88(sp)
    addi s0, sp, 96
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    sw   zero, -64(s0)
    sw   zero, -68(s0)
    sw   zero, -72(s0)
    sw   zero, -76(s0)
    sw   zero, -80(s0)
    sw   zero, -84(s0)
    sw   zero, -88(s0)
    sw   zero, -92(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call line_buf__SourceReader__StringBuffer
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_STRUCT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f103_pc18:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc34
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    j    .L_f103_pc18
  .L_f103_pc34:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_LBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj26
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
  .L_f103_pc79:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc89
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EOF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc89
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f103_pc90
  .L_f103_pc89:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f103_pc90:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc256
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc103
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_COMMA
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc103
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f103_pc103:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc112
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    sw   t0, 0(t1)
    j    .L_f103_pc255
  .L_f103_pc112:
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
  .L_f103_pc121:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc137
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    j    .L_f103_pc121
  .L_f103_pc137:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
  .L_f103_pc139:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc157
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    j    .L_f103_pc139
  .L_f103_pc157:
    la   t1, TK_IDENT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, TK_COLON
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call type_tok_name__U8Array__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 20(sp)
    lw   a1, 16(sp)
    lw   a2, 12(sp)
    lw   a3, 8(sp)
    lw   a4, 4(sp)
    lw   a5, 0(sp)
    call fi_set__I32Array__i32__i32__i32__i32__i32
    addi sp, sp, 24
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_type__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f103_pc255:
    j    .L_f103_pc79
  .L_f103_pc256:
    la   t1, TK_RBRACE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -4
    lw   t0, 4(sp)
    sw   t0, 0(sp)
    lw   a0, 36(sp)
    lw   a1, 32(sp)
    lw   a2, 28(sp)
    lw   a3, 24(sp)
    lw   a4, 20(sp)
    lw   a5, 16(sp)
    lw   a6, 12(sp)
    lw   a7, 8(sp)
    call emit_struct_ctor__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    addi sp, sp, 40
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
  .L_f103_pc290:
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc314
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -4
    lw   t0, 4(sp)
    sw   t0, 0(sp)
    lw   a0, 36(sp)
    lw   a1, 32(sp)
    lw   a2, 28(sp)
    lw   a3, 24(sp)
    lw   a4, 20(sp)
    lw   a5, 16(sp)
    lw   a6, 12(sp)
    lw   a7, 8(sp)
    call emit_struct_getter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    addi sp, sp, 40
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
    j    .L_f103_pc290
  .L_f103_pc314:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -92(s0)
  .L_f103_pc316:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f103_pc340
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -4
    lw   t0, 4(sp)
    sw   t0, 0(sp)
    lw   a0, 36(sp)
    lw   a1, 32(sp)
    lw   a2, 28(sp)
    lw   a3, 24(sp)
    lw   a4, 20(sp)
    lw   a5, 16(sp)
    lw   a6, 12(sp)
    lw   a7, 8(sp)
    call emit_struct_setter__StringBuffer__i32__StringBuffer__U8Array__i32__U8Array__U8Array__I32Array__i32
    addi sp, sp, 40
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -92(s0)
    j    .L_f103_pc316
  .L_f103_pc340:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call emit_comment_line__StringBuffer__i32__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj53
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj43
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj42
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj53
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj47
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_struct_decl__SourceReader__U8Array__StringBuffer__i32

    .globl pars_import__SourceReader__U8Array__StringBuffer__i32
    .type  pars_import__SourceReader__U8Array__StringBuffer__i32, @function
pars_import__SourceReader__U8Array__StringBuffer__i32:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    la   t1, TK_IMPORT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj27
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STR_LIT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f104_pc31
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_tok_slen
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call emit_n__StringBuffer__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f104_pc31:
    la   t1, TK_SEMI
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call expect_tok__i32__SourceReader__U8Array
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_import__SourceReader__U8Array__StringBuffer__i32

    .globl pars_program__SourceReader__U8Array__StringBuffer
    .type  pars_program__SourceReader__U8Array__StringBuffer, @function
pars_program__SourceReader__U8Array__StringBuffer:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __tc_strobj54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f105_pc8:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_IMPORT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc27
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_import__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f105_pc8
  .L_f105_pc27:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EOF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc93
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_indent__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_EXPORT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc55
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f105_pc92
  .L_f105_pc55:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_FN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc67
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call pars_fn_decl__SourceReader__U8Array__StringBuffer__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f105_pc92
  .L_f105_pc67:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_STRUCT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc78
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_struct_decl__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f105_pc92
  .L_f105_pc78:
    la   t1, g_tok
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TK_VAR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f105_pc89
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pars_var_decl__SourceReader__U8Array__StringBuffer__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f105_pc92
  .L_f105_pc89:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    li   a7, 93
    ecall
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f105_pc92:
    j    .L_f105_pc27
  .L_f105_pc93:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of pars_program__SourceReader__U8Array__StringBuffer

    .globl main
    .type  main, @function
main:
    # prologue: frame_size=32, params=0, locals=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   zero, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call SourceReader_new__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -12(s0)
    li   t0, 4092
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call StringBuffer_new__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_line
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call lex_tok__SourceReader__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call pars_program__SourceReader__U8Array__StringBuffer
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call write__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call close__SourceReader
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of main

