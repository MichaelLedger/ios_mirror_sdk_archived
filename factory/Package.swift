// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "factory",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "BBBadgeBarButtonItem", targets: ["BBBadgeBarButtonItem"]),
        .library(name: "BCMeshTransformView", targets: ["BCMeshTransformView"])
    ],
    dependencies: [
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
    swiftLanguageVersions: [.v5]
)
