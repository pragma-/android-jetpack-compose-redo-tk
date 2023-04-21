#!/usr/bin/env bash
set -e
redo-ifchange .vars.rc packages.rc
. ./.vars.rc
. ./packages.rc
classpath=($PLATFORM/android.jar compile.packages.jar R.jar)
plugin=$(package_file "$compose_compiler")
sources=(MainActivity.kt Theme.kt)
redo-ifchange "$KOTLINC" "$plugin" "$classpath" "${classpath[@]}" "${sources[@]}"
IFS=:; classpath=${classpath[*]}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$KOTLINC" -Xplugin="$plugin" -jvm-target 1.8 -cp "$classpath" -d "$tmp" "${sources[@]}"
jar --create --no-compress --date=2000-01-01T00:00:00Z --file "$3" -C "$tmp" .
# vim:ft=bash
