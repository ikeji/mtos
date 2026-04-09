/*
 * bc2asm — RISC-V 32-bit assembly generator from .bc bytecode.
 *
 * Target: RV32IM, GAS syntax.
 * Calling convention: standard RISC-V ABI (a0-a7 for args, a0 for return).
 *
 * Frame layout (fp = s0, grows downward):
 *   fp - 4:              saved ra
 *   fp - 8:              saved s0 (old fp)
 *   fp - 12 - 4*k:       var[k]  (params first, then locals)
 *   [padding to 16-byte alignment]
 *   sp (after prologue): bottom of fixed frame
 *
 * Expression stack: hardware stack below sp, grows downward during
 * expression evaluation, fully consumed by each statement.
 *
 * Functions are emitted as calls to mangled names (see runtime_syscall.c).
 * Exception: sys_exit is inlined as an ecall.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* ===== .bc parser (same format as bcrun) ===== */

typedef enum {
    OP_PUSH_INT, OP_PUSH_STR,
    OP_LOAD, OP_STORE,
    OP_CALL, OP_RETURN, OP_RETURN_VOID, OP_POP,
    OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_MOD,
    OP_AND, OP_OR,  OP_XOR, OP_SHL, OP_SHR,
    OP_EQ,  OP_NE,  OP_LT,  OP_LE,  OP_GT,  OP_GE,
    OP_NEG, OP_LNOT,
    OP_CAST,
    OP_JUMP, OP_JUMP_IF, OP_JUMP_IFNOT,
} OpCode;

typedef struct {
    OpCode op;
    long   ival;
    char  *sarg;
} Instr;

typedef struct {
    char  *name;
    char  *ret_type;
    char **param_names; char **param_types; int nparams;
    char **local_names; char **local_types; int nlocals;
    Instr *instrs; int ninstrs, instrs_cap;
} BcFunc;

typedef struct {
    char  **strings;      int nstrings, strings_cap;
    char  **global_names; char **global_types; int *global_inits; int nglobals, globals_cap;
    BcFunc *funcs;        int nfuncs,  funcs_cap;
} BcProg;

typedef struct { char *name; int pc; } LabelEnt;
typedef struct { LabelEnt *e; int n, cap; } LabelTab;

static char *skip_ws(char *s) { while(*s&&isspace((unsigned char)*s))s++; return s; }

static char *next_tok(char *s, char *out, int max) {
    int i=0;
    while(*s&&!isspace((unsigned char)*s)&&i<max-1) out[i++]=*s++;
    out[i]='\0'; return s;
}

static char *parse_strlit(char *s, char *buf, int blen) {
    int i=0;
    while(*s&&*s!='"'&&i<blen-1){
        if(*s=='\\'){s++;switch(*s){
            case 'n': buf[i++]='\n';break; case 'r': buf[i++]='\r';break;
            case 't': buf[i++]='\t';break; case '"': buf[i++]='"'; break;
            case '\\':buf[i++]='\\';break;
            case 'x':{s++;char h[3]={s[0],s[1],'\0'};buf[i++]=(char)strtol(h,NULL,16);s++;break;}
            default:buf[i++]=*s;}}
        else { buf[i++]=*s; } s++;}
    buf[i]='\0'; if(*s=='"')s++; return s;
}

static void lt_add(LabelTab *lt,const char*n,int pc){
    if(lt->n>=lt->cap){lt->cap=lt->cap?lt->cap*2:16;lt->e=realloc(lt->e,lt->cap*sizeof(LabelEnt));}
    lt->e[lt->n].name=strdup(n); lt->e[lt->n].pc=pc; lt->n++;
}
static int lt_find(LabelTab *lt,const char*n){
    for(int i=0;i<lt->n;i++) if(!strcmp(lt->e[i].name,n)) return lt->e[i].pc;
    fprintf(stderr,"bc2asm: unresolved label '%s'\n",n); exit(1);
}
static void lt_free(LabelTab *lt){
    for(int i=0;i<lt->n;i++)free(lt->e[i].name);
    free(lt->e); lt->n=lt->cap=0; lt->e=NULL;
}

static void prog_set_str(BcProg*p,int idx,const char*s){
    while(p->nstrings<=idx){
        if(p->nstrings>=p->strings_cap){p->strings_cap=p->strings_cap?p->strings_cap*2:16;p->strings=realloc(p->strings,p->strings_cap*sizeof(char*));}
        p->strings[p->nstrings++]=NULL;}
    free(p->strings[idx]); p->strings[idx]=strdup(s);
}
static void prog_add_global(BcProg*p,const char*nm,const char*ty,int iv){
    if(p->nglobals>=p->globals_cap){p->globals_cap=p->globals_cap?p->globals_cap*2:8;
        p->global_names=realloc(p->global_names,p->globals_cap*sizeof(char*));
        p->global_types=realloc(p->global_types,p->globals_cap*sizeof(char*));
        p->global_inits=realloc(p->global_inits,p->globals_cap*sizeof(int));}
    p->global_names[p->nglobals]=strdup(nm); p->global_types[p->nglobals]=strdup(ty);
    p->global_inits[p->nglobals]=iv; p->nglobals++;
}
static BcFunc *prog_new_fn(BcProg*p){
    if(p->nfuncs>=p->funcs_cap){p->funcs_cap=p->funcs_cap?p->funcs_cap*2:8;p->funcs=realloc(p->funcs,p->funcs_cap*sizeof(BcFunc));}
    BcFunc*f=&p->funcs[p->nfuncs++]; memset(f,0,sizeof(BcFunc)); return f;
}
static void fn_param(BcFunc*f,const char*n,const char*t){
    f->param_names=realloc(f->param_names,(f->nparams+1)*sizeof(char*));
    f->param_types=realloc(f->param_types,(f->nparams+1)*sizeof(char*));
    f->param_names[f->nparams]=strdup(n); f->param_types[f->nparams]=strdup(t); f->nparams++;
}
static void fn_local(BcFunc*f,const char*n,const char*t){
    f->local_names=realloc(f->local_names,(f->nlocals+1)*sizeof(char*));
    f->local_types=realloc(f->local_types,(f->nlocals+1)*sizeof(char*));
    f->local_names[f->nlocals]=strdup(n); f->local_types[f->nlocals]=strdup(t); f->nlocals++;
}
static void fn_emit(BcFunc*f,Instr ins){
    if(f->ninstrs>=f->instrs_cap){f->instrs_cap=f->instrs_cap?f->instrs_cap*2:32;f->instrs=realloc(f->instrs,f->instrs_cap*sizeof(Instr));}
    f->instrs[f->ninstrs++]=ins;
}
static void fn_resolve(BcFunc*f,LabelTab*lt){
    for(int i=0;i<f->ninstrs;i++){Instr*ins=&f->instrs[i];
        if((ins->op==OP_JUMP||ins->op==OP_JUMP_IF||ins->op==OP_JUMP_IFNOT)&&ins->sarg){
            ins->ival=lt_find(lt,ins->sarg); free(ins->sarg); ins->sarg=NULL;}}
}

/* Build mangled name: "name__type1__type2..." */
static void build_mangled(char *buf, int bufsz,
                           const char *name,
                           const char **types, int ntypes) {
    strncpy(buf, name, bufsz - 1); buf[bufsz - 1] = '\0';
    for (int i = 0; i < ntypes; i++) {
        strncat(buf, "__", bufsz - strlen(buf) - 1);
        strncat(buf, types[i], bufsz - strlen(buf) - 1);
    }
}

/* Extract base name (before first "__") */

static BcProg *bc_parse(FILE *in) {
    BcProg *p=calloc(1,sizeof(BcProg)); BcFunc *cur=NULL; LabelTab lt={0};
    char line[4096];
    while(fgets(line,sizeof(line),in)){
        int len=strlen(line);
        while(len>0&&(line[len-1]=='\n'||line[len-1]=='\r'))line[--len]='\0';
        char *s=skip_ws(line); if(!*s||*s==';') continue;
        if(*s=='.'){
            char dir[64]; s=skip_ws(next_tok(s+1,dir,sizeof(dir)));
            if(!strcmp(dir,"string")){char is[16];s=skip_ws(next_tok(s,is,sizeof(is)));if(*s=='"'){char b[4096];parse_strlit(s+1,b,sizeof(b));prog_set_str(p,atoi(is),b);}}
            else if(!strcmp(dir,"global")){char nm[128],ty[64],iv[32];s=skip_ws(next_tok(s,nm,sizeof(nm)));s=skip_ws(next_tok(s,ty,sizeof(ty)));next_tok(s,iv,sizeof(iv));prog_add_global(p,nm,ty,atoi(iv));}
            else if(!strcmp(dir,"fn")){
                /* Format: .fn NAME ARG_TYPE... RET_TYPE */
                char toks[30][128]; int ntok=0;
                char *p2=s;
                while(*p2&&ntok<30){p2=skip_ws(p2);if(!*p2)break;p2=next_tok(p2,toks[ntok],sizeof(toks[0]));if(toks[ntok][0])ntok++;}
                int nargs=ntok>=2?ntok-2:0;
                const char *argtypes[29];
                for(int i=0;i<nargs&&i<29;i++)argtypes[i]=toks[1+i];
                char mangled[512];
                build_mangled(mangled,sizeof(mangled),toks[0],argtypes,nargs);
                cur=prog_new_fn(p);cur->name=strdup(mangled);
                cur->ret_type=ntok>=1?strdup(toks[ntok-1]):strdup("void");lt_free(&lt);}
            else if(!strcmp(dir,"param")){char nm[128],ty[64];s=skip_ws(next_tok(s,nm,sizeof(nm)));next_tok(s,ty,sizeof(ty));if(cur)fn_param(cur,nm,ty);}
            else if(!strcmp(dir,"local")){char nm[128],ty[64];s=skip_ws(next_tok(s,nm,sizeof(nm)));next_tok(s,ty,sizeof(ty));if(cur)fn_local(cur,nm,ty);}
            else if(!strcmp(dir,"endfn")){if(cur){fn_resolve(cur,&lt);lt_free(&lt);}cur=NULL;}
            continue;
        }
        if(s[0]=='_'&&s[1]=='_'&&s[2]=='L'&&cur){
            const char*e=s; while(*e&&*e!=':')e++;
            if(*e==':'){int nl=(int)(e-s);char*ln=malloc(nl+1);memcpy(ln,s,nl);ln[nl]='\0';lt_add(&lt,ln,cur->ninstrs);free(ln);}
            continue;
        }
        if(!cur) continue;
        char op[32]; s=skip_ws(next_tok(s,op,sizeof(op)));
        Instr ins; memset(&ins,0,sizeof(ins));
        if(!strcmp(op,"push_int"))  {ins.op=OP_PUSH_INT;ins.ival=atol(skip_ws(s));}
        else if(!strcmp(op,"push_str"))  {ins.op=OP_PUSH_STR;ins.ival=atol(skip_ws(s));}
        else if(!strcmp(op,"load"))      {ins.op=OP_LOAD;char n[128];next_tok(s,n,sizeof(n));ins.sarg=strdup(n);}
        else if(!strcmp(op,"store"))     {ins.op=OP_STORE;char n[128];next_tok(s,n,sizeof(n));ins.sarg=strdup(n);}
        else if(!strcmp(op,"call"))      {
            ins.op=OP_CALL;char nm[128];s=skip_ws(next_tok(s,nm,sizeof(nm)));
            const char *types[29];char typebufs[29][64];int ntypes=0;
            char *p2=s;
            while(*p2&&ntypes<29){p2=skip_ws(p2);if(!*p2)break;p2=next_tok(p2,typebufs[ntypes],sizeof(typebufs[0]));if(typebufs[ntypes][0]){types[ntypes]=typebufs[ntypes];ntypes++;}}
            char mangled[512];build_mangled(mangled,sizeof(mangled),nm,types,ntypes);
            ins.sarg=strdup(mangled);ins.ival=ntypes;}
        else if(!strcmp(op,"return"))    {ins.op=OP_RETURN;}
        else if(!strcmp(op,"return_void")){ins.op=OP_RETURN_VOID;}
        else if(!strcmp(op,"pop"))       {ins.op=OP_POP;}
        else if(!strcmp(op,"add"))       {ins.op=OP_ADD;}
        else if(!strcmp(op,"sub"))       {ins.op=OP_SUB;}
        else if(!strcmp(op,"mul"))       {ins.op=OP_MUL;}
        else if(!strcmp(op,"div"))       {ins.op=OP_DIV;}
        else if(!strcmp(op,"mod"))       {ins.op=OP_MOD;}
        else if(!strcmp(op,"and"))       {ins.op=OP_AND;}
        else if(!strcmp(op,"or"))        {ins.op=OP_OR;}
        else if(!strcmp(op,"xor"))       {ins.op=OP_XOR;}
        else if(!strcmp(op,"shl"))       {ins.op=OP_SHL;}
        else if(!strcmp(op,"shr"))       {ins.op=OP_SHR;}
        else if(!strcmp(op,"eq"))        {ins.op=OP_EQ;}
        else if(!strcmp(op,"ne"))        {ins.op=OP_NE;}
        else if(!strcmp(op,"lt"))        {ins.op=OP_LT;}
        else if(!strcmp(op,"le"))        {ins.op=OP_LE;}
        else if(!strcmp(op,"gt"))        {ins.op=OP_GT;}
        else if(!strcmp(op,"ge"))        {ins.op=OP_GE;}
        else if(!strcmp(op,"neg"))       {ins.op=OP_NEG;}
        else if(!strcmp(op,"lnot"))      {ins.op=OP_LNOT;}
        else if(!strcmp(op,"cast"))      {ins.op=OP_CAST;char t[64];next_tok(s,t,sizeof(t));ins.sarg=strdup(t);}
        else if(!strcmp(op,"jump"))      {ins.op=OP_JUMP;char l[64];next_tok(s,l,sizeof(l));ins.sarg=strdup(l);}
        else if(!strcmp(op,"jump_if"))   {ins.op=OP_JUMP_IF;char l[64];next_tok(s,l,sizeof(l));ins.sarg=strdup(l);}
        else if(!strcmp(op,"jump_ifnot")){ins.op=OP_JUMP_IFNOT;char l[64];next_tok(s,l,sizeof(l));ins.sarg=strdup(l);}
        else{fprintf(stderr,"bc2asm: unknown op '%s'\n",op);exit(1);}
        fn_emit(cur,ins);
    }
    lt_free(&lt);
    return p;
}

/* ===== Variable lookup ===== */

/* Returns fp-relative offset (negative) for variable name in fn. */
static int var_offset(BcFunc *fn, const char *name) {
    for (int i = 0; i < fn->nparams; i++)
        if (!strcmp(fn->param_names[i], name)) return -12 - 4*i;
    for (int i = 0; i < fn->nlocals; i++)
        if (!strcmp(fn->local_names[i], name)) return -12 - 4*fn->nparams - 4*i;
    return 0; /* not found — global */
}

static int is_local(BcFunc *fn, const char *name) {
    for (int i = 0; i < fn->nparams; i++)
        if (!strcmp(fn->param_names[i], name)) return 1;
    for (int i = 0; i < fn->nlocals; i++)
        if (!strcmp(fn->local_names[i], name)) return 1;
    return 0;
}

/* ===== Builtin detection ===== */


/* ===== Code generation ===== */

static FILE *out;
static int g_skip_id = 0;

/* Macro-like helpers to emit common idioms */
#define E(...) fprintf(out, __VA_ARGS__)

/* Push t0 onto expression stack */
static void push_t0(void) {
    E("    addi sp, sp, -4\n");
    E("    sw   t0, 0(sp)\n");
}

/* Pop top of expression stack into t0 */
static void pop_t0(void) {
    E("    lw   t0, 0(sp)\n");
    E("    addi sp, sp, 4\n");
}

/* Pop top into t1, next into t0 (t0=left, t1=right) */
static void pop_t1_t0(void) {
    E("    lw   t1, 0(sp)\n");   /* right */
    E("    lw   t0, 4(sp)\n");   /* left */
    E("    addi sp, sp, 8\n");
}

/* Returns 1 if instruction i is a jump target in fn */
static int is_jump_target(BcFunc *fn, int i) {
    for (int j = 0; j < fn->ninstrs; j++) {
        Instr *ins = &fn->instrs[j];
        if ((ins->op == OP_JUMP || ins->op == OP_JUMP_IF || ins->op == OP_JUMP_IFNOT)
            && (int)ins->ival == i)
            return 1;
    }
    return 0;
}

/* Compute the maximum eval-stack depth (in slots) for a function.
   This is needed to reserve frame space so that pushed values don't
   collide with callee frames. */
static int max_eval_depth(BcFunc *fn) {
    int depth = 0, max_d = 0;
    for (int i = 0; i < fn->ninstrs; i++) {
        Instr *ins = &fn->instrs[i];
        switch (ins->op) {
        case OP_PUSH_INT: case OP_PUSH_STR: case OP_LOAD:
            depth++; break;
        case OP_STORE: case OP_POP: case OP_RETURN:
        case OP_JUMP_IF: case OP_JUMP_IFNOT:
            depth--; break;
        case OP_RETURN_VOID: case OP_JUMP:
            break;
        case OP_ADD: case OP_SUB: case OP_MUL: case OP_DIV: case OP_MOD:
        case OP_AND: case OP_OR:  case OP_XOR: case OP_SHL: case OP_SHR:
        case OP_EQ:  case OP_NE:  case OP_LT:  case OP_LE:  case OP_GT: case OP_GE:
            depth--; break; /* pop 2, push 1 */
        case OP_NEG: case OP_LNOT: case OP_CAST:
            break; /* pop 1, push 1 */
        case OP_CALL:
            depth -= ((int)ins->ival - 1); /* pop nargs, push 1 */
            break;
        }
        if (depth > max_d) max_d = depth;
        if (depth < 0) depth = 0; /* reset at branch targets */
    }
    return max_d;
}

static void emit_fn(BcFunc *fn, int fi) {
    int nvars      = fn->nparams + fn->nlocals;
    int eval_slots = max_eval_depth(fn);
    int frame_size = 8 + 4 * nvars + 4 * eval_slots;
    /* round up to 16-byte boundary */
    frame_size = (frame_size + 15) & ~15;

    /* --- function header --- */
    E("    .globl %s\n", fn->name);
    E("    .type  %s, @function\n", fn->name);
    E("%s:\n", fn->name);

    /* --- prologue --- */
    E("    # prologue: frame_size=%d, params=%d, locals=%d, eval_depth=%d\n",
      frame_size, fn->nparams, fn->nlocals, eval_slots);
    E("    addi sp, sp, -%d\n", frame_size);
    E("    sw   ra, %d(sp)\n",  frame_size - 4);
    E("    sw   s0, %d(sp)\n",  frame_size - 8);
    E("    addi s0, sp, %d\n",  frame_size);

    /* save incoming args (a0-a7) to param slots */
    static const char *areg[] = {"a0","a1","a2","a3","a4","a5","a6","a7"};
    int nreg_params = fn->nparams < 8 ? fn->nparams : 8;
    for (int i = 0; i < nreg_params; i++)
        E("    sw   %s, %d(s0)\n", areg[i], -12 - 4*i);

    /* load overflow args from caller's stack (above our frame).
       Caller placed: arg8 at s0+0, arg9 at s0+4, etc. */
    for (int i = 8; i < fn->nparams; i++) {
        E("    lw   t0, %d(s0)\n", 4*(i - 8));
        E("    sw   t0, %d(s0)\n", -12 - 4*i);
    }

    /* zero-initialize locals */
    for (int i = 0; i < fn->nlocals; i++)
        E("    sw   zero, %d(s0)\n", -12 - 4*fn->nparams - 4*i);

    /* --- instruction loop --- */
    for (int pc = 0; pc < fn->ninstrs; pc++) {
        /* emit label if this pc is a jump target */
        if (is_jump_target(fn, pc))
            E("  .L_f%d_pc%d:\n", fi, pc);

        Instr *ins = &fn->instrs[pc];

        switch (ins->op) {

        case OP_PUSH_INT:
            E("    li   t0, %ld\n", ins->ival);
            push_t0();
            break;

        case OP_PUSH_STR: {
            /* Push pointer to static HeapObj in .rodata (no allocation) */
            int idx = (int)ins->ival;
            E("    la   t0, __tc_strobj%d\n", idx);
            push_t0();
            break;
        }

        case OP_LOAD:
            if (is_local(fn, ins->sarg)) {
                int off = var_offset(fn, ins->sarg);
                E("    lw   t0, %d(s0)\n", off);
            } else {
                E("    la   t1, %s\n", ins->sarg);  /* global */
                E("    lw   t0, 0(t1)\n");
            }
            push_t0();
            break;

        case OP_STORE:
            pop_t0();
            if (is_local(fn, ins->sarg)) {
                int off = var_offset(fn, ins->sarg);
                E("    sw   t0, %d(s0)\n", off);
            } else {
                E("    la   t1, %s\n", ins->sarg);  /* global */
                E("    sw   t0, 0(t1)\n");
            }
            break;

        case OP_CALL: {
            int nargs = (int)ins->ival;
            /* Expression stack layout (arg0 pushed first → at bottom):
               sp+4*(nargs-1): arg0, ..., sp+0: arg(nargs-1) */
            int nreg = nargs < 8 ? nargs : 8;
            int noverflow = nargs - nreg;

            if (noverflow > 0) {
                /* Allocate space below expression stack for overflow args */
                E("    addi sp, sp, %d\n", -4*noverflow);
                /* Copy overflow args to new area (no overlap guaranteed).
                   Source: sp+4*noverflow+4*(nargs-1-i), Dest: sp+4*(i-8) */
                for (int i = 8; i < nargs; i++) {
                    E("    lw   t0, %d(sp)\n", 4*noverflow + 4*(nargs-1-i));
                    E("    sw   t0, %d(sp)\n", 4*(i-8));
                }
            }

            /* Load register args (arg0..arg7) into a0-a7.
               Offsets shifted by 4*noverflow if overflow area was allocated. */
            for (int i = 0; i < nreg; i++)
                E("    lw   %s, %d(sp)\n", areg[i],
                  4*noverflow + 4*(nargs-1-i));

            E("    call %s\n", ins->sarg);

            /* pop overflow args + expression stack */
            if (noverflow > 0)
                E("    addi sp, sp, %d\n", 4*noverflow + 4*nargs);
            else if (nargs > 0)
                E("    addi sp, sp, %d\n", 4*nargs);

            /* push return value (a0) — callers of void fns will pop it */
            E("    addi sp, sp, -4\n");
            E("    sw   a0, 0(sp)\n");
            break;
        }

        case OP_RETURN:
            pop_t0();
            E("    mv   a0, t0\n");
            /* epilogue */
            E("    mv   t0, s0\n");
            E("    lw   ra, -4(t0)\n");
            E("    lw   s0, -8(t0)\n");
            E("    addi sp, t0, 0\n");
            E("    ret\n");
            break;

        case OP_RETURN_VOID:
            /* epilogue */
            E("    mv   t0, s0\n");
            E("    lw   ra, -4(t0)\n");
            E("    lw   s0, -8(t0)\n");
            E("    addi sp, t0, 0\n");
            E("    ret\n");
            break;

        case OP_POP:
            E("    addi sp, sp, 4\n");
            break;

        /* --- arithmetic --- */
        case OP_ADD: pop_t1_t0(); E("    add  t0, t0, t1\n"); push_t0(); break;
        case OP_SUB: pop_t1_t0(); E("    sub  t0, t0, t1\n"); push_t0(); break;
        case OP_MUL: pop_t1_t0(); E("    mul  t0, t0, t1\n"); push_t0(); break;
        case OP_DIV: pop_t1_t0(); E("    div  t0, t0, t1\n"); push_t0(); break;
        case OP_MOD: pop_t1_t0(); E("    rem  t0, t0, t1\n"); push_t0(); break;
        case OP_AND: pop_t1_t0(); E("    and  t0, t0, t1\n"); push_t0(); break;
        case OP_OR:  pop_t1_t0(); E("    or   t0, t0, t1\n"); push_t0(); break;
        case OP_XOR: pop_t1_t0(); E("    xor  t0, t0, t1\n"); push_t0(); break;
        case OP_SHL: pop_t1_t0(); E("    sll  t0, t0, t1\n"); push_t0(); break;
        case OP_SHR: pop_t1_t0(); E("    sra  t0, t0, t1\n"); push_t0(); break;

        /* --- comparisons (result: 1 or 0) --- */
        case OP_EQ:
            pop_t1_t0();
            E("    sub  t0, t0, t1\n");
            E("    seqz t0, t0\n");
            push_t0(); break;
        case OP_NE:
            pop_t1_t0();
            E("    sub  t0, t0, t1\n");
            E("    snez t0, t0\n");
            push_t0(); break;
        case OP_LT:
            pop_t1_t0();
            E("    slt  t0, t0, t1\n");
            push_t0(); break;
        case OP_LE:
            /* a <= b  ≡  NOT (b < a) */
            pop_t1_t0();
            E("    slt  t0, t1, t0\n");
            E("    xori t0, t0, 1\n");
            push_t0(); break;
        case OP_GT:
            pop_t1_t0();
            E("    slt  t0, t1, t0\n");
            push_t0(); break;
        case OP_GE:
            /* a >= b  ≡  NOT (a < b) */
            pop_t1_t0();
            E("    slt  t0, t0, t1\n");
            E("    xori t0, t0, 1\n");
            push_t0(); break;

        case OP_NEG:
            pop_t0();
            E("    neg  t0, t0\n");
            push_t0(); break;
        case OP_LNOT:
            pop_t0();
            E("    seqz t0, t0\n");
            push_t0(); break;

        case OP_CAST: {
            pop_t0();
            const char *ty = ins->sarg;
            if      (!strcmp(ty,"u8"))   E("    andi t0, t0, 0xff\n");
            else if (!strcmp(ty,"u16"))  E("    slli t0, t0, 16\n    srli t0, t0, 16\n");
            else if (!strcmp(ty,"i8"))   E("    slli t0, t0, 24\n    srai t0, t0, 24\n");
            else if (!strcmp(ty,"i16"))  E("    slli t0, t0, 16\n    srai t0, t0, 16\n");
            else if (!strcmp(ty,"bool")) E("    snez t0, t0\n");
            /* u32, i32: no-op (already 32-bit) */
            push_t0();
            break;
        }

        case OP_JUMP:
            E("    j    .L_f%d_pc%ld\n", fi, ins->ival);
            break;
        case OP_JUMP_IF:
            /* jump_if: jump when t0 != 0
               → skip j if t0 == 0, else fall through to j */
            pop_t0();
            E("    beqz t0, __skip_%d\n", g_skip_id);
            E("    j    .L_f%d_pc%ld\n", fi, ins->ival);
            E("__skip_%d:\n", g_skip_id);
            g_skip_id++;
            break;
        case OP_JUMP_IFNOT:
            /* jump_ifnot: jump when t0 == 0
               → skip j if t0 != 0, else fall through to j */
            pop_t0();
            E("    bnez t0, __skip_%d\n", g_skip_id);
            E("    j    .L_f%d_pc%ld\n", fi, ins->ival);
            E("__skip_%d:\n", g_skip_id);
            g_skip_id++;
            break;

        } /* switch */
    }

    /* ensure function always ends with a ret */
    E("    # end of %s\n", fn->name);
    E("\n");
}

/* Escape a C string for .string directive */
static void emit_strdata(FILE *f, const char *s) {
    fputc('"', f);
    for (; *s; s++) {
        unsigned char c = (unsigned char)*s;
        if      (c == '"')  fputs("\\\"", f);
        else if (c == '\\') fputs("\\\\", f);
        else if (c == '\n') fputs("\\n",  f);
        else if (c == '\r') fputs("\\r",  f);
        else if (c == '\t') fputs("\\t",  f);
        else if (c < 0x20 || c == 0x7f) fprintf(f, "\\%03o", c);
        else fputc(c, f);
    }
    fputc('"', f);
}

static void emit_program(BcProg *prog) {
    out = stdout;

    /* --- .rodata: string literals as count-prefixed objects --- */
    if (prog->nstrings > 0) {
        E("    .section .rodata\n");
        for (int i = 0; i < prog->nstrings; i++) {
            const char *s = prog->strings[i] ? prog->strings[i] : "";
            E("    .align 4\n");
            E("__tc_strobj%d:\n", i);
            E("    .word %d\n", (int)strlen(s));    /* count */
            E("    .string "); emit_strdata(out, s); E("\n");  /* data follows inline */
        }
        E("\n");
    }

    /* --- .data: global variables --- */
    if (prog->nglobals > 0) {
        E("    .data\n");
        for (int i = 0; i < prog->nglobals; i++) {
            E("    .globl %s\n", prog->global_names[i]);
            E("%s:\n    .word %d\n", prog->global_names[i], prog->global_inits[i]);
        }
        E("\n");
    }

    /* --- .text: functions --- */
    E("    .text\n");
    E("    .align 2\n\n");
    for (int i = 0; i < prog->nfuncs; i++)
        emit_fn(&prog->funcs[i], i);
}

int main(int argc, char *argv[]) {
    FILE *in;
    if (argc > 1) {
        in = fopen(argv[1], "r");
        if (!in) { perror(argv[1]); return 1; }
    } else {
        in = stdin;
    }

    BcProg *prog = bc_parse(in);
    if (argc > 1) fclose(in);

    emit_program(prog);
    return 0;
}
