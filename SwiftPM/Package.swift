// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AEC3",
    platforms: [.macOS(.v10_10)],
    products: [
        .library(
            name: "AEC3",
            targets: ["api", "AEC3", "base"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "api",
            path: "../macos-products/api.xcframework"
        ),
        .binaryTarget(
            name: "AEC3",
            path: "../macos-products/AEC3.xcframework"
        ),
        .binaryTarget(
            name: "base",
            path: "../macos-products/base.xcframework"
        )
    ]
)
