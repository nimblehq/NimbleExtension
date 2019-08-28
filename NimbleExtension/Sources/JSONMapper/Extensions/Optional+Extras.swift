//  Optional+Or.swift
//
//  Created by Edgars Simanovskis on 27/08/2019.
//  Copyright © 2018 Nimble. All rights reserved.
//

public extension Optional {
    
    var isNil: Bool {
        return self == nil
    }
    
    var hasValue: Bool { return !isNil }

    func or(_ otherOptional: @autoclosure () throws -> Wrapped?) rethrows -> Wrapped? {
        switch self {
        case .some(let value):
            return value
        case .none:
            return try otherOptional()
        }
    }
    
    func or(_ otherWrapped: @autoclosure () throws -> Wrapped) rethrows -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return try otherWrapped()
        }
    }

    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none:
            throw error()
        case .some(let wrapped):
            return wrapped
        }
    }
}
