#!/usr/bin/env zsh

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

cd "$(dirname "$0")/.."

TOOLCHAIN_FILE_PATH="${HOME}/Library/Android/sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake"

BUILD_TYPE="Release"
# BUILD_TYPE="Debug"

echo "x86"
cmake -B build/android-x86 . -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE_PATH}" -DANDROID_ABI=x86 -DCMAKE_BUILD_TYPE="${BUILD_TYPE}"
cmake --build ./build/android-x86
mv "output/Android/Release_x64" "output/Android/x86"

echo "x86_64"
cmake -B build/android-x86_64 . -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE_PATH}" -DANDROID_ABI=x86_64 -DCMAKE_BUILD_TYPE="${BUILD_TYPE}"
cmake --build ./build/android-x86_64
mv "output/Android/Release_x64" "output/Android/x86_64"

echo "armeabi-v7a"
cmake -B build/android-armeabi-v7a . -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE_PATH}" -DANDROID_ABI=armeabi-v7a -DCMAKE_BUILD_TYPE="${BUILD_TYPE}"
cmake --build ./build/android-armeabi-v7a
mv "output/Android/Release_x64" "output/Android/armeabi-v7a"

echo "arm64-v8a"
cmake -B build/android-arm64-v8a . -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE_PATH}" -DANDROID_ABI=arm64-v8a -DCMAKE_BUILD_TYPE="${BUILD_TYPE}"
cmake --build ./build/android-arm64-v8a
mv "output/Android/Release_x64" "output/Android/arm64-v8a"