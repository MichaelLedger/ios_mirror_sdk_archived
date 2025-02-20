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

## References
[Creating a multiplatform binary framework bundle](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle)

[Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416)

