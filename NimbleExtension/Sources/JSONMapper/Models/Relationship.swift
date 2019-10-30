//
//  Relationship.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

public struct Relationship: Codable {
    
    enum CodingKeys: String, CodingKey {
        case links, data, meta
    }
    
    public let links: Links?
    public let data: DataType<ResourceIdentifier>?
    public let meta: JSON?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        links = try container.decodeIfPresent(Links.self, forKey: .links)
        data = try container.decodeIfPresent(DataType<ResourceIdentifier>.self, forKey: .data)
        meta = try container.decodeIfPresent(JSON.self, forKey: .meta)

        if links.isNil && data.isNil && meta.isNil {
            guard try !container.decodeNil(forKey: .data) else { return }
            let description = "Relationship object must contain at least one of links, data, or meta"
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: description)
            throw DecodingError.typeMismatch(Relationship.self, context)
        }
    }
}
