#!/usr/bin/env bash
set -e
jars=(R.jar MainActivity.jar)
redo-ifchange .vars.rc
. ./.vars.rc
android="$PLATFORM/android.jar"
redo-ifchange "$BUILD_TOOLS/d8" "$android" kotlin.dex "${jars[@]}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$BUILD_TOOLS/d8" --classpath "$android" --output "$tmp" kotlin.dex "${jars[@]}"
mv "$tmp/classes.dex" "$3"
# vim:ft=bash
