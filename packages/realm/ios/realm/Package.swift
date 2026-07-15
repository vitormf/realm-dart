// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to
// build this package.
//
// Swift Package Manager support for the Realm Flutter plugin (iOS).
//
// The native engine ships as a prebuilt `realm_dart.xcframework`. Because SPM's
// `.binaryTarget(url:checksum:)` only accepts a zipped xcframework (not the
// tar.gz Realm publishes), the framework is repackaged as a zip and hosted as a
// GitHub Release asset on this fork; SPM downloads and caches it automatically,
// which removes the CocoaPods `dart run realm install` download step entirely.
//
// The plugin glue is a single Swift target (see RealmPlugin.swift). The former
// Objective-C forwarder and platform.mm were dropped as vestigial on iOS — see
// the note in RealmPlugin.swift.
import PackageDescription

let package = Package(
    name: "realm",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "realm", targets: ["realm"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "realm_dart",
            url: "https://github.com/vitormf/realm-dart/releases/download/spm-native-binaries-20.2.0/realm_dart-ios.xcframework.zip",
            checksum: "77eb78c7674a3c9f28f1177cfd1147c23e542de52cca78f04f063143451f5295"
        ),
        .target(
            name: "realm",
            dependencies: ["realm_dart"],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
            ],
            linkerSettings: [
                // Mirror the CocoaPods podspec's `s.library` entries so the
                // realm_dart dylib's system dependencies are linked.
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("compression"),
            ]
        ),
    ]
)
