    .data
    .globl OP_PUSH_INT
OP_PUSH_INT:
    .word 1
    .globl OP_PUSH_STR
OP_PUSH_STR:
    .word 2
    .globl OP_LOAD
OP_LOAD:
    .word 3
    .globl OP_STORE
OP_STORE:
    .word 4
    .globl OP_CALL
OP_CALL:
    .word 5
    .globl OP_RETURN
OP_RETURN:
    .word 6
    .globl OP_RETURN_VOID
OP_RETURN_VOID:
    .word 7
    .globl OP_POP
OP_POP:
    .word 8
    .globl OP_ADD
OP_ADD:
    .word 9
    .globl OP_SUB
OP_SUB:
    .word 10
    .globl OP_MUL
OP_MUL:
    .word 11
    .globl OP_DIV
OP_DIV:
    .word 12
    .globl OP_MOD
OP_MOD:
    .word 13
    .globl OP_AND
OP_AND:
    .word 14
    .globl OP_OR
OP_OR:
    .word 15
    .globl OP_XOR
OP_XOR:
    .word 16
    .globl OP_SHL
OP_SHL:
    .word 17
    .globl OP_SHR
OP_SHR:
    .word 18
    .globl OP_EQ
OP_EQ:
    .word 19
    .globl OP_NE
OP_NE:
    .word 20
    .globl OP_LT
OP_LT:
    .word 21
    .globl OP_LE
OP_LE:
    .word 22
    .globl OP_GT
OP_GT:
    .word 23
    .globl OP_GE
OP_GE:
    .word 24
    .globl OP_NEG
OP_NEG:
    .word 25
    .globl OP_LNOT
OP_LNOT:
    .word 26
    .globl OP_CAST
OP_CAST:
    .word 27
    .globl OP_JUMP
OP_JUMP:
    .word 28
    .globl OP_JUMP_IF
OP_JUMP_IF:
    .word 29
    .globl OP_JUMP_IFNOT
OP_JUMP_IFNOT:
    .word 30
    .globl g_in_pos
g_in_pos:
    .word 0
    .globl g_in_len
g_in_len:
    .word 0
    .globl g_stab_pos
g_stab_pos:
    .word 0
    .globl g_nfuncs
g_nfuncs:
    .word 0
    .globl g_nparams
g_nparams:
    .word 0
    .globl g_nlocals
g_nlocals:
    .word 0
    .globl g_ninstrs
g_ninstrs:
    .word 0
    .globl g_nglobals
g_nglobals:
    .word 0
    .globl g_nstrings
g_nstrings:
    .word 0
    .globl g_ob_pos
g_ob_pos:
    .word 0

    .text

    .globl ob_flush
    .type  ob_flush, @function
ob_flush:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    la   t1, g_ob_pos
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
    beqz t0, .L_f0_pc12
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_ob_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_sys_write
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_ob_pos
    sw   t0, 0(t1)
  .L_f0_pc12:
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
    # end of ob_flush

    .globl ob_char
    .type  ob_char, @function
ob_char:
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
    la   t1, g_ob_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_ob_pos
    lw   t0, 0(t1)
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
    la   t1, g_ob_pos
    sw   t0, 0(t1)
    la   t1, g_ob_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8192
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
    beqz t0, .L_f1_pc17
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ob_flush
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f1_pc17:
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
    # end of ob_char

    .globl ob_n
    .type  ob_n, @function
ob_n:
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
  .L_f2_pc2:
    lw   t0, -28(s0)
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
    beqz t0, .L_f2_pc20
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    j    .L_f2_pc2
  .L_f2_pc20:
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
    # end of ob_n

    .globl ob_int
    .type  ob_int, @function
ob_int:
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
    lw   t0, -12(s0)
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
    beqz t0, .L_f3_pc9
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f3_pc9:
    lw   t0, -12(s0)
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
    beqz t0, .L_f3_pc21
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
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
    sw   t0, -12(s0)
  .L_f3_pc21:
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_U8Array
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f3_pc28:
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
    beqz t0, .L_f3_pc52
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
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
    addi sp, sp, 12
    call __tc_set
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
    j    .L_f3_pc28
  .L_f3_pc52:
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
  .L_f3_pc56:
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
    beqz t0, .L_f3_pc72
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    j    .L_f3_pc56
  .L_f3_pc72:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_delete
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
    # end of ob_int

    .globl e4
    .type  e4, @function
e4:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e4

    .globl ecomma
    .type  ecomma, @function
ecomma:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of ecomma

    .globl eNspnl
    .type  eNspnl, @function
eNspnl:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eNspnl

    .globl eNs0nl
    .type  eNs0nl, @function
eNs0nl:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eNs0nl

    .globl eNt0nl
    .type  eNt0nl, @function
eNt0nl:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eNt0nl

    .globl eregsp
    .type  eregsp, @function
eregsp:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eregsp

    .globl eregs0
    .type  eregs0, @function
eregs0:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eregs0

    .globl eregt0
    .type  eregt0, @function
eregt0:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eregt0

    .globl eregt1
    .type  eregt1, @function
eregt1:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eregt1

    .globl eregra
    .type  eregra, @function
eregra:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of eregra

    .globl e_addi
    .type  e_addi, @function
e_addi:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e_addi

    .globl e_sw
    .type  e_sw, @function
e_sw:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 119
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e_sw

    .globl e_lw
    .type  e_lw, @function
e_lw:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 119
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e_lw

    .globl e_li
    .type  e_li, @function
e_li:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e_li

    .globl e_la
    .type  e_la, @function
e_la:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of e_la

    .globl asm_push_t0
    .type  asm_push_t0, @function
asm_push_t0:
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
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
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
    # end of asm_push_t0

    .globl asm_pop_t0
    .type  asm_pop_t0, @function
asm_pop_t0:
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
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_pop_t0

    .globl asm_pop_t1_t0
    .type  asm_pop_t1_t0, @function
asm_pop_t1_t0:
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
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_pop_t1_t0

    .globl asm_epilogue
    .type  asm_epilogue, @function
asm_epilogue:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 118
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregra
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNt0nl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregs0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNt0nl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_epilogue

    .globl asm_pc_label
    .type  asm_pc_label, @function
asm_pc_label:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 76
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_pc_label

    .globl e_pcref
    .type  e_pcref, @function
e_pcref:
    # prologue: frame_size=32, params=3, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 76
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
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
    # end of e_pcref

    .globl asm_jump
    .type  asm_jump, @function
asm_jump:
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
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 106
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    addi sp, sp, 12
    call e_pcref
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_jump

    .globl asm_branch
    .type  asm_branch, @function
asm_branch:
    # prologue: frame_size=32, params=4, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
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
    beqz t0, .L_f26_pc28
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f26_pc48
  .L_f26_pc28:
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 113
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f26_pc48:
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call e_pcref
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_branch

    .globl asm_call_fn
    .type  asm_call_fn, @function
asm_call_fn:
    # prologue: frame_size=32, params=5, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f27_pc47
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f27_pc47:
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
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_call_fn

    .globl asm_seqz_t0
    .type  asm_seqz_t0, @function
asm_seqz_t0:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 113
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_seqz_t0

    .globl asm_snez_t0
    .type  asm_snez_t0, @function
asm_snez_t0:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_snez_t0

    .globl asm_xori_t0_1
    .type  asm_xori_t0_1, @function
asm_xori_t0_1:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 120
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_xori_t0_1

    .globl asm_sub_t0_t0_t1
    .type  asm_sub_t0_t0_t1, @function
asm_sub_t0_t0_t1:
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
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of asm_sub_t0_t0_t1

    .globl asm_slt
    .type  asm_slt, @function
asm_slt:
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
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
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
    beqz t0, .L_f32_pc46
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f32_pc61
  .L_f32_pc46:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f32_pc61:
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
    # end of asm_slt

    .globl stab_eq
    .type  stab_eq, @function
stab_eq:
    # prologue: frame_size=32, params=5, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    beqz t0, .L_f33_pc6
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
  .L_f33_pc6:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f33_pc8:
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
    beqz t0, .L_f33_pc33
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    beqz t0, .L_f33_pc28
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
  .L_f33_pc28:
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
    j    .L_f33_pc8
  .L_f33_pc33:
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
    # end of stab_eq

    .globl in_cur
    .type  in_cur, @function
in_cur:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    beqz t0, .L_f34_pc6
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
  .L_f34_pc6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of in_cur

    .globl is_ws
    .type  is_ws, @function
is_ws:
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
    bnez t0, .L_f35_pc10
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
    bnez t0, .L_f35_pc10
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f35_pc11
  .L_f35_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f35_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f35_pc18
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
    bnez t0, .L_f35_pc18
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f35_pc19
  .L_f35_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f35_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f35_pc26
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
    bnez t0, .L_f35_pc26
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f35_pc27
  .L_f35_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f35_pc27:
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
    # end of is_ws

    .globl skip_spaces
    .type  skip_spaces, @function
skip_spaces:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
  .L_f36_pc0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f36_pc20
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    bnez t0, .L_f36_pc16
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    bnez t0, .L_f36_pc16
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f36_pc17
  .L_f36_pc16:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f36_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f36_pc20
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f36_pc21
  .L_f36_pc20:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f36_pc21:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f36_pc27
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_f36_pc0
  .L_f36_pc27:
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
    # end of skip_spaces

    .globl skip_line
    .type  skip_line, @function
skip_line:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
  .L_f37_pc0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f37_pc11
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
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
    beqz t0, .L_f37_pc11
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f37_pc12
  .L_f37_pc11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f37_pc12:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f37_pc18
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_f37_pc0
  .L_f37_pc18:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f37_pc26
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_f37_pc26:
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
    # end of skip_line

    .globl next_tok
    .type  next_tok, @function
next_tok:
    # prologue: frame_size=32, params=2, locals=1
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_spaces
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
  .L_f38_pc5:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f38_pc16
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call is_ws
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f38_pc16
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f38_pc17
  .L_f38_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f38_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f38_pc34
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_f38_pc5
  .L_f38_pc34:
    lw   t0, -20(s0)
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
    # end of next_tok

    .globl tok_len
    .type  tok_len, @function
tok_len:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    la   t1, g_stab_pos
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
    # end of tok_len

    .globl discard_tok
    .type  discard_tok, @function
discard_tok:
    # prologue: frame_size=16, params=1, locals=0
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
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
    # end of discard_tok

    .globl int_from_stab
    .type  int_from_stab, @function
int_from_stab:
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
    lw   t0, -20(s0)
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
    beqz t0, .L_f41_pc17
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    beqz t0, .L_f41_pc17
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f41_pc18
  .L_f41_pc17:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f41_pc18:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc23
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f41_pc23:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f41_pc25:
    lw   t0, -28(s0)
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
    beqz t0, .L_f41_pc62
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -36(s0)
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
    beqz t0, .L_f41_pc46
    lw   t0, -36(s0)
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
    beqz t0, .L_f41_pc46
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f41_pc47
  .L_f41_pc46:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f41_pc47:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc57
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
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
  .L_f41_pc57:
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
    j    .L_f41_pc25
  .L_f41_pc62:
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
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f41_pc70
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
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
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f41_pc70:
    lw   t0, -32(s0)
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
    # end of int_from_stab

    .globl read_strlit
    .type  read_strlit, @function
read_strlit:
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f42_pc13
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    beqz t0, .L_f42_pc13
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc14
  .L_f42_pc13:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc14:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc19
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_f42_pc19:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f42_pc21:
    lw   t0, -24(s0)
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
    beqz t0, .L_f42_pc31
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f42_pc31
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc32
  .L_f42_pc31:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc32:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc247
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
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
    beqz t0, .L_f42_pc50
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f42_pc50:
    lw   t0, -32(s0)
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
    beqz t0, .L_f42_pc60
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
    beqz t0, .L_f42_pc60
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc61
  .L_f42_pc60:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc61:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc232
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -36(s0)
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
    beqz t0, .L_f42_pc77
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f42_pc77:
    lw   t0, -36(s0)
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
    beqz t0, .L_f42_pc83
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f42_pc83:
    lw   t0, -36(s0)
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
    beqz t0, .L_f42_pc89
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f42_pc89:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 120
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
    beqz t0, .L_f42_pc220
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -44(s0)
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
    beqz t0, .L_f42_pc121
    lw   t0, -44(s0)
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
    beqz t0, .L_f42_pc121
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc122
  .L_f42_pc121:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc122:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc128
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_f42_pc128:
    lw   t0, -44(s0)
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
    beqz t0, .L_f42_pc138
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
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
    beqz t0, .L_f42_pc138
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc139
  .L_f42_pc138:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc139:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc145
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 55
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
    sw   t0, -52(s0)
  .L_f42_pc145:
    lw   t0, -44(s0)
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
    beqz t0, .L_f42_pc155
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
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
    beqz t0, .L_f42_pc155
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc156
  .L_f42_pc155:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc156:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc162
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 87
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
    sw   t0, -52(s0)
  .L_f42_pc162:
    lw   t0, -48(s0)
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
    beqz t0, .L_f42_pc172
    lw   t0, -48(s0)
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
    beqz t0, .L_f42_pc172
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc173
  .L_f42_pc172:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc173:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc179
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f42_pc179:
    lw   t0, -48(s0)
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
    beqz t0, .L_f42_pc189
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
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
    beqz t0, .L_f42_pc189
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc190
  .L_f42_pc189:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc190:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc196
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 55
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
    sw   t0, -56(s0)
  .L_f42_pc196:
    lw   t0, -48(s0)
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
    beqz t0, .L_f42_pc206
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
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
    beqz t0, .L_f42_pc206
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f42_pc207
  .L_f42_pc206:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f42_pc207:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f42_pc213
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 87
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
    sw   t0, -56(s0)
  .L_f42_pc213:
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f42_pc220:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f42_pc232:
    lw   t0, -32(s0)
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
    beqz t0, .L_f42_pc246
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
  .L_f42_pc246:
    j    .L_f42_pc21
  .L_f42_pc247:
    lw   t0, -20(s0)
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
    # end of read_strlit

    .globl classify_op
    .type  classify_op, @function
classify_op:
    # prologue: frame_size=48, params=3, locals=6
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
    sw   zero, -44(s0)
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
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 0
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
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc19
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f43_pc19:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    beqz t0, .L_f43_pc30
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f43_pc30:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    beqz t0, .L_f43_pc41
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f43_pc41:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
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
    beqz t0, .L_f43_pc52
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f43_pc52:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
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
    beqz t0, .L_f43_pc63
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f43_pc63:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc165
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc77
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc77
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc78
  .L_f43_pc77:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc78:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc81
    la   t1, OP_OR
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
  .L_f43_pc81:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc91
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 113
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
    beqz t0, .L_f43_pc91
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc92
  .L_f43_pc91:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc92:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc95
    la   t1, OP_EQ
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
  .L_f43_pc95:
    lw   t0, -24(s0)
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
    beqz t0, .L_f43_pc105
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc105
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc106
  .L_f43_pc105:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc106:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc109
    la   t1, OP_NE
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
  .L_f43_pc109:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc119
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc119
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc120
  .L_f43_pc119:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc120:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc123
    la   t1, OP_LT
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
  .L_f43_pc123:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc133
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc133
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc134
  .L_f43_pc133:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc134:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc137
    la   t1, OP_LE
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
  .L_f43_pc137:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f43_pc147
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc147
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc148
  .L_f43_pc147:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc148:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc151
    la   t1, OP_GT
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
  .L_f43_pc151:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f43_pc161
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc161
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc162
  .L_f43_pc161:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc162:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc165
    la   t1, OP_GE
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
  .L_f43_pc165:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc411
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f43_pc179
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc179
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc180
  .L_f43_pc179:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc180:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc187
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc187
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc188
  .L_f43_pc187:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc188:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc191
    la   t1, OP_ADD
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
  .L_f43_pc191:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc201
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f43_pc201
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc202
  .L_f43_pc201:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc202:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc209
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    beqz t0, .L_f43_pc209
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc210
  .L_f43_pc209:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc210:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc213
    la   t1, OP_SUB
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
  .L_f43_pc213:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    beqz t0, .L_f43_pc223
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f43_pc223
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc224
  .L_f43_pc223:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc224:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc231
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc231
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc232
  .L_f43_pc231:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc232:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc235
    la   t1, OP_MUL
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
  .L_f43_pc235:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc245
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f43_pc245
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc246
  .L_f43_pc245:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc246:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc253
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 118
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
    beqz t0, .L_f43_pc253
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc254
  .L_f43_pc253:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc254:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc257
    la   t1, OP_DIV
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
  .L_f43_pc257:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    beqz t0, .L_f43_pc267
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc267
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc268
  .L_f43_pc267:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc268:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc275
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc275
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc276
  .L_f43_pc275:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc276:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc279
    la   t1, OP_MOD
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
  .L_f43_pc279:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f43_pc289
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc289
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc290
  .L_f43_pc289:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc290:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc297
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc297
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc298
  .L_f43_pc297:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc298:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc301
    la   t1, OP_AND
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
  .L_f43_pc301:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 120
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
    beqz t0, .L_f43_pc311
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc311
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc312
  .L_f43_pc311:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc312:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc319
    lw   t0, -32(s0)
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
    beqz t0, .L_f43_pc319
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc320
  .L_f43_pc319:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc320:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc323
    la   t1, OP_XOR
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
  .L_f43_pc323:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc333
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 104
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
    beqz t0, .L_f43_pc333
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc334
  .L_f43_pc333:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc334:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc341
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc341
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc342
  .L_f43_pc341:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc342:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc345
    la   t1, OP_SHL
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
  .L_f43_pc345:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc355
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 104
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
    beqz t0, .L_f43_pc355
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc356
  .L_f43_pc355:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc356:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc363
    lw   t0, -32(s0)
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
    beqz t0, .L_f43_pc363
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc364
  .L_f43_pc363:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc364:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc367
    la   t1, OP_SHR
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
  .L_f43_pc367:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f43_pc377
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc377
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc378
  .L_f43_pc377:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc378:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc385
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f43_pc385
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc386
  .L_f43_pc385:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc386:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc389
    la   t1, OP_POP
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
  .L_f43_pc389:
    lw   t0, -24(s0)
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
    beqz t0, .L_f43_pc399
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc399
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc400
  .L_f43_pc399:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc400:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc407
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f43_pc407
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc408
  .L_f43_pc407:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc408:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc411
    la   t1, OP_NEG
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
  .L_f43_pc411:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc565
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc425
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc425
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc426
  .L_f43_pc425:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc426:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc433
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc433
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc434
  .L_f43_pc433:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc434:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc441
    lw   t0, -36(s0)
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
    beqz t0, .L_f43_pc441
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc442
  .L_f43_pc441:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc442:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc445
    la   t1, OP_LNOT
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
  .L_f43_pc445:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 99
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
    beqz t0, .L_f43_pc455
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f43_pc455
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc456
  .L_f43_pc455:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc456:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc463
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc463
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc464
  .L_f43_pc463:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc464:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc471
    lw   t0, -36(s0)
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
    beqz t0, .L_f43_pc471
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc472
  .L_f43_pc471:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc472:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc475
    la   t1, OP_CAST
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
  .L_f43_pc475:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc485
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc485
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc486
  .L_f43_pc485:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc486:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc493
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f43_pc493
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc494
  .L_f43_pc493:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc494:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc501
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f43_pc501
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc502
  .L_f43_pc501:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc502:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc505
    la   t1, OP_LOAD
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
  .L_f43_pc505:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 106
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
    beqz t0, .L_f43_pc515
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f43_pc515
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc516
  .L_f43_pc515:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc516:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc523
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    beqz t0, .L_f43_pc523
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc524
  .L_f43_pc523:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc524:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc531
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f43_pc531
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc532
  .L_f43_pc531:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc532:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc535
    la   t1, OP_JUMP
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
  .L_f43_pc535:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 99
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
    beqz t0, .L_f43_pc545
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f43_pc545
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc546
  .L_f43_pc545:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc546:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc553
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc553
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc554
  .L_f43_pc553:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc554:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc561
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f43_pc561
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc562
  .L_f43_pc561:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc562:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc565
    la   t1, OP_CALL
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
  .L_f43_pc565:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc607
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc579
    lw   t0, -28(s0)
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
    beqz t0, .L_f43_pc579
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc580
  .L_f43_pc579:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc580:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc587
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f43_pc587
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc588
  .L_f43_pc587:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc588:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc595
    lw   t0, -36(s0)
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
    beqz t0, .L_f43_pc595
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc596
  .L_f43_pc595:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc596:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc603
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc603
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc604
  .L_f43_pc603:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc604:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc607
    la   t1, OP_STORE
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
  .L_f43_pc607:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc633
    lw   t0, -24(s0)
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
    beqz t0, .L_f43_pc621
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc621
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc622
  .L_f43_pc621:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc622:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc629
    lw   t0, -32(s0)
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
    beqz t0, .L_f43_pc629
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc630
  .L_f43_pc629:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc630:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc633
    la   t1, OP_RETURN
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
  .L_f43_pc633:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
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
    beqz t0, .L_f43_pc686
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 106
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
    beqz t0, .L_f43_pc647
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f43_pc647
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc648
  .L_f43_pc647:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc648:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc655
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    beqz t0, .L_f43_pc655
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc656
  .L_f43_pc655:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc656:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc663
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f43_pc663
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc664
  .L_f43_pc663:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc664:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc671
    lw   t0, -40(s0)
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
    beqz t0, .L_f43_pc671
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc672
  .L_f43_pc671:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc672:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc686
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f43_pc686
    la   t1, OP_JUMP_IF
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
  .L_f43_pc686:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc745
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f43_pc700
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f43_pc700
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc701
  .L_f43_pc700:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc701:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc708
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc708
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc709
  .L_f43_pc708:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc709:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc716
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 104
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
    beqz t0, .L_f43_pc716
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc717
  .L_f43_pc716:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc717:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc724
    lw   t0, -40(s0)
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
    beqz t0, .L_f43_pc724
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc725
  .L_f43_pc724:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc725:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc745
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f43_pc739
    la   t1, OP_PUSH_INT
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
  .L_f43_pc739:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f43_pc745
    la   t1, OP_PUSH_STR
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
  .L_f43_pc745:
    lw   t0, -20(s0)
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
    beqz t0, .L_f43_pc755
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 106
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
    beqz t0, .L_f43_pc755
    la   t1, OP_JUMP_IFNOT
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
  .L_f43_pc755:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 11
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
    beqz t0, .L_f43_pc773
    lw   t0, -24(s0)
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
    beqz t0, .L_f43_pc769
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f43_pc769
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f43_pc770
  .L_f43_pc769:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f43_pc770:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f43_pc773
    la   t1, OP_RETURN_VOID
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
  .L_f43_pc773:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
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
    # end of classify_op

    .globl fn_name_ss
    .type  fn_name_ss, @function
fn_name_ss:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_name_ss

    .globl fn_name_sl
    .type  fn_name_sl, @function
fn_name_sl:
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
    li   t0, 10
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_name_sl

    .globl fn_param_base
    .type  fn_param_base, @function
fn_param_base:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_param_base

    .globl fn_nparam
    .type  fn_nparam, @function
fn_nparam:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_nparam

    .globl fn_local_base
    .type  fn_local_base, @function
fn_local_base:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_local_base

    .globl fn_nlocal
    .type  fn_nlocal, @function
fn_nlocal:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_nlocal

    .globl fn_instr_base
    .type  fn_instr_base, @function
fn_instr_base:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_instr_base

    .globl fn_ninstr
    .type  fn_ninstr, @function
fn_ninstr:
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
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of fn_ninstr

    .globl fn_set
    .type  fn_set, @function
fn_set:
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
    li   t0, 10
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
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
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
    # end of fn_set

    .globl pl_name_ss
    .type  pl_name_ss, @function
pl_name_ss:
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of pl_name_ss

    .globl pl_name_sl
    .type  pl_name_sl, @function
pl_name_sl:
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of pl_name_sl

    .globl pl_set
    .type  pl_set, @function
pl_set:
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
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
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
    # end of pl_set

    .globl ins_op
    .type  ins_op, @function
ins_op:
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of ins_op

    .globl ins_ival
    .type  ins_ival, @function
ins_ival:
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of ins_ival

    .globl ins_ss
    .type  ins_ss, @function
ins_ss:
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of ins_ss

    .globl ins_sl
    .type  ins_sl, @function
ins_sl:
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    # end of ins_sl

    .globl ins_set
    .type  ins_set, @function
ins_set:
    # prologue: frame_size=32, params=5, locals=0
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    lw   t0, -24(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
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
    # end of ins_set

    .globl parse_lnum
    .type  parse_lnum, @function
parse_lnum:
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
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f61_pc6:
    lw   t0, -28(s0)
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
    beqz t0, .L_f61_pc41
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
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
    beqz t0, .L_f61_pc25
    lw   t0, -32(s0)
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
    beqz t0, .L_f61_pc25
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f61_pc26
  .L_f61_pc25:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f61_pc26:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f61_pc36
    lw   t0, -24(s0)
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
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    sw   t0, -24(s0)
  .L_f61_pc36:
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
    j    .L_f61_pc6
  .L_f61_pc41:
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
    # end of parse_lnum

    .globl parse_bc
    .type  parse_bc, @function
parse_bc:
    # prologue: frame_size=208, params=10, locals=39
    addi sp, sp, -208
    sw   ra, 204(sp)
    sw   s0, 200(sp)
    addi s0, sp, 208
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
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
    sw   zero, -96(s0)
    sw   zero, -100(s0)
    sw   zero, -104(s0)
    sw   zero, -108(s0)
    sw   zero, -112(s0)
    sw   zero, -116(s0)
    sw   zero, -120(s0)
    sw   zero, -124(s0)
    sw   zero, -128(s0)
    sw   zero, -132(s0)
    sw   zero, -136(s0)
    sw   zero, -140(s0)
    sw   zero, -144(s0)
    sw   zero, -148(s0)
    sw   zero, -152(s0)
    sw   zero, -156(s0)
    sw   zero, -160(s0)
    sw   zero, -164(s0)
    sw   zero, -168(s0)
    sw   zero, -172(s0)
    sw   zero, -176(s0)
    sw   zero, -180(s0)
    sw   zero, -184(s0)
    sw   zero, -188(s0)
    sw   zero, -192(s0)
    sw   zero, -196(s0)
    sw   zero, -200(s0)
    sw   zero, -204(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f62_pc5:
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
    beqz t0, .L_f62_pc15
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f62_pc15
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc16
  .L_f62_pc15:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc16:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1092
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_spaces
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    beqz t0, .L_f62_pc26
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f62_pc26:
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
    beqz t0, .L_f62_pc1091
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -60(s0)
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
    bnez t0, .L_f62_pc43
    lw   t0, -60(s0)
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
    bnez t0, .L_f62_pc43
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc44
  .L_f62_pc43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc49
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_f62_pc49:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    beqz t0, .L_f62_pc59
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
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
    beqz t0, .L_f62_pc59
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc60
  .L_f62_pc59:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc60:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc67
    lw   t0, -60(s0)
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
    beqz t0, .L_f62_pc67
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc68
  .L_f62_pc67:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc68:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc72
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc72:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    beqz t0, .L_f62_pc82
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
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
    beqz t0, .L_f62_pc82
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc83
  .L_f62_pc82:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc83:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc90
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
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
    beqz t0, .L_f62_pc90
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc91
  .L_f62_pc90:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc91:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc98
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
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
    beqz t0, .L_f62_pc98
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc99
  .L_f62_pc98:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc99:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc673
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    lw   t0, -68(s0)
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
    beqz t0, .L_f62_pc124
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
  .L_f62_pc124:
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    beqz t0, .L_f62_pc135
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
  .L_f62_pc135:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f62_pc145
    lw   t0, -76(s0)
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
    beqz t0, .L_f62_pc145
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc146
  .L_f62_pc145:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc146:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc207
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_spaces
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
    addi sp, sp, 8
    call read_strlit
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
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
    sw   t0, -92(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -84(s0)
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
    la   t1, g_nstrings
    lw   t0, 0(t1)
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
    beqz t0, .L_f62_pc204
    lw   t0, -84(s0)
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
    la   t1, g_nstrings
    sw   t0, 0(t1)
  .L_f62_pc204:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc207:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f62_pc217
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f62_pc217
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc218
  .L_f62_pc217:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc218:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc286
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nglobals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nglobals
    lw   t0, 0(t1)
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
    la   t1, g_nglobals
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc286:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
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
    beqz t0, .L_f62_pc296
    lw   t0, -76(s0)
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
    beqz t0, .L_f62_pc296
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc297
  .L_f62_pc296:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc297:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc385
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nfuncs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_ninstrs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nfuncs
    lw   t0, 0(t1)
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
    la   t1, g_nfuncs
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc385:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f62_pc395
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f62_pc395
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc396
  .L_f62_pc395:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc396:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc447
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call pl_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call pl_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nparams
    lw   t0, 0(t1)
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
    la   t1, g_nparams
    sw   t0, 0(t1)
    lw   t0, -52(s0)
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
    beqz t0, .L_f62_pc444
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nparam
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
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc444:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc447:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f62_pc457
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f62_pc457
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc458
  .L_f62_pc457:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc458:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc509
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
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
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call pl_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call pl_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nlocals
    lw   t0, 0(t1)
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
    la   t1, g_nlocals
    sw   t0, 0(t1)
    lw   t0, -52(s0)
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
    beqz t0, .L_f62_pc506
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nlocal
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
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc506:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc509:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
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
    beqz t0, .L_f62_pc522
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
  .L_f62_pc522:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f62_pc532
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    beqz t0, .L_f62_pc532
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc533
  .L_f62_pc532:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc533:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc539
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f62_pc539:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f62_pc549
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    beqz t0, .L_f62_pc549
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc550
  .L_f62_pc549:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc550:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc623
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
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
    beqz t0, .L_f62_pc617
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_instr_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -140(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_ninstr
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -144(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -148(s0)
  .L_f62_pc568:
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
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
    beqz t0, .L_f62_pc617
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_op
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -152(s0)
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
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
    bnez t0, .L_f62_pc587
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
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
    bnez t0, .L_f62_pc587
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc588
  .L_f62_pc587:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc588:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f62_pc595
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
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
    bnez t0, .L_f62_pc595
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc596
  .L_f62_pc595:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc596:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc612
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_ival
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc612:
    lw   t0, -148(s0)
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
    sw   t0, -148(s0)
    j    .L_f62_pc568
  .L_f62_pc617:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc623:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f62_pc633
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f62_pc633
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc634
  .L_f62_pc633:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc634:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc641
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
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
    beqz t0, .L_f62_pc641
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc642
  .L_f62_pc641:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc642:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc649
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f62_pc649
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc650
  .L_f62_pc649:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc650:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc657
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f62_pc657
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc658
  .L_f62_pc657:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc658:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc665
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f62_pc665
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc666
  .L_f62_pc665:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc666:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc673
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc673:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    beqz t0, .L_f62_pc683
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
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
    beqz t0, .L_f62_pc683
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc684
  .L_f62_pc683:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc684:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc691
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
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
    beqz t0, .L_f62_pc691
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc692
  .L_f62_pc691:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc692:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc699
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
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
    beqz t0, .L_f62_pc699
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc700
  .L_f62_pc699:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc700:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc707
    lw   t0, -60(s0)
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
    beqz t0, .L_f62_pc707
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc708
  .L_f62_pc707:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc708:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc777
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
  .L_f62_pc711:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f62_pc722
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 58
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
    beqz t0, .L_f62_pc722
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc723
  .L_f62_pc722:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc723:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc731
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call is_ws
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc731
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc732
  .L_f62_pc731:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc732:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc738
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_f62_pc711
  .L_f62_pc738:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f62_pc749
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    beqz t0, .L_f62_pc749
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc750
  .L_f62_pc749:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc750:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc774
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call parse_lnum
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -164(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -52(s0)
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
    beqz t0, .L_f62_pc774
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_ninstrs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_instr_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc774:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc777:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    beqz t0, .L_f62_pc787
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
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
    beqz t0, .L_f62_pc787
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc788
  .L_f62_pc787:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc788:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc795
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
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
    beqz t0, .L_f62_pc795
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc796
  .L_f62_pc795:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc796:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc803
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
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
    beqz t0, .L_f62_pc803
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc804
  .L_f62_pc803:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc804:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc811
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    beqz t0, .L_f62_pc811
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc812
  .L_f62_pc811:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc812:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1091
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -168(s0)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -172(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call classify_op
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -176(s0)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -176(s0)
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
    beqz t0, .L_f62_pc838
    lw   t0, -52(s0)
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
    beqz t0, .L_f62_pc838
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc839
  .L_f62_pc838:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc839:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1088
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_instr_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -180(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_ninstr
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
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
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
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
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_INT
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
    beqz t0, .L_f62_pc898
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc898:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_STR
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
    beqz t0, .L_f62_pc920
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc920:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LOAD
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
    bnez t0, .L_f62_pc930
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_STORE
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
    bnez t0, .L_f62_pc930
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc931
  .L_f62_pc930:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc931:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc953
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc953:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CALL
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
    beqz t0, .L_f62_pc998
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call int_from_stab
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call discard_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc998:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CAST
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
    beqz t0, .L_f62_pc1023
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call next_tok
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call tok_len
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc1023:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
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
    bnez t0, .L_f62_pc1033
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
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
    bnez t0, .L_f62_pc1033
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc1034
  .L_f62_pc1033:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc1034:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f62_pc1041
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
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
    bnez t0, .L_f62_pc1041
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc1042
  .L_f62_pc1041:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc1042:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1076
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_spaces
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
  .L_f62_pc1048:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
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
    beqz t0, .L_f62_pc1059
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call in_cur
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call is_ws
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1059
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f62_pc1060
  .L_f62_pc1059:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f62_pc1060:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f62_pc1066
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_f62_pc1048
  .L_f62_pc1066:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -204(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call parse_lnum
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call ins_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc1076:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
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
    addi sp, sp, 16
    call fn_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_ninstrs
    lw   t0, 0(t1)
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
    la   t1, g_ninstrs
    sw   t0, 0(t1)
  .L_f62_pc1088:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call skip_line
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f62_pc1091:
    j    .L_f62_pc5
  .L_f62_pc1092:
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
    # end of parse_bc

    .globl is_local
    .type  is_local, @function
is_local:
    # prologue: frame_size=64, params=7, locals=5
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
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_param_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nparam
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_local_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nlocal
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
  .L_f63_pc18:
    lw   t0, -56(s0)
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
    beqz t0, .L_f63_pc44
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call stab_eq
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc39
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
  .L_f63_pc39:
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
    j    .L_f63_pc18
  .L_f63_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f63_pc46:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
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
    beqz t0, .L_f63_pc72
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call stab_eq
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f63_pc67
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
  .L_f63_pc67:
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
    j    .L_f63_pc46
  .L_f63_pc72:
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
    # end of is_local

    .globl var_offset
    .type  var_offset, @function
var_offset:
    # prologue: frame_size=64, params=7, locals=5
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
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_param_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nparam
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_local_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nlocal
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
  .L_f64_pc18:
    lw   t0, -56(s0)
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
    beqz t0, .L_f64_pc50
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call stab_eq
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f64_pc45
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f64_pc45:
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
    j    .L_f64_pc18
  .L_f64_pc50:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f64_pc52:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
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
    beqz t0, .L_f64_pc88
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    addi sp, sp, 8
    call pl_name_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call stab_eq
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f64_pc83
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f64_pc83:
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
    j    .L_f64_pc52
  .L_f64_pc88:
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
    # end of var_offset

    .globl is_builtin
    .type  is_builtin, @function
is_builtin:
    # prologue: frame_size=64, params=3, locals=10
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    lw   t0, -20(s0)
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
    beqz t0, .L_f65_pc6
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
  .L_f65_pc6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    beqz t0, .L_f65_pc24
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f65_pc24:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    beqz t0, .L_f65_pc37
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f65_pc37:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    beqz t0, .L_f65_pc47
    lw   t0, -24(s0)
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
    beqz t0, .L_f65_pc47
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc48
  .L_f65_pc47:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc48:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc55
    lw   t0, -24(s0)
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
    beqz t0, .L_f65_pc55
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc56
  .L_f65_pc55:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc56:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc140
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
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
    beqz t0, .L_f65_pc112
    lw   t0, -40(s0)
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
    beqz t0, .L_f65_pc112
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc113
  .L_f65_pc112:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc113:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc120
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
    beqz t0, .L_f65_pc120
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc121
  .L_f65_pc120:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc121:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc128
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f65_pc128
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc129
  .L_f65_pc128:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc129:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc136
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 121
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
    beqz t0, .L_f65_pc136
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc137
  .L_f65_pc136:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc137:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc140
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
  .L_f65_pc140:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
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
    beqz t0, .L_f65_pc150
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f65_pc150
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc151
  .L_f65_pc150:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc151:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc158
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 121
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
    beqz t0, .L_f65_pc158
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc159
  .L_f65_pc158:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc159:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc166
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f65_pc166
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc167
  .L_f65_pc166:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc167:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc170
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
  .L_f65_pc170:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    beqz t0, .L_f65_pc180
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f65_pc180
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc181
  .L_f65_pc180:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc181:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc188
    lw   t0, -28(s0)
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
    beqz t0, .L_f65_pc188
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc189
  .L_f65_pc188:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc189:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc196
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f65_pc196
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc197
  .L_f65_pc196:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc197:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc200
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
  .L_f65_pc200:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
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
    beqz t0, .L_f65_pc210
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f65_pc210
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc211
  .L_f65_pc210:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc211:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc218
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc218
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc219
  .L_f65_pc218:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc219:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc226
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc226
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc227
  .L_f65_pc226:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc227:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc260
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 107
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
    beqz t0, .L_f65_pc260
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -60(s0)
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
    beqz t0, .L_f65_pc256
    lw   t0, -60(s0)
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
    beqz t0, .L_f65_pc256
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc257
  .L_f65_pc256:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc257:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc260
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
  .L_f65_pc260:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
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
    beqz t0, .L_f65_pc270
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f65_pc270
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc271
  .L_f65_pc270:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc271:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc278
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
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
    beqz t0, .L_f65_pc278
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc279
  .L_f65_pc278:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc279:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc286
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 107
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
    beqz t0, .L_f65_pc286
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc287
  .L_f65_pc286:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc287:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc290
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
  .L_f65_pc290:
    lw   t0, -20(s0)
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
    beqz t0, .L_f65_pc300
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f65_pc300
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc301
  .L_f65_pc300:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc301:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc308
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc308
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc309
  .L_f65_pc308:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc309:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc316
    lw   t0, -32(s0)
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
    beqz t0, .L_f65_pc316
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc317
  .L_f65_pc316:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc317:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc320
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
  .L_f65_pc320:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
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
    beqz t0, .L_f65_pc330
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc330
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc331
  .L_f65_pc330:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc331:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc338
    lw   t0, -32(s0)
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
    beqz t0, .L_f65_pc338
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc339
  .L_f65_pc338:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc339:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc342
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
  .L_f65_pc342:
    lw   t0, -20(s0)
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
    beqz t0, .L_f65_pc352
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f65_pc352
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc353
  .L_f65_pc352:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc353:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc360
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc360
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc361
  .L_f65_pc360:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc361:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc368
    lw   t0, -32(s0)
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
    beqz t0, .L_f65_pc368
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc369
  .L_f65_pc368:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc369:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc372
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
  .L_f65_pc372:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    beqz t0, .L_f65_pc382
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
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
    beqz t0, .L_f65_pc382
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc383
  .L_f65_pc382:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc383:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc390
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc390
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc391
  .L_f65_pc390:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc391:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc398
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
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
    beqz t0, .L_f65_pc398
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc399
  .L_f65_pc398:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc399:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc402
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
  .L_f65_pc402:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    beqz t0, .L_f65_pc412
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    beqz t0, .L_f65_pc412
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc413
  .L_f65_pc412:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc413:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc420
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f65_pc420
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc421
  .L_f65_pc420:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc421:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc428
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
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
    beqz t0, .L_f65_pc428
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc429
  .L_f65_pc428:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc429:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc432
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
  .L_f65_pc432:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    beqz t0, .L_f65_pc442
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f65_pc442
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc443
  .L_f65_pc442:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc443:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc450
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 113
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
    beqz t0, .L_f65_pc450
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc451
  .L_f65_pc450:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc451:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc458
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f65_pc458
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f65_pc459
  .L_f65_pc458:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f65_pc459:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f65_pc462
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
  .L_f65_pc462:
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
    # end of is_builtin

    .globl is_sys_exit
    .type  is_sys_exit, @function
is_sys_exit:
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
    li   t0, 8
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
    beqz t0, .L_f66_pc6
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
  .L_f66_pc6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 115
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
    beqz t0, .L_f66_pc15
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
  .L_f66_pc15:
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 101
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
    beqz t0, .L_f66_pc26
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
  .L_f66_pc26:
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 120
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
    beqz t0, .L_f66_pc37
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
  .L_f66_pc37:
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
    # end of is_sys_exit

    .globl is_jump_target
    .type  is_jump_target, @function
is_jump_target:
    # prologue: frame_size=32, params=4, locals=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f67_pc2:
    lw   t0, -28(s0)
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
    beqz t0, .L_f67_pc45
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
    addi sp, sp, 12
    call ins_op
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
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
    bnez t0, .L_f67_pc21
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
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
    bnez t0, .L_f67_pc21
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f67_pc22
  .L_f67_pc21:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f67_pc22:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, .L_f67_pc29
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
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
    bnez t0, .L_f67_pc29
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f67_pc30
  .L_f67_pc29:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f67_pc30:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f67_pc40
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
    addi sp, sp, 12
    call ins_ival
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
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
    beqz t0, .L_f67_pc40
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
  .L_f67_pc40:
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
    j    .L_f67_pc2
  .L_f67_pc45:
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
    # end of is_jump_target

    .globl emit_strdata
    .type  emit_strdata, @function
emit_strdata:
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
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f68_pc6:
    lw   t0, -28(s0)
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
    beqz t0, .L_f68_pc194
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
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
    beqz t0, .L_f68_pc33
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc33:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc43
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
    beqz t0, .L_f68_pc43
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc44
  .L_f68_pc43:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc55
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc55:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc65
    lw   t0, -32(s0)
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
    beqz t0, .L_f68_pc65
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc66
  .L_f68_pc65:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc66:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc77
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc77:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc87
    lw   t0, -32(s0)
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
    beqz t0, .L_f68_pc87
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc88
  .L_f68_pc87:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc88:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc99
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc99:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc109
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
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc109
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc110
  .L_f68_pc109:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc110:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc121
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc121:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc139
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
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
    bnez t0, .L_f68_pc135
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 127
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
    bnez t0, .L_f68_pc135
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc136
  .L_f68_pc135:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc136:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc139
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f68_pc140
  .L_f68_pc139:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f68_pc140:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f68_pc181
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f68_pc181:
    lw   t0, -36(s0)
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
    beqz t0, .L_f68_pc189
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f68_pc189:
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
    j    .L_f68_pc6
  .L_f68_pc194:
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of emit_strdata

    .globl emit_fn
    .type  emit_fn, @function
emit_fn:
    # prologue: frame_size=128, params=8, locals=22
    addi sp, sp, -128
    sw   ra, 124(sp)
    sw   s0, 120(sp)
    addi s0, sp, 128
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
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
    sw   zero, -96(s0)
    sw   zero, -100(s0)
    sw   zero, -104(s0)
    sw   zero, -108(s0)
    sw   zero, -112(s0)
    sw   zero, -116(s0)
    sw   zero, -120(s0)
    sw   zero, -124(s0)
    sw   zero, -128(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_name_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_name_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nparam
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_nlocal
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_instr_base
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call fn_ninstr
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    sw   t0, -68(s0)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    sw   t0, -72(s0)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    rem  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    beqz t0, .L_f69_pc48
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
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
    sw   t0, -72(s0)
  .L_f69_pc48:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 121
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 44
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 61
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregra
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregs0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregs0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
  .L_f69_pc435:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
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
    beqz t0, .L_f69_pc445
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
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
    beqz t0, .L_f69_pc445
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc446
  .L_f69_pc445:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc446:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc479
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    andi t0, t0, 0xff
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNs0nl
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
    j    .L_f69_pc435
  .L_f69_pc479:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
  .L_f69_pc481:
    lw   t0, -84(s0)
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
    beqz t0, .L_f69_pc526
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNs0nl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -84(s0)
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
    sw   t0, -84(s0)
    j    .L_f69_pc481
  .L_f69_pc526:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
  .L_f69_pc528:
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    beqz t0, .L_f69_pc2347
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call is_jump_target
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
    beqz t0, .L_f69_pc545
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call asm_pc_label
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc545:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_op
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -92(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_ival
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_ss
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call ins_sl
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_INT
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
    beqz t0, .L_f69_pc586
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_li
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc586:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_STR
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
    beqz t0, .L_f69_pc821
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_la
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_li
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 107
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc821:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LOAD
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
    beqz t0, .L_f69_pc905
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
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    addi sp, sp, 28
    call is_local
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
    beqz t0, .L_f69_pc856
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
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    addi sp, sp, 28
    call var_offset
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNs0nl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f69_pc902
  .L_f69_pc856:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_la
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc902:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc905:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_STORE
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
    beqz t0, .L_f69_pc989
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
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
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    addi sp, sp, 28
    call is_local
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
    beqz t0, .L_f69_pc943
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
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    addi sp, sp, 28
    call var_offset
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNs0nl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f69_pc989
  .L_f69_pc943:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_la
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 41
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc989:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CALL
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
    beqz t0, .L_f69_pc1174
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_f69_pc997:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
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
    beqz t0, .L_f69_pc1007
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
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
    beqz t0, .L_f69_pc1007
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc1008
  .L_f69_pc1007:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc1008:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc1041
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_lw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
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
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
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
    lw   t0, -120(s0)
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
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -120(s0)
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
    sw   t0, -120(s0)
    j    .L_f69_pc997
  .L_f69_pc1041:
    lw   t0, -116(s0)
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
    beqz t0, .L_f69_pc1064
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1064:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call is_sys_exit
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
    beqz t0, .L_f69_pc1125
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_li
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 55
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 51
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f69_pc1135
  .L_f69_pc1125:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call is_builtin
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    addi sp, sp, 20
    call asm_call_fn
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1135:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_sw
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call eNspnl
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1174:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_RETURN
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
    beqz t0, .L_f69_pc1230
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 118
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ecomma
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_epilogue
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1230:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_RETURN_VOID
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
    beqz t0, .L_f69_pc1237
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_epilogue
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1237:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_POP
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
    beqz t0, .L_f69_pc1258
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e_addi
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregsp
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1258:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_ADD
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
    beqz t0, .L_f69_pc1309
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1309:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SUB
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
    beqz t0, .L_f69_pc1360
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1360:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MUL
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
    beqz t0, .L_f69_pc1411
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1411:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_DIV
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
    beqz t0, .L_f69_pc1462
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 118
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1462:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MOD
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
    beqz t0, .L_f69_pc1513
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 109
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1513:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_AND
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
    beqz t0, .L_f69_pc1564
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1564:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_OR
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
    beqz t0, .L_f69_pc1615
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1615:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_XOR
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
    beqz t0, .L_f69_pc1666
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 120
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1666:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHL
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
    beqz t0, .L_f69_pc1717
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1717:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR
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
    beqz t0, .L_f69_pc1768
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1768:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_EQ
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
    beqz t0, .L_f69_pc1784
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_sub_t0_t0_t1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_seqz_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1784:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_NE
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
    beqz t0, .L_f69_pc1800
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_sub_t0_t0_t1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_snez_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1800:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT
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
    beqz t0, .L_f69_pc1814
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call asm_slt
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1814:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LE
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
    beqz t0, .L_f69_pc1831
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call asm_slt
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_xori_t0_1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1831:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GT
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
    beqz t0, .L_f69_pc1845
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call asm_slt
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1845:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE
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
    beqz t0, .L_f69_pc1862
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t1_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call asm_slt
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_xori_t0_1
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1862:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_NEG
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
    beqz t0, .L_f69_pc1910
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1910:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LNOT
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
    beqz t0, .L_f69_pc1923
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_seqz_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc1923:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CAST
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
    beqz t0, .L_f69_pc2307
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -104(s0)
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
    beqz t0, .L_f69_pc1943
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
  .L_f69_pc1943:
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    beqz t0, .L_f69_pc1954
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
  .L_f69_pc1954:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f69_pc1964
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
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
    beqz t0, .L_f69_pc1964
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc1965
  .L_f69_pc1964:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc1965:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc2015
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 120
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2015:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
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
    beqz t0, .L_f69_pc2025
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 49
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
    beqz t0, .L_f69_pc2025
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc2026
  .L_f69_pc2025:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc2026:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc2109
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2109:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f69_pc2119
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
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
    beqz t0, .L_f69_pc2119
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc2120
  .L_f69_pc2119:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc2120:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc2203
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 50
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 50
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2203:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    beqz t0, .L_f69_pc2213
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 49
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
    beqz t0, .L_f69_pc2213
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f69_pc2214
  .L_f69_pc2213:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f69_pc2214:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f69_pc2297
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call eregt0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2297:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    beqz t0, .L_f69_pc2304
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_snez_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2304:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_push_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2307:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
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
    beqz t0, .L_f69_pc2316
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call asm_jump
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2316:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
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
    beqz t0, .L_f69_pc2329
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call asm_branch
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2329:
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
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
    beqz t0, .L_f69_pc2342
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call asm_pop_t0
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call asm_branch
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f69_pc2342:
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
    j    .L_f69_pc528
  .L_f69_pc2347:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    # end of emit_fn

    .globl emit_program
    .type  emit_program, @function
emit_program:
    # prologue: frame_size=80, params=9, locals=8
    addi sp, sp, -80
    sw   ra, 76(sp)
    sw   s0, 72(sp)
    addi s0, sp, 80
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    sw   zero, -64(s0)
    sw   zero, -68(s0)
    sw   zero, -72(s0)
    sw   zero, -76(s0)
    la   t1, g_nstrings
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
    beqz t0, .L_f70_pc213
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
  .L_f70_pc77:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nstrings
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
    beqz t0, .L_f70_pc209
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 99
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call emit_strdata
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
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
    j    .L_f70_pc77
  .L_f70_pc209:
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f70_pc213:
    la   t1, g_nglobals
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
    beqz t0, .L_f70_pc372
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
  .L_f70_pc246:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nglobals
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
    beqz t0, .L_f70_pc368
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
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
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    addi sp, sp, 16
    call ob_n
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 119
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_int
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -60(s0)
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
    sw   t0, -60(s0)
    j    .L_f70_pc246
  .L_f70_pc368:
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f70_pc372:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call e4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 120
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call ob_char
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
  .L_f70_pc405:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nfuncs
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
    beqz t0, .L_f70_pc424
    lw   t0, -12(s0)
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
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 28(sp)
    lw   a1, 24(sp)
    lw   a2, 20(sp)
    lw   a3, 16(sp)
    lw   a4, 12(sp)
    lw   a5, 8(sp)
    lw   a6, 4(sp)
    lw   a7, 0(sp)
    addi sp, sp, 32
    call emit_fn
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -76(s0)
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
    sw   t0, -76(s0)
    j    .L_f70_pc405
  .L_f70_pc424:
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
    # end of emit_program

    .globl main
    .type  main, @function
main:
    # prologue: frame_size=80, params=0, locals=15
    addi sp, sp, -80
    sw   ra, 76(sp)
    sw   s0, 72(sp)
    addi s0, sp, 80
    sw   zero, -12(s0)
    sw   zero, -16(s0)
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
    sw   zero, -60(s0)
    sw   zero, -64(s0)
    sw   zero, -68(s0)
    li   t0, 524288
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_U8Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -12(s0)
    li   t0, 262144
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_U8Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    li   t0, 16384
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_U8Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 512
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 256
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 2560
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    li   t0, 262144
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    li   t0, 16384
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_I32Array
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
    la   t1, g_in_len
    sw   t0, 0(t1)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_U8Array
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
  .L_f71_pc40:
    lw   t0, -60(s0)
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
    beqz t0, .L_f71_pc50
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 524000
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
    beqz t0, .L_f71_pc50
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f71_pc51
  .L_f71_pc50:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f71_pc51:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f71_pc94
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_sys_read
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -64(s0)
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
    beqz t0, .L_f71_pc63
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
  .L_f71_pc63:
    lw   t0, -64(s0)
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
    beqz t0, .L_f71_pc93
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
  .L_f71_pc69:
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    beqz t0, .L_f71_pc89
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    addi sp, sp, 8
    call __tc_get
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    addi sp, sp, 12
    call __tc_set
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
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
    sw   t0, -68(s0)
    j    .L_f71_pc69
  .L_f71_pc89:
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    la   t1, g_in_len
    sw   t0, 0(t1)
  .L_f71_pc93:
    j    .L_f71_pc40
  .L_f71_pc94:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call __tc_delete
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_len
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
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, .L_f71_pc103
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
  .L_f71_pc103:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    lw   t0, -40(s0)
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
    lw   a0, 36(sp)
    lw   a1, 32(sp)
    lw   a2, 28(sp)
    lw   a3, 24(sp)
    lw   a4, 20(sp)
    lw   a5, 16(sp)
    lw   a6, 12(sp)
    lw   a7, 8(sp)
    addi sp, sp, 40
    call parse_bc
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
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
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 32(sp)
    lw   a1, 28(sp)
    lw   a2, 24(sp)
    lw   a3, 20(sp)
    lw   a4, 16(sp)
    lw   a5, 12(sp)
    lw   a6, 8(sp)
    lw   a7, 4(sp)
    addi sp, sp, 36
    call emit_program
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    addi sp, sp, 4
    call ob_flush
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

