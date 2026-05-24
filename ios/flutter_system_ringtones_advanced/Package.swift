// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_system_ringtones_advanced",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "flutter-system-ringtones-advanced",
            targets: ["flutter_system_ringtones_advanced"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_system_ringtones_advanced",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: []
        )
    ]
)
