//
//  PluginRegisterable.swift
//  NimbleExtension
//
//  Created by Mark G on 23/12/2020.
//  Copyright © 2020 Nimble. All rights reserved.
//

import UIKit

public protocol PluginRegisterable: NSObject {
    
    /// Mark it to `true` will prevent
    /// register from release after it finish `configure`
    var isPersistent: Bool { get }
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

public extension PluginRegisterable {
    var isPersistent: Bool { false }
}
