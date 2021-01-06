// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Resizin",
    platforms: [
        .iOS(.v9),
        .macOS("10.9"),
    ],
    products: [
        .library(
            name: "Resizin",
            targets: ["Resizin"]
        ),
    ],
    targets: [
        .target(
            name: "Resizin",
            path: "Resizin"
        ),
        .testTarget(
            name: "ResizinTests",
            dependencies: ["Resizin"],
            path: "ResizinTests"
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
