rm -rf macos-products || true

sh generate-macos-project.sh

DEVELOPERID_CERTIFICATE_NAME="Developer ID Application: TGR1.618 limited (5RMZ3ZU3DS)"
xcodebuild build \
    -project macOS/AEC3.xcodeproj \
    -target api \
    -sdk macosx \
    CODE_SIGN_IDENTITY=${DEVELOPERID_CERTIFICATE_NAME} \
    | xcpretty

mkdir -p ./macos-products/headers
rsync -avhm --include='api' --include='*.h' --exclude='*' ./ ./macos-products/headers/api/
rsync -avhm --include='*/' --include='*.h' --exclude='*' ./base/rtc_base ./macos-products/headers/api/
rsync -avhm --include='*/' --include='*.h' --exclude='*' ./base/abseil/absl ./macos-products/headers/api/
rsync -avhm --include='*/' --include='*.h' --exclude='*' ./audio_processing ./macos-products/headers/audio_processing

xcodebuild -create-xcframework \
    -library output/Darwin/Debug_x64/libapi.a \
    -headers macos-products/headers/api \
    -output macos-products/api.xcframework

xcodebuild -create-xcframework \
    -library output/Darwin/Debug_x64/libbase.a \
    -output macos-products/base.xcframework

xcodebuild -create-xcframework \
    -library output/Darwin/Debug_x64/libAEC3.a \
    -headers macos-products/headers/audio_processing \
    -output macos-products/AEC3.xcframework
