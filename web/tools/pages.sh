#!/bin/bash
# pages.sh — build the static GitHub Pages site for web/ and (optionally)
# publish it on the gh-pages branch.
#
#   web/tools/pages.sh dist      # assemble web/build/dist/ (page + src + vendor + kernels/*.bin)
#   web/tools/pages.sh deploy    # dist, smoke-test it (tests/test_dist.sh), force-push as one orphan commit to gh-pages
#
# The kernels come from kernel/build/tn20k_kernel*.bin (build them first:
# make -C kernel tn20k tn20k-extra tn20k-console tn20k-console-land
# tn20k-console-vram tn20k-console-text). Missing ones are skipped with
# a warning. The page fetches them from kernels/ next to index.html (in
# the repository that is a symlink to ../kernel/build), so the dist
# directory works as-is from any static host; the repo's gh-pages branch is served at
# https://<owner>.github.io/<repo>/ once Pages is set to that branch
# (settings → Pages → source: gh-pages / root, or
# gh api -X POST repos/<owner>/<repo>/pages -f 'source[branch]=gh-pages' -f 'source[path]=/').
#
# gh-pages holds one commit per deploy (history is thrown away each time)
# so the ~16 MB of kernel binaries do not pile up in the repository. The
# push goes to the https URL of the `github` remote through gh's
# credential helper (the ssh remote needs a key agent); override with
# PAGES_REMOTE=url.
set -eu
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
DIST="$WEB/build/dist"
WT="$WEB/build/gh-pages"
mode="${1:-dist}"

dist() {
    rm -rf "$DIST"
    mkdir -p "$DIST/kernels"
    cp "$WEB/index.html" "$DIST/"
    cp -r "$WEB/src" "$WEB/vendor" "$DIST/"
    rm -f "$DIST/src/node_run.js"                 # Node-only runner, not for the page
    touch "$DIST/.nojekyll"                       # serve files starting with _ / . as-is, no Jekyll pass
    local n=0
    for v in "" _extra _console _console_land _console_vram _console_text; do
        local bin="$ROOT/kernel/build/tn20k_kernel$v.bin"
        if [ -s "$bin" ]; then cp "$bin" "$DIST/kernels/"; n=$((n + 1))
        else echo "pages: WARNING: $bin missing (make -C kernel tn20k$(echo "$v" | tr _ -))" >&2; fi
    done
    [ "$n" -gt 0 ] || { echo "pages: no kernels built" >&2; exit 1; }
    # record what went in, for the deploy commit and for humans
    { echo "built from $(git -C "$ROOT" rev-parse --short HEAD) on $(date -u +%Y-%m-%dT%H:%MZ)";
      (cd "$DIST" && find . -type f -not -path './.git/*' | sort | while read -r f; do printf '%8d %s\n' "$(stat -c %s "$f")" "${f#./}"; done); } > "$DIST/MANIFEST.txt"
    echo "pages: dist ready in $DIST ($n kernels, $(du -sh "$DIST" | cut -f1))" >&2
}

deploy() {
    dist
    "$WEB/tests/test_dist.sh" || { echo "pages: dist smoke test failed, not deploying" >&2; exit 1; }
    local remote="${PAGES_REMOTE:-}"
    if [ -z "$remote" ]; then
        remote="$(git -C "$ROOT" remote get-url github)"
        case "$remote" in git@github.com:*) remote="https://github.com/${remote#git@github.com:}" ;; esac
    fi
    local src; src="$(git -C "$ROOT" rev-parse --short HEAD)"
    git -C "$ROOT" worktree remove --force "$WT" 2>/dev/null || true
    rm -rf "$WT"
    git -C "$ROOT" worktree add --detach "$WT" HEAD >/dev/null 2>&1
    (
        cd "$WT"
        git checkout -q --orphan gh-pages-new
        git rm -rfq .
        cp -r "$DIST"/. .
        git add -A
        git -c user.name="$(git -C "$ROOT" config user.name)" -c user.email="$(git -C "$ROOT" config user.email)" \
            commit -q -m "pages: web/ built from master $src" -m "$(head -1 "$DIST/MANIFEST.txt")"
        git -c credential.helper='!gh auth git-credential' push -q --force "$remote" HEAD:refs/heads/gh-pages
    )
    git -C "$ROOT" worktree remove --force "$WT"
    git -C "$ROOT" branch -D gh-pages-new >/dev/null 2>&1 || true
    echo "pages: pushed gh-pages (from master $src) to $remote" >&2
}

case "$mode" in
    dist) dist ;;
    deploy) deploy ;;
    *) echo "usage: $0 {dist|deploy}" >&2; exit 2 ;;
esac
