// swift-tools-version:5.4

import PackageDescription

let package = Package(
  name: "ReflogUI",
  platforms: [
    .macOS(.v11)
  ],
  products: [
    .executable(name: "git-reflog-ui", targets: ["ReflogUI"])
  ],
  dependencies: [
    .package(url: "https://github.com/danielctull/GitKit.git", .branch("main"))
  ],
  targets: [
    .executableTarget(
      name: "ReflogUI",
      dependencies: ["GitKit"]
    )
  ]
)
