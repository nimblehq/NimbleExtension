// swift-tools-version:5.0
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
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(name: "NimbleExtension", targets: ["NimbleExtension"])
    ],
    targets: [
        .target(name: "NimbleExtension", path: "NimbleExtension/Sources")
    ]
)
