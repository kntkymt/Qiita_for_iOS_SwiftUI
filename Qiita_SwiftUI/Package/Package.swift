// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Release",
            targets: ["Presentation", "Common", "Repository", "Service", "Network"]),
        .library(
            name: "Stub",
            targets: ["Presentation", "Common", "Repository", "StubService"]),
    ],
    dependencies: [
        .package(name: "Introspect", url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.3"),
        .package(name: "SwiftUIX", url: "https://github.com/SwiftUIX/SwiftUIX", from: "0.1.0"),
        .package(name: "Moya", url: "https://github.com/Moya/Moya.git", from: "14.0.1"),
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.9.5"),
        .package(name: "KeychainAccess", url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2")
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "SwiftyBeaver", package: "SwiftyBeaver", condition: .when(platforms: [.iOS])),
            ]
        ),
        .target(
            name: "Presentation",
            dependencies: [
                "Common",
                "Model",
                "Repository",
                .product(name: "Introspect", package: "Introspect", condition: .when(platforms: [.iOS])),
                .product(name: "SwiftUIX", package: "SwiftUIX", condition: .when(platforms: [.iOS])),
            ],
            resources: [.process("Common/Resources")]
        ),
        .target(name: "Model"),
        .target(
            name: "Repository",
            dependencies: [
                "Model"
            ]),
        .target(
            name: "Service",
            dependencies: [
                "Repository",
                "Model",
                "Network"
            ]
        ),
        .target(
            name: "StubService",
            dependencies: [
                "Repository",
                "Model"
            ]
        ),
        .target(
            name: "Network",
            dependencies: [
                "Common",
                "Model",
                .product(name: "Moya", package: "Moya", condition: .when(platforms: [.iOS])),
                .product(name: "KeychainAccess", package: "KeychainAccess", condition: .when(platforms: [.iOS])),
            ]
        ),
    ]
)
