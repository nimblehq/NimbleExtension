//
//  Collection+MapKeyPath.swift
//  NimbleExtension
//
//  Created by Issarapong Poesua on 8/27/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

extension Collection {
    
    func map<U>(_ keyPath: KeyPath<Element, U>) -> [U] {
        return map { $0[keyPath: keyPath] }
    }
    
    func compactMap<U>(_ keyPath: KeyPath<Element, U?>) -> [U] {
        return compactMap { $0[keyPath: keyPath] }
    }
    
    func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        return filter { $0[keyPath: keyPath] }
    }
    
}
