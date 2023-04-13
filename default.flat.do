#!/usr/bin/env bash
set -e
src=${1%.flat}
dir=${src%%_*}
file=${src#*_}
src=res/$dir/$file
redo-ifchange .vars.rc
. ./.vars.rc
redo-ifchange "$BUILD_TOOLS/aapt2" "$src"
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
"$BUILD_TOOLS/aapt2" compile -o "$tmp" "$src"
unzip -p "$tmp" >"$3"
# vim:ft=bash
