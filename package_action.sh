#!/bin/bash

set -x 

ARCH=$(dpkg-architecture -qDEB_HOST_ARCH)

if [ ${ARCH} == "amd64" ]; then
    arch="linux64"
elif [ ${ARCH} == "arm64" ]; then
    arch="linuxarm64"
elif [ ${ARCH} == "loongarch64" ]; then
    arch="linuxloong64"
else
    echo "Unsupported architecture: ${ARCH}"
    exit 1
fi

if [ -z $1 ]; then
    [ ${ARCH} == "amd64" ] && package_name="cef_binary_121.3.13+g5c4a81b+chromium-121.0.6167.184_linux64.tar.bz2"
    [ ${ARCH} == "arm64" ] && package_name="cef_binary_121.3.13+g5c4a81b+chromium-121.0.6167.184_linuxarm64.tar.bz2"
    [ ${ARCH} == "loongarch64" ] && package_name="cef_binary_112.3.0+gb09c4ca+chromium-112.0.5615.165_linuxloong64.zip"
else
    package_name=$1
fi

#Extract the source code package
if [ ${ARCH} == "amd64" ] || [ ${ARCH} == "arm64" ]; then
    base_name=$(basename ${package_name} .tar.bz2)
    if [ ! -f "${package_name}" ]; then
        cat ./src/${ARCH}/cef_binary_package_${ARCH}_* > ./${package_name}
    fi
    sha1sum ./${package_name}
    tar -xvf ./${package_name} ${base_name}/Release

elif [ ${ARCH} == "loongarch64" ]; then
    base_name=$(basename ${package_name} .zip)
    if [ ! -f "${package_name}" ]; then
        cat ./src/${ARCH}/cef_binary_package_${ARCH}_* > ./${package_name}
    fi
    sha1sum ./${package_name}
    unzip ${package_name} -d .
fi

#Retrieve data
mv ${base_name}/Release/* opt/apps/deepin-cef-helper/files/cef

#Clean up the environment
rm -fr ${base_name}
exit 0