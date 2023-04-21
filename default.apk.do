#!/usr/bin/env bash
set -e
src=${1%.apk}.dex
redo-ifchange .vars.rc "$src" "R.zip" "R.dex" \
	"compile.packages.dex" "runtime.packages.dex"
. ./.vars.rc
redo-ifchange "$BUILD_TOOLS/zipalign"
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
add() {
	7z a -tzip "$tmp" "$1" >/dev/null
	7z rn -tzip "$tmp" "$1" "classes$2.dex" >/dev/null
}
7z e -so "R.zip" "res.apk" >"$tmp"
add "$src" ''
add "R.dex" 2
add "compile.packages.dex" 3
add "runtime.packages.dex" 4
"$BUILD_TOOLS/zipalign" -f 4 "$tmp" "$3"
# vim:ft=bash
