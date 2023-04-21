#!/usr/bin/env bash
set -e
res=(values_colors.xml.flat.zip values_strings.xml.flat.zip
	values_themes.xml.flat.zip)
redo-ifchange .vars.rc packages.rc
. ./.vars.rc
. ./packages.rc
pkg_res=() R_args=()
for package in "${!packages[@]}"; do
	if [[ $(package_ext "$package") != "aar" ]]; then continue; fi
	flat_zip="pkg/$package.flat.zip"
	pkg_res+=("$flat_zip") R_args+=(-R "$flat_zip")
done
android=$PLATFORM/android.jar aapt2_bin=$BUILD_TOOLS/aapt2
redo-ifchange "$MANIFEST" "$android" "$aapt2_bin" "${res[@]}" "${pkg_res[@]}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$aapt2_bin" link -I "$android" --manifest "$MANIFEST" --java "$tmp/src" \
	-o "$tmp/res.apk" --output-text-symbols "$tmp/R" --auto-add-overlay \
	"${R_args[@]}" "${res[@]}"
R_java=$(find "$tmp/src" -name R.java -print -quit)
7z a -tzip "$tmp/out.zip" "$R_java" "$tmp/res.apk" "$tmp/R" >/dev/null
mv "$tmp/out.zip" "$3"
# vim:ft=bash
