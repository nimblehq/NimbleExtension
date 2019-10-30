//  Resource.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

public struct Resource: JSONAPICodable {
    
    enum CodingKeys: String, CodingKey {
        case id, type, attributes, relationships, links, meta
    }

    public let id: String
    public let type: String

    public let attributes: JSON?
    public let relationships: [String: Relationship]?
    public let links: Links?
    public let meta: JSON?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        attributes = try container.decodeIfPresent(JSON.self, forKey: .attributes)
        relationships = try container.decodeIfPresent([String: Relationship].self, forKey: .relationships)
        links = try container.decodeIfPresent(Links.self, forKey: .links)
        meta = try container.decodeIfPresent(JSON.self, forKey: .meta)
    }
}
