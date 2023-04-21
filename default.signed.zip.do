#!/usr/bin/env bash
set -e
src=${1%.signed.zip}.apk
redo-ifchange .vars.rc "$src"
. ./.vars.rc
if [[ $KEYSTORE_PASS =~ ^file: ]]; then redo-ifchange "${KEYSTORE_PASS#file:}"; fi
redo-ifchange "$BUILD_TOOLS/apksigner" "$KEYSTORE"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
"$BUILD_TOOLS/apksigner" sign --ks "$KEYSTORE" --ks-pass "$KEYSTORE_PASS" \
	"${APKSIGNER_SIGN_ARGS[@]}" --out "$tmp/app.apk" "$src"
7z a -tzip "$tmp/app.zip" "$tmp/app.apk" "$tmp/app.apk.idsig" >/dev/null
mv "$tmp/app.zip" "$3"
# vim:ft=bash
