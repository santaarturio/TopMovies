// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "APILinkerGraphQL",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5)
  ],
  products: [
    .executable(name: "Downloader",
                targets: ["Downloader"]),
    .library(
      name: "GraphQLAPI",
      targets: ["GraphQLAPI"]),
  ],
  dependencies: [
    .package(name: "Apollo",
             url: "https://github.com/apollographql/apollo-ios.git",
             from: "0.42.0"),
  ],
  targets: [
    .target(
      name: "Downloader",
      dependencies: [.product(name: "ApolloCodegenLib", package: "Apollo")]),
    .target(
      name: "GraphQLAPI",
      dependencies: [.product(name: "Apollo", package: "Apollo")]),
  ]
)
