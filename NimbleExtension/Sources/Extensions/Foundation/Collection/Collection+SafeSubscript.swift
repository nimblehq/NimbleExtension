//
//  Collection+SafeSubscript.swift
//  NimbleExtension
//
//  Created by Issarapong Poesua on 8/27/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
