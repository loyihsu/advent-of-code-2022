// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "advent-of-code-2022",
    products: [
        .executable(
            name: "advent-of-code-2022",
            targets: ["advent-of-code-2022"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "advent-of-code-2022",
            dependencies: [],
            resources: [
                .copy("Inputs"),
            ]
        ),
        .testTarget(
            name: "advent-of-code-2022Tests",
            dependencies: ["advent-of-code-2022"],
            resources: [
                .copy("Daily Tests"),
            ]
        ),
    ]
)
