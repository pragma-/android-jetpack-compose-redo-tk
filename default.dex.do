#!/usr/bin/env bash
set -e
src=${1%.dex}.jar
redo-ifchange .vars.rc "$src"
. ./.vars.rc
d8 "$3" "$src"
# vim:ft=bash
