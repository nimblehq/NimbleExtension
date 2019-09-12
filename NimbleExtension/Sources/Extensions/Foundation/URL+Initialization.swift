//
//  URL.swift
//  NimbleExtension
//
//  Created by Su Van Ho on 12/9/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

public extension URL {
    init?(str: String?) {
        guard let str = str else { return nil }
        self.init(string: str)
    }
}
