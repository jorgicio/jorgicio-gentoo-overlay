#!/bin/bash
ARCH=$(uname -m)
[[ $ARCH == "x86_64" ]] && SUFFIX="64" || SUFFIX="32"
/usr/lib${SUFFIX}/prey/bin/prey "$@"
