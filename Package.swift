// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "ReflogUI",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "git-reflog-ui", targets: ["ReflogUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danielctull/GitKit", branch: "swift-concurrency/global-actor-4"),
    ],
    targets: [
        .executableTarget(
            name: "ReflogUI",
            dependencies: [
                .product(name: "Git", package: "GitKit"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
    ]
)
