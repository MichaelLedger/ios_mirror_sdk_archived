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

## batch generate checksum of zips

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

## References
[Creating a multiplatform binary framework bundle](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle)

[Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416)

