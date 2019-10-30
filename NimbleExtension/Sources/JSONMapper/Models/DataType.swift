//  DataType.swift
//
//  Created by Edgars Simanovskis on 27/08/2019.
//  Copyright © 2018 Nimble. All rights reserved.
//

import Foundation

public enum DataType<T: Codable>: Codable {

    case single(T)
    case collection([T])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .single(container.decode(T.self))
        } catch DecodingError.typeMismatch {
            self = try .collection(container.decode([T].self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .single(let object):
            try container.encode(object)
        case .collection(let array):
            try container.encode(array)
        }
    }
}
