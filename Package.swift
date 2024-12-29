// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "PayBoxSdk",
    platforms: [
        .iOS(.v9) // Deployment target
    ],
    products: [
        .library(
            name: "PayBoxSdk",
            targets: ["PayBoxSdk"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PayBoxSdk",
            dependencies: [],
            path: "Sources/PayBoxSdk", // Path to source files
            exclude: [], // No files excluded
            publicHeadersPath: ".", // Headers path
            cSettings: [
                .headerSearchPath(".")
            ],
            linkerSettings: [
                .linkedLibrary("z") // Add required libraries
            ]
        )
    ],
    swiftLanguageVersions: [.v5] // Compatible with Swift 5.4+
)
