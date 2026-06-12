/*
 * gcc_libc.c — picolibc-facing libc shim for GCC-compiled guest tasks.
 *
 * picolibc supplies the heavy lifting (printf / malloc / strcmp / sin /
 * cos / FILE buffering) and asks the platform to provide:
 *
 *   - POSIX syscall wrappers (open / read / write / close / lseek /
 *     unlink / rename) that translate to our ecall ABI.
 *   - stdin / stdout / stderr FILE objects so anything that writes
 *     via fprintf(stderr, ...) or printf(...) lands on the right fd.
 *   - _sbrk for the bump allocator picolibc malloc layers itself onto.
 *   - _exit so picolibc's exit/abort eventually terminate the task.
 *
 * We also expose:
 *
 *   - _libc_init_heap (called by gcc_crt0.s before main): drains the
 *     kernel-provided arena into the sbrk state block.
 *   - _libc_unpack_argv_to: converts the kernel's StringArray to a
 *     C-style argv[] in a caller-provided buffer.
 *
 * Kernel ecall ABI (a7 = syscall #):
 *   34 mkdir(path:String)         87 unlink(path:String)
 *     [no rename yet]            56 openat(dirfd, path:String, flags)
 *   57 close(fd)                 63 read(fd, buf, n)
 *   64 write(fd, buf, n)         93 exit(rc)
 *
 * Path arguments are kernel-side `String` values (`[count:u32][bytes][\0]`),
 * NOT NUL-terminated C strings. The wrappers in this file build a
 * temporary String on the caller's stack so picolibc's C-string callers
 * can keep talking C-string. PATH_MAX is capped at 256.
 */

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* Syscall stubs. ABI: a7 = syscall number, a0..a5 = args, a0 = return. */
static inline long _syscall3(long n, long a, long b, long c) {
    register long _a __asm__("a0") = a;
    register long _b __asm__("a1") = b;
    register long _c __asm__("a2") = c;
    register long _n __asm__("a7") = n;
    __asm__ volatile("ecall"
                     : "+r"(_a)
                     : "r"(_b), "r"(_c), "r"(_n)
                     : "memory");
    return _a;
}
static inline long _syscall1(long n, long a) {
    register long _a __asm__("a0") = a;
    register long _n __asm__("a7") = n;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_n) : "memory");
    return _a;
}

/* ---------- POSIX-ish syscalls ---------- */

long write(int fd, const void *buf, unsigned long n) {
    return _syscall3(64, fd, (long)buf, n);
}

long read(int fd, void *buf, unsigned long n) {
    return _syscall3(63, fd, (long)buf, n);
}

long close(int fd) { return _syscall1(57, fd); }

void _exit(int rc) {
    _syscall1(93, rc);
    for (;;) {}
}

/* openat-style: takes a kernel-side String (length-prefixed) for path.
   Used by callers (libtc-style) that already hold a String value. */
long do_openat(int dirfd, const void *path_str, int flags) {
    return _syscall3(56, dirfd, (long)path_str, flags);
}

/* ---------- C-string → String path wrappers for picolibc ---------- */

/* Cap on path length we feed into the kernel. DOOM file names are well
   under this; tighten later if it starts costing stack. */
#define _LIBC_PATH_MAX 256

/* Build a kernel-side String in `out` from a NUL-terminated C path.
   out must have room for 4 + len + 1 bytes (header + payload + NUL).
   Returns the length of the path (≤ _LIBC_PATH_MAX-5) or -1 on
   overflow. */
static long _path_to_string(const char *path, char *out) {
    unsigned long len = 0;
    while (path[len] && len < _LIBC_PATH_MAX - 5) {
        out[4 + len] = path[len];
        len++;
    }
    if (path[len] != '\0') return -1;       /* path too long */
    *(uint32_t *)out = (uint32_t)len;
    out[4 + len] = '\0';
    return (long)len;
}

#define _AT_FDCWD (-100)

int open(const char *path, int flags, ...) {
    char buf[_LIBC_PATH_MAX];
    if (_path_to_string(path, buf) < 0) return -1;
    return (int)_syscall3(56, _AT_FDCWD, (long)buf, flags);
}

int unlink(const char *path) {
    char buf[_LIBC_PATH_MAX];
    if (_path_to_string(path, buf) < 0) return -1;
    return (int)_syscall1(87, (long)buf);
}

int mkdir(const char *path, unsigned int mode) {
    (void)mode;     /* kernel mkdir takes path only (no perms yet) */
    char buf[_LIBC_PATH_MAX];
    if (_path_to_string(path, buf) < 0) return -1;
    return (int)_syscall1(34, (long)buf);
}

/* Our kernel doesn't currently have lseek or rename. Stub them as
   "not supported" so picolibc can still link — DOOM's WAD reader
   only uses lseek for forward/backward seeks on a WAD file, and we'll
   wire it up properly in Phase 4. rename is hit by save-game logic,
   which is far down the scope list. */
long lseek(int fd, long offset, int whence) {
    (void)fd; (void)offset; (void)whence;
    return -1;
}

int rename(const char *oldp, const char *newp) {
    (void)oldp; (void)newp;
    return -1;
}

/* ---------- stdin / stdout / stderr ---------- */

static int _stdout_put(char c, FILE *f) {
    (void)f;
    write(1, &c, 1);
    return (unsigned char)c;
}

static int _stderr_put(char c, FILE *f) {
    (void)f;
    write(2, &c, 1);
    return (unsigned char)c;
}

static int _stdin_get(FILE *f) {
    (void)f;
    unsigned char c;
    long n = read(0, &c, 1);
    if (n != 1) return _FDEV_EOF;
    return c;
}

static FILE __stdin_file  = FDEV_SETUP_STREAM(NULL,        _stdin_get, NULL, _FDEV_SETUP_READ);
static FILE __stdout_file = FDEV_SETUP_STREAM(_stdout_put, NULL,       NULL, _FDEV_SETUP_WRITE);
static FILE __stderr_file = FDEV_SETUP_STREAM(_stderr_put, NULL,       NULL, _FDEV_SETUP_WRITE);

FILE *const stdin  = &__stdin_file;
FILE *const stdout = &__stdout_file;
FILE *const stderr = &__stderr_file;

/* ---------- sbrk bump allocator ---------- */

/* The three heap pointers (base / brk / end) live in the first 16
   bytes of the kernel-provided arena. gcc_crt0.s sets `tp = arena
   addr` so libc can read/write them through tp directly without
   touching gp or the binutils gp-relax pass. The kernel's
   trap_common.s preserves tp across context switches the same way
   it does s0..s11.

   Two reasons we don't put the heap pointers in .bss:
   - The binutils gp-relax pass has a quirk where one of several
     consecutive `auipc + lw/sw` pairs silently fails to collapse to
     `lw/sw rd, off(gp)`; the surviving auipc bakes in the link-time
     VMA and the task crashes when the kernel loads it elsewhere.
   - Tasks with > 4 KB of .data (anything picolibc-linked) push the
     gp window beyond the heap pointers' VMAs anyway, so the relax
     wouldn't help even if it worked. */
typedef struct { char *base; char *brk; char *end; } heap_state_t;

static inline heap_state_t *_heap_state(void) {
    heap_state_t *p;
    __asm__("mv %0, tp" : "=r"(p));
    return p;
}

void _libc_init_heap(void *arena_addr, long arena_size) {
    heap_state_t *h = _heap_state();
    h->base = (char *)arena_addr;
    h->brk  = (char *)arena_addr;
    h->end  = (char *)arena_addr + arena_size;
}

void *_sbrk(long n) {
    heap_state_t *h = _heap_state();
    if (h->brk == 0) return (void *)-1;
    char *prev = h->brk;
    char *next = prev + n;
    if (next < h->base || next > h->end) return (void *)-1;
    h->brk = next;
    return prev;
}

/* ---------- argv unpacking ---------- */

/* Cap on argv we hand to main; bigger requests fall off the end.
   The buffer lives on the task's stack (allocated by gcc_crt0),
   not as a libc global — keeps the gp-relative addressing surface
   small (just the heap pointers) and lets each spawn get a fresh
   argv area without a wipe step. */
#define ARGV_MAX 32

/* Each kernel-side String / StringLiteral is laid out as:
     [count:u32][bytes...][\0]    — bytes is `count` long
   Translate to a C-pointer to the first byte of `bytes`. The NUL byte
   after `bytes` is guaranteed by the kernel's argv packer (kernel/
   loader.tc::pack_argv_at), so the resulting pointer is a valid
   C-string for any consumer that strlen()s it. */
static char *_string_to_cstr(unsigned long s_ptr) {
    if (s_ptr == 0) return 0;
    return (char *)(s_ptr + 4);
}

/* Translate the kernel's StringArray into a C-style argv[] in the
   caller-provided buffer. Returns argc. argv must hold at least
   ARGV_MAX + 1 char* slots so we can NUL-terminate. */
int _libc_unpack_argv_to(unsigned long sa_ptr, char **argv) {
    if (sa_ptr == 0) {
        argv[0] = 0;
        return 0;
    }
    unsigned long *base = (unsigned long *)sa_ptr;
    unsigned int  count = (unsigned int)base[0];
    if (count > ARGV_MAX) count = ARGV_MAX;
    for (unsigned int i = 0; i < count; i++) {
        argv[i] = _string_to_cstr(base[1 + i]);
    }
    argv[count] = 0;
    return (int)count;
}
