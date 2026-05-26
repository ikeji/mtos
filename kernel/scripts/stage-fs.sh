#!/bin/bash
# stage-fs.sh — copy files into mtfs root according to a fs-spec.
#
# Usage: stage-fs.sh <root-dir> <spec-file>
#
# spec syntax (kernel/fs-spec/*.spec):
#   # comment
#   *include <relative-path>     ; include another spec (path is relative
#                                 ; to the current spec's directory)
#   <mtfs-path> <host-path>      ; copy ROOT/<host-path> →
#                                 ; <root-dir>/<mtfs-path>
# Blank lines are ignored. Each mtfs-path starts with `/`.
#
# `<host-path>` is interpreted relative to the project root (the directory
# containing this script's parent's parent — i.e., kernel/scripts/ → ROOT).

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <root-dir> <spec-file>" >&2
    exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
out_root="$1"
spec_file="$2"

if [ ! -d "$out_root" ]; then
    echo "Error: output root does not exist: $out_root" >&2
    exit 1
fi
if [ ! -f "$spec_file" ]; then
    echo "Error: spec file not found: $spec_file" >&2
    exit 1
fi

_process_spec() {
    local spec="$1"
    local spec_dir
    spec_dir=$(cd "$(dirname "$spec")" && pwd)
    local line lineno=0
    while IFS= read -r line || [ -n "$line" ]; do
        lineno=$((lineno + 1))
        # Strip comments and trim
        line="${line%%#*}"
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        [ -z "$line" ] && continue
        case "$line" in
            "*include "*)
                local target="${line#\*include }"
                local target_path
                if [[ "$target" = /* ]]; then
                    target_path="$target"
                else
                    target_path="$spec_dir/$target"
                fi
                if [ ! -f "$target_path" ]; then
                    echo "Error: $spec:$lineno: included spec not found: $target_path" >&2
                    exit 1
                fi
                _process_spec "$target_path"
                ;;
            "*"*)
                echo "Error: $spec:$lineno: unknown directive: $line" >&2
                exit 1
                ;;
            *)
                local mtfs_path host_path
                mtfs_path=$(echo "$line" | awk '{print $1}')
                host_path=$(echo "$line" | awk '{print $2}')
                if [ -z "$mtfs_path" ] || [ -z "$host_path" ]; then
                    echo "Error: $spec:$lineno: malformed entry: $line" >&2
                    exit 1
                fi
                # mtfs path must start with /
                case "$mtfs_path" in
                    /*) ;;
                    *)
                        echo "Error: $spec:$lineno: mtfs path must start with /: $mtfs_path" >&2
                        exit 1
                        ;;
                esac
                local src="$ROOT_DIR/$host_path"
                if [ ! -f "$src" ]; then
                    echo "Error: $spec:$lineno: host file not found: $host_path" >&2
                    exit 1
                fi
                local dest="$out_root${mtfs_path}"
                mkdir -p "$(dirname "$dest")"
                cp "$src" "$dest"
                ;;
        esac
    done < "$spec"
}

_process_spec "$spec_file"
