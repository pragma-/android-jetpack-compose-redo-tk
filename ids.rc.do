#!/usr/bin/env bash
set -e
redo-ifchange R.zip
printf 'declare -A ids\n' >"$3"
7z e -so R.zip R | sed 's/^\(int[][]*\) \([^ ]*\) \([^ ]*\) \([0-9a-fA-F{},x ]*\)$/ids[\2:\3]="\1 \3 = \4"/' >>"$3"
# vim:ft=bash
