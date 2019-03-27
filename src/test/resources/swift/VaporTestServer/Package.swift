// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "VaporCodegenTest",
    products: [
        .library(name: "VaporCodegenTest", targets: ["App"]),
        ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
//        .package(path: "../VaporTestInterface")
        .package(path: "../../../../../target/test-classes/swift/VaporTestInterface/")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "VaporTestInterface"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
