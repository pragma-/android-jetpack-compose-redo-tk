#!/usr/bin/env bash
set -e

redo-ifchange .vars.rc resources.rc
. ./.vars.rc
. ./resources.rc

src=${1%.apk}.dex

android="$PLATFORM/android.jar"
manifest=AndroidManifest.xml

redo-ifchange "$BUILD_TOOLS/aapt2" "$BUILD_TOOLS/zipalign" "${resources[@]}" "$src" "$manifest" "$android"

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
"$BUILD_TOOLS/aapt2" link --manifest "$manifest" -o "$tmp" -I "$android" "${resources[@]}"
7z a -tzip "$tmp" "$src"
7z rn -tzip "$tmp" "$src" classes.dex
"$BUILD_TOOLS/zipalign" -f 4 "$tmp" "$3"
# vim:ft=bash
