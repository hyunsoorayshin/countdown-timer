// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CountdownTimer",
    platforms: [.macOS(.v15)],
    targets: [
        .executableTarget(
            name: "CountdownTimer",
            path: "Sources"
        )
    ]
)
