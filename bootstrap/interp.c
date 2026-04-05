#include "interp.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>
#include <unistd.h>

/* ---- Value types ---- */

typedef enum {
    VAL_INT,
    VAL_REF,
    VAL_VOID,
} ValKind;

typedef struct HeapObj HeapObj;

typedef struct {
    ValKind kind;
    int32_t ival;
    HeapObj *ref;
} Value;

typedef enum {
    OBJ_ARRAY,
    OBJ_STRUCT,
    OBJ_STRING,
} ObjKind;

struct HeapObj {
    ObjKind kind;
    char *type_name;
    int size;
    int len;
    int is_literal;
    Value *fields;
    uint8_t *bytes;
    int ref_count;
    struct HeapObj *next; /* for heap linked list */
};

static Value val_int(int32_t v) { Value r; r.kind = VAL_INT; r.ival = v; r.ref = NULL; return r; }
static Value val_ref(HeapObj *o) { Value r; r.kind = VAL_REF; r.ival = 0; r.ref = o; return r; }
static Value val_void(void) { Value r; r.kind = VAL_VOID; r.ival = 0; r.ref = NULL; return r; }

/* ---- Heap ---- */

typedef struct {
    HeapObj *head;
} Heap;

static Heap g_heap;

static HeapObj *heap_alloc(ObjKind kind, const char *type_name) {
    HeapObj *o = calloc(1, sizeof(HeapObj));
    if (!o) { fprintf(stderr, "out of memory\n"); exit(1); }
    o->kind = kind;
    o->type_name = strdup(type_name);
    o->ref_count = 1;
    o->next = g_heap.head;
    g_heap.head = o;
    return o;
}

static void heap_obj_free(HeapObj *o) {
    if (!o) return;
    if (!o->is_literal) {
        free(o->bytes);
        free(o->fields);
    }
    free(o->type_name);
    free(o);
}

/* ---- fake memory for peek/poke ---- */
#define FAKE_MEM_SIZE (1024*1024)
static uint8_t fake_mem[FAKE_MEM_SIZE];

/* ---- Variable frames ---- */

typedef struct VarBinding {
    char *name;
    Value val;
    struct VarBinding *next;
} VarBinding;

typedef struct Frame {
    VarBinding *vars;
    struct Frame *parent;
} Frame;

typedef struct {
    Frame *frame;
    Frame *global_frame;
    AstNode *program;
    /* for control flow */
    int returning;
    int breaking;
    int continuing;
    Value ret_val;
} Interp;

static void frame_push(Interp *ip) {
    Frame *f = calloc(1, sizeof(Frame));
    f->parent = ip->frame;
    ip->frame = f;
}

static void frame_pop(Interp *ip) {
    Frame *f = ip->frame;
    if (!f) return;
    VarBinding *b = f->vars;
    while (b) {
        VarBinding *nx = b->next;
        free(b->name);
        free(b);
        b = nx;
    }
    ip->frame = f->parent;
    free(f);
}

static void frame_set(Frame *f, const char *name, Value val) {
    for (VarBinding *b = f->vars; b; b = b->next) {
        if (strcmp(b->name, name) == 0) {
            b->val = val;
            return;
        }
    }
    VarBinding *b = calloc(1, sizeof(VarBinding));
    b->name = strdup(name);
    b->val = val;
    b->next = f->vars;
    f->vars = b;
}

static Value *frame_get_local(Frame *f, const char *name) {
    for (VarBinding *b = f->vars; b; b = b->next)
        if (strcmp(b->name, name) == 0) return &b->val;
    return NULL;
}

static Value var_get(Interp *ip, const char *name) {
    for (Frame *f = ip->frame; f; f = f->parent) {
        Value *v = frame_get_local(f, name);
        if (v) return *v;
    }
    Value *v = frame_get_local(ip->global_frame, name);
    if (v) return *v;
    fprintf(stderr, "runtime error: undefined variable '%s'\n", name);
    exit(1);
}

static void var_set(Interp *ip, const char *name, Value val) {
    /* search current scope chain */
    for (Frame *f = ip->frame; f; f = f->parent) {
        for (VarBinding *b = f->vars; b; b = b->next) {
            if (strcmp(b->name, name) == 0) {
                b->val = val;
                return;
            }
        }
    }
    /* global */
    for (VarBinding *b = ip->global_frame->vars; b; b = b->next) {
        if (strcmp(b->name, name) == 0) {
            b->val = val;
            return;
        }
    }
    /* define in current frame */
    frame_set(ip->frame, name, val);
}

static void var_define(Interp *ip, const char *name, Value val) {
    frame_set(ip->frame, name, val);
}

/* ---- find function node ---- */

static AstNode *find_fn(Interp *ip, const char *name,
                          Value *args, int nargs) {
    /* look in program for fn with matching name and arg types */
    for (int i = 0; i < ip->program->nchildren; i++) {
        AstNode *d = ip->program->children[i];
        if (strcmp(d->kind, "fn") != 0) continue;
        if (strcmp(d->sval, name) != 0) continue;
        AstNode *params = d->children[0];
        if (params->nchildren != nargs) continue;
        /* match types */
        int ok = 1;
        for (int j = 0; j < nargs && ok; j++) {
            AstNode *param = params->children[j];
            const char *pty = param->type_annot ? param->type_annot :
                              (param->children[0]->sval ? param->children[0]->sval : "?");
            Value *av = &args[j];
            /* check compatibility */
            if (av->kind == VAL_INT) {
                if (!( strcmp(pty,"i8")==0 || strcmp(pty,"i16")==0 || strcmp(pty,"i32")==0 ||
                       strcmp(pty,"u8")==0 || strcmp(pty,"u16")==0 || strcmp(pty,"u32")==0 ||
                       strcmp(pty,"bool")==0 ))
                    ok = 0;
            } else if (av->kind == VAL_REF) {
                /* At runtime all references share a common representation.
                   Overload resolution between distinct reference types
                   (String, XxxArray, struct types) is a compile-time
                   concern — mangled names already encode the distinction.
                   The interp accepts any ref for any ref-typed param. */
                (void)av;
            }
        }
        if (ok) return d;
    }
    return NULL;
}

/* ---- forward declare ---- */
static Value eval_expr(Interp *ip, AstNode *node);
static void exec_block(Interp *ip, AstNode *block);

/* ---- built-in function dispatch ---- */

static Value call_builtin(Interp *ip, const char *name, Value *args, int nargs) {
    /* peek/poke */
    if (strcmp(name, "peek8") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr < FAKE_MEM_SIZE) return val_int(fake_mem[addr]);
        return val_int(0);
    }
    if (strcmp(name, "peek16") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr + 1 < FAKE_MEM_SIZE)
            return val_int(*(uint16_t*)(fake_mem + addr));
        return val_int(0);
    }
    if (strcmp(name, "peek32") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr + 3 < FAKE_MEM_SIZE)
            return val_int((int32_t)*(uint32_t*)(fake_mem + addr));
        return val_int(0);
    }
    if (strcmp(name, "poke8") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr < FAKE_MEM_SIZE) fake_mem[addr] = (uint8_t)args[1].ival;
        return val_void();
    }
    if (strcmp(name, "poke16") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr + 1 < FAKE_MEM_SIZE) *(uint16_t*)(fake_mem + addr) = (uint16_t)args[1].ival;
        return val_void();
    }
    if (strcmp(name, "poke32") == 0) {
        uint32_t addr = (uint32_t)args[0].ival;
        if (addr + 3 < FAKE_MEM_SIZE) *(uint32_t*)(fake_mem + addr) = (uint32_t)args[1].ival;
        return val_void();
    }

    /* sys_write(fd, buf, len) */
    if (strcmp(name, "sys_write") == 0 && nargs == 3) {
        int fd = args[0].ival;
        HeapObj *buf = args[1].ref;
        int len = args[2].ival;
        if (buf && buf->kind == OBJ_ARRAY) {
            int actual = len < buf->size ? len : buf->size;
            uint8_t *data = malloc(actual);
            for (int i = 0; i < actual; i++)
                data[i] = (uint8_t)buf->fields[i].ival;
            int r = (int)write(fd, data, actual);
            free(data);
            return val_int(r);
        }
        return val_int(-1);
    }

    /* sys_read(fd, buf, len) */
    if (strcmp(name, "sys_read") == 0 && nargs == 3) {
        int fd = args[0].ival;
        HeapObj *buf = args[1].ref;
        int len = args[2].ival;
        if (buf && buf->kind == OBJ_ARRAY) {
            int actual = len < buf->size ? len : buf->size;
            uint8_t *data = malloc(actual);
            int r = (int)read(fd, data, actual);
            if (r > 0) {
                for (int i = 0; i < r; i++)
                    buf->fields[i].ival = data[i];
            }
            free(data);
            return val_int(r);
        }
        return val_int(-1);
    }

    /* sys_exit */
    if (strcmp(name, "sys_exit") == 0 && nargs == 1) {
        exit(args[0].ival);
    }

    /* print helpers */
    if (strcmp(name, "print_i32") == 0 && nargs == 1) {
        printf("%d\n", (int)args[0].ival);
        return val_void();
    }
    if (strcmp(name, "print_u32") == 0 && nargs == 1) {
        printf("%u\n", (unsigned)args[0].ival);
        return val_void();
    }
    if (strcmp(name, "print_bool") == 0 && nargs == 1) {
        printf("%s\n", args[0].ival ? "true" : "false");
        return val_void();
    }
    if (strcmp(name, "print_str") == 0 && nargs == 1) {
        HeapObj *s = args[0].ref;
        if (s && s->kind == OBJ_STRING && s->bytes)
            fwrite(s->bytes, 1, s->len, stdout);
        putchar('\n');
        return val_void();
    }

    /* XxxArray(size) — constructor name == type name */
    {
        int arr_len = strlen(name);
        if (arr_len > 5 && strcmp(name + arr_len - 5, "Array") == 0 && isupper((unsigned char)name[0]) && nargs == 1) {
            int sz = args[0].ival;
            HeapObj *obj = heap_alloc(OBJ_ARRAY, name);
            obj->size = sz;
            obj->fields = calloc(sz > 0 ? sz : 1, sizeof(Value));
            return val_ref(obj);
        }
    }

    /* len(arr) or len(str) */
    if (strcmp(name, "len") == 0 && nargs == 1) {
        HeapObj *o = args[0].ref;
        if (!o) return val_int(0);
        if (o->kind == OBJ_ARRAY) return val_int(o->size);
        if (o->kind == OBJ_STRING) return val_int(o->len);
        return val_int(0);
    }

    /* get(arr_or_str, idx) */
    if (strcmp(name, "get") == 0 && nargs == 2) {
        HeapObj *o = args[0].ref;
        int idx = args[1].ival;
        if (!o) { fprintf(stderr, "get: null\n"); exit(1); }
        if (o->kind == OBJ_STRING) {
            if (idx < 0 || idx >= o->len) return val_int(0);
            return val_int(o->bytes[idx]);
        }
        if (idx < 0 || idx >= o->size) {
            fprintf(stderr, "get: index %d out of bounds (size %d)\n", idx, o->size);
            exit(1);
        }
        return o->fields[idx];
    }

    /* set(arr, idx, val) */
    if (strcmp(name, "set") == 0 && nargs == 3) {
        HeapObj *o = args[0].ref;
        int idx = args[1].ival;
        Value val = args[2];
        if (!o) { fprintf(stderr, "set: null array\n"); exit(1); }
        if (idx < 0 || idx >= o->size) {
            fprintf(stderr, "set: index %d out of bounds (size %d)\n", idx, o->size);
            exit(1);
        }
        o->fields[idx] = val;
        return val_void();
    }

    /* delete */
    if (strcmp(name, "delete") == 0 && nargs == 1) {
        /* simple: just mark for GC or do nothing in this simple impl */
        return val_void();
    }

    /* String operations */

    /* append(s, c) -> String or append(s, t) -> String */
    if (strcmp(name, "append") == 0 && nargs == 2) {
        HeapObj *s = args[0].ref;
        if (!s) return args[0];
        if (args[1].kind == VAL_INT) {
            /* append char */
            HeapObj *ns = heap_alloc(OBJ_STRING, "String");
            ns->len = s->len + 1;
            ns->size = ns->len + 1;
            ns->bytes = malloc(ns->size);
            memcpy(ns->bytes, s->bytes, s->len);
            ns->bytes[s->len] = (uint8_t)args[1].ival;
            ns->bytes[ns->len] = '\0';
            return val_ref(ns);
        } else {
            /* append string */
            HeapObj *t = args[1].ref;
            if (!t) return args[0];
            HeapObj *ns = heap_alloc(OBJ_STRING, "String");
            ns->len = s->len + t->len;
            ns->size = ns->len + 1;
            ns->bytes = malloc(ns->size);
            memcpy(ns->bytes, s->bytes, s->len);
            memcpy(ns->bytes + s->len, t->bytes, t->len);
            ns->bytes[ns->len] = '\0';
            return val_ref(ns);
        }
    }

    /* equals(s, t) -> bool */
    if (strcmp(name, "equals") == 0 && nargs == 2) {
        HeapObj *s = args[0].ref;
        HeapObj *t = args[1].ref;
        if (!s || !t) return val_int(s == t ? 1 : 0);
        if (s->len != t->len) return val_int(0);
        return val_int(memcmp(s->bytes, t->bytes, s->len) == 0 ? 1 : 0);
    }

    return val_void(); /* unhandled built-in */
}

static int is_builtin(const char *name) {
    static const char *builtins[] = {
        "peek8","peek16","peek32","poke8","poke16","poke32",
        "sys_write","sys_read","sys_exit",
        "print_i32","print_u32","print_bool","print_str",
        "len","get","set","delete","append","equals",
        NULL
    };
    for (int i = 0; builtins[i]; i++)
        if (strcmp(name, builtins[i]) == 0) return 1;
    { int n = strlen(name); if (n > 5 && strcmp(name+n-5,"Array")==0 && isupper((unsigned char)name[0])) return 1; }
    return 0;
}

/* ---- call user function ---- */

static Value call_fn(Interp *ip, AstNode *fn_node, Value *args, int nargs) {
    AstNode *params = fn_node->children[0];
    AstNode *body = fn_node->children[2];

    frame_push(ip);
    for (int i = 0; i < nargs; i++) {
        const char *pname = params->children[i]->sval;
        var_define(ip, pname, args[i]);
    }

    ip->returning = 0;
    exec_block(ip, body);
    Value ret = ip->returning ? ip->ret_val : val_void();
    ip->returning = 0;
    frame_pop(ip);
    return ret;
}

/* ---- dispatch call ---- */

static Value dispatch_call(Interp *ip, const char *name, Value *args, int nargs) {
    if (is_builtin(name)) {
        return call_builtin(ip, name, args, nargs);
    }
    AstNode *fn = find_fn(ip, name, args, nargs);
    if (!fn) {
        /* try built-in as fallback (e.g. newStructName) */
        return call_builtin(ip, name, args, nargs);
    }
    return call_fn(ip, fn, args, nargs);
}

/* ---- evaluate expressions ---- */

static Value eval_expr(Interp *ip, AstNode *node) {
    const char *k = node->kind;

    if (strcmp(k, "int") == 0) {
        return val_int((int32_t)node->ival);
    }

    if (strcmp(k, "bool") == 0) {
        return val_int(node->ival ? 1 : 0);
    }

    if (strcmp(k, "str") == 0) {
        HeapObj *s = heap_alloc(OBJ_STRING, "String");
        const char *txt = node->sval ? node->sval : "";
        s->len = (int)strlen(txt);
        s->size = s->len + 1;
        s->bytes = malloc(s->size);
        memcpy(s->bytes, txt, s->len);
        s->bytes[s->len] = '\0';
        s->is_literal = 1;
        return val_ref(s);
    }

    if (strcmp(k, "var") == 0) {
        return var_get(ip, node->sval);
    }

    if (strcmp(k, "call") == 0) {
        int nargs = node->nchildren;
        Value *args = nargs > 0 ? malloc(nargs * sizeof(Value)) : NULL;
        for (int i = 0; i < nargs; i++)
            args[i] = eval_expr(ip, node->children[i]);
        Value r = dispatch_call(ip, node->sval, args, nargs);
        free(args);
        return r;
    }

    if (strcmp(k, "unary") == 0) {
        Value v = eval_expr(ip, node->children[0]);
        if (strcmp(node->sval, "!") == 0) return val_int(!v.ival);
        if (strcmp(node->sval, "-") == 0) return val_int(-v.ival);
        return v;
    }

    if (strcmp(k, "binop") == 0) {
        const char *op = node->sval;
        /* short-circuit for && and || */
        if (strcmp(op, "&&") == 0) {
            Value l = eval_expr(ip, node->children[0]);
            if (!l.ival) return val_int(0);
            return eval_expr(ip, node->children[1]);
        }
        if (strcmp(op, "||") == 0) {
            Value l = eval_expr(ip, node->children[0]);
            if (l.ival) return val_int(1);
            return eval_expr(ip, node->children[1]);
        }
        Value l = eval_expr(ip, node->children[0]);
        Value r = eval_expr(ip, node->children[1]);
        int32_t a = l.ival, b = r.ival;
        if (strcmp(op, "+") == 0) return val_int(a + b);
        if (strcmp(op, "-") == 0) return val_int(a - b);
        if (strcmp(op, "*") == 0) return val_int(a * b);
        if (strcmp(op, "/") == 0) {
            if (b == 0) { fprintf(stderr, "division by zero\n"); exit(1); }
            return val_int(a / b);
        }
        if (strcmp(op, "%") == 0) {
            if (b == 0) { fprintf(stderr, "modulo by zero\n"); exit(1); }
            return val_int(a % b);
        }
        if (strcmp(op, "&") == 0) return val_int(a & b);
        if (strcmp(op, "|") == 0) return val_int(a | b);
        if (strcmp(op, "^") == 0) return val_int(a ^ b);
        if (strcmp(op, "<<") == 0) return val_int(a << b);
        if (strcmp(op, ">>") == 0) return val_int(a >> b);
        if (strcmp(op, "==") == 0) return val_int(a == b);
        if (strcmp(op, "!=") == 0) return val_int(a != b);
        if (strcmp(op, "<") == 0) return val_int(a < b);
        if (strcmp(op, "<=") == 0) return val_int(a <= b);
        if (strcmp(op, ">") == 0) return val_int(a > b);
        if (strcmp(op, ">=") == 0) return val_int(a >= b);
        fprintf(stderr, "unknown binop '%s'\n", op);
        exit(1);
    }

    if (strcmp(k, "cast") == 0) {
        Value v = eval_expr(ip, node->children[0]);
        const char *target = node->children[1]->sval;
        /* truncate integer casts */
        if (strcmp(target, "u8") == 0) return val_int((uint8_t)v.ival);
        if (strcmp(target, "u16") == 0) return val_int((uint16_t)v.ival);
        if (strcmp(target, "u32") == 0) return val_int((int32_t)(uint32_t)v.ival);
        if (strcmp(target, "i8") == 0) return val_int((int8_t)v.ival);
        if (strcmp(target, "i16") == 0) return val_int((int16_t)v.ival);
        if (strcmp(target, "i32") == 0) return val_int((int32_t)v.ival);
        if (strcmp(target, "bool") == 0) return val_int(v.ival ? 1 : 0);
        return v;
    }

    fprintf(stderr, "unknown expr node kind '%s'\n", k);
    exit(1);
}

/* ---- execute statements ---- */

static void exec_stmt(Interp *ip, AstNode *node) {
    if (ip->returning || ip->breaking || ip->continuing) return;
    const char *k = node->kind;

    if (strcmp(k, "var_decl") == 0) {
        Value v = val_void();
        if (node->nchildren > 1) {
            v = eval_expr(ip, node->children[1]);
        } else {
            /* zero-initialize */
            v = val_int(0);
        }
        var_define(ip, node->sval, v);
        return;
    }

    if (strcmp(k, "assign") == 0) {
        Value v = eval_expr(ip, node->children[0]);
        var_set(ip, node->sval, v);
        return;
    }

    if (strcmp(k, "call_stmt") == 0) {
        int nargs = node->nchildren;
        Value *args = nargs > 0 ? malloc(nargs * sizeof(Value)) : NULL;
        for (int i = 0; i < nargs; i++)
            args[i] = eval_expr(ip, node->children[i]);
        dispatch_call(ip, node->sval, args, nargs);
        free(args);
        return;
    }

    if (strcmp(k, "if") == 0) {
        Value cond = eval_expr(ip, node->children[0]);
        if (cond.ival) {
            frame_push(ip);
            exec_block(ip, node->children[1]);
            frame_pop(ip);
        } else if (node->nchildren > 2) {
            if (strcmp(node->children[2]->kind, "if") == 0) {
                exec_stmt(ip, node->children[2]);
            } else {
                frame_push(ip);
                exec_block(ip, node->children[2]);
                frame_pop(ip);
            }
        }
        return;
    }

    if (strcmp(k, "while") == 0) {
        while (1) {
            Value cond = eval_expr(ip, node->children[0]);
            if (!cond.ival) break;
            frame_push(ip);
            exec_block(ip, node->children[1]);
            frame_pop(ip);
            if (ip->returning) break;
            if (ip->breaking)  { ip->breaking = 0; break; }
            if (ip->continuing){ ip->continuing = 0; }
        }
        return;
    }

    if (strcmp(k, "break") == 0)    { ip->breaking   = 1; return; }
    if (strcmp(k, "continue") == 0) { ip->continuing  = 1; return; }

    if (strcmp(k, "return") == 0) {
        if (node->nchildren > 0) {
            ip->ret_val = eval_expr(ip, node->children[0]);
        } else {
            ip->ret_val = val_void();
        }
        ip->returning = 1;
        return;
    }

    fprintf(stderr, "unknown stmt kind '%s'\n", k);
    exit(1);
}

static void exec_block(Interp *ip, AstNode *block) {
    for (int i = 0; i < block->nchildren; i++) {
        if (ip->returning || ip->breaking || ip->continuing) return;
        exec_stmt(ip, block->children[i]);
    }
}

/* ---- main entry ---- */

int interpret(AstNode *program) {
    Interp ip;
    memset(&ip, 0, sizeof(ip));
    ip.program = program;

    /* global frame */
    Frame *gf = calloc(1, sizeof(Frame));
    ip.global_frame = gf;
    ip.frame = gf;

    /* initialize global variables */
    for (int i = 0; i < program->nchildren; i++) {
        AstNode *d = program->children[i];
        if (strcmp(d->kind, "var_decl") == 0) {
            Value v = val_int(0);
            if (d->nchildren > 1) v = eval_expr(&ip, d->children[1]);
            frame_set(gf, d->sval, v);
        }
    }

    /* find and call main */
    Value no_args[1];
    AstNode *main_fn = find_fn(&ip, "main", no_args, 0);
    if (!main_fn) {
        fprintf(stderr, "no main() function found\n");
        return 1;
    }

    Value result = call_fn(&ip, main_fn, no_args, 0);

    /* cleanup global frame */
    ip.frame = gf;
    frame_pop(&ip);

    if (result.kind == VAL_INT) return (int)result.ival;
    return 0;
}
