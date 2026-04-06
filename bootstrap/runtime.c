/*
 * runtime.c — C runtime support for bc2asm-generated code (hosted).
 *
 * Implements mangled-name functions called by the generated assembly.
 * Provides heap-based array/string objects matching the interpreter's model.
 *
 * Compile with the generated assembly:
 *   riscv32-unknown-linux-gnu-gcc program.s runtime.c -o program
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

/* ===== HeapObj (mirrors interp.c / bcrun.c) ===== */

#define OBJ_ARRAY  0
#define OBJ_STRING 1

typedef struct HeapObj {
    int      kind;
    char    *type_name;
    int      size;
    int      len;
    int      is_literal;
    int32_t *fields;   /* array elements (int32_t for uniformity) */
    uint8_t *bytes;    /* string data */
} HeapObj;

static HeapObj *alloc_obj(int kind, const char *type_name) {
    HeapObj *o = calloc(1, sizeof(HeapObj));
    o->kind      = kind;
    o->type_name = strdup(type_name);
    return o;
}

/* ===== Print helpers ===== */

void print_i32__i32(int32_t v) { printf("%d\n", v); }
void print_u32__u32(uint32_t v) { printf("%u\n", v); }
void print_bool__bool(int32_t v) { printf("%s\n", v ? "true" : "false"); }

void print_str__String(HeapObj *s) {
    if (s && s->kind == OBJ_STRING && s->bytes)
        fwrite(s->bytes, 1, s->len, stdout);
    putchar('\n');
}

/* ===== Array operations ===== */

static HeapObj *new_array(const char *type_name, int32_t size) {
    HeapObj *o = alloc_obj(OBJ_ARRAY, type_name);
    o->size   = size;
    o->fields = calloc(size > 0 ? size : 1, sizeof(int32_t));
    return o;
}

/* Array constructors — mangled as TypeName__i32 */
#define ARRAY_CTOR(T) HeapObj * T##__i32(int32_t sz) { return new_array(#T, sz); }
ARRAY_CTOR(U8Array)
ARRAY_CTOR(U16Array)
ARRAY_CTOR(U32Array)
ARRAY_CTOR(I8Array)
ARRAY_CTOR(I16Array)
ARRAY_CTOR(I32Array)
ARRAY_CTOR(StringArray)

/* len — all array/string types share the same implementation */
static int32_t len_impl(HeapObj *o) {
    if (!o) return 0;
    return o->kind == OBJ_ARRAY ? o->size : o->len;
}
#define LEN_ALIAS(T) int32_t len__##T(HeapObj *o) { return len_impl(o); }
LEN_ALIAS(U8Array)   LEN_ALIAS(U16Array)  LEN_ALIAS(U32Array)
LEN_ALIAS(I8Array)   LEN_ALIAS(I16Array)  LEN_ALIAS(I32Array)
LEN_ALIAS(StringArray) LEN_ALIAS(String)

/* get — all array/string types share the same implementation */
static int32_t get_impl(HeapObj *o, int32_t idx) {
    if (!o) { fprintf(stderr, "runtime: get null\n"); exit(1); }
    if (o->kind == OBJ_STRING) {
        if (idx < 0 || idx >= o->len) return 0;
        return (uint8_t)o->bytes[idx];
    }
    if (idx < 0 || idx >= o->size) {
        fprintf(stderr, "runtime: get out of bounds %d/%d\n", idx, o->size);
        exit(1);
    }
    return o->fields[idx];
}
#define GET_ALIAS(T) int32_t get__##T##__i32(HeapObj *o, int32_t i) { return get_impl(o, i); }
GET_ALIAS(U8Array)   GET_ALIAS(U16Array)  GET_ALIAS(U32Array)
GET_ALIAS(I8Array)   GET_ALIAS(I16Array)  GET_ALIAS(I32Array)
GET_ALIAS(StringArray) GET_ALIAS(String)

/* set — all array types share the same implementation */
static void set_impl(HeapObj *o, int32_t idx, int32_t val) {
    if (!o || idx < 0 || idx >= o->size) {
        fprintf(stderr, "runtime: set out of bounds %d/%d\n", idx, o ? o->size : 0);
        exit(1);
    }
    o->fields[idx] = val;
}
void set__U8Array__i32__u8    (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__U16Array__i32__u16  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__U32Array__i32__u32  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I8Array__i32__i8    (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I16Array__i32__i16  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I32Array__i32__i32  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__StringArray__i32__String(HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }

/* delete — all types share the same implementation */
static void delete_impl(HeapObj *o) {
    if (!o || o->is_literal) return;
    free(o->fields);
    free(o->bytes);
    free(o->type_name);
    free(o);
}
#define DELETE_ALIAS(T) void delete__##T(HeapObj *o) { delete_impl(o); }
DELETE_ALIAS(U8Array)   DELETE_ALIAS(U16Array)  DELETE_ALIAS(U32Array)
DELETE_ALIAS(I8Array)   DELETE_ALIAS(I16Array)  DELETE_ALIAS(I32Array)
DELETE_ALIAS(StringArray) DELETE_ALIAS(String)

/* Mark/reset are no-ops (pool allocator handles memory in runtime_syscall.c) */
int32_t heap_mark(void) { return 0; }
void heap_reset__i32(int32_t mark) { (void)mark; }

/* ===== String operations ===== */

HeapObj *append__String__u8(HeapObj *s, int32_t c) {
    HeapObj *ns = alloc_obj(OBJ_STRING, "String");
    ns->len   = s ? s->len + 1 : 1;
    ns->bytes = malloc(ns->len + 1);
    if (s) memcpy(ns->bytes, s->bytes, s->len);
    ns->bytes[ns->len - 1] = (uint8_t)c;
    ns->bytes[ns->len] = '\0';
    return ns;
}

HeapObj *append__String__String(HeapObj *s, HeapObj *t) {
    HeapObj *ns = alloc_obj(OBJ_STRING, "String");
    int sl = s ? s->len : 0, tl = t ? t->len : 0;
    ns->len   = sl + tl;
    ns->bytes = malloc(ns->len + 1);
    if (s) memcpy(ns->bytes,      s->bytes, sl);
    if (t) memcpy(ns->bytes + sl, t->bytes, tl);
    ns->bytes[ns->len] = '\0';
    return ns;
}

int32_t equals__String__String(HeapObj *s, HeapObj *t) {
    if (!s || !t) return s == t;
    if (s->len != t->len) return 0;
    return memcmp(s->bytes, t->bytes, s->len) == 0;
}

/* ===== peek / poke ===== */

uint32_t peek8__u32 (uint32_t addr) { return *(uint8_t  *)addr; }
uint32_t peek16__u32(uint32_t addr) { return *(uint16_t *)addr; }
uint32_t peek32__u32(uint32_t addr) { return *(uint32_t *)addr; }
void poke8__u32__u32 (uint32_t addr, uint32_t v) { *(uint8_t  *)addr = v; }
void poke16__u32__u32(uint32_t addr, uint32_t v) { *(uint16_t *)addr = v; }
void poke32__u32__u32(uint32_t addr, uint32_t v) { *(uint32_t *)addr = v; }

/* ===== sys calls ===== */

int32_t sys_write__i32__U8Array__i32(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    uint8_t *tmp = malloc(n);
    for (int i = 0; i < n; i++) tmp[i] = (uint8_t)buf->fields[i];
    int r = (int)write(fd, tmp, n);
    free(tmp);
    return r;
}

int32_t sys_read__i32__U8Array__i32(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    uint8_t *tmp = malloc(n);
    int r = (int)read(fd, tmp, n);
    if (r > 0) for (int i = 0; i < r; i++) buf->fields[i] = tmp[i];
    free(tmp);
    return r;
}

/* sys_exit is inlined by bc2asm as ecall; this is a fallback */
void sys_exit__i32(int32_t code) { exit(code); }
