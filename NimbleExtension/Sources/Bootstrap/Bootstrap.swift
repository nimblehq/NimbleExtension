//
//  Bootstrap.swift
//  NimbleExtension
//
//  Created by Mark G on 23/12/2020.
//  Copyright © 2020 Nimble. All rights reserved.
//

import UIKit

public class Bootstrap: NSObject {
    
    fileprivate var persistentRegisters: [PluginRegisterable] = []
    fileprivate var appDelegateRegisters: [PluginRegisterable & UIApplicationDelegate] {
        persistentRegisters
            .filter { $0 is UIApplicationDelegate }
            .compactMap { $0 as? PluginRegisterable & UIApplicationDelegate }
    }
    
    public func register(
        application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
        plugins: [PluginRegisterable.Type]
    ) {
        
        for plugin in plugins {
            let register = plugin.init()
            
            appendToPersistentRegistersIfNeeded(
                register: register
            )
            register.configure(
                application: application,
                launchOptions: launchOptions
            )
            
        }
    }
    
    public func register(
        application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
        plugins: PluginRegisterable.Type...
    ) {
    
        register(application: application, launchOptions: launchOptions, plugins: plugins)
    }
    
    private func appendToPersistentRegistersIfNeeded(register: PluginRegisterable) {
        
        guard register.isPersistent
        else { return }
        
        persistentRegisters.append(register)
    }
}

// MARK: - UIApplicationDelegate
extension Bootstrap: UIApplicationDelegate {
    
    public func applicationWillResignActive(_ application: UIApplication) {
        appDelegateRegisters.forEach { $0.applicationWillResignActive?(application) }
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        appDelegateRegisters.forEach { $0.applicationDidEnterBackground?(application) }
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegateRegisters.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegateRegisters.forEach { $0.applicationDidBecomeActive?(application) }
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        appDelegateRegisters.forEach { $0.applicationWillTerminate?(application) }
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        guard #available(iOS 9.0, *) else {
            return false
        }
        
        for delegate in appDelegateRegisters {
            
            let handled = delegate.application?(
                app,
                open: url,
                options: options
            ) ?? false
            
            if handled {
                return true
            }
        }
        return false
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        for delegate in appDelegateRegisters {
            let handled = delegate.application?(
                application,
                continue: userActivity,
                restorationHandler: restorationHandler
            ) ?? false
            
            if handled {
                return true
            }
        }
        
        return false
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        appDelegateRegisters.forEach {
            $0.application?(
                application,
                didReceiveRemoteNotification: userInfo,
                fetchCompletionHandler: completionHandler
            )
        }
    }
}
