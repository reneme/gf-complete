#!/bin/bash

SOURCE_DIR="$(pwd)"
BUILD_DIR="${SOURCE_DIR}/build"
INSTALL_DIR="${SOURCE_DIR}/install"
INSTALL_PREFIX="usr/local"

die() {
    ( [ x"$(echo -n -e)" = x"-e" ] && echo $1 >&2 || echo -e $1 ) >&2
    exit 1
}
