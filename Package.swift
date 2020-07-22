// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ReflogUI",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "git-reflog-ui", targets: ["ReflogUI"]),
    ],
    dependencies: [
        .package(name: "GitKit",
                 url: "https://github.com/danielctull/GitKit",
                 .branch("main")),
    ],
    targets: [
        .target(
            name: "ReflogUI",
            dependencies: ["GitKit"]),
    ]
)
