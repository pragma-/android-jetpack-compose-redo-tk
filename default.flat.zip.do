#!/usr/bin/env bash
set -e
src=${1%.flat.zip}
dir=${src%%_*}
file=${src#*_}
src=res/$dir/$file
redo-ifchange .vars.rc
. ./.vars.rc
redo-ifchange "$BUILD_TOOLS/aapt2" "$src"
"$BUILD_TOOLS/aapt2" compile -o "$3" "$src"
# vim:ft=bash
