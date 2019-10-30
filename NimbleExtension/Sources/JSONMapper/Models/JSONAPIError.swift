//  JSONAPIError.swift
//
//  Created by Pirush Prechathavanich on 4/25/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

public struct JSONAPIError: Error, Decodable, Equatable {

    public struct Source: Decodable, Equatable {
        let parameter: String?
    }
    
    public let id: String?
    public let title: String?
    public let detail: String?
    public let source: Source?
    /// http status code of the error
    public let status: String?
    /// application-specific error code
    public let code: String?
}

//note:- JSON:API error object is sent as an array of errors.
extension Array: Error where Element == JSONAPIError {}
