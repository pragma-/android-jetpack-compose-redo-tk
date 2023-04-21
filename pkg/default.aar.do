#!/usr/bin/env bash
set -e
pkg=${1%.aar}
redo-ifchange get
. ./get "$pkg" "$3"
# vim:ft=bash
