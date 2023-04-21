#!/usr/bin/env bash
set -e
src=${1%.flat.zip}.aar
redo-ifchange ../.vars.rc "$src"
. ../.vars.rc
redo-ifchange "$BUILD_TOOLS/aapt2"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/res"
7z x -tzip -o"$tmp" "$src" res >/dev/null
"$BUILD_TOOLS/aapt2" compile --dir "$tmp/res" -o "$3"
# vim:ft=bash
