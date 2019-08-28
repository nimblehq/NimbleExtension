//  JSONAPIError.swift
//
//  Created by Pirush Prechathavanich on 4/25/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

struct JSONAPIError: Error, Decodable, Equatable {

    struct Source: Decodable, Equatable {
        let parameter: String?
    }
    
    let id: String?
    let title: String?
    let detail: String?
    let source: Source?
    /// http status code of the error
    let status: String?
    /// application-specific error code
    let code: String?
}

//note:- JSON:API error object is sent as an array of errors.

extension Array: Error where Element == JSONAPIError {}
