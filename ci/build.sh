#!/bin/bash

set -e

SCRIPT_LOCATION=$(cd "$(dirname "$0")"; pwd)
. ${SCRIPT_LOCATION}/common.sh

[ -d ${SOURCE_DIR}/ci ] || die "CWD must be repository root"

[ ! -d $BUILD_DIR   ] || rm -fR $BUILD_DIR
[ ! -d $INSTALL_DIR ] || rm -fR $INSTALL_DIR

echo $SOURCE_DIR

mkdir $INSTALL_DIR
mkdir $BUILD_DIR && cd $BUILD_DIR
cmake -DBUILD_TESTS=yes                                       \
      -DWITH_SSE=yes                                          \
      -DWITH_AVX=no                                           \
      -DCMAKE_BUILD_TYPE=Release                              \
      -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/${INSTALL_PREFIX} \
      $SOURCE_DIR

make
