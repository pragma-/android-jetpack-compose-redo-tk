#!/usr/bin/env bash
set -e
redo-ifchange .vars.rc
. ./.vars.rc
src="$KOTLIN/lib/kotlin-stdlib.jar"
redo-ifchange "$BUILD_TOOLS/d8" "$PLATFORM/android.jar" "$src"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$BUILD_TOOLS/d8" --intermediate "$src" --classpath "$PLATFORM/android.jar" --output "$tmp"
mv "$tmp/classes.dex" "$3"
# vim:ft=bash
