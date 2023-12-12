// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TSVoiceConverter",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TSVoiceConverter",
            targets: ["TSVoiceConverter"]),
        .library(
            name: "TSVoiceConverterSwift",
            targets: ["TSVoiceConverterSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TSVoiceConverter",
            dependencies: [
                .target(name: "libopencore-amrnb"),
                .target(name: "libopencore-amrwb"),
            ]
        ),
        .target(
            name: "TSVoiceConverterSwift",
            dependencies: ["TSVoiceConverter"]
        ),
        .binaryTarget(
            name: "libopencore-amrnb",
            path: "Sources/frameworks/libopencore-amrnb.xcframework"),
        .binaryTarget(
            name: "libopencore-amrwb",
            path: "Sources/frameworks/libopencore-amrwb.xcframework"),
        .testTarget(
            name: "TSVoiceConverterTests",
            dependencies: ["TSVoiceConverter"]),
        .testTarget(
            name: "TSVoiceConverterSwiftTests",
            dependencies: ["TSVoiceConverterSwift"],
            resources: [
//                .copy("Resources/count.wav"),
//                .copy("Resources/hello.amr"),
                .process("Resources")
            ]
        ),
    ]
)
