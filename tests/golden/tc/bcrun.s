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
    .globl HK_U8
HK_U8:
    .word 1
    .globl HK_I32
HK_I32:
    .word 2
    .globl HK_STR
HK_STR:
    .word 3
    .globl TAG_INT
TAG_INT:
    .word 0
    .globl TAG_REF
TAG_REF:
    .word 1
    .globl g_cur_func
g_cur_func:
    .word 0
    .globl g_cur_pc
g_cur_pc:
    .word 0
    .globl g_sp
g_sp:
    .word 0
    .globl g_csp
g_csp:
    .word 0
    .globl g_frame_base
g_frame_base:
    .word 0
    .globl g_vp
g_vp:
    .word 0
    .globl g_pop_ival
g_pop_ival:
    .word 0
    .globl g_pop_tag
g_pop_tag:
    .word 0
    .globl g_cs_func
g_cs_func:
    .word 0
    .globl g_cs_pc
g_cs_pc:
    .word 0
    .globl g_cs_fbase
g_cs_fbase:
    .word 0
    .globl g_cs_vp
g_cs_vp:
    .word 0
    .globl g_cs_sp
g_cs_sp:
    .word 0
    .globl g_prog_stdin_pos
g_prog_stdin_pos:
    .word 0
    .globl g_prog_stdin_len
g_prog_stdin_len:
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
    .globl g_stab_pos
g_stab_pos:
    .word 0
    .globl g_in_pos
g_in_pos:
    .word 0
    .globl g_in_len
g_in_len:
    .word 0
    .globl g_heap_bytes_top
g_heap_bytes_top:
    .word 0
    .globl g_heap_i32s_top
g_heap_i32s_top:
    .word 0
    .globl g_heap_obj_count
g_heap_obj_count:
    .word 0

    .text

    .globl stab_eq__U8Array__i32__i32__i32__i32
    .type  stab_eq__U8Array__i32__i32__i32__i32, @function
stab_eq__U8Array__i32__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=1, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
    bnez t0, __skipn_0
    j    .L_f0_pc6
__skipn_0:
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
  .L_f0_pc6:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f0_pc8:
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
    bnez t0, __skipn_1
    j    .L_f0_pc31
__skipn_1:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    bnez t0, __skipn_2
    j    .L_f0_pc26
__skipn_2:
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
  .L_f0_pc26:
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
    j    .L_f0_pc8
  .L_f0_pc31:
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
    # end of stab_eq__U8Array__i32__i32__i32__i32

    .globl in_cur__U8Array
    .type  in_cur__U8Array, @function
in_cur__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    bnez t0, __skipn_3
    j    .L_f1_pc6
__skipn_3:
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
  .L_f1_pc6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    # end of in_cur__U8Array

    .globl is_ws__u8
    .type  is_ws__u8, @function
is_ws__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    beqz t0, __skip_0
    j    .L_f2_pc10
__skip_0:
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
    beqz t0, __skip_1
    j    .L_f2_pc10
__skip_1:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f2_pc11
  .L_f2_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f2_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_2
    j    .L_f2_pc18
__skip_2:
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
    beqz t0, __skip_3
    j    .L_f2_pc18
__skip_3:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f2_pc19
  .L_f2_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f2_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_4
    j    .L_f2_pc26
__skip_4:
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
    beqz t0, __skip_5
    j    .L_f2_pc26
__skip_5:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f2_pc27
  .L_f2_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f2_pc27:
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
    # end of is_ws__u8

    .globl skip_spaces__U8Array
    .type  skip_spaces__U8Array, @function
skip_spaces__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
  .L_f3_pc0:
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
    bnez t0, __skipn_4
    j    .L_f3_pc20
__skipn_4:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    beqz t0, __skip_6
    j    .L_f3_pc16
__skip_6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    beqz t0, __skip_7
    j    .L_f3_pc16
__skip_7:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f3_pc17
  .L_f3_pc16:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f3_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_5
    j    .L_f3_pc20
__skipn_5:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f3_pc21
  .L_f3_pc20:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f3_pc21:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_6
    j    .L_f3_pc27
__skipn_6:
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
    j    .L_f3_pc0
  .L_f3_pc27:
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
    # end of skip_spaces__U8Array

    .globl skip_line__U8Array
    .type  skip_line__U8Array, @function
skip_line__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
  .L_f4_pc0:
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
    bnez t0, __skipn_7
    j    .L_f4_pc11
__skipn_7:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
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
    bnez t0, __skipn_8
    j    .L_f4_pc11
__skipn_8:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f4_pc12
  .L_f4_pc11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f4_pc12:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_9
    j    .L_f4_pc18
__skipn_9:
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
    j    .L_f4_pc0
  .L_f4_pc18:
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
    bnez t0, __skipn_10
    j    .L_f4_pc26
__skipn_10:
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
  .L_f4_pc26:
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
    # end of skip_line__U8Array

    .globl next_tok__U8Array__U8Array
    .type  next_tok__U8Array__U8Array, @function
next_tok__U8Array__U8Array:
    # prologue: frame_size=48, params=2, locals=1, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
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
  .L_f5_pc5:
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
    bnez t0, __skipn_11
    j    .L_f5_pc16
__skipn_11:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_12
    j    .L_f5_pc16
__skipn_12:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f5_pc17
  .L_f5_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f5_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_13
    j    .L_f5_pc33
__skipn_13:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
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
    j    .L_f5_pc5
  .L_f5_pc33:
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
    # end of next_tok__U8Array__U8Array

    .globl tok_len__i32
    .type  tok_len__i32, @function
tok_len__i32:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of tok_len__i32

    .globl discard_tok__i32
    .type  discard_tok__i32, @function
discard_tok__i32:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
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
    # end of discard_tok__i32

    .globl int_from_stab__U8Array__i32__i32
    .type  int_from_stab__U8Array__i32__i32, @function
int_from_stab__U8Array__i32__i32:
    # prologue: frame_size=64, params=3, locals=4, eval_depth=5
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
    bnez t0, __skipn_14
    j    .L_f8_pc16
__skipn_14:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
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
    bnez t0, __skipn_15
    j    .L_f8_pc16
__skipn_15:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f8_pc17
  .L_f8_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f8_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_16
    j    .L_f8_pc22
__skipn_16:
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
  .L_f8_pc22:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f8_pc24:
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
    bnez t0, __skipn_17
    j    .L_f8_pc60
__skipn_17:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
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
    bnez t0, __skipn_18
    j    .L_f8_pc44
__skipn_18:
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
    bnez t0, __skipn_19
    j    .L_f8_pc44
__skipn_19:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f8_pc45
  .L_f8_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f8_pc45:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_20
    j    .L_f8_pc55
__skipn_20:
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
  .L_f8_pc55:
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
    j    .L_f8_pc24
  .L_f8_pc60:
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
    bnez t0, __skipn_21
    j    .L_f8_pc68
__skipn_21:
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
  .L_f8_pc68:
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
    # end of int_from_stab__U8Array__i32__i32

    .globl read_strlit__U8Array__U8Array
    .type  read_strlit__U8Array__U8Array, @function
read_strlit__U8Array__U8Array:
    # prologue: frame_size=112, params=2, locals=10, eval_depth=12
    addi sp, sp, -112
    sw   ra, 108(sp)
    sw   s0, 104(sp)
    addi s0, sp, 112
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
    bnez t0, __skipn_22
    j    .L_f9_pc13
__skipn_22:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
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
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_23
    j    .L_f9_pc13
__skipn_23:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc14
  .L_f9_pc13:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc14:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_24
    j    .L_f9_pc19
__skipn_24:
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
  .L_f9_pc19:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_f9_pc21:
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
    bnez t0, __skipn_25
    j    .L_f9_pc31
__skipn_25:
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
    bnez t0, __skipn_26
    j    .L_f9_pc31
__skipn_26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc32
  .L_f9_pc31:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc32:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_27
    j    .L_f9_pc245
__skipn_27:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_28
    j    .L_f9_pc50
__skipn_28:
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
  .L_f9_pc50:
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
    bnez t0, __skipn_29
    j    .L_f9_pc60
__skipn_29:
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
    bnez t0, __skipn_30
    j    .L_f9_pc60
__skipn_30:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc61
  .L_f9_pc60:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc61:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_31
    j    .L_f9_pc231
__skipn_31:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_32
    j    .L_f9_pc77
__skipn_32:
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f9_pc77:
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
    bnez t0, __skipn_33
    j    .L_f9_pc83
__skipn_33:
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f9_pc83:
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
    bnez t0, __skipn_34
    j    .L_f9_pc89
__skipn_34:
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f9_pc89:
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
    bnez t0, __skipn_35
    j    .L_f9_pc220
__skipn_35:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    call in_cur__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_36
    j    .L_f9_pc121
__skipn_36:
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
    bnez t0, __skipn_37
    j    .L_f9_pc121
__skipn_37:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc122
  .L_f9_pc121:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc122:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_38
    j    .L_f9_pc128
__skipn_38:
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
  .L_f9_pc128:
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
    bnez t0, __skipn_39
    j    .L_f9_pc138
__skipn_39:
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
    bnez t0, __skipn_40
    j    .L_f9_pc138
__skipn_40:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc139
  .L_f9_pc138:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc139:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_41
    j    .L_f9_pc145
__skipn_41:
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
  .L_f9_pc145:
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
    bnez t0, __skipn_42
    j    .L_f9_pc155
__skipn_42:
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
    bnez t0, __skipn_43
    j    .L_f9_pc155
__skipn_43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc156
  .L_f9_pc155:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc156:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_44
    j    .L_f9_pc162
__skipn_44:
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
  .L_f9_pc162:
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
    bnez t0, __skipn_45
    j    .L_f9_pc172
__skipn_45:
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
    bnez t0, __skipn_46
    j    .L_f9_pc172
__skipn_46:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc173
  .L_f9_pc172:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc173:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_47
    j    .L_f9_pc179
__skipn_47:
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
  .L_f9_pc179:
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
    bnez t0, __skipn_48
    j    .L_f9_pc189
__skipn_48:
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
    bnez t0, __skipn_49
    j    .L_f9_pc189
__skipn_49:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc190
  .L_f9_pc189:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc190:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_50
    j    .L_f9_pc196
__skipn_50:
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
  .L_f9_pc196:
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
    bnez t0, __skipn_51
    j    .L_f9_pc206
__skipn_51:
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
    bnez t0, __skipn_52
    j    .L_f9_pc206
__skipn_52:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f9_pc207
  .L_f9_pc206:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f9_pc207:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_53
    j    .L_f9_pc213
__skipn_53:
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
  .L_f9_pc213:
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
  .L_f9_pc220:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
  .L_f9_pc231:
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
    bnez t0, __skipn_54
    j    .L_f9_pc244
__skipn_54:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
  .L_f9_pc244:
    j    .L_f9_pc21
  .L_f9_pc245:
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
    # end of read_strlit__U8Array__U8Array

    .globl classify_op__U8Array__i32__i32
    .type  classify_op__U8Array__i32__i32, @function
classify_op__U8Array__i32__i32:
    # prologue: frame_size=288, params=3, locals=6, eval_depth=61
    addi sp, sp, -288
    sw   ra, 284(sp)
    sw   s0, 280(sp)
    addi s0, sp, 288
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
    bnez t0, __skipn_55
    j    .L_f10_pc18
__skipn_55:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    sw   t0, -24(s0)
  .L_f10_pc18:
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
    bnez t0, __skipn_56
    j    .L_f10_pc28
__skipn_56:
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_f10_pc28:
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
    bnez t0, __skipn_57
    j    .L_f10_pc38
__skipn_57:
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_f10_pc38:
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
    bnez t0, __skipn_58
    j    .L_f10_pc48
__skipn_58:
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f10_pc48:
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
    bnez t0, __skipn_59
    j    .L_f10_pc58
__skipn_59:
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_f10_pc58:
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
    bnez t0, __skipn_60
    j    .L_f10_pc160
__skipn_60:
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
    bnez t0, __skipn_61
    j    .L_f10_pc72
__skipn_61:
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
    bnez t0, __skipn_62
    j    .L_f10_pc72
__skipn_62:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc73
  .L_f10_pc72:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc73:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_63
    j    .L_f10_pc76
__skipn_63:
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
  .L_f10_pc76:
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
    bnez t0, __skipn_64
    j    .L_f10_pc86
__skipn_64:
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
    bnez t0, __skipn_65
    j    .L_f10_pc86
__skipn_65:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc87
  .L_f10_pc86:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc87:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_66
    j    .L_f10_pc90
__skipn_66:
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
  .L_f10_pc90:
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
    bnez t0, __skipn_67
    j    .L_f10_pc100
__skipn_67:
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
    bnez t0, __skipn_68
    j    .L_f10_pc100
__skipn_68:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc101
  .L_f10_pc100:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc101:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_69
    j    .L_f10_pc104
__skipn_69:
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
  .L_f10_pc104:
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
    bnez t0, __skipn_70
    j    .L_f10_pc114
__skipn_70:
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
    bnez t0, __skipn_71
    j    .L_f10_pc114
__skipn_71:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc115
  .L_f10_pc114:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc115:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_72
    j    .L_f10_pc118
__skipn_72:
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
  .L_f10_pc118:
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
    bnez t0, __skipn_73
    j    .L_f10_pc128
__skipn_73:
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
    bnez t0, __skipn_74
    j    .L_f10_pc128
__skipn_74:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc129
  .L_f10_pc128:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc129:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_75
    j    .L_f10_pc132
__skipn_75:
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
  .L_f10_pc132:
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
    bnez t0, __skipn_76
    j    .L_f10_pc142
__skipn_76:
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
    bnez t0, __skipn_77
    j    .L_f10_pc142
__skipn_77:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc143
  .L_f10_pc142:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc143:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_78
    j    .L_f10_pc146
__skipn_78:
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
  .L_f10_pc146:
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
    bnez t0, __skipn_79
    j    .L_f10_pc156
__skipn_79:
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
    bnez t0, __skipn_80
    j    .L_f10_pc156
__skipn_80:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc157
  .L_f10_pc156:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc157:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_81
    j    .L_f10_pc160
__skipn_81:
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
  .L_f10_pc160:
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
    bnez t0, __skipn_82
    j    .L_f10_pc406
__skipn_82:
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
    bnez t0, __skipn_83
    j    .L_f10_pc174
__skipn_83:
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
    bnez t0, __skipn_84
    j    .L_f10_pc174
__skipn_84:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc175
  .L_f10_pc174:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc175:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_85
    j    .L_f10_pc182
__skipn_85:
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
    bnez t0, __skipn_86
    j    .L_f10_pc182
__skipn_86:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc183
  .L_f10_pc182:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc183:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_87
    j    .L_f10_pc186
__skipn_87:
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
  .L_f10_pc186:
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
    bnez t0, __skipn_88
    j    .L_f10_pc196
__skipn_88:
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
    bnez t0, __skipn_89
    j    .L_f10_pc196
__skipn_89:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc197
  .L_f10_pc196:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc197:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_90
    j    .L_f10_pc204
__skipn_90:
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
    bnez t0, __skipn_91
    j    .L_f10_pc204
__skipn_91:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc205
  .L_f10_pc204:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc205:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_92
    j    .L_f10_pc208
__skipn_92:
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
  .L_f10_pc208:
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
    bnez t0, __skipn_93
    j    .L_f10_pc218
__skipn_93:
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
    bnez t0, __skipn_94
    j    .L_f10_pc218
__skipn_94:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc219
  .L_f10_pc218:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc219:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_95
    j    .L_f10_pc226
__skipn_95:
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
    bnez t0, __skipn_96
    j    .L_f10_pc226
__skipn_96:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc227
  .L_f10_pc226:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc227:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_97
    j    .L_f10_pc230
__skipn_97:
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
  .L_f10_pc230:
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
    bnez t0, __skipn_98
    j    .L_f10_pc240
__skipn_98:
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
    bnez t0, __skipn_99
    j    .L_f10_pc240
__skipn_99:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc241
  .L_f10_pc240:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc241:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_100
    j    .L_f10_pc248
__skipn_100:
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
    bnez t0, __skipn_101
    j    .L_f10_pc248
__skipn_101:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc249
  .L_f10_pc248:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc249:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_102
    j    .L_f10_pc252
__skipn_102:
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
  .L_f10_pc252:
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
    bnez t0, __skipn_103
    j    .L_f10_pc262
__skipn_103:
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
    bnez t0, __skipn_104
    j    .L_f10_pc262
__skipn_104:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc263
  .L_f10_pc262:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc263:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_105
    j    .L_f10_pc270
__skipn_105:
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
    bnez t0, __skipn_106
    j    .L_f10_pc270
__skipn_106:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc271
  .L_f10_pc270:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc271:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_107
    j    .L_f10_pc274
__skipn_107:
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
  .L_f10_pc274:
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
    bnez t0, __skipn_108
    j    .L_f10_pc284
__skipn_108:
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
    bnez t0, __skipn_109
    j    .L_f10_pc284
__skipn_109:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc285
  .L_f10_pc284:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc285:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_110
    j    .L_f10_pc292
__skipn_110:
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
    bnez t0, __skipn_111
    j    .L_f10_pc292
__skipn_111:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc293
  .L_f10_pc292:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc293:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_112
    j    .L_f10_pc296
__skipn_112:
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
  .L_f10_pc296:
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
    bnez t0, __skipn_113
    j    .L_f10_pc306
__skipn_113:
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
    bnez t0, __skipn_114
    j    .L_f10_pc306
__skipn_114:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc307
  .L_f10_pc306:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc307:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_115
    j    .L_f10_pc314
__skipn_115:
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
    bnez t0, __skipn_116
    j    .L_f10_pc314
__skipn_116:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc315
  .L_f10_pc314:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc315:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_117
    j    .L_f10_pc318
__skipn_117:
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
  .L_f10_pc318:
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
    bnez t0, __skipn_118
    j    .L_f10_pc328
__skipn_118:
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
    bnez t0, __skipn_119
    j    .L_f10_pc328
__skipn_119:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc329
  .L_f10_pc328:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc329:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_120
    j    .L_f10_pc336
__skipn_120:
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
    bnez t0, __skipn_121
    j    .L_f10_pc336
__skipn_121:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc337
  .L_f10_pc336:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc337:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_122
    j    .L_f10_pc340
__skipn_122:
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
  .L_f10_pc340:
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
    bnez t0, __skipn_123
    j    .L_f10_pc350
__skipn_123:
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
    bnez t0, __skipn_124
    j    .L_f10_pc350
__skipn_124:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc351
  .L_f10_pc350:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc351:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_125
    j    .L_f10_pc358
__skipn_125:
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
    bnez t0, __skipn_126
    j    .L_f10_pc358
__skipn_126:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc359
  .L_f10_pc358:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc359:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_127
    j    .L_f10_pc362
__skipn_127:
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
  .L_f10_pc362:
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
    bnez t0, __skipn_128
    j    .L_f10_pc372
__skipn_128:
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
    bnez t0, __skipn_129
    j    .L_f10_pc372
__skipn_129:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc373
  .L_f10_pc372:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc373:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_130
    j    .L_f10_pc380
__skipn_130:
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
    bnez t0, __skipn_131
    j    .L_f10_pc380
__skipn_131:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc381
  .L_f10_pc380:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc381:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_132
    j    .L_f10_pc384
__skipn_132:
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
  .L_f10_pc384:
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
    bnez t0, __skipn_133
    j    .L_f10_pc394
__skipn_133:
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
    bnez t0, __skipn_134
    j    .L_f10_pc394
__skipn_134:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc395
  .L_f10_pc394:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc395:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_135
    j    .L_f10_pc402
__skipn_135:
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
    bnez t0, __skipn_136
    j    .L_f10_pc402
__skipn_136:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc403
  .L_f10_pc402:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc403:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_137
    j    .L_f10_pc406
__skipn_137:
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
  .L_f10_pc406:
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
    bnez t0, __skipn_138
    j    .L_f10_pc560
__skipn_138:
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
    bnez t0, __skipn_139
    j    .L_f10_pc420
__skipn_139:
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
    bnez t0, __skipn_140
    j    .L_f10_pc420
__skipn_140:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc421
  .L_f10_pc420:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc421:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_141
    j    .L_f10_pc428
__skipn_141:
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
    bnez t0, __skipn_142
    j    .L_f10_pc428
__skipn_142:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc429
  .L_f10_pc428:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc429:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_143
    j    .L_f10_pc436
__skipn_143:
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
    bnez t0, __skipn_144
    j    .L_f10_pc436
__skipn_144:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc437
  .L_f10_pc436:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc437:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_145
    j    .L_f10_pc440
__skipn_145:
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
  .L_f10_pc440:
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
    bnez t0, __skipn_146
    j    .L_f10_pc450
__skipn_146:
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
    bnez t0, __skipn_147
    j    .L_f10_pc450
__skipn_147:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc451
  .L_f10_pc450:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc451:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_148
    j    .L_f10_pc458
__skipn_148:
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
    bnez t0, __skipn_149
    j    .L_f10_pc458
__skipn_149:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc459
  .L_f10_pc458:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc459:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_150
    j    .L_f10_pc466
__skipn_150:
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
    bnez t0, __skipn_151
    j    .L_f10_pc466
__skipn_151:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc467
  .L_f10_pc466:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc467:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_152
    j    .L_f10_pc470
__skipn_152:
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
  .L_f10_pc470:
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
    bnez t0, __skipn_153
    j    .L_f10_pc480
__skipn_153:
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
    bnez t0, __skipn_154
    j    .L_f10_pc480
__skipn_154:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc481
  .L_f10_pc480:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc481:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_155
    j    .L_f10_pc488
__skipn_155:
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
    bnez t0, __skipn_156
    j    .L_f10_pc488
__skipn_156:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc489
  .L_f10_pc488:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc489:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_157
    j    .L_f10_pc496
__skipn_157:
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
    bnez t0, __skipn_158
    j    .L_f10_pc496
__skipn_158:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc497
  .L_f10_pc496:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc497:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_159
    j    .L_f10_pc500
__skipn_159:
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
  .L_f10_pc500:
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
    bnez t0, __skipn_160
    j    .L_f10_pc510
__skipn_160:
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
    bnez t0, __skipn_161
    j    .L_f10_pc510
__skipn_161:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc511
  .L_f10_pc510:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc511:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_162
    j    .L_f10_pc518
__skipn_162:
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
    bnez t0, __skipn_163
    j    .L_f10_pc518
__skipn_163:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc519
  .L_f10_pc518:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc519:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_164
    j    .L_f10_pc526
__skipn_164:
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
    bnez t0, __skipn_165
    j    .L_f10_pc526
__skipn_165:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc527
  .L_f10_pc526:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc527:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_166
    j    .L_f10_pc530
__skipn_166:
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
  .L_f10_pc530:
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
    bnez t0, __skipn_167
    j    .L_f10_pc540
__skipn_167:
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
    bnez t0, __skipn_168
    j    .L_f10_pc540
__skipn_168:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc541
  .L_f10_pc540:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc541:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_169
    j    .L_f10_pc548
__skipn_169:
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
    bnez t0, __skipn_170
    j    .L_f10_pc548
__skipn_170:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc549
  .L_f10_pc548:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc549:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_171
    j    .L_f10_pc556
__skipn_171:
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
    bnez t0, __skipn_172
    j    .L_f10_pc556
__skipn_172:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc557
  .L_f10_pc556:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc557:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_173
    j    .L_f10_pc560
__skipn_173:
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
  .L_f10_pc560:
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
    bnez t0, __skipn_174
    j    .L_f10_pc602
__skipn_174:
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
    bnez t0, __skipn_175
    j    .L_f10_pc574
__skipn_175:
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
    bnez t0, __skipn_176
    j    .L_f10_pc574
__skipn_176:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc575
  .L_f10_pc574:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc575:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_177
    j    .L_f10_pc582
__skipn_177:
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
    bnez t0, __skipn_178
    j    .L_f10_pc582
__skipn_178:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc583
  .L_f10_pc582:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc583:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_179
    j    .L_f10_pc590
__skipn_179:
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
    bnez t0, __skipn_180
    j    .L_f10_pc590
__skipn_180:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc591
  .L_f10_pc590:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc591:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_181
    j    .L_f10_pc598
__skipn_181:
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
    bnez t0, __skipn_182
    j    .L_f10_pc598
__skipn_182:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc599
  .L_f10_pc598:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc599:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_183
    j    .L_f10_pc602
__skipn_183:
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
  .L_f10_pc602:
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
    bnez t0, __skipn_184
    j    .L_f10_pc628
__skipn_184:
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
    bnez t0, __skipn_185
    j    .L_f10_pc616
__skipn_185:
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
    bnez t0, __skipn_186
    j    .L_f10_pc616
__skipn_186:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc617
  .L_f10_pc616:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc617:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_187
    j    .L_f10_pc624
__skipn_187:
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
    bnez t0, __skipn_188
    j    .L_f10_pc624
__skipn_188:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc625
  .L_f10_pc624:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc625:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_189
    j    .L_f10_pc628
__skipn_189:
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
  .L_f10_pc628:
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
    bnez t0, __skipn_190
    j    .L_f10_pc680
__skipn_190:
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
    bnez t0, __skipn_191
    j    .L_f10_pc642
__skipn_191:
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
    bnez t0, __skipn_192
    j    .L_f10_pc642
__skipn_192:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc643
  .L_f10_pc642:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc643:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_193
    j    .L_f10_pc650
__skipn_193:
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
    bnez t0, __skipn_194
    j    .L_f10_pc650
__skipn_194:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc651
  .L_f10_pc650:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc651:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_195
    j    .L_f10_pc658
__skipn_195:
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
    bnez t0, __skipn_196
    j    .L_f10_pc658
__skipn_196:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc659
  .L_f10_pc658:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc659:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_197
    j    .L_f10_pc666
__skipn_197:
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
    bnez t0, __skipn_198
    j    .L_f10_pc666
__skipn_198:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc667
  .L_f10_pc666:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc667:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_199
    j    .L_f10_pc680
__skipn_199:
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
    bnez t0, __skipn_200
    j    .L_f10_pc680
__skipn_200:
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
  .L_f10_pc680:
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
    bnez t0, __skipn_201
    j    .L_f10_pc738
__skipn_201:
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
    bnez t0, __skipn_202
    j    .L_f10_pc694
__skipn_202:
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
    bnez t0, __skipn_203
    j    .L_f10_pc694
__skipn_203:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc695
  .L_f10_pc694:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc695:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_204
    j    .L_f10_pc702
__skipn_204:
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
    bnez t0, __skipn_205
    j    .L_f10_pc702
__skipn_205:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc703
  .L_f10_pc702:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc703:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_206
    j    .L_f10_pc710
__skipn_206:
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
    bnez t0, __skipn_207
    j    .L_f10_pc710
__skipn_207:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc711
  .L_f10_pc710:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc711:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_208
    j    .L_f10_pc718
__skipn_208:
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
    bnez t0, __skipn_209
    j    .L_f10_pc718
__skipn_209:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc719
  .L_f10_pc718:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc719:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_210
    j    .L_f10_pc738
__skipn_210:
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
    bnez t0, __skipn_211
    j    .L_f10_pc732
__skipn_211:
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
  .L_f10_pc732:
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
    bnez t0, __skipn_212
    j    .L_f10_pc738
__skipn_212:
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
  .L_f10_pc738:
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
    bnez t0, __skipn_213
    j    .L_f10_pc748
__skipn_213:
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
    bnez t0, __skipn_214
    j    .L_f10_pc748
__skipn_214:
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
  .L_f10_pc748:
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
    bnez t0, __skipn_215
    j    .L_f10_pc766
__skipn_215:
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
    bnez t0, __skipn_216
    j    .L_f10_pc762
__skipn_216:
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
    bnez t0, __skipn_217
    j    .L_f10_pc762
__skipn_217:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f10_pc763
  .L_f10_pc762:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f10_pc763:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_218
    j    .L_f10_pc766
__skipn_218:
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
  .L_f10_pc766:
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
    # end of classify_op__U8Array__i32__i32

    .globl fn_name_ss__I32Array__i32
    .type  fn_name_ss__I32Array__i32, @function
fn_name_ss__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_name_ss__I32Array__i32

    .globl fn_name_sl__I32Array__i32
    .type  fn_name_sl__I32Array__i32, @function
fn_name_sl__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_name_sl__I32Array__i32

    .globl fn_param_base__I32Array__i32
    .type  fn_param_base__I32Array__i32, @function
fn_param_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_param_base__I32Array__i32

    .globl fn_nparam__I32Array__i32
    .type  fn_nparam__I32Array__i32, @function
fn_nparam__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_nparam__I32Array__i32

    .globl fn_local_base__I32Array__i32
    .type  fn_local_base__I32Array__i32, @function
fn_local_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_local_base__I32Array__i32

    .globl fn_nlocal__I32Array__i32
    .type  fn_nlocal__I32Array__i32, @function
fn_nlocal__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_nlocal__I32Array__i32

    .globl fn_instr_base__I32Array__i32
    .type  fn_instr_base__I32Array__i32, @function
fn_instr_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_instr_base__I32Array__i32

    .globl fn_ninstr__I32Array__i32
    .type  fn_ninstr__I32Array__i32, @function
fn_ninstr__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of fn_ninstr__I32Array__i32

    .globl fn_set__I32Array__i32__i32__i32
    .type  fn_set__I32Array__i32__i32__i32, @function
fn_set__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
    # end of fn_set__I32Array__i32__i32__i32

    .globl pl_name_ss__I32Array__i32
    .type  pl_name_ss__I32Array__i32, @function
pl_name_ss__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of pl_name_ss__I32Array__i32

    .globl pl_name_sl__I32Array__i32
    .type  pl_name_sl__I32Array__i32, @function
pl_name_sl__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of pl_name_sl__I32Array__i32

    .globl pl_set__I32Array__i32__i32__i32
    .type  pl_set__I32Array__i32__i32__i32, @function
pl_set__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
    # end of pl_set__I32Array__i32__i32__i32

    .globl ins_op__I32Array__i32__i32
    .type  ins_op__I32Array__i32__i32, @function
ins_op__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
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
    # end of ins_op__I32Array__i32__i32

    .globl ins_ival__I32Array__i32__i32
    .type  ins_ival__I32Array__i32__i32, @function
ins_ival__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
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
    # end of ins_ival__I32Array__i32__i32

    .globl ins_ss__I32Array__i32__i32
    .type  ins_ss__I32Array__i32__i32, @function
ins_ss__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
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
    # end of ins_ss__I32Array__i32__i32

    .globl ins_sl__I32Array__i32__i32
    .type  ins_sl__I32Array__i32__i32, @function
ins_sl__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
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
    # end of ins_sl__I32Array__i32__i32

    .globl ins_set__I32Array__i32__i32__i32__i32
    .type  ins_set__I32Array__i32__i32__i32__i32, @function
ins_set__I32Array__i32__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
    # end of ins_set__I32Array__i32__i32__i32__i32

    .globl hm_kind__I32Array__i32
    .type  hm_kind__I32Array__i32, @function
hm_kind__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of hm_kind__I32Array__i32

    .globl hm_base__I32Array__i32
    .type  hm_base__I32Array__i32, @function
hm_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of hm_base__I32Array__i32

    .globl hm_size__I32Array__i32
    .type  hm_size__I32Array__i32, @function
hm_size__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
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
    # end of hm_size__I32Array__i32

    .globl heap_new_u8__I32Array__i32
    .type  heap_new_u8__I32Array__i32, @function
heap_new_u8__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    li   t0, 1
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
    lw   t0, -20(s0)
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
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
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
    lw   t0, -20(s0)
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
    lw   t0, -16(s0)
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
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    la   t1, g_heap_bytes_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
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
    # end of heap_new_u8__I32Array__i32

    .globl heap_new_i32__I32Array__i32
    .type  heap_new_i32__I32Array__i32, @function
heap_new_i32__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    li   t0, 2
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
    lw   t0, -20(s0)
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
    la   t1, g_heap_i32s_top
    lw   t0, 0(t1)
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
    lw   t0, -20(s0)
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
    lw   t0, -16(s0)
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
    la   t1, g_heap_i32s_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    la   t1, g_heap_i32s_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
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
    # end of heap_new_i32__I32Array__i32

    .globl heap_new_str__I32Array__U8Array__U8Array__i32__i32
    .type  heap_new_str__I32Array__U8Array__U8Array__i32__i32, @function
heap_new_str__I32Array__U8Array__U8Array__i32__i32:
    # prologue: frame_size=64, params=5, locals=2, eval_depth=5
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
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
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
    li   t0, 3
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
    lw   t0, -32(s0)
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
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
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
    lw   t0, -32(s0)
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
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_f33_pc31:
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
    bnez t0, __skipn_219
    j    .L_f33_pc51
__skipn_219:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
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
    lw   t0, -36(s0)
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
    j    .L_f33_pc31
  .L_f33_pc51:
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
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
    la   t1, g_heap_bytes_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
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
    # end of heap_new_str__I32Array__U8Array__U8Array__i32__i32

    .globl heap_getu8__I32Array__U8Array__i32__i32
    .type  heap_getu8__I32Array__U8Array__i32__i32, @function
heap_getu8__I32Array__U8Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
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
    # end of heap_getu8__I32Array__U8Array__i32__i32

    .globl heap_setu8__I32Array__U8Array__i32__i32__i32
    .type  heap_setu8__I32Array__U8Array__i32__i32__i32, @function
heap_setu8__I32Array__U8Array__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
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
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    # end of heap_setu8__I32Array__U8Array__i32__i32__i32

    .globl heap_geti32__I32Array__I32Array__i32__i32
    .type  heap_geti32__I32Array__I32Array__i32__i32, @function
heap_geti32__I32Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
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
    # end of heap_geti32__I32Array__I32Array__i32__i32

    .globl heap_seti32__I32Array__I32Array__i32__i32__i32
    .type  heap_seti32__I32Array__I32Array__i32__i32__i32, @function
heap_seti32__I32Array__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
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
    # end of heap_seti32__I32Array__I32Array__i32__i32__i32

    .globl parse_lnum__U8Array__i32__i32
    .type  parse_lnum__U8Array__i32__i32, @function
parse_lnum__U8Array__i32__i32:
    # prologue: frame_size=48, params=3, locals=3, eval_depth=4
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
  .L_f38_pc6:
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
    bnez t0, __skipn_220
    j    .L_f38_pc40
__skipn_220:
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
    bnez t0, __skipn_221
    j    .L_f38_pc24
__skipn_221:
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
    bnez t0, __skipn_222
    j    .L_f38_pc24
__skipn_222:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f38_pc25
  .L_f38_pc24:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f38_pc25:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_223
    j    .L_f38_pc35
__skipn_223:
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
  .L_f38_pc35:
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
    j    .L_f38_pc6
  .L_f38_pc40:
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
    # end of parse_lnum__U8Array__i32__i32

    .globl parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array
    .type  parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array, @function
parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array:
    # prologue: frame_size=384, params=10, locals=39, eval_depth=44
    addi sp, sp, -384
    sw   ra, 380(sp)
    sw   s0, 376(sp)
    addi s0, sp, 384
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
    lw   t0, 4(s0)
    sw   t0, -48(s0)
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
  .L_f39_pc5:
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
    bnez t0, __skipn_224
    j    .L_f39_pc15
__skipn_224:
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
    bnez t0, __skipn_225
    j    .L_f39_pc15
__skipn_225:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc16
  .L_f39_pc15:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc16:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_226
    j    .L_f39_pc1202
__skipn_226:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_227
    j    .L_f39_pc26
__skipn_227:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f39_pc26:
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
    bnez t0, __skipn_228
    j    .L_f39_pc1201
__skipn_228:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    beqz t0, __skip_8
    j    .L_f39_pc43
__skip_8:
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
    beqz t0, __skip_9
    j    .L_f39_pc43
__skip_9:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc44
  .L_f39_pc43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_229
    j    .L_f39_pc49
__skipn_229:
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
  .L_f39_pc49:
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
    bnez t0, __skipn_230
    j    .L_f39_pc59
__skipn_230:
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
    bnez t0, __skipn_231
    j    .L_f39_pc59
__skipn_231:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc60
  .L_f39_pc59:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc60:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_232
    j    .L_f39_pc67
__skipn_232:
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
    bnez t0, __skipn_233
    j    .L_f39_pc67
__skipn_233:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc68
  .L_f39_pc67:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc68:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_234
    j    .L_f39_pc72
__skipn_234:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc72:
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
    bnez t0, __skipn_235
    j    .L_f39_pc82
__skipn_235:
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
    bnez t0, __skipn_236
    j    .L_f39_pc82
__skipn_236:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc83
  .L_f39_pc82:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc83:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_237
    j    .L_f39_pc90
__skipn_237:
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
    bnez t0, __skipn_238
    j    .L_f39_pc90
__skipn_238:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc91
  .L_f39_pc90:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc91:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_239
    j    .L_f39_pc98
__skipn_239:
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
    bnez t0, __skipn_240
    j    .L_f39_pc98
__skipn_240:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc99
  .L_f39_pc98:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc99:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_241
    j    .L_f39_pc738
__skipn_241:
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
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
    bnez t0, __skipn_242
    j    .L_f39_pc123
__skipn_242:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    sw   t0, -72(s0)
  .L_f39_pc123:
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
    bnez t0, __skipn_243
    j    .L_f39_pc133
__skipn_243:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
  .L_f39_pc133:
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
    bnez t0, __skipn_244
    j    .L_f39_pc143
__skipn_244:
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
    bnez t0, __skipn_245
    j    .L_f39_pc143
__skipn_245:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc144
  .L_f39_pc143:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc144:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_246
    j    .L_f39_pc203
__skipn_246:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
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
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
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
    call read_strlit__U8Array__U8Array
    addi sp, sp, 8
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
    lw   t0, -88(s0)
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
    lw   t0, -92(s0)
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
    bnez t0, __skipn_247
    j    .L_f39_pc200
__skipn_247:
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
  .L_f39_pc200:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc203:
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
    bnez t0, __skipn_248
    j    .L_f39_pc213
__skipn_248:
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
    bnez t0, __skipn_249
    j    .L_f39_pc213
__skipn_249:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc214
  .L_f39_pc213:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc214:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_250
    j    .L_f39_pc297
__skipn_250:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nglobals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
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
    lw   t0, -96(s0)
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
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
    lw   t0, -100(s0)
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
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
    lw   t0, -104(s0)
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
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
    lw   t0, -108(s0)
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
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
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
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc297:
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
    bnez t0, __skipn_251
    j    .L_f39_pc307
__skipn_251:
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
    bnez t0, __skipn_252
    j    .L_f39_pc307
__skipn_252:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc308
  .L_f39_pc307:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc308:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_253
    j    .L_f39_pc425
__skipn_253:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc321:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
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
    bnez t0, __skipn_254
    j    .L_f39_pc332
__skipn_254:
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
    bnez t0, __skipn_255
    j    .L_f39_pc332
__skipn_255:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc333
  .L_f39_pc332:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc333:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_256
    j    .L_f39_pc362
__skipn_256:
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f39_pc321
  .L_f39_pc362:
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
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
    sw   t0, -100(s0)
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc425:
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
    bnez t0, __skipn_257
    j    .L_f39_pc435
__skipn_257:
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
    bnez t0, __skipn_258
    j    .L_f39_pc435
__skipn_258:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc436
  .L_f39_pc435:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc436:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_259
    j    .L_f39_pc499
__skipn_259:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
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
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    bnez t0, __skipn_260
    j    .L_f39_pc496
__skipn_260:
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
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc496:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc499:
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
    bnez t0, __skipn_261
    j    .L_f39_pc509
__skipn_261:
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
    bnez t0, __skipn_262
    j    .L_f39_pc509
__skipn_262:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc510
  .L_f39_pc509:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc510:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_263
    j    .L_f39_pc573
__skipn_263:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
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
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
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
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
    bnez t0, __skipn_264
    j    .L_f39_pc570
__skipn_264:
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
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc570:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc573:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
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
    bnez t0, __skipn_265
    j    .L_f39_pc585
__skipn_265:
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
  .L_f39_pc585:
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
    bnez t0, __skipn_266
    j    .L_f39_pc595
__skipn_266:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_267
    j    .L_f39_pc595
__skipn_267:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc596
  .L_f39_pc595:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc596:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_268
    j    .L_f39_pc605
__skipn_268:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f39_pc605:
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
    bnez t0, __skipn_269
    j    .L_f39_pc615
__skipn_269:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_270
    j    .L_f39_pc615
__skipn_270:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc616
  .L_f39_pc615:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc616:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_271
    j    .L_f39_pc688
__skipn_271:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
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
    bnez t0, __skipn_272
    j    .L_f39_pc682
__skipn_272:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -140(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -144(s0)
  .L_f39_pc634:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    bnez t0, __skipn_273
    j    .L_f39_pc682
__skipn_273:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_op__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -148(s0)
    lw   t0, -148(s0)
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
    beqz t0, __skip_10
    j    .L_f39_pc653
__skip_10:
    lw   t0, -148(s0)
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
    beqz t0, __skip_11
    j    .L_f39_pc653
__skip_11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc654
  .L_f39_pc653:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc654:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_12
    j    .L_f39_pc661
__skip_12:
    lw   t0, -148(s0)
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
    beqz t0, __skip_13
    j    .L_f39_pc661
__skip_13:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc662
  .L_f39_pc661:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc662:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_274
    j    .L_f39_pc677
__skipn_274:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ival__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -152(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc677:
    lw   t0, -144(s0)
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
    sw   t0, -144(s0)
    j    .L_f39_pc634
  .L_f39_pc682:
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
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc688:
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
    bnez t0, __skipn_275
    j    .L_f39_pc698
__skipn_275:
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
    bnez t0, __skipn_276
    j    .L_f39_pc698
__skipn_276:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc699
  .L_f39_pc698:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc699:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_277
    j    .L_f39_pc706
__skipn_277:
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
    bnez t0, __skipn_278
    j    .L_f39_pc706
__skipn_278:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc707
  .L_f39_pc706:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc707:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_279
    j    .L_f39_pc714
__skipn_279:
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
    bnez t0, __skipn_280
    j    .L_f39_pc714
__skipn_280:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc715
  .L_f39_pc714:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc715:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_281
    j    .L_f39_pc722
__skipn_281:
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
    bnez t0, __skipn_282
    j    .L_f39_pc722
__skipn_282:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc723
  .L_f39_pc722:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc723:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_283
    j    .L_f39_pc730
__skipn_283:
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
    bnez t0, __skipn_284
    j    .L_f39_pc730
__skipn_284:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc731
  .L_f39_pc730:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc731:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_285
    j    .L_f39_pc738
__skipn_285:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc738:
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
    bnez t0, __skipn_286
    j    .L_f39_pc748
__skipn_286:
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
    bnez t0, __skipn_287
    j    .L_f39_pc748
__skipn_287:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc749
  .L_f39_pc748:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc749:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_288
    j    .L_f39_pc756
__skipn_288:
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
    bnez t0, __skipn_289
    j    .L_f39_pc756
__skipn_289:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc757
  .L_f39_pc756:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc757:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_290
    j    .L_f39_pc764
__skipn_290:
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
    bnez t0, __skipn_291
    j    .L_f39_pc764
__skipn_291:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc765
  .L_f39_pc764:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc765:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_292
    j    .L_f39_pc772
__skipn_292:
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
    bnez t0, __skipn_293
    j    .L_f39_pc772
__skipn_293:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc773
  .L_f39_pc772:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc773:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_294
    j    .L_f39_pc841
__skipn_294:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
  .L_f39_pc776:
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
    bnez t0, __skipn_295
    j    .L_f39_pc787
__skipn_295:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_296
    j    .L_f39_pc787
__skipn_296:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc788
  .L_f39_pc787:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc788:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_297
    j    .L_f39_pc796
__skipn_297:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_298
    j    .L_f39_pc796
__skipn_298:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc797
  .L_f39_pc796:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc797:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_299
    j    .L_f39_pc803
__skipn_299:
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
    j    .L_f39_pc776
  .L_f39_pc803:
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
    bnez t0, __skipn_300
    j    .L_f39_pc814
__skipn_300:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_301
    j    .L_f39_pc814
__skipn_301:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc815
  .L_f39_pc814:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc815:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_302
    j    .L_f39_pc838
__skipn_302:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call parse_lnum__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
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
    bnez t0, __skipn_303
    j    .L_f39_pc838
__skipn_303:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
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
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
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
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc838:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc841:
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
    bnez t0, __skipn_304
    j    .L_f39_pc851
__skipn_304:
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
    bnez t0, __skipn_305
    j    .L_f39_pc851
__skipn_305:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc852
  .L_f39_pc851:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc852:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_306
    j    .L_f39_pc859
__skipn_306:
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
    bnez t0, __skipn_307
    j    .L_f39_pc859
__skipn_307:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc860
  .L_f39_pc859:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc860:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_308
    j    .L_f39_pc867
__skipn_308:
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
    bnez t0, __skipn_309
    j    .L_f39_pc867
__skipn_309:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc868
  .L_f39_pc867:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc868:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_310
    j    .L_f39_pc875
__skipn_310:
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
    bnez t0, __skipn_311
    j    .L_f39_pc875
__skipn_311:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc876
  .L_f39_pc875:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc876:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_312
    j    .L_f39_pc1201
__skipn_312:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -164(s0)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -168(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call classify_op__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -172(s0)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -172(s0)
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
    bnez t0, __skipn_313
    j    .L_f39_pc902
__skipn_313:
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
    bnez t0, __skipn_314
    j    .L_f39_pc902
__skipn_314:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc903
  .L_f39_pc902:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc903:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_315
    j    .L_f39_pc1198
__skipn_315:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -176(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -180(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -172(s0)
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
    bnez t0, __skipn_316
    j    .L_f39_pc964
__skipn_316:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc964:
    lw   t0, -172(s0)
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
    bnez t0, __skipn_317
    j    .L_f39_pc988
__skipn_317:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc988:
    lw   t0, -172(s0)
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
    beqz t0, __skip_14
    j    .L_f39_pc998
__skip_14:
    lw   t0, -172(s0)
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
    beqz t0, __skip_15
    j    .L_f39_pc998
__skip_15:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc999
  .L_f39_pc998:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc999:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_318
    j    .L_f39_pc1021
__skipn_318:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1021:
    lw   t0, -172(s0)
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
    bnez t0, __skipn_319
    j    .L_f39_pc1106
__skipn_319:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1036:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
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
    bnez t0, __skipn_320
    j    .L_f39_pc1047
__skipn_320:
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
    bnez t0, __skipn_321
    j    .L_f39_pc1047
__skipn_321:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc1048
  .L_f39_pc1047:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc1048:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_322
    j    .L_f39_pc1081
__skipn_322:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    lw   t0, -196(s0)
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
    sw   t0, -196(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_f39_pc1036
  .L_f39_pc1081:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
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
    sw   t0, -100(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1106:
    lw   t0, -172(s0)
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
    bnez t0, __skipn_323
    j    .L_f39_pc1131
__skipn_323:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1131:
    lw   t0, -172(s0)
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
    beqz t0, __skip_16
    j    .L_f39_pc1141
__skip_16:
    lw   t0, -172(s0)
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
    beqz t0, __skip_17
    j    .L_f39_pc1141
__skip_17:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc1142
  .L_f39_pc1141:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc1142:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_18
    j    .L_f39_pc1149
__skip_18:
    lw   t0, -172(s0)
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
    beqz t0, __skip_19
    j    .L_f39_pc1149
__skip_19:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc1150
  .L_f39_pc1149:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc1150:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_324
    j    .L_f39_pc1186
__skipn_324:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
  .L_f39_pc1156:
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
    bnez t0, __skipn_325
    j    .L_f39_pc1167
__skipn_325:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_326
    j    .L_f39_pc1167
__skipn_326:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f39_pc1168
  .L_f39_pc1167:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f39_pc1168:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_327
    j    .L_f39_pc1174
__skipn_327:
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
    j    .L_f39_pc1156
  .L_f39_pc1174:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call parse_lnum__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -204(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1186:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
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
  .L_f39_pc1198:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f39_pc1201:
    j    .L_f39_pc5
  .L_f39_pc1202:
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
    # end of parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array

    .globl var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    .type  var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32, @function
var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32:
    # prologue: frame_size=80, params=7, locals=5, eval_depth=5
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
    call fn_param_base__I32Array__i32
    addi sp, sp, 8
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
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
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
    call fn_local_base__I32Array__i32
    addi sp, sp, 8
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
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
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
  .L_f40_pc18:
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
    bnez t0, __skipn_328
    j    .L_f40_pc44
__skipn_328:
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
    call pl_name_ss__I32Array__i32
    addi sp, sp, 8
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
    call pl_name_sl__I32Array__i32
    addi sp, sp, 8
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
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_329
    j    .L_f40_pc39
__skipn_329:
    lw   t0, -56(s0)
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
  .L_f40_pc39:
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
    j    .L_f40_pc18
  .L_f40_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_f40_pc46:
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
    bnez t0, __skipn_330
    j    .L_f40_pc74
__skipn_330:
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
    call pl_name_ss__I32Array__i32
    addi sp, sp, 8
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
    call pl_name_sl__I32Array__i32
    addi sp, sp, 8
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
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_331
    j    .L_f40_pc69
__skipn_331:
    lw   t0, -44(s0)
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
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_f40_pc69:
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
    j    .L_f40_pc46
  .L_f40_pc74:
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
    # end of var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32

    .globl global_find__U8Array__I32Array__i32__i32
    .type  global_find__U8Array__I32Array__i32__i32, @function
global_find__U8Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=1, eval_depth=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
  .L_f41_pc2:
    lw   t0, -28(s0)
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
    bnez t0, __skipn_332
    j    .L_f41_pc32
__skipn_332:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_333
    j    .L_f41_pc27
__skipn_333:
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
  .L_f41_pc27:
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
    j    .L_f41_pc2
  .L_f41_pc32:
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
    # end of global_find__U8Array__I32Array__i32__i32

    .globl func_find__U8Array__I32Array__i32__i32
    .type  func_find__U8Array__I32Array__i32__i32, @function
func_find__U8Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=1, eval_depth=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
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
  .L_f42_pc2:
    lw   t0, -28(s0)
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
    bnez t0, __skipn_334
    j    .L_f42_pc24
__skipn_334:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_name_ss__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_name_sl__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_335
    j    .L_f42_pc19
__skipn_335:
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
  .L_f42_pc19:
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
    j    .L_f42_pc2
  .L_f42_pc24:
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
    # end of func_find__U8Array__I32Array__i32__i32

    .globl stk_push__I32Array__I32Array__i32__i32
    .type  stk_push__I32Array__I32Array__i32__i32, @function
stk_push__I32Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
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
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
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
    la   t1, g_sp
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
    la   t1, g_sp
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
    # end of stk_push__I32Array__I32Array__i32__i32

    .globl stk_pop__I32Array__I32Array
    .type  stk_pop__I32Array__I32Array, @function
stk_pop__I32Array__I32Array:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    la   t1, g_sp
    lw   t0, 0(t1)
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
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
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
    la   t1, g_pop_ival
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
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
    la   t1, g_pop_tag
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
    # end of stk_pop__I32Array__I32Array

    .globl cs_push__I32Array__i32__i32__i32__i32__i32
    .type  cs_push__I32Array__i32__i32__i32__i32__i32, @function
cs_push__I32Array__i32__i32__i32__i32__i32:
    # prologue: frame_size=48, params=6, locals=1, eval_depth=3
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
    sw   zero, -36(s0)
    la   t1, g_csp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
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
    sw   t0, -36(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
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
    lw   t0, -16(s0)
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
    lw   t0, -36(s0)
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
    lw   t0, -36(s0)
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
    lw   t0, -36(s0)
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
    la   t1, g_csp
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
    la   t1, g_csp
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
    # end of cs_push__I32Array__i32__i32__i32__i32__i32

    .globl cs_pop__I32Array
    .type  cs_pop__I32Array, @function
cs_pop__I32Array:
    # prologue: frame_size=32, params=1, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    la   t1, g_csp
    lw   t0, 0(t1)
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
    la   t1, g_csp
    sw   t0, 0(t1)
    la   t1, g_csp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
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
    sw   t0, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    sw   t0, 0(t1)
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
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_pc
    sw   t0, 0(t1)
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
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_fbase
    sw   t0, 0(t1)
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
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_vp
    sw   t0, 0(t1)
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
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_sp
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
    # end of cs_pop__I32Array

    .globl vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array
    .type  vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array, @function
vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array:
    # prologue: frame_size=592, params=21, locals=73, eval_depth=52
    addi sp, sp, -592
    sw   ra, 588(sp)
    sw   s0, 584(sp)
    addi s0, sp, 592
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
    lw   t0, 4(s0)
    sw   t0, -48(s0)
    lw   t0, 8(s0)
    sw   t0, -52(s0)
    lw   t0, 12(s0)
    sw   t0, -56(s0)
    lw   t0, 16(s0)
    sw   t0, -60(s0)
    lw   t0, 20(s0)
    sw   t0, -64(s0)
    lw   t0, 24(s0)
    sw   t0, -68(s0)
    lw   t0, 28(s0)
    sw   t0, -72(s0)
    lw   t0, 32(s0)
    sw   t0, -76(s0)
    lw   t0, 36(s0)
    sw   t0, -80(s0)
    lw   t0, 40(s0)
    sw   t0, -84(s0)
    lw   t0, 44(s0)
    sw   t0, -88(s0)
    lw   t0, 48(s0)
    sw   t0, -92(s0)
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
    sw   zero, -208(s0)
    sw   zero, -212(s0)
    sw   zero, -216(s0)
    sw   zero, -220(s0)
    sw   zero, -224(s0)
    sw   zero, -228(s0)
    sw   zero, -232(s0)
    sw   zero, -236(s0)
    sw   zero, -240(s0)
    sw   zero, -244(s0)
    sw   zero, -248(s0)
    sw   zero, -252(s0)
    sw   zero, -256(s0)
    sw   zero, -260(s0)
    sw   zero, -264(s0)
    sw   zero, -268(s0)
    sw   zero, -272(s0)
    sw   zero, -276(s0)
    sw   zero, -280(s0)
    sw   zero, -284(s0)
    sw   zero, -288(s0)
    sw   zero, -292(s0)
    sw   zero, -296(s0)
    sw   zero, -300(s0)
    sw   zero, -304(s0)
    sw   zero, -308(s0)
    sw   zero, -312(s0)
    sw   zero, -316(s0)
    sw   zero, -320(s0)
    sw   zero, -324(s0)
    sw   zero, -328(s0)
    sw   zero, -332(s0)
    sw   zero, -336(s0)
    sw   zero, -340(s0)
    sw   zero, -344(s0)
    sw   zero, -348(s0)
    sw   zero, -352(s0)
    sw   zero, -356(s0)
    sw   zero, -360(s0)
    sw   zero, -364(s0)
    sw   zero, -368(s0)
    sw   zero, -372(s0)
    sw   zero, -376(s0)
    sw   zero, -380(s0)
    sw   zero, -384(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call func_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -100(s0)
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
    bnez t0, __skipn_336
    j    .L_f47_pc52
__skipn_336:
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
  .L_f47_pc52:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_f47_pc54:
    lw   t0, -104(s0)
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
    bnez t0, __skipn_337
    j    .L_f47_pc83
__skipn_337:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
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
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
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
    li   t0, 0
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
    lw   t0, -104(s0)
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
    sw   t0, -104(s0)
    j    .L_f47_pc54
  .L_f47_pc83:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
  .L_f47_pc97:
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    bnez t0, __skipn_338
    j    .L_f47_pc118
__skipn_338:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    lw   t0, -116(s0)
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
    sw   t0, -116(s0)
    j    .L_f47_pc97
  .L_f47_pc118:
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
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
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 20(sp)
    lw   a1, 16(sp)
    lw   a2, 12(sp)
    lw   a3, 8(sp)
    lw   a4, 4(sp)
    lw   a5, 0(sp)
    call cs_push__I32Array__i32__i32__i32__i32__i32
    addi sp, sp, 24
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_f47_pc140:
    lw   t0, -120(s0)
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
    bnez t0, __skipn_339
    j    .L_f47_pc2092
__skipn_339:
    la   t1, g_cur_func
    lw   t0, 0(t1)
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
    bnez t0, __skipn_340
    j    .L_f47_pc150
__skipn_340:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_f47_pc150:
    lw   t0, -120(s0)
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
    bnez t0, __skipn_341
    j    .L_f47_pc2091
__skipn_341:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -128(s0)
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
    bnez t0, __skipn_342
    j    .L_f47_pc185
__skipn_342:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc185:
    lw   t0, -120(s0)
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
    bnez t0, __skipn_343
    j    .L_f47_pc195
__skipn_343:
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -128(s0)
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
    bnez t0, __skipn_344
    j    .L_f47_pc195
__skipn_344:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc196
  .L_f47_pc195:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc196:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_345
    j    .L_f47_pc2091
__skipn_345:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_op__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ival__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ss__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -140(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_sl__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -144(s0)
    la   t1, g_cur_pc
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
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    lw   t0, -132(s0)
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
    bnez t0, __skipn_346
    j    .L_f47_pc231
__skipn_346:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc231:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_347
    j    .L_f47_pc262
__skipn_347:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -148(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -152(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_new_str__I32Array__U8Array__U8Array__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc262:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_348
    j    .L_f47_pc335
__skipn_348:
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
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    call var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 28
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
    lw   t0, -156(s0)
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
    bnez t0, __skipn_349
    j    .L_f47_pc293
__skipn_349:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
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
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
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
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc293:
    lw   t0, -156(s0)
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
    bnez t0, __skipn_350
    j    .L_f47_pc335
__skipn_350:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call global_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
    lw   t0, -160(s0)
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
    bnez t0, __skipn_351
    j    .L_f47_pc325
__skipn_351:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc325:
    lw   t0, -160(s0)
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
    bnez t0, __skipn_352
    j    .L_f47_pc335
__skipn_352:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc335:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_353
    j    .L_f47_pc406
__skipn_353:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -164(s0)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -168(s0)
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
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    call var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 28
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
    lw   t0, -156(s0)
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
    bnez t0, __skipn_354
    j    .L_f47_pc374
__skipn_354:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
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
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -168(s0)
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
  .L_f47_pc374:
    lw   t0, -156(s0)
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
    bnez t0, __skipn_355
    j    .L_f47_pc406
__skipn_355:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call global_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
    lw   t0, -160(s0)
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
    bnez t0, __skipn_356
    j    .L_f47_pc406
__skipn_356:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
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
    lw   t0, -164(s0)
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
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
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
    lw   t0, -168(s0)
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
  .L_f47_pc406:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_357
    j    .L_f47_pc1625
__skipn_357:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -172(s0)
    lw   t0, -172(s0)
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
    sw   t0, -176(s0)
  .L_f47_pc416:
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
    bnez t0, __skipn_358
    j    .L_f47_pc439
__skipn_358:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
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
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
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
    lw   t0, -176(s0)
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
    sw   t0, -176(s0)
    j    .L_f47_pc416
  .L_f47_pc439:
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -180(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -208(s0)
    lw   t0, -144(s0)
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
    bnez t0, __skipn_359
    j    .L_f47_pc463
__skipn_359:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    sw   t0, -184(s0)
  .L_f47_pc463:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_360
    j    .L_f47_pc473
__skipn_360:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
  .L_f47_pc473:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_361
    j    .L_f47_pc483
__skipn_361:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
  .L_f47_pc483:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_362
    j    .L_f47_pc493
__skipn_362:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
  .L_f47_pc493:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_363
    j    .L_f47_pc503
__skipn_363:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
  .L_f47_pc503:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
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
    bnez t0, __skipn_364
    j    .L_f47_pc513
__skipn_364:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
  .L_f47_pc513:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
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
    bnez t0, __skipn_365
    j    .L_f47_pc523
__skipn_365:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -208(s0)
  .L_f47_pc523:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
    lw   t0, -220(s0)
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
    bnez t0, __skipn_366
    j    .L_f47_pc539
__skipn_366:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_367
    j    .L_f47_pc539
__skipn_367:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc540
  .L_f47_pc539:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc540:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_368
    j    .L_f47_pc547
__skipn_368:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_369
    j    .L_f47_pc547
__skipn_369:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc548
  .L_f47_pc547:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc548:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_370
    j    .L_f47_pc555
__skipn_370:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_371
    j    .L_f47_pc555
__skipn_371:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc556
  .L_f47_pc555:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc556:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_372
    j    .L_f47_pc563
__skipn_372:
    lw   t0, -196(s0)
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
    bnez t0, __skipn_373
    j    .L_f47_pc563
__skipn_373:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc564
  .L_f47_pc563:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc564:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_374
    j    .L_f47_pc776
__skipn_374:
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 119
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_375
    j    .L_f47_pc626
__skipn_375:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -224(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    sw   t0, -232(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    bnez t0, __skipn_376
    j    .L_f47_pc595
__skipn_376:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -232(s0)
  .L_f47_pc595:
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -244(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc600:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -232(s0)
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
    bnez t0, __skipn_377
    j    .L_f47_pc618
__skipn_377:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc600
  .L_f47_pc618:
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc626:
    lw   t0, -200(s0)
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
    bnez t0, __skipn_378
    j    .L_f47_pc765
__skipn_378:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -224(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    sw   t0, -252(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    bnez t0, __skipn_379
    j    .L_f47_pc656
__skipn_379:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_f47_pc656:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
    lw   t0, -224(s0)
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
    bnez t0, __skipn_380
    j    .L_f47_pc668
__skipn_380:
    lw   t0, -256(s0)
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
    bnez t0, __skipn_381
    j    .L_f47_pc668
__skipn_381:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc669
  .L_f47_pc668:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc669:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_382
    j    .L_f47_pc714
__skipn_382:
    la   t1, g_prog_stdin_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
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
    sw   t0, -260(s0)
    lw   t0, -260(s0)
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
    bnez t0, __skipn_383
    j    .L_f47_pc712
__skipn_383:
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -260(s0)
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
    bnez t0, __skipn_384
    j    .L_f47_pc684
__skipn_384:
    lw   t0, -260(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_f47_pc684:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc686:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
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
    bnez t0, __skipn_385
    j    .L_f47_pc706
__skipn_385:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc686
  .L_f47_pc706:
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
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
    la   t1, g_prog_stdin_pos
    sw   t0, 0(t1)
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_f47_pc712:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
  .L_f47_pc714:
    lw   t0, -224(s0)
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
    bnez t0, __skipn_386
    j    .L_f47_pc724
__skipn_386:
    lw   t0, -256(s0)
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
    bnez t0, __skipn_387
    j    .L_f47_pc724
__skipn_387:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc725
  .L_f47_pc724:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc725:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_388
    j    .L_f47_pc765
__skipn_388:
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -244(s0)
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
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
    sw   t0, -264(s0)
    lw   t0, -264(s0)
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
    bnez t0, __skipn_389
    j    .L_f47_pc758
__skipn_389:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc740:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
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
    bnez t0, __skipn_390
    j    .L_f47_pc758
__skipn_390:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc740
  .L_f47_pc758:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
  .L_f47_pc765:
    lw   t0, -200(s0)
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
    bnez t0, __skipn_391
    j    .L_f47_pc774
__skipn_391:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call sys_exit__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc774:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc776:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_392
    j    .L_f47_pc786
__skipn_392:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_393
    j    .L_f47_pc786
__skipn_393:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc787
  .L_f47_pc786:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc787:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_394
    j    .L_f47_pc794
__skipn_394:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_395
    j    .L_f47_pc794
__skipn_395:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc795
  .L_f47_pc794:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc795:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_396
    j    .L_f47_pc802
__skipn_396:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_397
    j    .L_f47_pc802
__skipn_397:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc803
  .L_f47_pc802:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc803:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_398
    j    .L_f47_pc892
__skipn_398:
    lw   t0, -208(s0)
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
    bnez t0, __skipn_399
    j    .L_f47_pc813
__skipn_399:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call print_i32__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc813:
    lw   t0, -208(s0)
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
    bnez t0, __skipn_400
    j    .L_f47_pc823
__skipn_400:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call print_u32__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc823:
    lw   t0, -208(s0)
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
    bnez t0, __skipn_401
    j    .L_f47_pc834
__skipn_401:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    lw   a0, 0(sp)
    call print_bool__bool
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc834:
    lw   t0, -208(s0)
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
    bnez t0, __skipn_402
    j    .L_f47_pc890
__skipn_402:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -228(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -240(s0)
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
    sw   t0, -244(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc857:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    bnez t0, __skipn_403
    j    .L_f47_pc875
__skipn_403:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc857
  .L_f47_pc875:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
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
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc890:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc892:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_404
    j    .L_f47_pc902
__skipn_404:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_405
    j    .L_f47_pc902
__skipn_405:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc903
  .L_f47_pc902:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc903:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_406
    j    .L_f47_pc910
__skipn_406:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_407
    j    .L_f47_pc910
__skipn_407:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc911
  .L_f47_pc910:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc911:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_408
    j    .L_f47_pc918
__skipn_408:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
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
    bnez t0, __skipn_409
    j    .L_f47_pc918
__skipn_409:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc919
  .L_f47_pc918:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc919:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_410
    j    .L_f47_pc946
__skipn_410:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -268(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 73
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_411
    j    .L_f47_pc934
__skipn_411:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -268(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_i32__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_f47_pc934:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 73
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
    bnez t0, __skipn_412
    j    .L_f47_pc944
__skipn_412:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -268(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_f47_pc944:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc946:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_413
    j    .L_f47_pc972
__skipn_413:
    lw   t0, -144(s0)
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
    beqz t0, __skip_20
    j    .L_f47_pc968
__skip_20:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_414
    j    .L_f47_pc964
__skipn_414:
    lw   t0, -196(s0)
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
    bnez t0, __skipn_415
    j    .L_f47_pc964
__skipn_415:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc965
  .L_f47_pc964:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc965:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_21
    j    .L_f47_pc968
__skip_21:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc969
  .L_f47_pc968:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc969:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_416
    j    .L_f47_pc972
__skipn_416:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc973
  .L_f47_pc972:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc973:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_417
    j    .L_f47_pc980
__skipn_417:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_418
    j    .L_f47_pc980
__skipn_418:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc981
  .L_f47_pc980:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc981:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_419
    j    .L_f47_pc988
__skipn_419:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_420
    j    .L_f47_pc988
__skipn_420:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc989
  .L_f47_pc988:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc989:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_421
    j    .L_f47_pc996
__skipn_421:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_422
    j    .L_f47_pc996
__skipn_422:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc997
  .L_f47_pc996:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc997:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_423
    j    .L_f47_pc1032
__skipn_423:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -272(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
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
    bnez t0, __skipn_424
    j    .L_f47_pc1018
__skipn_424:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call heap_geti32__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_f47_pc1018:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
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
    bnez t0, __skipn_425
    j    .L_f47_pc1030
__skipn_425:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call heap_getu8__I32Array__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_f47_pc1030:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1032:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_426
    j    .L_f47_pc1058
__skipn_426:
    lw   t0, -144(s0)
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
    beqz t0, __skip_22
    j    .L_f47_pc1054
__skip_22:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_427
    j    .L_f47_pc1050
__skipn_427:
    lw   t0, -196(s0)
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
    bnez t0, __skipn_428
    j    .L_f47_pc1050
__skipn_428:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1051
  .L_f47_pc1050:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1051:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_23
    j    .L_f47_pc1054
__skip_23:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1055
  .L_f47_pc1054:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1055:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_429
    j    .L_f47_pc1058
__skipn_429:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1059
  .L_f47_pc1058:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1059:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_430
    j    .L_f47_pc1066
__skipn_430:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_431
    j    .L_f47_pc1066
__skipn_431:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1067
  .L_f47_pc1066:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1067:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_432
    j    .L_f47_pc1074
__skipn_432:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_433
    j    .L_f47_pc1074
__skipn_433:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1075
  .L_f47_pc1074:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1075:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_434
    j    .L_f47_pc1082
__skipn_434:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_435
    j    .L_f47_pc1082
__skipn_435:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1083
  .L_f47_pc1082:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1083:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_436
    j    .L_f47_pc1124
__skipn_436:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -272(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
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
    sw   t0, -276(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
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
    bnez t0, __skipn_437
    j    .L_f47_pc1109
__skipn_437:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -276(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_seti32__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1109:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
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
    bnez t0, __skipn_438
    j    .L_f47_pc1122
__skipn_438:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -276(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_setu8__I32Array__U8Array__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1122:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1124:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_439
    j    .L_f47_pc1150
__skipn_439:
    lw   t0, -144(s0)
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
    beqz t0, __skip_24
    j    .L_f47_pc1146
__skip_24:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_440
    j    .L_f47_pc1142
__skipn_440:
    lw   t0, -196(s0)
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
    bnez t0, __skipn_441
    j    .L_f47_pc1142
__skipn_441:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1143
  .L_f47_pc1142:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1143:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, __skip_25
    j    .L_f47_pc1146
__skip_25:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1147
  .L_f47_pc1146:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1147:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_442
    j    .L_f47_pc1150
__skipn_442:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1151
  .L_f47_pc1150:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1151:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_443
    j    .L_f47_pc1158
__skipn_443:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_444
    j    .L_f47_pc1158
__skipn_444:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1159
  .L_f47_pc1158:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1159:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_445
    j    .L_f47_pc1166
__skipn_445:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_446
    j    .L_f47_pc1166
__skipn_446:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1167
  .L_f47_pc1166:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1167:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_447
    j    .L_f47_pc1174
__skipn_447:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_448
    j    .L_f47_pc1174
__skipn_448:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1175
  .L_f47_pc1174:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1175:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_449
    j    .L_f47_pc1184
__skipn_449:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1184:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_450
    j    .L_f47_pc1194
__skipn_450:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_451
    j    .L_f47_pc1194
__skipn_451:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1195
  .L_f47_pc1194:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1195:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_452
    j    .L_f47_pc1202
__skipn_452:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_453
    j    .L_f47_pc1202
__skipn_453:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1203
  .L_f47_pc1202:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1203:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_454
    j    .L_f47_pc1210
__skipn_454:
    lw   t0, -192(s0)
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
    bnez t0, __skipn_455
    j    .L_f47_pc1210
__skipn_455:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1211
  .L_f47_pc1210:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1211:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_456
    j    .L_f47_pc1214
__skipn_456:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1214:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_457
    j    .L_f47_pc1224
__skipn_457:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_458
    j    .L_f47_pc1224
__skipn_458:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1225
  .L_f47_pc1224:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1225:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_459
    j    .L_f47_pc1232
__skipn_459:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_460
    j    .L_f47_pc1232
__skipn_460:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1233
  .L_f47_pc1232:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1233:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_461
    j    .L_f47_pc1378
__skipn_461:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -280(s0)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -284(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -288(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -292(s0)
    lw   t0, -284(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
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
    bnez t0, __skipn_462
    j    .L_f47_pc1304
__skipn_462:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -296(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -300(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc1270:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    bnez t0, __skipn_463
    j    .L_f47_pc1290
__skipn_463:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -288(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc1270
  .L_f47_pc1290:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_f47_pc1304:
    lw   t0, -284(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_REF
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
    bnez t0, __skipn_464
    j    .L_f47_pc1376
__skipn_464:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -304(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -308(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -308(s0)
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
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -296(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -300(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc1328:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    bnez t0, __skipn_465
    j    .L_f47_pc1348
__skipn_465:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -288(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc1328
  .L_f47_pc1348:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_f47_pc1350:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -308(s0)
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
    bnez t0, __skipn_466
    j    .L_f47_pc1372
__skipn_466:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -304(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_f47_pc1350
  .L_f47_pc1372:
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_f47_pc1376:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1378:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_467
    j    .L_f47_pc1388
__skipn_467:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_468
    j    .L_f47_pc1388
__skipn_468:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1389
  .L_f47_pc1388:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1389:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_469
    j    .L_f47_pc1396
__skipn_469:
    lw   t0, -188(s0)
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
    bnez t0, __skipn_470
    j    .L_f47_pc1396
__skipn_470:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1397
  .L_f47_pc1396:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1397:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_471
    j    .L_f47_pc1471
__skipn_471:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    sw   t0, -312(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    sw   t0, -316(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -312(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -320(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -312(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -324(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -316(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -316(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -332(s0)
    lw   t0, -324(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -332(s0)
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
    bnez t0, __skipn_472
    j    .L_f47_pc1428
__skipn_472:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_f47_pc1428:
    lw   t0, -324(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -332(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_473
    j    .L_f47_pc1469
__skipn_473:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -336(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -340(s0)
  .L_f47_pc1436:
    lw   t0, -340(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -324(s0)
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
    bnez t0, __skipn_474
    j    .L_f47_pc1446
__skipn_474:
    lw   t0, -336(s0)
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
    bnez t0, __skipn_475
    j    .L_f47_pc1446
__skipn_475:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1447
  .L_f47_pc1446:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1447:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_476
    j    .L_f47_pc1467
__skipn_476:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -320(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -340(s0)
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
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -340(s0)
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
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_477
    j    .L_f47_pc1462
__skipn_477:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -336(s0)
  .L_f47_pc1462:
    lw   t0, -340(s0)
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
    sw   t0, -340(s0)
    j    .L_f47_pc1436
  .L_f47_pc1467:
    lw   t0, -336(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_f47_pc1469:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1471:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_478
    j    .L_f47_pc1481
__skipn_478:
    lw   t0, -184(s0)
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
    bnez t0, __skipn_479
    j    .L_f47_pc1481
__skipn_479:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1482
  .L_f47_pc1481:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1482:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_480
    j    .L_f47_pc1497
__skipn_480:
    lw   t0, -188(s0)
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
    beqz t0, __skip_26
    j    .L_f47_pc1493
__skip_26:
    lw   t0, -188(s0)
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
    beqz t0, __skip_27
    j    .L_f47_pc1493
__skip_27:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1494
  .L_f47_pc1493:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1494:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_481
    j    .L_f47_pc1497
__skipn_481:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1498
  .L_f47_pc1497:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1498:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_482
    j    .L_f47_pc1503
__skipn_482:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_f47_pc1503:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_483
    j    .L_f47_pc1513
__skipn_483:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -212(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -216(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1513:
    lw   t0, -220(s0)
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
    bnez t0, __skipn_484
    j    .L_f47_pc1625
__skipn_484:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call func_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -344(s0)
    lw   t0, -344(s0)
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
    bnez t0, __skipn_485
    j    .L_f47_pc1533
__skipn_485:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1533:
    lw   t0, -344(s0)
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
    bnez t0, __skipn_486
    j    .L_f47_pc1625
__skipn_486:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 20(sp)
    lw   a1, 16(sp)
    lw   a2, 12(sp)
    lw   a3, 8(sp)
    lw   a4, 4(sp)
    lw   a5, 0(sp)
    call cs_push__I32Array__i32__i32__i32__i32__i32
    addi sp, sp, 24
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -348(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -352(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -356(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -360(s0)
  .L_f47_pc1557:
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
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
    bnez t0, __skipn_487
    j    .L_f47_pc1584
__skipn_487:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -360(s0)
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
    sw   t0, -360(s0)
    j    .L_f47_pc1557
  .L_f47_pc1584:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -364(s0)
  .L_f47_pc1586:
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -356(s0)
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
    bnez t0, __skipn_488
    j    .L_f47_pc1613
__skipn_488:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    lw   t0, -364(s0)
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
    sw   t0, -364(s0)
    j    .L_f47_pc1586
  .L_f47_pc1613:
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -356(s0)
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
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_f47_pc1625:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_489
    j    .L_f47_pc1656
__skipn_489:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -368(s0)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -372(s0)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -368(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -372(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1656:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_490
    j    .L_f47_pc1679
__skipn_490:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1679:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_491
    j    .L_f47_pc1687
__skipn_491:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1687:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_ADD
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
    bnez t0, __skipn_492
    j    .L_f47_pc1697
__skipn_492:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR
    lw   t0, 0(t1)
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
    bnez t0, __skipn_493
    j    .L_f47_pc1697
__skipn_493:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1698
  .L_f47_pc1697:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1698:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_494
    j    .L_f47_pc1799
__skipn_494:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    lw   t0, -132(s0)
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
    bnez t0, __skipn_495
    j    .L_f47_pc1721
__skipn_495:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_f47_pc1721:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_496
    j    .L_f47_pc1729
__skipn_496:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_f47_pc1729:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_497
    j    .L_f47_pc1737
__skipn_497:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_f47_pc1737:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_498
    j    .L_f47_pc1745
__skipn_498:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_f47_pc1745:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_499
    j    .L_f47_pc1753
__skipn_499:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_f47_pc1753:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_500
    j    .L_f47_pc1761
__skipn_500:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1761:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_501
    j    .L_f47_pc1769
__skipn_501:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    or   t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1769:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_502
    j    .L_f47_pc1777
__skipn_502:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1777:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_503
    j    .L_f47_pc1785
__skipn_503:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1785:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_504
    j    .L_f47_pc1793
__skipn_504:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1793:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1799:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_EQ
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
    bnez t0, __skipn_505
    j    .L_f47_pc1809
__skipn_505:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE
    lw   t0, 0(t1)
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
    bnez t0, __skipn_506
    j    .L_f47_pc1809
__skipn_506:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1810
  .L_f47_pc1809:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1810:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_507
    j    .L_f47_pc1891
__skipn_507:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    lw   t0, -132(s0)
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
    bnez t0, __skipn_508
    j    .L_f47_pc1835
__skipn_508:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_509
    j    .L_f47_pc1835
__skipn_509:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1835:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_510
    j    .L_f47_pc1845
__skipn_510:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    bnez t0, __skipn_511
    j    .L_f47_pc1845
__skipn_511:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1845:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_512
    j    .L_f47_pc1855
__skipn_512:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    bnez t0, __skipn_513
    j    .L_f47_pc1855
__skipn_513:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1855:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_514
    j    .L_f47_pc1865
__skipn_514:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    bnez t0, __skipn_515
    j    .L_f47_pc1865
__skipn_515:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1865:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_516
    j    .L_f47_pc1875
__skipn_516:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    bnez t0, __skipn_517
    j    .L_f47_pc1875
__skipn_517:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1875:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_518
    j    .L_f47_pc1885
__skipn_518:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    bnez t0, __skipn_519
    j    .L_f47_pc1885
__skipn_519:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1885:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1891:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_520
    j    .L_f47_pc1907
__skipn_520:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1907:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_521
    j    .L_f47_pc1929
__skipn_521:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
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
    bnez t0, __skipn_522
    j    .L_f47_pc1923
__skipn_522:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_f47_pc1923:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc1929:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_523
    j    .L_f47_pc2057
__skipn_523:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -380(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -384(s0)
    lw   t0, -144(s0)
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
    bnez t0, __skipn_524
    j    .L_f47_pc1951
__skipn_524:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    sw   t0, -380(s0)
  .L_f47_pc1951:
    lw   t0, -144(s0)
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
    bnez t0, __skipn_525
    j    .L_f47_pc1961
__skipn_525:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -384(s0)
  .L_f47_pc1961:
    lw   t0, -380(s0)
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
    bnez t0, __skipn_526
    j    .L_f47_pc1971
__skipn_526:
    lw   t0, -384(s0)
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
    bnez t0, __skipn_527
    j    .L_f47_pc1971
__skipn_527:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1972
  .L_f47_pc1971:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1972:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_528
    j    .L_f47_pc1977
__skipn_528:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_f47_pc1977:
    lw   t0, -380(s0)
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
    bnez t0, __skipn_529
    j    .L_f47_pc1987
__skipn_529:
    lw   t0, -384(s0)
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
    bnez t0, __skipn_530
    j    .L_f47_pc1987
__skipn_530:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc1988
  .L_f47_pc1987:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc1988:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_531
    j    .L_f47_pc1993
__skipn_531:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65535
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_f47_pc1993:
    lw   t0, -380(s0)
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
    bnez t0, __skipn_532
    j    .L_f47_pc2003
__skipn_532:
    lw   t0, -384(s0)
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
    bnez t0, __skipn_533
    j    .L_f47_pc2003
__skipn_533:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc2004
  .L_f47_pc2003:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc2004:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_534
    j    .L_f47_pc2017
__skipn_534:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 128
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
    bnez t0, __skipn_535
    j    .L_f47_pc2017
__skipn_535:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 256
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
    sw   t0, -376(s0)
  .L_f47_pc2017:
    lw   t0, -380(s0)
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
    bnez t0, __skipn_536
    j    .L_f47_pc2027
__skipn_536:
    lw   t0, -384(s0)
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
    bnez t0, __skipn_537
    j    .L_f47_pc2027
__skipn_537:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f47_pc2028
  .L_f47_pc2027:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f47_pc2028:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_538
    j    .L_f47_pc2041
__skipn_538:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65535
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32768
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
    bnez t0, __skipn_539
    j    .L_f47_pc2041
__skipn_539:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65536
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
    sw   t0, -376(s0)
  .L_f47_pc2041:
    lw   t0, -380(s0)
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
    bnez t0, __skipn_540
    j    .L_f47_pc2051
__skipn_540:
    lw   t0, -376(s0)
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
    bnez t0, __skipn_541
    j    .L_f47_pc2051
__skipn_541:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_f47_pc2051:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_f47_pc2057:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_542
    j    .L_f47_pc2063
__skipn_542:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_f47_pc2063:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_543
    j    .L_f47_pc2077
__skipn_543:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
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
    bnez t0, __skipn_544
    j    .L_f47_pc2077
__skipn_544:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_f47_pc2077:
    lw   t0, -132(s0)
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
    bnez t0, __skipn_545
    j    .L_f47_pc2091
__skipn_545:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
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
    bnez t0, __skipn_546
    j    .L_f47_pc2091
__skipn_546:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_f47_pc2091:
    j    .L_f47_pc140
  .L_f47_pc2092:
    la   t1, g_sp
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
    bnez t0, __skipn_547
    j    .L_f47_pc2102
__skipn_547:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
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
  .L_f47_pc2102:
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
    # end of vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array

    .globl main
    .type  main, @function
main:
    # prologue: frame_size=224, params=0, locals=30, eval_depth=22
    addi sp, sp, -224
    sw   ra, 220(sp)
    sw   s0, 216(sp)
    addi s0, sp, 224
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
    li   t0, 524288
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -12(s0)
    li   t0, 262144
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
    li   t0, 2048
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 256
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 2560
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    li   t0, 262144
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    li   t0, 16384
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    li   t0, 2048
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
    li   t0, 524288
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    li   t0, 131072
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    li   t0, 8192
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    li   t0, 8192
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    li   t0, 512
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    li   t0, 512
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    li   t0, 2560
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
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
    sw   t0, -92(s0)
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
    sw   t0, -96(s0)
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
    call U8Array__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_f48_pc73:
    lw   t0, -104(s0)
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
    bnez t0, __skipn_548
    j    .L_f48_pc83
__skipn_548:
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
    bnez t0, __skipn_549
    j    .L_f48_pc83
__skipn_549:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_f48_pc84
  .L_f48_pc83:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_f48_pc84:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, __skipn_550
    j    .L_f48_pc125
__skipn_550:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65536
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
    sw   t0, -108(s0)
    lw   t0, -108(s0)
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
    bnez t0, __skipn_551
    j    .L_f48_pc96
__skipn_551:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_f48_pc96:
    lw   t0, -108(s0)
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
    bnez t0, __skipn_552
    j    .L_f48_pc124
__skipn_552:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
  .L_f48_pc102:
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
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
    bnez t0, __skipn_553
    j    .L_f48_pc120
__skipn_553:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
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
    lw   t0, -112(s0)
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
    sw   t0, -112(s0)
    j    .L_f48_pc102
  .L_f48_pc120:
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
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
  .L_f48_pc124:
    j    .L_f48_pc73
  .L_f48_pc125:
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
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
    bnez t0, __skipn_554
    j    .L_f48_pc134
__skipn_554:
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
  .L_f48_pc134:
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
    addi sp, sp, -8
    lw   t0, 12(sp)
    sw   t0, 0(sp)
    lw   t0, 8(sp)
    sw   t0, 4(sp)
    lw   a0, 44(sp)
    lw   a1, 40(sp)
    lw   a2, 36(sp)
    lw   a3, 32(sp)
    lw   a4, 28(sp)
    lw   a5, 24(sp)
    lw   a6, 20(sp)
    lw   a7, 16(sp)
    call parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array
    addi sp, sp, 48
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    sw   t0, -116(s0)
    lw   t0, -116(s0)
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
    sw   t0, -120(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
  .L_f48_pc157:
    lw   t0, -124(s0)
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
    bnez t0, __skipn_555
    j    .L_f48_pc175
__skipn_555:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
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
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -124(s0)
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
    sw   t0, -124(s0)
    j    .L_f48_pc157
  .L_f48_pc175:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_prog_stdin_pos
    sw   t0, 0(t1)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_prog_stdin_len
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
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
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -52
    lw   t0, 100(sp)
    sw   t0, 0(sp)
    lw   t0, 96(sp)
    sw   t0, 4(sp)
    lw   t0, 92(sp)
    sw   t0, 8(sp)
    lw   t0, 88(sp)
    sw   t0, 12(sp)
    lw   t0, 84(sp)
    sw   t0, 16(sp)
    lw   t0, 80(sp)
    sw   t0, 20(sp)
    lw   t0, 76(sp)
    sw   t0, 24(sp)
    lw   t0, 72(sp)
    sw   t0, 28(sp)
    lw   t0, 68(sp)
    sw   t0, 32(sp)
    lw   t0, 64(sp)
    sw   t0, 36(sp)
    lw   t0, 60(sp)
    sw   t0, 40(sp)
    lw   t0, 56(sp)
    sw   t0, 44(sp)
    lw   t0, 52(sp)
    sw   t0, 48(sp)
    lw   a0, 132(sp)
    lw   a1, 128(sp)
    lw   a2, 124(sp)
    lw   a3, 120(sp)
    lw   a4, 116(sp)
    lw   a5, 112(sp)
    lw   a6, 108(sp)
    lw   a7, 104(sp)
    call vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array
    addi sp, sp, 136
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -128(s0)
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

