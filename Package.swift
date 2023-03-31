// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MusicTimer",
    platforms: [.macOS(.v10_15)],
    targets: [
        .target(
            name: "MusicTimer",
            dependencies: [],
            path: "."
        )
    ]
)
