/*
 * runtime.c — C runtime support for bc2asm-generated code.
 *
 * Implements __tc_<name> functions called by the generated assembly.
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

/* ===== String construction ===== */

/* Called by push_str: wrap a .rodata string pointer into a HeapObj. */
HeapObj *__tc_make_string(const char *data, int len) {
    HeapObj *o = alloc_obj(OBJ_STRING, "String");
    o->len       = len;
    o->bytes     = (uint8_t *)data;  /* point directly into rodata */
    o->is_literal = 1;
    return o;
}

/* ===== Print helpers ===== */

void __tc_print_i32(int32_t v) { printf("%d\n", v); }
void __tc_print_u32(uint32_t v) { printf("%u\n", v); }
void __tc_print_bool(int32_t v) { printf("%s\n", v ? "true" : "false"); }

void __tc_print_str(HeapObj *s) {
    if (s && s->kind == OBJ_STRING && s->bytes)
        fwrite(s->bytes, 1, s->len, stdout);
    putchar('\n');
}

/* ===== Array operations ===== */

HeapObj *__tc_newArray(const char *type_name, int32_t size) {
    HeapObj *o = alloc_obj(OBJ_ARRAY, type_name);
    o->size   = size;
    o->fields = calloc(size > 0 ? size : 1, sizeof(int32_t));
    return o;
}

/* Constructors — name = type name (e.g., U8Array(size)) */
HeapObj *__tc_U8Array (int32_t sz) { return __tc_newArray("U8Array",  sz); }
HeapObj *__tc_U16Array(int32_t sz) { return __tc_newArray("U16Array", sz); }
HeapObj *__tc_U32Array(int32_t sz) { return __tc_newArray("U32Array", sz); }
HeapObj *__tc_I8Array (int32_t sz) { return __tc_newArray("I8Array",  sz); }
HeapObj *__tc_I16Array(int32_t sz) { return __tc_newArray("I16Array", sz); }
HeapObj *__tc_I32Array(int32_t sz) { return __tc_newArray("I32Array", sz); }
/* Legacy aliases */
HeapObj *__tc_newU8Array (int32_t sz) { return __tc_U8Array(sz); }
HeapObj *__tc_newU16Array(int32_t sz) { return __tc_U16Array(sz); }
HeapObj *__tc_newU32Array(int32_t sz) { return __tc_U32Array(sz); }
HeapObj *__tc_newI8Array (int32_t sz) { return __tc_I8Array(sz); }
HeapObj *__tc_newI16Array(int32_t sz) { return __tc_I16Array(sz); }
HeapObj *__tc_newI32Array(int32_t sz) { return __tc_I32Array(sz); }

int32_t __tc_len(HeapObj *o) {
    if (!o) return 0;
    return o->kind == OBJ_ARRAY ? o->size : o->len;
}

int32_t __tc_get(HeapObj *o, int32_t idx) {
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

void __tc_set(HeapObj *o, int32_t idx, int32_t val) {
    if (!o || idx < 0 || idx >= o->size) {
        fprintf(stderr, "runtime: set out of bounds %d/%d\n", idx, o ? o->size : 0);
        exit(1);
    }
    o->fields[idx] = val;
}

void __tc_delete(HeapObj *o) {
    if (!o || o->is_literal) return;
    free(o->fields);
    if (!o->is_literal) free(o->bytes);
    free(o->type_name);
    free(o);
}

/* ===== String operations ===== */

HeapObj *__tc_append_char(HeapObj *s, int32_t c) {
    HeapObj *ns = alloc_obj(OBJ_STRING, "String");
    ns->len   = s ? s->len + 1 : 1;
    ns->bytes = malloc(ns->len + 1);
    if (s) memcpy(ns->bytes, s->bytes, s->len);
    ns->bytes[ns->len - 1] = (uint8_t)c;
    ns->bytes[ns->len] = '\0';
    return ns;
}

HeapObj *__tc_append_str(HeapObj *s, HeapObj *t) {
    HeapObj *ns = alloc_obj(OBJ_STRING, "String");
    int sl = s ? s->len : 0, tl = t ? t->len : 0;
    ns->len   = sl + tl;
    ns->bytes = malloc(ns->len + 1);
    if (s) memcpy(ns->bytes,      s->bytes, sl);
    if (t) memcpy(ns->bytes + sl, t->bytes, tl);
    ns->bytes[ns->len] = '\0';
    return ns;
}

int32_t __tc_equals(HeapObj *s, HeapObj *t) {
    if (!s || !t) return s == t;
    if (s->len != t->len) return 0;
    return memcmp(s->bytes, t->bytes, s->len) == 0;
}

/* ===== peek / poke ===== */

uint8_t  __tc_peek8 (uint32_t addr) { return *(uint8_t  *)addr; }
uint16_t __tc_peek16(uint32_t addr) { return *(uint16_t *)addr; }
uint32_t __tc_peek32(uint32_t addr) { return *(uint32_t *)addr; }
void __tc_poke8 (uint32_t addr, uint8_t  v) { *(uint8_t  *)addr = v; }
void __tc_poke16(uint32_t addr, uint16_t v) { *(uint16_t *)addr = v; }
void __tc_poke32(uint32_t addr, uint32_t v) { *(uint32_t *)addr = v; }

/* ===== sys calls ===== */

int32_t __tc_sys_write(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    uint8_t *tmp = malloc(n);
    for (int i = 0; i < n; i++) tmp[i] = (uint8_t)buf->fields[i];
    int r = (int)write(fd, tmp, n);
    free(tmp);
    return r;
}

int32_t __tc_sys_read(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    uint8_t *tmp = malloc(n);
    int r = (int)read(fd, tmp, n);
    if (r > 0) for (int i = 0; i < r; i++) buf->fields[i] = tmp[i];
    free(tmp);
    return r;
}

/* sys_exit is inlined by bc2asm as ecall; this is a fallback */
void __tc_sys_exit(int32_t code) { exit(code); }
