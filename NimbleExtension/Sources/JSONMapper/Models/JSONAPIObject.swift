//  JSONAPIObject.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimble. All rights reserved.
//

import Foundation

public enum JSONAPIResponseType {

    case data(DataType<Resource>)
    case errors([JSONAPIError])
    case meta(JSON)
}

public struct JSONAPIObject: Decodable {
    //todo:- data, errors, meta - (either data or errors)
    //       jsonapi, links, included (optional)
    enum CodingKeys: String, CodingKey {
        case data, links, included, errors, meta
    }
    
    public let type: JSONAPIResponseType

    public let links: Links?
    public let included: [Resource]?
    public let meta: JSON?

    public var data: DataType<Resource>? {
        if case .data(let data) = type { return data }
        return nil
    }

    public var errors: [JSONAPIError]? {
        if case .errors(let errors) = type { return errors }
        return nil
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let data = try container.decodeIfPresent(DataType<Resource>.self, forKey: .data)
        let errors = try container.decodeIfPresent([JSONAPIError].self, forKey: .errors)

        if data.hasValue && errors.hasValue {
            throw Errors.JSONAPIDecodingError.invalidFormat(
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
            throw Errors.JSONAPIDecodingError.invalidFormat(
                reason: "Either one of data, errors, or meta should have value")
        }

        links = try container.decodeIfPresent(Links.self, forKey: .links)
        included = try container.decodeIfPresent([Resource].self, forKey: .included)
    }
}
