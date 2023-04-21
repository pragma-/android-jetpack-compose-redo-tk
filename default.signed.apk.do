#!/usr/bin/env bash
set -e
src=${1%.apk}.zip
redo-ifchange "$src"
7z e -so "$src" app.apk >"$3"
# vim:ft=bash
