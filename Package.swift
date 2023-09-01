// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyLogger",
    platforms: [.iOS(.v13), .macOS(.v10_15), .macCatalyst(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "SwiftyLogger", targets: ["SwiftyLogger"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftyLogger", dependencies: []),
        .testTarget(name: "SwiftyLoggerTests", dependencies: ["SwiftyLogger"]),
    ]
)
