#!/bin/bash

set -e

SCRIPT_LOCATION=$(cd "$(dirname "$0")"; pwd)
. ${SCRIPT_LOCATION}/common.sh

[ -d ${SOURCE_DIR}/ci ] || die "CWD must be repository root"
[ -d $BUILD_DIR       ] || die "didn't find build location '${BUILD_DIR}'"

cd $BUILD_DIR
make check
