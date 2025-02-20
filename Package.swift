// swift-tools-version: 6.0
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
        .package(url: "https://github.com/amplitude/analytics-connector-ios.git", from: "1.3.0"),
        .package(url: "https://github.com/openid/AppAuth-iOS.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/google/GTMAppAuth.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/google/gtm-session-fetcher.git", .upToNextMajor(from: "3.4.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BBBadgeBarButtonItem",
            path: "Sources/BBBadgeBarButtonItem"
        ),
        .target(
            name: "BCMeshTransformView",
            path: "Sources/BCMeshTransformView",
            resources: [
                .process("Resources")
            ],
            cSettings: [
                .headerSearchPath("include")
            ],
            linkerSettings: [
                .linkedFramework("GLKit"),
                .linkedLibrary("stdc++"),
                .linkedFramework("QuartzCore")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
