//
//  Encodable+Dictionary.swift
//  NimbleExtension
//
//  Created by Tam Nguyen on 11/17/20.
//  Copyright © 2020 Nimble. All rights reserved.
//

import Foundation

public extension Encodable {

    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let dictionary = try? JSONSerialization.jsonObject(
            with: encoder.encode(self), options: .allowFragments
        ) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
