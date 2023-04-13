#!/usr/bin/env bash
set -e
src=${1%.jar}
redo-ifchange .vars.rc
. ./.vars.rc
classpath=($PLATFORM/android.jar)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
if [[ $1 != R.jar ]]; then classpath+=(R.jar); fi
for e in "${classpath[@]}"; do redo-ifchange "$e"; done
IFS=:; classpath=${classpath[*]}
if [[ -f "$src.kt" ]]; then
	src="$src.kt"
	redo-ifchange "$KOTLINC" "$src"
	"$KOTLINC" -jvm-target 1.8 -cp "$classpath" -d "$tmp" "$src"
else
	src="$src.java"
	redo-ifchange "$JAVAC" "$src"
	"$JAVAC" -source 11 -target 11 -classpath "$classpath" -d "$tmp" "$src"
fi
jar --create --no-compress --date=2000-01-01T00:00:00Z --file "$3" -C "$tmp" .
# vim:ft=bash
