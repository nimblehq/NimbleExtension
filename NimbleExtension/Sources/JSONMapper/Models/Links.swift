//  Links.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

struct Links: Codable {
    
    enum CodingKeys: String, CodingKey {
        case selfURL = "self"
        case relatedURL = "related"
        case articleURL = "article"
    }

    let selfURL: Link?
    let relatedURL: Link?
    let articleURL: Link?
}
