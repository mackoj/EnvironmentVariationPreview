// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "EnvironmentVariationPreview",
  
  platforms: [
    .iOS(.v14),
    .macOS(.v11),
    .tvOS(.v14),
    .watchOS(.v7),
  ],
  
  products: [
    .library(
      name: "EnvironmentVariationPreview",
      targets: ["EnvironmentVariationPreview"]
    ),
  ],
  
  targets: [
    .target(
      name: "EnvironmentVariationPreview"
    ),
    .testTarget(
      name: "EnvironmentVariationPreviewTests",
      dependencies: ["EnvironmentVariationPreview"]
    ),
  ]
)
