//
//  ExampleRegister.swift
//  Example
//
//  Created by Mark G on 25/12/2020.
//  Copyright © 2020 Nimble. All rights reserved.
//

import UIKit
import NimbleExtension

class ExampleRegister: NSObject, PluginRegisterable {
    
    var isPersistent: Bool = true
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        
        print("ExampleRegister -> App launched")
    }
}

extension ExampleRegister: UIApplicationDelegate {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        print("ExampleRegister -> App did become active")
    }
}
