#!/usr/bin/env bash
set -e
redo-ifchange .vars.rc resources.rc
. ./.vars.rc
. ./resources.rc
android="$PLATFORM/android.jar"
manifest=AndroidManifest.xml
redo-ifchange "$BUILD_TOOLS/aapt2" "$android" "$manifest" "${resources[@]}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$BUILD_TOOLS/aapt2" link --java "$tmp" --manifest "$manifest" -o /dev/null -I "$android" "${resources[@]}"
find "$tmp" -name "R.java" -exec mv {} "$3" \; -quit
# vim:ft=bash
