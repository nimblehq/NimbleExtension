//
//  Thread+Async.swift
//  NimbleExtension
//
//  Created by Minh Pham on 27/01/2021.
//  Copyright © 2021 Nimble. All rights reserved.
//

import Foundation

extension Thread {

    /**
        A better alternative for executing code on main thread

        - Parameters:
            - execution: The block of code to be executed on main thread

        - Description: Whenever we want to execute a block of code on main thread, instead of putting it inside `DispatchQueue.main.async` block, we can use this function - `Thread.performOnMain` as a better replacement because in the situation when that block of code is already running on main thread, using `DispatchQueue.main.async` will cause the code to be rescheduled to run on main thread in the next run loop instead of the current one, causing a small delay in execution.
    */
    static func performOnMain(_ execution: @escaping CompletionHandler) {
        guard !Thread.isMainThread else { return execution() }
        DispatchQueue.main.async { execution() }
    }
}
