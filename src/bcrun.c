/*
 * bcrun — bytecode interpreter for the .bc stack-machine format.
 * Standalone: no dependency on lexer/parser/typecheck/ast.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>
#include <unistd.h>

/* ===== Values ===== */

typedef enum { VAL_INT, VAL_REF, VAL_VOID } ValKind;
typedef struct HeapObj HeapObj;

typedef struct {
    ValKind  kind;
    int32_t  ival;
    HeapObj *ref;
} Value;

typedef enum { OBJ_ARRAY, OBJ_STRING } ObjKind;

struct HeapObj {
    ObjKind  kind;
    char    *type_name;
    int      size;   /* capacity / element count for arrays */
    int      len;    /* used length for strings */
    int      is_literal;
    Value   *fields; /* array elements or struct fields */
    uint8_t *bytes;  /* raw bytes for strings */
    struct HeapObj *next;
};

static Value val_int (int32_t v)  { Value r; r.kind=VAL_INT;  r.ival=v; r.ref=NULL; return r; }
static Value val_ref (HeapObj *o) { Value r; r.kind=VAL_REF;  r.ival=0; r.ref=o;    return r; }
static Value val_void(void)       { Value r; r.kind=VAL_VOID; r.ival=0; r.ref=NULL; return r; }

static HeapObj *g_heap = NULL;

static HeapObj *heap_alloc(ObjKind kind, const char *type_name) {
    HeapObj *o = calloc(1, sizeof(HeapObj));
    if (!o) { fprintf(stderr, "bcrun: out of memory\n"); exit(1); }
    o->kind      = kind;
    o->type_name = strdup(type_name);
    o->next      = g_heap;
    g_heap       = o;
    return o;
}

/* ===== Opcodes ===== */

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
    long   ival;  /* integer operand, nargs, or resolved jump PC */
    char  *sarg;  /* name, type, or pre-resolution label */
} Instr;

/* ===== Function ===== */

typedef struct {
    char  *name;
    char  *ret_type;
    char **param_names;
    char **param_types;
    int    nparams;
    char **local_names;
    char **local_types;
    int    nlocals;
    Instr *instrs;
    int    ninstrs, instrs_cap;
} BcFunc;

/* ===== Program ===== */

typedef struct {
    char  **strings;
    int     nstrings, strings_cap;
    char  **global_names;
    char  **global_types;
    int     nglobals,  globals_cap;
    BcFunc *funcs;
    int     nfuncs,    funcs_cap;
} BcProg;

/* ===== Parser helpers ===== */

static char *skip_ws(char *s) {
    while (*s && isspace((unsigned char)*s)) s++;
    return s;
}

/* Read one whitespace-delimited token into out[maxlen]. Returns ptr after token. */
static char *next_tok(char *s, char *out, int maxlen) {
    int i = 0;
    while (*s && !isspace((unsigned char)*s) && i < maxlen - 1)
        out[i++] = *s++;
    out[i] = '\0';
    return s;
}

/* Parse escaped string literal after the opening '"'.
   Returns pointer past closing '"'. */
static char *parse_strlit(char *s, char *buf, int buflen) {
    int i = 0;
    while (*s && *s != '"' && i < buflen - 1) {
        if (*s == '\\') {
            s++;
            switch (*s) {
                case 'n':  buf[i++] = '\n'; break;
                case 'r':  buf[i++] = '\r'; break;
                case 't':  buf[i++] = '\t'; break;
                case '"':  buf[i++] = '"';  break;
                case '\\': buf[i++] = '\\'; break;
                case 'x': {
                    s++;
                    char hex[3] = { s[0], s[1], '\0' };
                    buf[i++] = (char)strtol(hex, NULL, 16);
                    s++;
                    break;
                }
                default: buf[i++] = *s;
            }
        } else {
            buf[i++] = *s;
        }
        s++;
    }
    buf[i] = '\0';
    if (*s == '"') s++;
    return s;
}

/* ===== Label table (temporary during parsing) ===== */

typedef struct { char *name; int pc; } LabelEnt;

typedef struct {
    LabelEnt *entries;
    int count, cap;
} LabelTab;

static void label_add(LabelTab *lt, const char *name, int pc) {
    if (lt->count >= lt->cap) {
        lt->cap  = lt->cap ? lt->cap * 2 : 16;
        lt->entries = realloc(lt->entries, lt->cap * sizeof(LabelEnt));
    }
    lt->entries[lt->count].name = strdup(name);
    lt->entries[lt->count].pc   = pc;
    lt->count++;
}

static int label_find(LabelTab *lt, const char *name) {
    for (int i = 0; i < lt->count; i++)
        if (strcmp(lt->entries[i].name, name) == 0) return lt->entries[i].pc;
    fprintf(stderr, "bcrun: unresolved label '%s'\n", name);
    exit(1);
}

static void label_free(LabelTab *lt) {
    for (int i = 0; i < lt->count; i++) free(lt->entries[i].name);
    free(lt->entries);
    lt->count = lt->cap = 0; lt->entries = NULL;
}

/* ===== Program builders ===== */

static void prog_set_string(BcProg *p, int idx, const char *s) {
    while (p->nstrings <= idx) {
        if (p->nstrings >= p->strings_cap) {
            p->strings_cap = p->strings_cap ? p->strings_cap * 2 : 16;
            p->strings = realloc(p->strings, p->strings_cap * sizeof(char*));
        }
        p->strings[p->nstrings++] = NULL;
    }
    free(p->strings[idx]);
    p->strings[idx] = strdup(s);
}

static void prog_add_global(BcProg *p, const char *name, const char *type) {
    if (p->nglobals >= p->globals_cap) {
        p->globals_cap = p->globals_cap ? p->globals_cap * 2 : 8;
        p->global_names = realloc(p->global_names, p->globals_cap * sizeof(char*));
        p->global_types = realloc(p->global_types, p->globals_cap * sizeof(char*));
    }
    p->global_names[p->nglobals] = strdup(name);
    p->global_types[p->nglobals] = strdup(type);
    p->nglobals++;
}

static BcFunc *prog_new_func(BcProg *p) {
    if (p->nfuncs >= p->funcs_cap) {
        p->funcs_cap = p->funcs_cap ? p->funcs_cap * 2 : 8;
        p->funcs = realloc(p->funcs, p->funcs_cap * sizeof(BcFunc));
    }
    BcFunc *f = &p->funcs[p->nfuncs++];
    memset(f, 0, sizeof(BcFunc));
    return f;
}

static void func_add_param(BcFunc *f, const char *nm, const char *ty) {
    f->param_names = realloc(f->param_names, (f->nparams+1) * sizeof(char*));
    f->param_types = realloc(f->param_types, (f->nparams+1) * sizeof(char*));
    f->param_names[f->nparams] = strdup(nm);
    f->param_types[f->nparams] = strdup(ty);
    f->nparams++;
}

static void func_add_local(BcFunc *f, const char *nm, const char *ty) {
    f->local_names = realloc(f->local_names, (f->nlocals+1) * sizeof(char*));
    f->local_types = realloc(f->local_types, (f->nlocals+1) * sizeof(char*));
    f->local_names[f->nlocals] = strdup(nm);
    f->local_types[f->nlocals] = strdup(ty);
    f->nlocals++;
}

static void func_emit(BcFunc *f, Instr ins) {
    if (f->ninstrs >= f->instrs_cap) {
        f->instrs_cap = f->instrs_cap ? f->instrs_cap * 2 : 32;
        f->instrs = realloc(f->instrs, f->instrs_cap * sizeof(Instr));
    }
    f->instrs[f->ninstrs++] = ins;
}

/* Resolve all jump targets in f using label table. */
static void func_resolve_labels(BcFunc *f, LabelTab *lt) {
    for (int i = 0; i < f->ninstrs; i++) {
        Instr *ins = &f->instrs[i];
        if ((ins->op == OP_JUMP || ins->op == OP_JUMP_IF || ins->op == OP_JUMP_IFNOT)
            && ins->sarg) {
            ins->ival = label_find(lt, ins->sarg);
            free(ins->sarg);
            ins->sarg = NULL;
        }
    }
}

/* ===== .bc file parser ===== */

static BcProg *bc_parse(FILE *in) {
    BcProg  *p     = calloc(1, sizeof(BcProg));
    BcFunc  *cur   = NULL;
    LabelTab lt    = {0};
    char     line[4096];

    while (fgets(line, sizeof(line), in)) {
        /* strip trailing newline */
        int len = strlen(line);
        while (len > 0 && (line[len-1] == '\n' || line[len-1] == '\r'))
            line[--len] = '\0';

        char *s = skip_ws(line);
        if (!*s || *s == ';') continue;

        /* --- directives --- */
        if (*s == '.') {
            char dir[64];
            s = skip_ws(next_tok(s + 1, dir, sizeof(dir)));

            if (strcmp(dir, "string") == 0) {
                char idx_s[16]; s = skip_ws(next_tok(s, idx_s, sizeof(idx_s)));
                if (*s == '"') {
                    char buf[4096]; parse_strlit(s+1, buf, sizeof(buf));
                    prog_set_string(p, atoi(idx_s), buf);
                }
            } else if (strcmp(dir, "global") == 0) {
                char nm[128], ty[64];
                s = skip_ws(next_tok(s, nm, sizeof(nm)));
                next_tok(s, ty, sizeof(ty));
                prog_add_global(p, nm, ty);
            } else if (strcmp(dir, "fn") == 0) {
                char nm[128], np[16], rt[64];
                s = skip_ws(next_tok(s, nm,  sizeof(nm)));
                s = skip_ws(next_tok(s, np,  sizeof(np)));
                next_tok(s, rt, sizeof(rt));
                cur = prog_new_func(p);
                cur->name     = strdup(nm);
                cur->ret_type = strdup(rt);
                label_free(&lt);
            } else if (strcmp(dir, "param") == 0) {
                char nm[128], ty[64];
                s = skip_ws(next_tok(s, nm, sizeof(nm)));
                next_tok(s, ty, sizeof(ty));
                if (cur) func_add_param(cur, nm, ty);
            } else if (strcmp(dir, "local") == 0) {
                char nm[128], ty[64];
                s = skip_ws(next_tok(s, nm, sizeof(nm)));
                next_tok(s, ty, sizeof(ty));
                if (cur) func_add_local(cur, nm, ty);
            } else if (strcmp(dir, "endfn") == 0) {
                if (cur) { func_resolve_labels(cur, &lt); label_free(&lt); }
                cur = NULL;
            }
            continue;
        }

        /* --- label: __Lnn: --- */
        if (s[0]=='_' && s[1]=='_' && s[2]=='L' && cur) {
            const char *end = s;
            while (*end && *end != ':') end++;
            if (*end == ':') {
                int namelen = (int)(end - s);
                char *lname = malloc(namelen + 1);
                memcpy(lname, s, namelen); lname[namelen] = '\0';
                label_add(&lt, lname, cur->ninstrs);
                free(lname);
            }
            continue;
        }

        /* --- instruction --- */
        if (!cur) continue;

        char op[32];
        s = skip_ws(next_tok(s, op, sizeof(op)));

        Instr ins; memset(&ins, 0, sizeof(ins));

        if      (!strcmp(op, "push_int"))   { ins.op = OP_PUSH_INT;    ins.ival = atol(skip_ws(s)); }
        else if (!strcmp(op, "push_str"))   { ins.op = OP_PUSH_STR;    ins.ival = atol(skip_ws(s)); }
        else if (!strcmp(op, "load"))       { ins.op = OP_LOAD;        char n[128]; next_tok(s,n,sizeof(n)); ins.sarg=strdup(n); }
        else if (!strcmp(op, "store"))      { ins.op = OP_STORE;       char n[128]; next_tok(s,n,sizeof(n)); ins.sarg=strdup(n); }
        else if (!strcmp(op, "call")) {
            ins.op = OP_CALL;
            char nm[128], na[16];
            s = skip_ws(next_tok(s, nm, sizeof(nm)));
            next_tok(s, na, sizeof(na));
            ins.sarg = strdup(nm); ins.ival = atol(na);
        }
        else if (!strcmp(op, "return"))      { ins.op = OP_RETURN; }
        else if (!strcmp(op, "return_void")) { ins.op = OP_RETURN_VOID; }
        else if (!strcmp(op, "pop"))         { ins.op = OP_POP; }
        else if (!strcmp(op, "add"))         { ins.op = OP_ADD; }
        else if (!strcmp(op, "sub"))         { ins.op = OP_SUB; }
        else if (!strcmp(op, "mul"))         { ins.op = OP_MUL; }
        else if (!strcmp(op, "div"))         { ins.op = OP_DIV; }
        else if (!strcmp(op, "mod"))         { ins.op = OP_MOD; }
        else if (!strcmp(op, "and"))         { ins.op = OP_AND; }
        else if (!strcmp(op, "or"))          { ins.op = OP_OR; }
        else if (!strcmp(op, "xor"))         { ins.op = OP_XOR; }
        else if (!strcmp(op, "shl"))         { ins.op = OP_SHL; }
        else if (!strcmp(op, "shr"))         { ins.op = OP_SHR; }
        else if (!strcmp(op, "eq"))          { ins.op = OP_EQ; }
        else if (!strcmp(op, "ne"))          { ins.op = OP_NE; }
        else if (!strcmp(op, "lt"))          { ins.op = OP_LT; }
        else if (!strcmp(op, "le"))          { ins.op = OP_LE; }
        else if (!strcmp(op, "gt"))          { ins.op = OP_GT; }
        else if (!strcmp(op, "ge"))          { ins.op = OP_GE; }
        else if (!strcmp(op, "neg"))         { ins.op = OP_NEG; }
        else if (!strcmp(op, "lnot"))        { ins.op = OP_LNOT; }
        else if (!strcmp(op, "cast"))        { ins.op = OP_CAST;       char t[64]; next_tok(s,t,sizeof(t)); ins.sarg=strdup(t); }
        else if (!strcmp(op, "jump"))        { ins.op = OP_JUMP;       char l[64]; next_tok(s,l,sizeof(l)); ins.sarg=strdup(l); }
        else if (!strcmp(op, "jump_if"))     { ins.op = OP_JUMP_IF;    char l[64]; next_tok(s,l,sizeof(l)); ins.sarg=strdup(l); }
        else if (!strcmp(op, "jump_ifnot"))  { ins.op = OP_JUMP_IFNOT; char l[64]; next_tok(s,l,sizeof(l)); ins.sarg=strdup(l); }
        else { fprintf(stderr, "bcrun: unknown instruction '%s'\n", op); exit(1); }

        func_emit(cur, ins);
    }

    label_free(&lt);
    return p;
}

/* ===== Runtime ===== */

/* fake memory for peek/poke */
#define FAKE_MEM_SIZE (1024*1024)
static uint8_t fake_mem[FAKE_MEM_SIZE];

/* Variable frame */
typedef struct { char *name; Value val; } Slot;
typedef struct Frame {
    Slot  *slots;
    int    nslots, slots_cap;
    struct Frame *parent;
} Frame;

static Frame *frame_new(Frame *parent) {
    Frame *f = calloc(1, sizeof(Frame));
    f->parent = parent;
    return f;
}

static void frame_free(Frame *f) {
    for (int i = 0; i < f->nslots; i++) free(f->slots[i].name);
    free(f->slots);
    free(f);
}

static void frame_set(Frame *f, const char *name, Value v) {
    for (int i = 0; i < f->nslots; i++) {
        if (strcmp(f->slots[i].name, name) == 0) { f->slots[i].val = v; return; }
    }
    if (f->nslots >= f->slots_cap) {
        f->slots_cap = f->slots_cap ? f->slots_cap * 2 : 8;
        f->slots = realloc(f->slots, f->slots_cap * sizeof(Slot));
    }
    f->slots[f->nslots].name = strdup(name);
    f->slots[f->nslots].val  = v;
    f->nslots++;
}

static Value *frame_lookup(Frame *f, const char *name) {
    for (int i = 0; i < f->nslots; i++)
        if (strcmp(f->slots[i].name, name) == 0) return &f->slots[i].val;
    return NULL;
}

/* VM */
typedef struct {
    BcProg *prog;
    Value  *stack;
    int     sp, stack_cap;
    Frame  *frame;
    Frame  *global_frame;
} VM;

static void vm_push(VM *vm, Value v) {
    if (vm->sp >= vm->stack_cap) {
        vm->stack_cap = vm->stack_cap ? vm->stack_cap * 2 : 64;
        vm->stack = realloc(vm->stack, vm->stack_cap * sizeof(Value));
    }
    vm->stack[vm->sp++] = v;
}

static Value vm_pop(VM *vm) {
    if (vm->sp <= 0) { fprintf(stderr, "bcrun: stack underflow\n"); exit(1); }
    return vm->stack[--vm->sp];
}

static Value vm_var_load(VM *vm, const char *name) {
    for (Frame *f = vm->frame; f; f = f->parent) {
        Value *v = frame_lookup(f, name);
        if (v) return *v;
    }
    Value *v = frame_lookup(vm->global_frame, name);
    if (v) return *v;
    fprintf(stderr, "bcrun: undefined variable '%s'\n", name);
    exit(1);
}

static void vm_var_store(VM *vm, const char *name, Value val) {
    for (Frame *f = vm->frame; f; f = f->parent) {
        if (frame_lookup(f, name)) { frame_set(f, name, val); return; }
    }
    if (frame_lookup(vm->global_frame, name)) {
        frame_set(vm->global_frame, name, val); return;
    }
    /* new variable in current scope */
    frame_set(vm->frame, name, val);
}

/* ===== Built-in functions ===== */

static int is_builtin(const char *name) {
    static const char *B[] = {
        "peek8","peek16","peek32","poke8","poke16","poke32",
        "sys_write","sys_read","sys_exit",
        "print_i32","print_u32","print_bool","print_str",
        "len","get","set","delete","getChar","append","equals",
        NULL
    };
    for (int i = 0; B[i]; i++)
        if (strcmp(name, B[i]) == 0) return 1;
    if (strncmp(name, "new", 3) == 0) return 1;
    return 0;
}

static Value call_builtin(const char *name, Value *args, int nargs) {
    /* peek / poke */
    if (!strcmp(name,"peek8"))  { uint32_t a=(uint32_t)args[0].ival; return a<FAKE_MEM_SIZE ? val_int(fake_mem[a]) : val_int(0); }
    if (!strcmp(name,"peek16")) { uint32_t a=(uint32_t)args[0].ival; return a+1<FAKE_MEM_SIZE ? val_int(*(uint16_t*)(fake_mem+a)) : val_int(0); }
    if (!strcmp(name,"peek32")) { uint32_t a=(uint32_t)args[0].ival; return a+3<FAKE_MEM_SIZE ? val_int((int32_t)*(uint32_t*)(fake_mem+a)) : val_int(0); }
    if (!strcmp(name,"poke8"))  { uint32_t a=(uint32_t)args[0].ival; if(a<FAKE_MEM_SIZE) fake_mem[a]=(uint8_t)args[1].ival; return val_void(); }
    if (!strcmp(name,"poke16")) { uint32_t a=(uint32_t)args[0].ival; if(a+1<FAKE_MEM_SIZE) *(uint16_t*)(fake_mem+a)=(uint16_t)args[1].ival; return val_void(); }
    if (!strcmp(name,"poke32")) { uint32_t a=(uint32_t)args[0].ival; if(a+3<FAKE_MEM_SIZE) *(uint32_t*)(fake_mem+a)=(uint32_t)args[1].ival; return val_void(); }

    /* sys calls */
    if (!strcmp(name,"sys_write") && nargs==3) {
        int fd=args[0].ival; HeapObj *buf=args[1].ref; int len=args[2].ival;
        if (buf && buf->kind==OBJ_ARRAY) {
            int n=len<buf->size?len:buf->size; uint8_t *tmp=malloc(n);
            for(int i=0;i<n;i++) tmp[i]=(uint8_t)buf->fields[i].ival;
            int r=(int)write(fd,tmp,n); free(tmp); return val_int(r);
        }
        return val_int(-1);
    }
    if (!strcmp(name,"sys_read") && nargs==3) {
        int fd=args[0].ival; HeapObj *buf=args[1].ref; int len=args[2].ival;
        if (buf && buf->kind==OBJ_ARRAY) {
            int n=len<buf->size?len:buf->size; uint8_t *tmp=malloc(n);
            int r=(int)read(fd,tmp,n);
            if(r>0) for(int i=0;i<r;i++) buf->fields[i].ival=tmp[i];
            free(tmp); return val_int(r);
        }
        return val_int(-1);
    }
    if (!strcmp(name,"sys_exit") && nargs==1) exit(args[0].ival);

    /* print helpers */
    if (!strcmp(name,"print_i32"))  { printf("%d\n",  (int)args[0].ival);              return val_void(); }
    if (!strcmp(name,"print_u32"))  { printf("%u\n",  (unsigned)args[0].ival);          return val_void(); }
    if (!strcmp(name,"print_bool")) { printf("%s\n",  args[0].ival?"true":"false");     return val_void(); }
    if (!strcmp(name,"print_str"))  {
        HeapObj *s=args[0].ref;
        if(s && s->kind==OBJ_STRING && s->bytes) fwrite(s->bytes,1,s->len,stdout);
        putchar('\n'); return val_void();
    }

    /* newXxxArray(size) */
    if (strncmp(name,"new",3)==0 && nargs==1) {
        const char *aname=name+3; int alen=strlen(aname);
        if(alen>5 && !strcmp(aname+alen-5,"Array")) {
            int sz=args[0].ival; HeapObj *o=heap_alloc(OBJ_ARRAY,aname);
            o->size=sz; o->fields=calloc(sz>0?sz:1,sizeof(Value));
            return val_ref(o);
        }
    }

    /* array / string operations */
    if (!strcmp(name,"len") && nargs==1) {
        HeapObj *o=args[0].ref; if(!o) return val_int(0);
        return val_int(o->kind==OBJ_ARRAY ? o->size : o->len);
    }
    if (!strcmp(name,"get") && nargs==2) {
        HeapObj *o=args[0].ref; int idx=args[1].ival;
        if(!o){fprintf(stderr,"get: null\n");exit(1);}
        if(idx<0||idx>=o->size){fprintf(stderr,"get: index %d/%d\n",idx,o->size);exit(1);}
        return o->fields[idx];
    }
    if (!strcmp(name,"set") && nargs==3) {
        HeapObj *o=args[0].ref; int idx=args[1].ival;
        if(!o){fprintf(stderr,"set: null\n");exit(1);}
        if(idx<0||idx>=o->size){fprintf(stderr,"set: index %d/%d\n",idx,o->size);exit(1);}
        o->fields[idx]=args[2]; return val_void();
    }
    if (!strcmp(name,"delete")) return val_void();

    if (!strcmp(name,"getChar") && nargs==2) {
        HeapObj *s=args[0].ref; int idx=args[1].ival;
        if(!s||s->kind!=OBJ_STRING||idx<0||idx>=s->len) return val_int(0);
        return val_int(s->bytes[idx]);
    }
    if (!strcmp(name,"append") && nargs==2) {
        HeapObj *s=args[0].ref; if(!s) return args[0];
        if(args[1].kind==VAL_INT) {
            HeapObj *ns=heap_alloc(OBJ_STRING,"String");
            ns->len=s->len+1; ns->size=ns->len+1; ns->bytes=malloc(ns->size);
            memcpy(ns->bytes,s->bytes,s->len); ns->bytes[s->len]=(uint8_t)args[1].ival;
            ns->bytes[ns->len]='\0'; return val_ref(ns);
        } else {
            HeapObj *t=args[1].ref; if(!t) return args[0];
            HeapObj *ns=heap_alloc(OBJ_STRING,"String");
            ns->len=s->len+t->len; ns->size=ns->len+1; ns->bytes=malloc(ns->size);
            memcpy(ns->bytes,s->bytes,s->len); memcpy(ns->bytes+s->len,t->bytes,t->len);
            ns->bytes[ns->len]='\0'; return val_ref(ns);
        }
    }
    if (!strcmp(name,"equals") && nargs==2) {
        HeapObj *s=args[0].ref, *t=args[1].ref;
        if(!s||!t) return val_int(s==t);
        if(s->len!=t->len) return val_int(0);
        return val_int(memcmp(s->bytes,t->bytes,s->len)==0);
    }

    return val_void();
}

/* ===== VM execution ===== */

static Value vm_exec(VM *vm, BcFunc *fn, Value *args, int nargs);

static Value vm_dispatch(VM *vm, const char *name, Value *args, int nargs) {
    if (is_builtin(name)) return call_builtin(name, args, nargs);
    for (int i = 0; i < vm->prog->nfuncs; i++) {
        if (strcmp(vm->prog->funcs[i].name, name) == 0)
            return vm_exec(vm, &vm->prog->funcs[i], args, nargs);
    }
    /* fallback to builtin (e.g. newStructName) */
    return call_builtin(name, args, nargs);
}

static Value vm_exec(VM *vm, BcFunc *fn, Value *args, int nargs) {
    Frame *f = frame_new(vm->frame);
    vm->frame = f;

    /* bind parameters */
    for (int i = 0; i < nargs && i < fn->nparams; i++)
        frame_set(f, fn->param_names[i], args[i]);
    /* zero-initialize locals */
    for (int i = 0; i < fn->nlocals; i++)
        frame_set(f, fn->local_names[i], val_int(0));

    int saved_sp = vm->sp;
    int pc = 0;

    while (pc < fn->ninstrs) {
        Instr *ins = &fn->instrs[pc++];

        switch (ins->op) {

        case OP_PUSH_INT:
            vm_push(vm, val_int((int32_t)ins->ival));
            break;

        case OP_PUSH_STR: {
            int idx = (int)ins->ival;
            const char *txt = (idx>=0 && idx<vm->prog->nstrings && vm->prog->strings[idx])
                              ? vm->prog->strings[idx] : "";
            HeapObj *s = heap_alloc(OBJ_STRING, "String");
            s->len = strlen(txt); s->size = s->len+1;
            s->bytes = malloc(s->size);
            memcpy(s->bytes, txt, s->len); s->bytes[s->len] = '\0';
            s->is_literal = 1;
            vm_push(vm, val_ref(s));
            break;
        }

        case OP_LOAD:
            vm_push(vm, vm_var_load(vm, ins->sarg));
            break;

        case OP_STORE:
            vm_var_store(vm, ins->sarg, vm_pop(vm));
            break;

        case OP_CALL: {
            int na = (int)ins->ival;
            Value *a = na>0 ? malloc(na*sizeof(Value)) : NULL;
            for (int i = na-1; i >= 0; i--) a[i] = vm_pop(vm);
            Value r = vm_dispatch(vm, ins->sarg, a, na);
            free(a);
            vm_push(vm, r); /* always push (void result will be popped by pop instr) */
            break;
        }

        case OP_RETURN: {
            Value v = vm_pop(vm);
            vm->sp = saved_sp;
            vm->frame = f->parent; frame_free(f);
            return v;
        }

        case OP_RETURN_VOID:
            vm->sp = saved_sp;
            vm->frame = f->parent; frame_free(f);
            return val_void();

        case OP_POP:
            vm_pop(vm);
            break;

        case OP_ADD:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival+b.ival)); break; }
        case OP_SUB:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival-b.ival)); break; }
        case OP_MUL:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival*b.ival)); break; }
        case OP_DIV:  { Value b=vm_pop(vm),a=vm_pop(vm);
                        if(!b.ival){fprintf(stderr,"bcrun: div by zero\n");exit(1);}
                        vm_push(vm,val_int(a.ival/b.ival)); break; }
        case OP_MOD:  { Value b=vm_pop(vm),a=vm_pop(vm);
                        if(!b.ival){fprintf(stderr,"bcrun: mod by zero\n");exit(1);}
                        vm_push(vm,val_int(a.ival%b.ival)); break; }
        case OP_AND:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival&b.ival)); break; }
        case OP_OR:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival|b.ival)); break; }
        case OP_XOR:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival^b.ival)); break; }
        case OP_SHL:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival<<b.ival)); break; }
        case OP_SHR:  { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival>>b.ival)); break; }
        case OP_EQ:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival==b.ival)); break; }
        case OP_NE:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival!=b.ival)); break; }
        case OP_LT:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival<b.ival));  break; }
        case OP_LE:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival<=b.ival)); break; }
        case OP_GT:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival>b.ival));  break; }
        case OP_GE:   { Value b=vm_pop(vm),a=vm_pop(vm); vm_push(vm,val_int(a.ival>=b.ival)); break; }
        case OP_NEG:  { Value a=vm_pop(vm); vm_push(vm,val_int(-a.ival)); break; }
        case OP_LNOT: { Value a=vm_pop(vm); vm_push(vm,val_int(!a.ival)); break; }

        case OP_CAST: {
            Value a = vm_pop(vm); int32_t v = a.ival;
            const char *t = ins->sarg;
            if      (!strcmp(t,"u8"))   v=(uint8_t)v;
            else if (!strcmp(t,"u16"))  v=(uint16_t)v;
            else if (!strcmp(t,"u32"))  v=(int32_t)(uint32_t)v;
            else if (!strcmp(t,"i8"))   v=(int8_t)v;
            else if (!strcmp(t,"i16"))  v=(int16_t)v;
            else if (!strcmp(t,"bool")) v=v?1:0;
            vm_push(vm, val_int(v)); break;
        }

        case OP_JUMP:      pc = (int)ins->ival; break;
        case OP_JUMP_IF:   { Value c=vm_pop(vm); if( c.ival) pc=(int)ins->ival; break; }
        case OP_JUMP_IFNOT:{ Value c=vm_pop(vm); if(!c.ival) pc=(int)ins->ival; break; }

        } /* switch */
    }

    vm->sp = saved_sp;
    vm->frame = f->parent; frame_free(f);
    return val_void();
}

/* ===== main ===== */

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

    VM vm; memset(&vm, 0, sizeof(vm));
    vm.prog = prog;

    /* global frame */
    vm.global_frame = frame_new(NULL);
    vm.frame        = vm.global_frame;

    for (int i = 0; i < prog->nglobals; i++)
        frame_set(vm.global_frame, prog->global_names[i], val_int(0));

    /* find main */
    BcFunc *main_fn = NULL;
    for (int i = 0; i < prog->nfuncs; i++)
        if (!strcmp(prog->funcs[i].name, "main")) { main_fn = &prog->funcs[i]; break; }
    if (!main_fn) { fprintf(stderr, "bcrun: no main() found\n"); return 1; }

    Value result = vm_exec(&vm, main_fn, NULL, 0);

    free(vm.stack);
    frame_free(vm.global_frame);

    return result.kind == VAL_INT ? (int)result.ival : 0;
}
