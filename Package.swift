// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArchimedeanSpiral",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ArchimedeanSpiral",
            targets: ["ArchimedeanSpiral"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/chenhaiteng/CoreGraphicsExtension.git", from: "0.3.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ArchimedeanSpiral",
            dependencies: ["CoreGraphicsExtension"]),
        .testTarget(
            name: "ArchimedeanSpiralTests",
            dependencies: ["ArchimedeanSpiral", "CoreGraphicsExtension"]),
    ]
)
