// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "quantum",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "quantum", targets: ["quantum"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "quantum",
            dependencies: [],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)