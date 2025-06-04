//  swift-tools-version: 5.8
//  Package.swift
//  NimbleExtension
//
//  Created by Bliss on 08/09/2021.
//  Copyright (c) 2021 Nimble All rights reserved.
//
import PackageDescription

let package = Package(
    name: "NimbleExtension",
    platforms: [
        .iOS(.v15), .macOS(.v11), .tvOS(.v12), .watchOS(.v4)
    ],
    products: [
        .library(name: "NimbleExtension", targets: ["NimbleExtension"])
    ],
    targets: [
        .target(name: "NimbleExtension", path: "NimbleExtension/Sources")
    ]
)
