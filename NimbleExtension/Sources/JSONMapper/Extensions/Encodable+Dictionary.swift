//
//  Encodable+Dictionary.swift
//  NimbleExtension
//
//  Created by Tam Nguyen on 11/17/20.
//  Copyright © 2020 Nimble. All rights reserved.
//

import Foundation

public extension Encodable {

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap {
            $0 as? [String: Any]
        }
    }
}
