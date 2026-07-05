# Single source of truth for the kernel_pico2.tc self-build module
# layout. Sourced by:
#   - integration/scripts/gen_self_replicate_fixtures.sh
#     → regenerates pico2_self_step{1,2}.sh and pico2_compile_kern{,2}.sh
#   - integration/pico2_self_replicate.sh
#     → derives INPUT_NAMES for compile-gen2.sh
#
# Order MUST match compile-gen2.sh's emit order for kernel_pico2.tc.
# To verify after editing, run:
#
#   bash integration/scripts/gen_self_replicate_fixtures.sh --check
#
# which rebuilds compile-gen2's intermediate dir and compares against
# this manifest.
#
# Format per entry: <short>|<path-relative-to-repo-root>
# Direct imports are auto-extracted from `grep '^import' <path>` at
# generation time (see gen_self_replicate_fixtures.sh).

KERNEL_MODULES=(
    "kc|kernel/src/kernel_common.tc"
    "pp|kernel/platform/pico2/platform_pico2.tc"
    "bf|kernel/platform/pico2/block_flash.tc"
    "bs|kernel/platform/pico2/block_sd.tc"
    "ff|kernel/src/fatfs.tc"
    "mf|kernel/src/mtfs.tc"
    "tf|kernel/src/tmpfs.tc"
    "pf|kernel/src/procfs.tc"
    "rt|kernel/src/rtc.tc"
    "df|kernel/src/devfs.tc"
    "vf|kernel/src/vfs.tc"
    "ld|kernel/src/loader.tc"
    "r3|kernel/platform/pico2/rtc_ds3231.tc"
    "di|kernel/platform/pico2/display_ili9488.tc"
    "km|kernel/platform/pico2/keyboard_matrix.tc"
    "tp|kernel/platform/pico2/touch_xpt2046.tc"
    "kp|kernel/src/kernel_pico2.tc"
)

# Helper functions sourcing scripts can call:
#   module_short_names    → echoes "kc pp bf ... kp"
#   module_path_by_short SHORT  → echoes the full path
#   module_direct_imports SHORT → echoes space-separated short names of
#                                 direct imports (e.g. "kc rt" for df)
#                                 Auto-computed from `grep '^import'`.

module_short_names() {
    local out="" e
    for e in "${KERNEL_MODULES[@]}"; do
        out="$out ${e%%|*}"
    done
    echo "${out# }"
}

module_path_by_short() {
    local want="$1" e short path
    for e in "${KERNEL_MODULES[@]}"; do
        IFS='|' read -r short path <<< "$e"
        if [ "$short" = "$want" ]; then
            echo "$path"
            return 0
        fi
    done
    return 1
}

# Build a basename→short lookup so we can map `import "vfs.tc"` →
# short name "vf". O(N) per call but N=16 keeps this trivial.
_module_short_by_basename() {
    local want="$1" e short path bn
    for e in "${KERNEL_MODULES[@]}"; do
        IFS='|' read -r short path <<< "$e"
        bn="${path##*/}"
        if [ "$bn" = "$want" ]; then
            echo "$short"
            return 0
        fi
    done
    return 1
}

module_direct_imports() {
    local want="$1" path imp bn short out=""
    path=$(module_path_by_short "$want") || return 1
    while IFS= read -r line; do
        # `import "foo/bar.tc";` → bar.tc
        bn=$(printf '%s' "$line" | sed -n 's/^import "\(.*\)";$/\1/p')
        [ -z "$bn" ] && continue
        bn="${bn##*/}"
        short=$(_module_short_by_basename "$bn") || continue
        out="$out $short"
    done < <(grep '^import "' "$path" 2>/dev/null)
    echo "${out# }"
}
