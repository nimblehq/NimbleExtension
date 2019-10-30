//  ResourceIdentifier.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

public protocol ResourceIdentifiable {
    var id: String { get }
    var type: String { get }
}

public struct ResourceIdentifier: JSONAPICodable, Hashable {
    public let id: String
    public let type: String
}

//todo:- continue working on this one after relationships field is required
//       to be as a parameter of JSON:API request.

public extension ResourceIdentifiable {
    var resourceIdentifier: ResourceIdentifier {
        return ResourceIdentifier(id: id, type: type)
    }
}
