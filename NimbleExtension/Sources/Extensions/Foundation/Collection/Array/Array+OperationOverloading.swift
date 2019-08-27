//
//  Array+OperationOverloading.swift
//  NimbleExtension
//
//  Created by Issarapong Poesua on 8/27/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

extension Array {
    
    static func += (elements: inout [Element], element: Element) {
        elements.append(element)
    }
    
}
