#!/usr/bin/env bash
set -e
redo-ifchange ../packages.rc
. ../packages.rc
pkg=${1%.jar}
if [[ $(package_ext "$pkg") == "aar" ]]; then
	redo-ifchange "$pkg.aar"
	7z e -tzip -so "$pkg.aar" classes.jar >"$3"
else
	redo-ifchange get
	. ./get "$pkg" "$3"
fi
# vim:ft=bash
