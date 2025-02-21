# ios_mirror_sdk_archived
Collection of commonly used archived iOS SDKs for better swift package manager compatibility.

## [Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416)
Xcode 11 now fully supports using and creating binary frameworks in Swift. Find out how to simultaneously support devices and Simulator with the new XCFramework bundle type, how Swift module interfaces work, and how to manage changes to your framework over time.

1. enable "Build Libraries for Distribution"
2. `xcodebuild archive -scheme FlightKit -destination "..." -destination "..." SKIP_INSTALL=NO`
3. `xcodebuild -create-xcframework -framework [path] -framework [path] -output FlightKit.xcframework`

Implications for API Design
Keep your interface small - easy to add, hard to remove!
Choose names and requirements carefully
Avoid unnecessary extensibility (open classes, arbitrary callbacks, etc.)

Trading Flexibility for Optimizability

`@inlinable` functions
`@usableFromInline` properties

Rule of thumb -- don't change the output or observable behavior
Better algorithms are okay

`@frozen` enums
`@frozen` structs

### generate checksum & MD5 checksum for a zip
```
% shasum -a 256 PayPalMessages.xcframework.zip
565ab72a3ab75169e41685b16e43268a39e24217a12a641155961d8b10ffe1b4  PayPalMessages.xcframework.zip
```
If you want to generate an MD5 checksum instead, you can use:
```
% md5 PayPalMessages.xcframework.zip
MD5 (PayPalMessages.xcframework.zip) = ef39266fb315b518e283d2385a0ea9bd
```

This will give you the MD5 checksum of the ZIP file.

### batch generate checksum for zips

```
% python3 checksum_generator.py
Enter the directory to search for .zip files (or press Enter to use current directory): /Users/gavinxiang/Desktop     
ios_mirror_sdk_archived-Package 2025-02-20 17-24-54.zip: 9471de326c73bab931d9f47c61c313296ce0b188ad6471b7b2a322553dd0e818

% python3 checksum_generator.py
Enter the directory to search for .zip files (or press Enter to use current directory): 
BBBadgeBarButtonItem.xcframework.zip: 80c5ec9b39ff71383df13a985d43fe065a99548542921a841ed52683a381c6a7
BCMeshTransformView.xcframework.zip: ba3aefe0331b3ecaac972d92237af3fbfdb015f7b7f6aff7eb12ab19418011d0
PayPalMessages.xcframework.zip: 565ab72a3ab75169e41685b16e43268a39e24217a12a641155961d8b10ffe1b4
```

using following zip url & checksum to double-check this python shell.
```
.binaryTarget(
    name: "PayPalMessages",
    url: "https://github.com/paypal/paypal-messages-ios/releases/download/1.0.0/PayPalMessages.xcframework.zip",
    checksum: "565ab72a3ab75169e41685b16e43268a39e24217a12a641155961d8b10ffe1b4"
)
```

### [DOWNLOAD A .ZIP FILE WITHOUT UNZIPPING IN SAFARI](https://cyberchimps.com/docs/responsive-theme/faq/downloading-zip-file-without-unzipping-in-safari/)

Step 1: Open Safari browser.

Step 2: Navigate to the menu bar on the top and click on Safari > Settings tab.
In case you are using the older version of Safari; the Settings tab might appear as Preferences.

Step 3: Next, the general settings screen will appear. Here, uncheck the checkbox beside `Open “safe” files after downloading`.
This will ensure that Safari does not open “safe” files automatically after downloading; instead, it will open as a .zip file.

Following the above steps, you can download a .zip file without unzipping it for the Safari browser on a Mac.

## [swift-create-xcframework](https://github.com/segment-integrations/swift-create-xcframework)

### NOTE:

This tool is a maintained fork of the original unsignedapps/swift-create-xcframework.  This unlinked fork started off to add Xcode 15 support, after waiting for 8+ months for the original author to merge the PR.  Things like the github action, and mint installation haven't been tested.  It's currently been set up to install via `brew` or manually.  More to come, please file bugs/PRs here.

### swift-create-xcframework

swift-create-xcframework is a very simple tool designed to wrap `xcodebuild` and the process of creating multiple frameworks for a Swift Package and merging them into a single XCFramework.

On the 23rd of June 2020, Apple announced Xcode 12 and Swift 5.3 with support for Binary Targets. Though they provide a simplified way to [include Binary Frameworks in your packages][apple-docs], they did not provide a simple way to create your XCFrameworks, with only some [documentation for the long manual process][manual-docs]. swift-create-xcframework bridges that gap.

**Note:** swift-create-xcframework pre-dates the WWDC20 announcement and is tested with Xcode 11.4 or later, but should work with Xcode 11.2 or later. You can include the generated XCFrameworks in your app manually even without Xcode 12.

### Usage

Inside your Swift Package folder you can just run:

```shell
swift create-xcframework
```

By default swift-create-xcframework will build XCFrameworks for all library products in your Package.swift, or any targets you specify on the command line (this can be for any dependencies you include as well).

Then for every target or product specified, swift-create-xcframework will:

1. Generate an Xcode Project for your package (in `.build/swift-create-xcframework`).
2. Build a `.framework` for each supported platform/SDK.
3. Merge the SDK-specific framework into an XCFramework using `xcodebuild -create-xcframework`.
4. Optionally package it up into a zip file ready for a GitHub release.

This process mirrors the [official documentation][manual-docs].

### Choosing what to build

Let's use an example `Package.swift`:

```swift
var package = Package(
    name: "example-generator",
    platforms: [
        .ios(.v12),
         .macos(.v10_12)
    ],
    products: [
        .library(
            name: "ExampleGenerator",
            targets: [ "ExampleGenerator" ]),
    ],
    dependencies: [],
    targets: [
        ...
    ]
)
```

By default swift-create-xcframework will build `ExampleGenerator.xcframework` that supports: macosx, iphoneos, iphonesimulator. Additional `.library` products would be built automatically as well.

### Choosing Platforms

You can narrow down what gets built
If you omit the platforms specification, we'll build for all platforms that support Swift Binary Frameworks, which at the time of writing is just the Apple SDKs: macosx, iphoneos, iphonesimulator, watchos, watchsimulator, appletvos, appletvsimulator.

**Note:** Because only Apple's platforms are supported at this time, swift-create-xcframework will ignore Linux and other platforms in the Package.swift.

You can specify a subset of the platforms to build using the `--platform` option, for example:

```shell
swift create-xcframework --platform ios --platform macos ...
```

#### Catalyst

You can build your XCFrameworks with support for Mac Catalyst by specifying `--platform maccatalyst` on the command line. As you can't include or exclude Catalyst support in your `Package.swift` we don't try to build it automatically.

### Choosing Products

Because we wrap `xcodebuild`, you can actually build XCFrameworks from anything that will be mapped to an Xcode project as a Framework target. This includes all of the dependencies your Package has.

To see whats available:

```shell
swift create-xcframework --list-products
```

And then to choose what to build:

```shell
swift create-xcframework Target1 Target2 Target3...
```

By default it builds all top-level library products in your Package.swift.

### Command Line Options

Because of the low-friction to adding command line options with [swift-argument-parser](https://github.com/apple/swift-argument-parser), there are a number of useful command line options available, so `--help` should be your first port of call.

## Packaging for distribution

**swift-create-xcframework provides a `--zip` option to automatically zip up your newly created XCFrameworks ready for upload to GitHub as a release artefact, or anywhere you choose.**

If the target you are creating an XCFramework happens to be a dependency, swift-create-xcframework will look back into the package graph, locate the version that dependency resolved to, and append the version number to your zip file name. eg: `ArgumentParser-0.0.6.zip`

If the target you are creating is a product from the root package, unfortunately there is no standard way to identify the version number. For those cases you can specify one with `--zip-version`.

Because you're probably wanting to [distribute your binary frameworks as Swift Packages][apple-docs] `swift create-xcframework --zip` will also calculate the necessary SHA256 checksum and place it alongside the zip. eg: `ArgumentParser-0.0.6.sha256`.

## GitHub Action

**swift-create-xcframework includes a GitHub Action that can kick off and automatically create an XCFramework when you tag a release in your project.**

The action produces one zipped XCFramework and checksum artifact for every target specified.

**Note:** You MUST use a macOS-based runner (such as `macos-latest`) as xcodebuild doesn't run on Linux.

You can then take those artifacts and add them to your release.

An incomplete example:

### .github/workflows/create-release.yml

```yaml
name: Create Release

# Create XCFramework when a version is tagged
on:
  push:
    tags:

jobs:
  create_release:
    name: Create Release
    runs-on: macos-latest
    steps:

      - uses: actions/checkout@v2

      - name: Create XCFramework
        uses: unsignedapps/swift-create-xcframework@v2

      # Create a release
      # Upload those artifacts to the release
```

## Installation

You can install using brew:

```shell
brew install segment-integrations/formulae/swift-create-xcframework
```

Or manually:

```shell
git clone https://github.com/unsignedapps/swift-create-xcframework.git
cd swift-create-xcframework
make install
```

Either should pop the swift-create-xcframework binary into `/usr/local/bin`. And because the `swift` binary is extensible, you can then call it as a subcommand of `swift` itself:

```shell
swift create-xcframework --help
```

## Practice

We need `cd` to `facotry` to using another `Package.swift` which do not contains `binaryTarget` to generate xcframeworks & zips because of

*Xcode project generation is not supported by Swift Package Manager for packages that contain binary targets*.

```
% swift create-xcframework --list-products
debug: evaluating manifest for 'ios_mirror_sdk_archived' v. unknown
debug: evaluating manifest for 'ios_mirror_sdk_archived' v. unknown
Error: Xcode project generation is not supported by Swift Package Manager for packages that contain binary targets.These binary targets were detected: BBBadgeBarButtonItem, BCMeshTransformView
```

```
% cd factory
% pwd
/Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory

% ls
Package.swift Sources

% swift create-xcframework --list-products
debug: evaluating manifest for 'factory' v. unknown
debug: evaluating manifest for 'factory' v. unknown

Available factory products:
    BBBadgeBarButtonItem
    BCMeshTransformView

Additional available targets:
```

```
% swift create-xcframework --platform ios
...
xcframework successfully written out to: /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BCMeshTransformView.xcframework
xcframework successfully written out to: /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BBBadgeBarButtonItem.xcframework
```

```
% swift create-xcframework --platform ios --zip
...
** ARCHIVE SUCCEEDED **

xcframework successfully written out to: /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BCMeshTransformView.xcframework
xcframework successfully written out to: /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BBBadgeBarButtonItem.xcframework

Packaging /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BCMeshTransformView.xcframework into /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BCMeshTransformView.zip

Packaging /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BBBadgeBarButtonItem.xcframework into /Users/gavinxiang/Downloads/ios_mirror_sdk_archived/factory/BBBadgeBarButtonItem.zip
```
```
➜  factory git:(main) ✗ ls
BBBadgeBarButtonItem.sha256 BCMeshTransformView.sha256  Package.swift               checksum_generator.py
BBBadgeBarButtonItem.zip    BCMeshTransformView.zip     Sources

➜  factory git:(main) ✗ cat BBBadgeBarButtonItem.sha256 
539d99bd7aa3ae7eb7bb2dceac39b623c2e943b1c5e98d6365e12185414f2301%

➜  factory git:(main) ✗ cat BCMeshTransformView.sha256 
419ecc8d0daeb38cc2a3fe3295d21f555ca44a8d680857861fed6929519bfa94% 
```
```
➜  factory git:(main) ✗ python3 checksum_generator.py 
Enter the directory to search for .zip files (or press Enter to use current directory): 
BCMeshTransformView.zip: 419ecc8d0daeb38cc2a3fe3295d21f555ca44a8d680857861fed6929519bfa94
BBBadgeBarButtonItem.zip: 539d99bd7aa3ae7eb7bb2dceac39b623c2e943b1c5e98d6365e12185414f2301
```

## References
[Creating a multiplatform binary framework bundle](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle)
[Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416)

## Links
[apple-docs]: https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages
[manual-docs]: https://help.apple.com/xcode/mac/11.4/#/dev544efab96
