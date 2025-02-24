// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios_mirror_sdk_archived",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "BBBadgeBarButtonItem", targets: ["BBBadgeBarButtonItem"]),
        .library(name: "BCMeshTransformView", targets: ["BCMeshTransformView"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "BBBadgeBarButtonItem",
            url: "https://github.com/MichaelLedger/ios_mirror_sdk_archived/releases/download/0.0.1-beta/BBBadgeBarButtonItem.xcframework.zip",
            checksum: "80c5ec9b39ff71383df13a985d43fe065a99548542921a841ed52683a381c6a7"
        ),
        .binaryTarget(
            name: "BCMeshTransformView",
            url: "https://github.com/MichaelLedger/ios_mirror_sdk_archived/releases/download/0.0.1-beta/BCMeshTransformView.xcframework.zip",
            checksum: "ba3aefe0331b3ecaac972d92237af3fbfdb015f7b7f6aff7eb12ab19418011d0"
        ),
        .testTarget(name: "MirrorSDKTest", dependencies: ["BBBadgeBarButtonItem", "BCMeshTransformView"], path: "Tests/MirrorSDKTest")
    ],
    swiftLanguageVersions: [.v5]
)
