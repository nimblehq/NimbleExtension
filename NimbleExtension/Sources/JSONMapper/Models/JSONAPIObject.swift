//
//  JSONAPIObject.swift
//  Braive
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

enum JSONAPIResponseType {
    
    case data(DataType<Resource>)
    case errors([JSONAPIError])
    case meta(JSON)
    
}

struct JSONAPIObject: Decodable {
    
    //todo:- data, errors, meta - (either data or errors)
    //       jsonapi, links, included (optional)
    
    let type: JSONAPIResponseType
    
    let links: Links?
    let included: [Resource]?
    let meta: JSON?
    
    var data: DataType<Resource>? {
        if case .data(let data) = type { return data }
        return nil
    }
    
    var errors: [JSONAPIError]? {
        if case .errors(let errors) = type { return errors }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case data, links, included, errors, meta
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.decodeIfPresent(DataType<Resource>.self, forKey: .data)
        let errors = try container.decodeIfPresent([JSONAPIError].self, forKey: .errors)
        
        if data.hasValue && errors.hasValue {
            throw Errors.JSONAPIDecoding.invalidFormat(
                reason: "Data and errors shouldn't co-exist in the same JSON:API object"
            )
        }
        
        meta = try container.decodeIfPresent(JSON.self, forKey: .meta)
        
        if let dataObject = data {
            type = .data(dataObject)
        } else if let errorObjects = errors {
            type = .errors(errorObjects)
        } else if let meta = meta {
            type = .meta(meta)
        } else {
            throw Errors.JSONAPIDecoding.invalidFormat(reason: "Either one of data, errors, or meta should have value")
        }
        
        links = try container.decodeIfPresent(Links.self, forKey: .links)
        included = try container.decodeIfPresent([Resource].self, forKey: .included)
    }
    
}
