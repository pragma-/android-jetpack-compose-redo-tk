#!/usr/bin/env bash
set -e
src=${1%.signed.apk}.apk
redo-ifchange .vars.rc
. ./.vars.rc
if [[ $KEYSTORE_PASS =~ ^file: ]]; then redo-ifchange "${KEYSTORE_PASS#file:}"; fi
redo-ifchange "$BUILD_TOOLS/apksigner" "$KEYSTORE" "$src"
"$BUILD_TOOLS/apksigner" sign --ks "$KEYSTORE" --ks-pass "$KEYSTORE_PASS" "${APKSIGNER_SIGN_ARGS[@]}" --out "$3" "$src"
rm "$3.idsig"
# vim:ft=bash
