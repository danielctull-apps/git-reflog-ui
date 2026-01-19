// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "ReflogUI",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .executable(name: "git-reflog-ui", targets: ["ReflogUI"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/danielctull/swift-git.git",
      branch: "main"
    )
  ],
  targets: [
    .executableTarget(
      name: "ReflogUI",
      dependencies: [
        .product(name: "Git", package: "swift-git")
      ]
    )
  ]
)
