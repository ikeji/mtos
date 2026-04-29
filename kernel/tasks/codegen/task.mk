EXTRA_GUEST_TASKS += codegen
# 192 KB. Hello World peak 77 KB; bumped for headroom on bc2asm.tc-class
# inputs. See docs/scaling.md Q5.
TASK_ARENA_codegen := 196608
TASK_STACK_codegen := 16384
