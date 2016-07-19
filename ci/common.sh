#!/bin/bash

INSTALL_PREFIX="usr/local"

die() {
    ( [ x"$(echo -n -e)" = x"-e" ] && echo $1 >&2 || echo -e $1 ) >&2
    exit 1
}
