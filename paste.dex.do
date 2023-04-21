#!/usr/bin/env bash
set -e
redo-ifchange .vars.rc paste.jar
. ./.vars.rc
d8 "$3" paste.jar
# vim:ft=bash
