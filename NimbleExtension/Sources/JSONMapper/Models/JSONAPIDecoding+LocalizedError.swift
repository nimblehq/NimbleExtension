//  JSONAPIErrorSource.swift
//
//  Created by Issarapong Poesua on 18/9/18.
//  Copyright © 2018 Nimble. All rights reserved.
//

enum Errors: Error {
    enum JSONAPIDecodingError: LocalizedError {
        case resourceNotFound(identifier: ResourceIdentifier)
        case invalidFormat(reason: String)
        case unableToDecode(reason: String)
    }
}
