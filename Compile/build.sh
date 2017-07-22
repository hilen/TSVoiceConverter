#!/bin/sh

set -xe

VERSION="0.1.5"
SDKVERSION="10.3"
LIBSRCNAME="opencore-amr"

CURRENTPATH=`pwd`

mkdir -p "${CURRENTPATH}/src"
tar zxvf ${LIBSRCNAME}-${VERSION}.tar.gz -C "${CURRENTPATH}/src"
cd "${CURRENTPATH}/src/${LIBSRCNAME}-${VERSION}"

DEVELOPER=`xcode-select -print-path`
DEST="${CURRENTPATH}/lib-ios"
mkdir -p "${DEST}"

ARCHS="armv7 armv7s arm64 i386 x86_64"
# ARCHS="armv7"
LIBS="libopencore-amrnb.a libopencore-amrwb.a"

DEVELOPER=`xcode-select -print-path`

for arch in $ARCHS; do
case $arch in
arm*)

IOSV="-miphoneos-version-min=7.0"
if [ $arch == "arm64" ]
then
IOSV="-miphoneos-version-min=7.0"
fi

echo "Building for iOS $arch ****************"
SDKROOT="$(xcrun --sdk iphoneos --show-sdk-path)"
CC="$(xcrun --sdk iphoneos -f clang)"
CXX="$(xcrun --sdk iphoneos -f clang++)"
CPP="$(xcrun -sdk iphonesimulator -f clang++)"
CFLAGS="-isysroot $SDKROOT -arch $arch $IOSV -isystem $SDKROOT/usr/include -fembed-bitcode"
CXXFLAGS=$CFLAGS
CPPFLAGS=$CFLAGS
export CC CXX CFLAGS CXXFLAGS CPPFLAGS

./configure \
--host=arm-apple-darwin \
--prefix=$DEST \
--disable-shared --enable-static \
--host=arm
;;
*)
IOSV="-mios-simulator-version-min=7.0"
echo "Building for iOS $arch*****************"

SDKROOT=`xcodebuild -version -sdk iphonesimulator Path`
CC="$(xcrun -sdk iphoneos -f clang)"
CXX="$(xcrun -sdk iphonesimulator -f clang++)"
CPP="$(xcrun -sdk iphonesimulator -f clang++)"
CFLAGS="-isysroot $SDKROOT -arch $arch $IOSV -isystem $SDKROOT/usr/include -fembed-bitcode"
CXXFLAGS=$CFLAGS
CPPFLAGS=$CFLAGS
export CC CXX CFLAGS CXXFLAGS CPPFLAGS
./configure \
--prefix=$DEST \
--disable-shared \
--host=arm
;;
esac
make > /dev/null
make install
make clean
for i in $LIBS; do
mv $DEST/lib/$i $DEST/lib/$i.$arch
done
done

for i in $LIBS; do
input=""
for arch in $ARCHS; do
input="$input $DEST/lib/$i.$arch"
done
lipo -create -output $DEST/lib/$i $input
done