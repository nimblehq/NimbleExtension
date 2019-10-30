//  JSON.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimble. All rights reserved.
//
// swiftlint:disable multiline_function_chains

public enum JSON: Codable {

    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case nested([String: JSON])
    case array([JSON])
    case `nil`
    
    public var string: String? {
        guard case .string(let value) = self else { return nil }
        return value
    }
    
    public var int: Int? {
        guard case .int(let value) = self else { return nil }
        return value
    }
    
    // swiftlint:disable:next discouraged_optional_boolean
    public var bool: Bool? {
        guard case .bool(let value) = self else { return nil }
        return value
    }
    
    public var double: Double? {
        guard case .double(let value) = self else { return nil }
        return value
    }
    
    public var nested: [String: JSON]? {
        guard case .nested(let value) = self else { return nil }
        return value
    }
    
    public var array: [JSON]? {
        guard case .array(let value) = self else { return nil }
        return value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try container.decodeIfPresent(String.self).map(JSON.string)
            .or(container.decodeIfPresent(Int.self).map(JSON.int))
            .or(container.decodeIfPresent(Double.self).map(JSON.double))
            .or(container.decodeIfPresent(Bool.self).map(JSON.bool))
            .or(container.decodeIfPresent([String: JSON].self).map(JSON.nested))
            .or(container.decodeIfPresent([JSON].self).map(JSON.array))
            .or(container.decodeNil() ? .nil : nil)
            .resolve(with: JSON.typeMismatchError(for: container.codingPath))
    }

    // MARK: - private helpers
    private static func typeMismatchError(for codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Unsupported JSON value")
        return DecodingError.typeMismatch(JSON.self, context)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):   try container.encode(string)
        case .int(let int):         try container.encode(int)
        case .double(let double):   try container.encode(double)
        case .bool(let bool):       try container.encode(bool)
        case .nested(let nested):   try container.encode(nested)
        case .array(let array):     try container.encode(array)
        case .nil:                  try container.encodeNil()
        }
    }
    
    public subscript(key: String) -> JSON? {
        get { return nested?[key] }
        set {
            if case .nested(var dictionary) = self {
                dictionary[key] = newValue
                self = .nested(dictionary)
            }
        }
    }
}

private extension SingleValueDecodingContainer {
    func decodeIfPresent<T: Decodable>(_ type: T.Type) -> T? {
        return try? decode(type)
    }
}
