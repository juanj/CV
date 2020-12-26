// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CV",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_11)],
    targets: [
        .target(
            name: "CV",
            dependencies: [],
            resources: [.process("Resources")])
    ]
)
