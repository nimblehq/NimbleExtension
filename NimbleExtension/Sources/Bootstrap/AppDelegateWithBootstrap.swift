//
//  AppDelegateWithBootstrap.swift
//  NimbleExtension
//
//  Created by Mark G on 23/12/2020.
//  Copyright © 2020 Nimble. All rights reserved.
//

import UIKit

open class AppDelegateWithBootstrap: UIResponder, UIApplicationDelegate {
    fileprivate let bootstrap: Bootstrap
    
    open var window: UIWindow?
    open var plugins: [PluginRegisterable.Type] { [] }
    
    public override init() {
        bootstrap = Bootstrap()
        super.init()
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        bootstrap.register(application: application, launchOptions: launchOptions, plugins: plugins)
        return true
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        bootstrap.applicationWillResignActive(application)
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        bootstrap.applicationDidEnterBackground(application)
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        bootstrap.applicationWillEnterForeground(application)
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        bootstrap.applicationDidBecomeActive(application)
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        bootstrap.applicationWillTerminate(application)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        bootstrap.application(app, open: url, options: options)
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        bootstrap.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        bootstrap.application(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler
        )
    }
}
