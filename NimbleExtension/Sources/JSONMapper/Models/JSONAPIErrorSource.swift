//
//  JSONAPIErrorSource.swift
//  Braive
//
//  Created by Issarapong Poesua on 18/9/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

extension JSONAPIError {
    
    struct Source: Decodable, Equatable {
        
        let parameter: String?
        
    }

}

enum Errors: Error {
    
    enum JSONAPIDecoding: LocalizedError {
        
        case resourceNotFound(identifier: ResourceIdentifier)
        
        case invalidFormat(reason: String)
        
        case unableToDecode(reason: String)
        
    }
}
