#!/bin/sh

set -xe

VERSION="0.1.5"
MIN_IOS_SDK_VERSION="13.0"
LIB_SOURCE_NAME="opencore-amr"

CURRENT_PATH=$(pwd)

PRODUCT_DIR="${CURRENT_PATH}/product"
if [  -d "${PRODUCT_DIR}" ]; then
    rm -rf ${PRODUCT_DIR}
fi
mkdir -p "${PRODUCT_DIR}"

if [ ! -d "${CURRENT_PATH}/src" ]; then
    mkdir -p "${CURRENT_PATH}/src"
    tar zxvf ${LIB_SOURCE_NAME}-${VERSION}.tar.gz -C "${CURRENT_PATH}/src"
fi

cd "${CURRENT_PATH}/src/${LIB_SOURCE_NAME}-${VERSION}"

CURRENT_ARCH=$(uname -m)

if [ "${CURRENT_ARCH}" = "arm64" ]; then
    BUILD_ARCH=arm
else
    BUILD_ARCH=$CURRENT_ARCH
fi

# xcrun: error: SDK "iphoneos" cannot be located
# $ sudo xcode-select --switch ${DEVELOPER}
# $ sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
DEVELOPER=$(xcode-select -print-path)


# (platform, arch, min_ios_sdk_version, host, build)
generic_build()
{
    local platform="$1"
    local arch="$2"
    local min_ios_sdk_version="$3"
    local host="$4"
    local build="$5"

    echo "Building for iOS $platform-$arch ****************"

    SDK_ROOT="$(xcrun --sdk ${platform} --show-sdk-path)"
    CC="$(xcrun --sdk ${platform} -f clang)"
    CXX="$(xcrun --sdk ${platform} -f clang++)"
    CPP="$(xcrun -sdk ${platform} -f clang++)"
    CFLAGS="-isysroot $SDK_ROOT -arch ${arch} ${min_ios_sdk_version} -isystem ${SDK_ROOT}/usr/include -fembed-bitcode"
    CXXFLAGS=$CFLAGS
    CPPFLAGS=$CFLAGS
    export CC CXX CFLAGS CXXFLAGS CPPFLAGS

    ./configure \
    --prefix="$PRODUCT_DIR/$platform/$arch" \
    --disable-shared \
    --enable-static \
    --host=$host \
    --build=$build
    make >/dev/null
    make install
    make clean
}

create_xcframework()
{
    local name="$1"
    lipo -create ${PRODUCT_DIR}/iphonesimulator/x86_64/lib/${name}.a ${PRODUCT_DIR}/iphonesimulator/arm64/lib/${name}.a -output ${PRODUCT_DIR}/iphonesimulator/${name}.a

    cp ${PRODUCT_DIR}/iphoneos/arm64/lib/${name}.a ${PRODUCT_DIR}/iphoneos

    xcodebuild -create-xcframework -library ${PRODUCT_DIR}/iphoneos/${name}.a -library ${PRODUCT_DIR}/iphonesimulator/${name}.a -output ${PRODUCT_DIR}/framework/${name}.xcframework
}

generic_build iphoneos arm64 "-miphoneos-version-min=${MIN_IOS_SDK_VERSION}" "arm-apple-darwin" "${BUILD_ARCH}-apple"
generic_build iphonesimulator arm64 "-mios-simulator-version-min=${MIN_IOS_SDK_VERSION}" "arm-apple-darwin" "${BUILD_ARCH}-apple"
generic_build iphonesimulator x86_64 "-mios-simulator-version-min=${MIN_IOS_SDK_VERSION}" "x86_64-apple-darwin" "${BUILD_ARCH}-apple"

# 16kHZ
create_xcframework "libopencore-amrwb"

# 8kHZ
create_xcframework "libopencore-amrnb"

