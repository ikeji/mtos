    .text
    .align 2

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
    bnez t0, 0f
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc6
0:
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
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc6:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc8:
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
    bnez t0, 0f
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc31
0:
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
    bnez t0, 0f
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc26
0:
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
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc26:
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
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc8
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc31:
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
    bnez t0, 0f
    j    .L_in_cur__U8Array_pc6
0:
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
  .L_in_cur__U8Array_pc6:
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
    beqz t0, 0f
    j    .L_is_ws__u8_pc10
0:
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
    beqz t0, 0f
    j    .L_is_ws__u8_pc10
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc11
  .L_is_ws__u8_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc18
0:
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
    beqz t0, 0f
    j    .L_is_ws__u8_pc18
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc19
  .L_is_ws__u8_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc26
0:
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
    beqz t0, 0f
    j    .L_is_ws__u8_pc26
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc27
  .L_is_ws__u8_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc27:
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
  .L_skip_spaces__U8Array_pc0:
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
    bnez t0, 0f
    j    .L_skip_spaces__U8Array_pc20
0:
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
    beqz t0, 0f
    j    .L_skip_spaces__U8Array_pc16
0:
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
    beqz t0, 0f
    j    .L_skip_spaces__U8Array_pc16
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_spaces__U8Array_pc17
  .L_skip_spaces__U8Array_pc16:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_spaces__U8Array_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_spaces__U8Array_pc20
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_spaces__U8Array_pc21
  .L_skip_spaces__U8Array_pc20:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_spaces__U8Array_pc21:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_spaces__U8Array_pc27
0:
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
    j    .L_skip_spaces__U8Array_pc0
  .L_skip_spaces__U8Array_pc27:
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
  .L_skip_line__U8Array_pc0:
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
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc11
0:
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
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc11
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_line__U8Array_pc12
  .L_skip_line__U8Array_pc11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_line__U8Array_pc12:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc18
0:
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
    j    .L_skip_line__U8Array_pc0
  .L_skip_line__U8Array_pc18:
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
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc26
0:
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
  .L_skip_line__U8Array_pc26:
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
  .L_next_tok__U8Array__U8Array_pc5:
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
    bnez t0, 0f
    j    .L_next_tok__U8Array__U8Array_pc16
0:
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
    bnez t0, 0f
    j    .L_next_tok__U8Array__U8Array_pc16
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_next_tok__U8Array__U8Array_pc17
  .L_next_tok__U8Array__U8Array_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_next_tok__U8Array__U8Array_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_next_tok__U8Array__U8Array_pc33
0:
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
    j    .L_next_tok__U8Array__U8Array_pc5
  .L_next_tok__U8Array__U8Array_pc33:
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
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc16
0:
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
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc16
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_int_from_stab__U8Array__i32__i32_pc17
  .L_int_from_stab__U8Array__i32__i32_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_int_from_stab__U8Array__i32__i32_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc22
0:
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
  .L_int_from_stab__U8Array__i32__i32_pc22:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_int_from_stab__U8Array__i32__i32_pc24:
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
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc60
0:
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
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc44
0:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc44
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_int_from_stab__U8Array__i32__i32_pc45
  .L_int_from_stab__U8Array__i32__i32_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_int_from_stab__U8Array__i32__i32_pc45:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc55
0:
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
  .L_int_from_stab__U8Array__i32__i32_pc55:
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
    j    .L_int_from_stab__U8Array__i32__i32_pc24
  .L_int_from_stab__U8Array__i32__i32_pc60:
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
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc68
0:
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
  .L_int_from_stab__U8Array__i32__i32_pc68:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc13
0:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc13
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc14
  .L_read_strlit__U8Array__U8Array_pc13:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc14:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc19
0:
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
  .L_read_strlit__U8Array__U8Array_pc19:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_read_strlit__U8Array__U8Array_pc21:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc31
0:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc31
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc32
  .L_read_strlit__U8Array__U8Array_pc31:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc32:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc245
0:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc50
0:
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
  .L_read_strlit__U8Array__U8Array_pc50:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc60
0:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc60
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc61
  .L_read_strlit__U8Array__U8Array_pc60:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc61:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc231
0:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc77
0:
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc77:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc83
0:
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc83:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc89
0:
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc89:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc220
0:
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
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc121
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc121
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc122
  .L_read_strlit__U8Array__U8Array_pc121:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc122:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc128
0:
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
  .L_read_strlit__U8Array__U8Array_pc128:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc138
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc138
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc139
  .L_read_strlit__U8Array__U8Array_pc138:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc139:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc145
0:
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
  .L_read_strlit__U8Array__U8Array_pc145:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc155
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc155
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc156
  .L_read_strlit__U8Array__U8Array_pc155:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc156:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc162
0:
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
  .L_read_strlit__U8Array__U8Array_pc162:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc172
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc172
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc173
  .L_read_strlit__U8Array__U8Array_pc172:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc173:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc179
0:
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
  .L_read_strlit__U8Array__U8Array_pc179:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc189
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc189
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc190
  .L_read_strlit__U8Array__U8Array_pc189:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc190:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc196
0:
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
  .L_read_strlit__U8Array__U8Array_pc196:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc206
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc206
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc207
  .L_read_strlit__U8Array__U8Array_pc206:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc207:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc213
0:
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
  .L_read_strlit__U8Array__U8Array_pc213:
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
  .L_read_strlit__U8Array__U8Array_pc220:
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
  .L_read_strlit__U8Array__U8Array_pc231:
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
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc244
0:
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
  .L_read_strlit__U8Array__U8Array_pc244:
    j    .L_read_strlit__U8Array__U8Array_pc21
  .L_read_strlit__U8Array__U8Array_pc245:
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
    # prologue: frame_size=320, params=3, locals=6, eval_depth=69
    addi sp, sp, -320
    sw   ra, 316(sp)
    sw   s0, 312(sp)
    addi s0, sp, 320
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc18
0:
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
  .L_classify_op__U8Array__i32__i32_pc18:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc28
0:
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
  .L_classify_op__U8Array__i32__i32_pc28:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc38
0:
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
  .L_classify_op__U8Array__i32__i32_pc38:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc48
0:
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
  .L_classify_op__U8Array__i32__i32_pc48:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc58
0:
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
  .L_classify_op__U8Array__i32__i32_pc58:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc160
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc72
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc72
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc73
  .L_classify_op__U8Array__i32__i32_pc72:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc73:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc76
0:
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
  .L_classify_op__U8Array__i32__i32_pc76:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc86
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc86
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc87
  .L_classify_op__U8Array__i32__i32_pc86:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc87:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc90
0:
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
  .L_classify_op__U8Array__i32__i32_pc90:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc100
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc100
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc101
  .L_classify_op__U8Array__i32__i32_pc100:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc101:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc104
0:
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
  .L_classify_op__U8Array__i32__i32_pc104:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc114
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc114
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc115
  .L_classify_op__U8Array__i32__i32_pc114:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc115:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc118
0:
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
  .L_classify_op__U8Array__i32__i32_pc118:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc128
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc128
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc129
  .L_classify_op__U8Array__i32__i32_pc128:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc129:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc132
0:
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
  .L_classify_op__U8Array__i32__i32_pc132:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc142
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc142
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc143
  .L_classify_op__U8Array__i32__i32_pc142:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc143:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc146
0:
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
  .L_classify_op__U8Array__i32__i32_pc146:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc156
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc156
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc157
  .L_classify_op__U8Array__i32__i32_pc156:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc157:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc160
0:
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
  .L_classify_op__U8Array__i32__i32_pc160:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc406
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc174
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc174
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc175
  .L_classify_op__U8Array__i32__i32_pc174:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc175:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc182
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc182
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc183
  .L_classify_op__U8Array__i32__i32_pc182:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc183:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc186
0:
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
  .L_classify_op__U8Array__i32__i32_pc186:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc196
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc196
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc197
  .L_classify_op__U8Array__i32__i32_pc196:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc197:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc204
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc204
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc205
  .L_classify_op__U8Array__i32__i32_pc204:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc205:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc208
0:
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
  .L_classify_op__U8Array__i32__i32_pc208:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc218
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc218
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc219
  .L_classify_op__U8Array__i32__i32_pc218:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc219:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc226
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc226
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc227
  .L_classify_op__U8Array__i32__i32_pc226:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc227:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc230
0:
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
  .L_classify_op__U8Array__i32__i32_pc230:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc240
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc240
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc241
  .L_classify_op__U8Array__i32__i32_pc240:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc241:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc248
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc248
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc249
  .L_classify_op__U8Array__i32__i32_pc248:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc249:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc252
0:
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
  .L_classify_op__U8Array__i32__i32_pc252:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc262
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc262
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc263
  .L_classify_op__U8Array__i32__i32_pc262:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc263:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc270
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc270
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc271
  .L_classify_op__U8Array__i32__i32_pc270:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc271:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc274
0:
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
  .L_classify_op__U8Array__i32__i32_pc274:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc284
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc284
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc285
  .L_classify_op__U8Array__i32__i32_pc284:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc285:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc292
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc292
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc293
  .L_classify_op__U8Array__i32__i32_pc292:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc293:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc296
0:
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
  .L_classify_op__U8Array__i32__i32_pc296:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc306
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc306
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc307
  .L_classify_op__U8Array__i32__i32_pc306:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc307:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc314
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc314
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc315
  .L_classify_op__U8Array__i32__i32_pc314:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc315:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc318
0:
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
  .L_classify_op__U8Array__i32__i32_pc318:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc328
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc328
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc329
  .L_classify_op__U8Array__i32__i32_pc328:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc329:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc336
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc336
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc337
  .L_classify_op__U8Array__i32__i32_pc336:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc337:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc340
0:
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
  .L_classify_op__U8Array__i32__i32_pc340:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc350
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc350
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc351
  .L_classify_op__U8Array__i32__i32_pc350:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc351:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc358
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc358
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc359
  .L_classify_op__U8Array__i32__i32_pc358:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc359:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc362
0:
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
  .L_classify_op__U8Array__i32__i32_pc362:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc372
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc372
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc373
  .L_classify_op__U8Array__i32__i32_pc372:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc373:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc380
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc380
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc381
  .L_classify_op__U8Array__i32__i32_pc380:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc381:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc384
0:
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
  .L_classify_op__U8Array__i32__i32_pc384:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc394
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc394
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc395
  .L_classify_op__U8Array__i32__i32_pc394:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc395:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc402
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc402
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc403
  .L_classify_op__U8Array__i32__i32_pc402:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc403:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc406
0:
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
  .L_classify_op__U8Array__i32__i32_pc406:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc624
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc420
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc420
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc421
  .L_classify_op__U8Array__i32__i32_pc420:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc421:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc428
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc428
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc429
  .L_classify_op__U8Array__i32__i32_pc428:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc429:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc436
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc436
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc437
  .L_classify_op__U8Array__i32__i32_pc436:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc437:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc440
0:
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
  .L_classify_op__U8Array__i32__i32_pc440:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc450
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc450
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc451
  .L_classify_op__U8Array__i32__i32_pc450:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc451:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc458
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc458
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc459
  .L_classify_op__U8Array__i32__i32_pc458:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc459:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc466
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc466
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc467
  .L_classify_op__U8Array__i32__i32_pc466:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc467:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc470
0:
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
  .L_classify_op__U8Array__i32__i32_pc470:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc480
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc480
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc481
  .L_classify_op__U8Array__i32__i32_pc480:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc481:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc488
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc488
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc489
  .L_classify_op__U8Array__i32__i32_pc488:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc489:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc496
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc496
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc497
  .L_classify_op__U8Array__i32__i32_pc496:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc497:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc500
0:
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
  .L_classify_op__U8Array__i32__i32_pc500:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc510
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc510
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc511
  .L_classify_op__U8Array__i32__i32_pc510:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc511:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc518
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc518
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc519
  .L_classify_op__U8Array__i32__i32_pc518:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc519:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc526
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc526
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc527
  .L_classify_op__U8Array__i32__i32_pc526:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc527:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc530
0:
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
  .L_classify_op__U8Array__i32__i32_pc530:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc540
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc540
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc541
  .L_classify_op__U8Array__i32__i32_pc540:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc541:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc548
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc548
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc549
  .L_classify_op__U8Array__i32__i32_pc548:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc549:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc556
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc556
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc557
  .L_classify_op__U8Array__i32__i32_pc556:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc557:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc560
0:
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
  .L_classify_op__U8Array__i32__i32_pc560:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc570
0:
    lw   t0, -32(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc570
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc571
  .L_classify_op__U8Array__i32__i32_pc570:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc571:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc578
0:
    lw   t0, -36(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc578
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc579
  .L_classify_op__U8Array__i32__i32_pc578:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc579:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc592
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc586
0:
    la   t1, OP_LT_U
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
  .L_classify_op__U8Array__i32__i32_pc586:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc592
0:
    la   t1, OP_GT_U
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
  .L_classify_op__U8Array__i32__i32_pc592:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc602
0:
    lw   t0, -32(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc602
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc603
  .L_classify_op__U8Array__i32__i32_pc602:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc603:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc610
0:
    lw   t0, -36(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc610
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc611
  .L_classify_op__U8Array__i32__i32_pc610:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc611:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc624
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc618
0:
    la   t1, OP_LE_U
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
  .L_classify_op__U8Array__i32__i32_pc618:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc624
0:
    la   t1, OP_GE_U
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
  .L_classify_op__U8Array__i32__i32_pc624:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc704
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc638
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc638
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc639
  .L_classify_op__U8Array__i32__i32_pc638:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc639:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc646
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc646
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc647
  .L_classify_op__U8Array__i32__i32_pc646:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc647:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc654
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc654
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc655
  .L_classify_op__U8Array__i32__i32_pc654:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc655:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc662
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc662
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc663
  .L_classify_op__U8Array__i32__i32_pc662:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc663:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc666
0:
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
  .L_classify_op__U8Array__i32__i32_pc666:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc676
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc676
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc677
  .L_classify_op__U8Array__i32__i32_pc676:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc677:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc684
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc684
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc685
  .L_classify_op__U8Array__i32__i32_pc684:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc685:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc692
0:
    lw   t0, -36(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc692
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc693
  .L_classify_op__U8Array__i32__i32_pc692:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc693:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc700
0:
    lw   t0, -40(s0)
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc700
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc701
  .L_classify_op__U8Array__i32__i32_pc700:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc701:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc704
0:
    la   t1, OP_SHR_U
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
  .L_classify_op__U8Array__i32__i32_pc704:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc730
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc718
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc718
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc719
  .L_classify_op__U8Array__i32__i32_pc718:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc719:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc726
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc726
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc727
  .L_classify_op__U8Array__i32__i32_pc726:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc727:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc730
0:
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
  .L_classify_op__U8Array__i32__i32_pc730:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc782
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc744
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc744
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc745
  .L_classify_op__U8Array__i32__i32_pc744:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc745:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc752
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc752
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc753
  .L_classify_op__U8Array__i32__i32_pc752:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc753:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc760
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc760
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc761
  .L_classify_op__U8Array__i32__i32_pc760:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc761:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc768
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc768
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc769
  .L_classify_op__U8Array__i32__i32_pc768:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc769:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc782
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc782
0:
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
  .L_classify_op__U8Array__i32__i32_pc782:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc840
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc796
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc796
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc797
  .L_classify_op__U8Array__i32__i32_pc796:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc797:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc804
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc804
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc805
  .L_classify_op__U8Array__i32__i32_pc804:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc805:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc812
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc812
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc813
  .L_classify_op__U8Array__i32__i32_pc812:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc813:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc820
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc820
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc821
  .L_classify_op__U8Array__i32__i32_pc820:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc821:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc840
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc834
0:
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
  .L_classify_op__U8Array__i32__i32_pc834:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc840
0:
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
  .L_classify_op__U8Array__i32__i32_pc840:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc850
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc850
0:
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
  .L_classify_op__U8Array__i32__i32_pc850:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc868
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc864
0:
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
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc864
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_classify_op__U8Array__i32__i32_pc865
  .L_classify_op__U8Array__i32__i32_pc864:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_classify_op__U8Array__i32__i32_pc865:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc868
0:
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
  .L_classify_op__U8Array__i32__i32_pc868:
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
  .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc31:
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
    bnez t0, 0f
    j    .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc51
0:
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
    j    .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc31
  .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc51:
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
  .L_parse_lnum__U8Array__i32__i32_pc6:
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
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc40
0:
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
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc24
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc24
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_lnum__U8Array__i32__i32_pc25
  .L_parse_lnum__U8Array__i32__i32_pc24:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_lnum__U8Array__i32__i32_pc25:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc35
0:
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
  .L_parse_lnum__U8Array__i32__i32_pc35:
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
    j    .L_parse_lnum__U8Array__i32__i32_pc6
  .L_parse_lnum__U8Array__i32__i32_pc40:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc5:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc16
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc16:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1202
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc26
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc26:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc44
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc49
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc49:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc60
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc60:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc68
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc68:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc72
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc72:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc83
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc83:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc91
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc91:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc99
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc99:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc123
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc123:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc133
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc133:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc144
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc144:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc203
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc200
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc200:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc203:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc214
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc214:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc297
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc297:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc308
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc308:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc425
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc321:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc333
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc333:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc362
0:
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc321
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc362:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc425:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc436
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc436:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc499
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc496
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc496:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc499:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc510
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc510:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc573
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc570
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc570:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc573:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc585
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc585:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc596
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc596:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc605
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc605:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc616
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc616:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc688
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc634:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc654
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc654:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc662
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc662:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc677
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc677:
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc634
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc688:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc699
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc699:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc707
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc707:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc715
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc715:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc723
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc723:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc731
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc731:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc749
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc749:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc757
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc757:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc765
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc765:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc773
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc773:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc841
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc776:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc788
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc788:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc797
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc797:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc803
0:
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc776
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc803:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc815
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc815:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc841:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc852
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc852:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc860
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc860:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc868
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc868:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc876
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc876:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc903
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc903:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1198
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc964
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc964:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc988
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc988:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc999
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc999:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1021
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1021:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1106
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1036:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1048
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1048:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1081
0:
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1036
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1081:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1106:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1131
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1131:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1142
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1142:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149
0:
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
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1150
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1150:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1186
0:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1156:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167
0:
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
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1168
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1168:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1174
0:
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1156
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1174:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1186:
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
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1198:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201:
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc5
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1202:
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
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc18:
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
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc44
0:
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
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc39
0:
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
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc39:
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
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc18
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc46:
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
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc74
0:
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
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc69
0:
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
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc69:
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
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc46
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc74:
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
  .L_global_find__U8Array__I32Array__i32__i32_pc2:
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
    bnez t0, 0f
    j    .L_global_find__U8Array__I32Array__i32__i32_pc32
0:
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
    bnez t0, 0f
    j    .L_global_find__U8Array__I32Array__i32__i32_pc27
0:
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
  .L_global_find__U8Array__I32Array__i32__i32_pc27:
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
    j    .L_global_find__U8Array__I32Array__i32__i32_pc2
  .L_global_find__U8Array__I32Array__i32__i32_pc32:
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
  .L_func_find__U8Array__I32Array__i32__i32_pc2:
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
    bnez t0, 0f
    j    .L_func_find__U8Array__I32Array__i32__i32_pc24
0:
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
    bnez t0, 0f
    j    .L_func_find__U8Array__I32Array__i32__i32_pc19
0:
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
  .L_func_find__U8Array__I32Array__i32__i32_pc19:
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
    j    .L_func_find__U8Array__I32Array__i32__i32_pc2
  .L_func_find__U8Array__I32Array__i32__i32_pc24:
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
    # prologue: frame_size=640, params=21, locals=82, eval_depth=53
    addi sp, sp, -640
    sw   ra, 636(sp)
    sw   s0, 632(sp)
    addi s0, sp, 640
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
    sw   zero, -388(s0)
    sw   zero, -392(s0)
    sw   zero, -396(s0)
    sw   zero, -400(s0)
    sw   zero, -404(s0)
    sw   zero, -408(s0)
    sw   zero, -412(s0)
    sw   zero, -416(s0)
    sw   zero, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc52
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc52:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc54:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc83
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc54
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc83:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc97:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc118
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc97
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc118:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc140:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2219
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc150
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc150:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2218
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc185
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc185:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc196
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc196:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2218
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc231
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc231:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc262
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc262:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc293
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc293:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc325
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc325:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc374
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc374:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1628
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc439
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc439:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc463
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc463:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc473
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc473:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc483
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc483:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc493
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc493:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc503
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc503:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc513
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc513:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc523
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc523:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc539
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc539
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc540
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc539:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc540:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc547
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc547
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc548
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc547:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc548:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc555
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc555
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc556
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc555:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc556:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc563
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc563
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc564
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc563:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc564:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc778
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc627
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc595
0:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -232(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc595:
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc601:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc619
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc601
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc619:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc627:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc767
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc657
0:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc657:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc669
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc669
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc670
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc669:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc670:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc715
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc713
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc685
0:
    lw   t0, -260(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc685:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc687:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc707
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc687
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc707:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc713:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc715:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc725
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc725
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc726
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc725:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc726:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc767
0:
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc760
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc742:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc760
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc742
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc760:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc767:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc776
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc776:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc778:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc788
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc788
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc789
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc788:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc789:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc796
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc796
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc797
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc796:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc797:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc804
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc804
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc805
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc804:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc805:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc895
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc815
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc815:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc825
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc825:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc836
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc836:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc893
0:
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc860:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc878
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc860
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc878:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc893:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc895:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc905
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc905
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc906
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc905:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc906:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc913
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 90
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc913
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc914
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc913:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc914:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc921
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc921
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc922
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc921:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc922:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc949
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc937
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc937:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc947
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc947:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc949:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc975
0:
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
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc971
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc967
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc967
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc968
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc967:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc968:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc971
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc972
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc971:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc972:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc975
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc976
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc975:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc976:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc983
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc983
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc984
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc983:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc984:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc991
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc991
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc992
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc991:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc992:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc999
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc999
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1000
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc999:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1000:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1035
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1021
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1021:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1033
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1033:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1035:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1061
0:
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
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1057
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1053
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1053
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1054
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1053:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1054:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1057
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1058
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1057:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1058:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1061
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1062
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1061:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1062:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1069
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1069
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1070
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1069:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1070:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1077
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1077
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1078
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1077:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1078:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1085
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1085
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1086
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1085:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1086:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1127
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1112
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1112:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1125
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1125:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1127:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1153
0:
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
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1149
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1145
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1145
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1146
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1145:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1146:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1149
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1150
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1149:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1150:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1153
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1154
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1153:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1154:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1161
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1161
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1162
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1161:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1162:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1169
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1169
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1170
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1169:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1170:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1177
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1177
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1178
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1177:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1178:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1187
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1187:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1197
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1197
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1198
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1197:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1198:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1205
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1205
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1206
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1205:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1206:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1213
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1213
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1214
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1213:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1214:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1217
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1217:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1227
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1227
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1228
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1227:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1228:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1235
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1235
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1236
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1235:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1236:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1381
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1307
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1273:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1293
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1273
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1293:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1307:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1379
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1331:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1351
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1331
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1351:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1353:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1375
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1353
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1375:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1379:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1381:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1391
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1391
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1392
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1391:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1392:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1399
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1399
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1400
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1399:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1400:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1474
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1431
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1431:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1472
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1439:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1449
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1449
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1450
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1449:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1450:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1470
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1465
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -336(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1465:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1439
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1470:
    lw   t0, -336(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1472:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1474:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1484
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1484
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1485
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1484:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1485:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1500
0:
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
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1496
0:
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
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1496
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1497
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1496:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1497:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1500
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1501
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1500:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1501:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1506
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1506:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1516
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1516:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1628
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1536
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1536:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1628
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1560:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1587
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1560
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1587:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -364(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1589:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1616
0:
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1589
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1616:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1628:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1659
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1659:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1682
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1682:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1690
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1690:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1700
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1700
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1701
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1700:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1701:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1802
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1724
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1724:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1732
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1732:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1740
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1740:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1748
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1748:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1756
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1756:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1764
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1764:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1772
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1772:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1780
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1780:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1788
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1788:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1796
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1796:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1802:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1842
0:
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
    sw   t0, -380(s0)
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
    sw   t0, -384(s0)
    lw   t0, -384(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -388(s0)
    lw   t0, -380(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1836
0:
    lw   t0, -388(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2147483647
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
    sw   t0, -388(s0)
    lw   t0, -388(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -380(s0)
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
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -388(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1836:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -388(s0)
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1842:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1852
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1852
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1853
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1852:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1853:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1934
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1878
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1878
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1878:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1888
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1888
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1888:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1898
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1898
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1898:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1908
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1908
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1908:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1918
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1918
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1918:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1928
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1928
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1928:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1934:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1944
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1944
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1945
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1944:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1945:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2018
0:
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
    sw   t0, -392(s0)
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
    sw   t0, -396(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 31
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
    sw   t0, -400(s0)
    lw   t0, -396(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -400(s0)
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
    sw   t0, -404(s0)
    lw   t0, -392(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -400(s0)
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
    sw   t0, -408(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1982
0:
    lw   t0, -404(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -408(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1982
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1982:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LE_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1992
0:
    lw   t0, -404(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -408(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1992
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1992:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GT_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2002
0:
    lw   t0, -404(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -408(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2002
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2002:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE_U
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2012
0:
    lw   t0, -404(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -408(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2012
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2012:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -412(s0)
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2018:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2034
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2034:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2056
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2050
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2050:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2056:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2184
0:
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
    sw   t0, -416(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2078
0:
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
    sw   t0, -416(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2078:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2088
0:
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
    sw   t0, -420(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2088:
    lw   t0, -416(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2098
0:
    lw   t0, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2098
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2099
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2098:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2099:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2104
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2104:
    lw   t0, -416(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2114
0:
    lw   t0, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2114
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2115
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2114:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2115:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2120
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2120:
    lw   t0, -416(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2130
0:
    lw   t0, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2130
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2131
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2130:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2131:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2144
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2144
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2144:
    lw   t0, -416(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2154
0:
    lw   t0, -420(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2154
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2155
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2154:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2155:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2168
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2168
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2168:
    lw   t0, -416(s0)
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2178
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2178
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2178:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2184:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2190
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2190:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2204
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2204
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2204:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2218
0:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2218
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2218:
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc140
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2219:
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
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2229
0:
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2229:
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
    call U8Array__u32
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
    call U8Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call U8Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call I32Array__u32
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
    call U8Array__u32
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
  .L_main_pc73:
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
    bnez t0, 0f
    j    .L_main_pc83
0:
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
    bnez t0, 0f
    j    .L_main_pc83
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_main_pc84
  .L_main_pc83:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_main_pc84:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc125
0:
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
    bnez t0, 0f
    j    .L_main_pc96
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_main_pc96:
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
    bnez t0, 0f
    j    .L_main_pc124
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
  .L_main_pc102:
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
    bnez t0, 0f
    j    .L_main_pc120
0:
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
    j    .L_main_pc102
  .L_main_pc120:
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
  .L_main_pc124:
    j    .L_main_pc73
  .L_main_pc125:
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
    bnez t0, 0f
    j    .L_main_pc134
0:
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
  .L_main_pc134:
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
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
  .L_main_pc158:
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
    bnez t0, 0f
    j    .L_main_pc176
0:
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
    j    .L_main_pc158
  .L_main_pc176:
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
    .globl OP_SHR_U
OP_SHR_U:
    .word 31
    .globl OP_LT_U
OP_LT_U:
    .word 32
    .globl OP_LE_U
OP_LE_U:
    .word 33
    .globl OP_GT_U
OP_GT_U:
    .word 34
    .globl OP_GE_U
OP_GE_U:
    .word 35
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

