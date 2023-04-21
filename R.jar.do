#!/usr/bin/env bash
set -e
redo-ifchange R.zip .vars.rc packages.rc
. ./.vars.rc
. ./packages.rc
javas=()
for package in "${!packages[@]}"; do
	if [[ $(package_ext "$package") != "aar" ]]; then continue; fi
	javas+=("pkg/$package.java")
done
android=$PLATFORM/android.jar
redo-ifchange "$JAVAC" "$android" "${javas[@]}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
7z e -so R.zip R.java >"$tmp/R.java"
sources=("$tmp/R.java")
for f in "${javas[@]}"; do
	if [[ ! -r $f ]]; then continue; fi
	dir="$tmp/${#sources[@]}"
	mkdir "$dir"
	cp "$f" "$dir/R.java"
	sources+=("$dir/R.java")
done
mkdir "$tmp/compiled"
"$JAVAC" -source 8 -target 8 -bootclasspath "$android" -d "$tmp/compiled" "${sources[@]}"
jar --create --no-compress --date=2000-01-01T00:00:00Z --file "$3" -C "$tmp/compiled" .
# vim:ft=bash
