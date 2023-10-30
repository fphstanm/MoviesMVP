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
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMinor(from: "5.8.0")),
        .package(url: "https://github.com/AliSoftware/Dip", .upToNextMinor(from: "7.1.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMinor(from: "7.9.1"))
    ],
    targets: [
        .target(name: "BusinessLogic", dependencies: ["Networking", "Library"]),
        .target(
            name: "Helpers",
            dependencies: [
                "BusinessLogic",
                .product(name: "Dip", package: "Dip")
            ]
        ),
        .target(
            name: "Library",
            dependencies: [.product(name: "Kingfisher", package: "Kingfisher")]
        ),
        .target(name: "Models"),
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                "Models"
            ]
        ),

        // MARK: - Navigation

        .target(
            name: "Navigation",
            dependencies: [
                "Movies",
                "MovieDetails"
            ]
        ),

        // MARK: - Screens

        .target(name: "Movies", dependencies: ["BusinessLogic", "Models", "Helpers"], path: "Sources/Screens/Movies"),
        .target(name: "MovieDetails", dependencies: ["BusinessLogic", "Models", "Helpers"], path: "Sources/Screens/MovieDetails")
    ]
)
