#!/usr/bin/env bash

# toggle to debug the script
# options could be found by 'set help'
set -o errexit
#set -o xtrace
#set -o verbose

#### global variables ####
ABSOLUTE_FILENAME=`readlink -f "$0"`
PROEJCT_ROOT=$(dirname ${ABSOLUTE_FILENAME})

CONANFILE_CRC32=$(crc32 ${PROEJCT_ROOT}/conanfile_linux64.txt)
CONANPROFILE_CRC32=$(crc32 ${PROEJCT_ROOT}/conanprofile_i386)

echo "crc32 of conanfile: ${CONANFILE_CRC32}"
echo "crc32 of conanprofile: ${CONANPROFILE_CRC32}"

docker build \
    --build-arg CONANFILE_CRC32=${CONANFILE_CRC32} \
    --build-arg CONANPROFILE_CRC32=${CONANPROFILE_CRC32} \
    --build-arg CONANFILE=conanfile_linux64.txt \
    -t cpcos_i386 \
    -f Dockerfile.i386 \
    .
