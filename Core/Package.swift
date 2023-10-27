// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Navigation", targets: ["Navigation"])
    ],
    dependencies: [
        .package(url: "https://github.com/AliSoftware/Dip", .upToNextMinor(from: "7.1.1"))
    ],
    targets: [
        .target(name: "BusinessLogic"),
        .target(
            name: "Helpers",
            dependencies: [
                .product(name: "Dip", package: "Dip")
            ]
        ),
        .target(name: "Models"),
        .target(name: "Networking"),

        // MARK: - Navigation

        .target(
            name: "Navigation",
            dependencies: [
                "Movies"
            ]
        ),

        // MARK: - Sources/Screens

        .target(name: "Movies", path: "Sources/Screens/Movies")
    ]
)
