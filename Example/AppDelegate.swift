//
//  AppDelegate.swift
//  Example
//
//  Created by Mark G on 25/12/2020.
//  Copyright © 2020 Nimble. All rights reserved.
//

import UIKit
import NimbleExtension

@main
class AppDelegate: AppDelegateWithBootstrap {
    override var plugins: [PluginRegisterable.Type] {[
        ExampleRegister.self
    ]}
}

