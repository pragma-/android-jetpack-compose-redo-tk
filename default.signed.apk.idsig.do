#!/usr/bin/env bash
set -e
src=${1%.apk.idsig}.zip
redo-ifchange "$src"
7z e -so "$src" app.apk.idsig >"$3"
# vim:ft=bash
