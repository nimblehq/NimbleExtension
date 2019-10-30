//  Link.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

public struct Link: Codable {
    
    enum CodingKeys: String, CodingKey {
        case url = "href"
        case meta
    }

    let url: URL
    let meta: JSON?

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer() {
            url = try container.decode(URL.self)
            meta = nil
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            url = try container.decode(URL.self, forKey: .url)
            meta = try container.decodeIfPresent(JSON.self, forKey: .meta)
        }
    }
}
