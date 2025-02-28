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
            dependencies: ["native"],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        ),
//        .binaryTarget(
//            name: "MTQuantum",
//            path: "Frameworks/MTQuantum.xcframework"
//        )
        .target(
            name: "native",
            dependencies: []
        ),
    ]
)