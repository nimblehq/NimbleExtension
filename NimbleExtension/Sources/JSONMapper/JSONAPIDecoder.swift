//  JSONAPIDecoder.swift
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimble. All rights reserved.
//

import Foundation

public class JSONAPIDecoder: JSONDecoder {
    
    private typealias ResourceDictionary = [ResourceIdentifier: Resource]

    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let jsonAPIObject = try super.decode(JSONAPIObject.self, from: data)

        let includedData = jsonAPIObject.included ?? []
        let dictionary = includedDictionary(from: includedData)

        switch jsonAPIObject.type {
        case .data(let data):
            return try decode(data, including: dictionary, into: type)
        case .meta(let meta):
            return try decode(meta, into: type)
        case .errors(let errors):
            throw errors
        }
    }
    
    public func decodeWithMeta<Value: Decodable, Meta: Decodable>(
        value valueType: Value.Type,
        meta metaType: Meta.Type,
        from data: Data
    ) throws -> (value: Value, meta: Meta) {
        let jsonAPIObject = try super.decode(JSONAPIObject.self, from: data)
        
        let includedData = jsonAPIObject.included ?? []
        let dictionary = includedDictionary(from: includedData)
        
        switch jsonAPIObject.type {
        case .data(let data):
            return (
                value: try decode(data, including: dictionary, into: valueType),
                meta: try decode(jsonAPIObject.meta ?? .nil, into: metaType)
            )
        case .meta(let meta):
            throw Errors.JSONAPIDecodingError.unableToDecode(
                reason: "No data field. Only contains meta: \(meta)"
            )
        case .errors(let errors):
            throw errors
        }
    }
    
}

// MARK: - Private
    
extension JSONAPIDecoder {
    
    private func decode<T: Decodable>(_ meta: JSON, into type: T.Type) throws -> T {
        let data = try JSONEncoder().encode(meta)
        return try super.decode(type, from: data)
    }
    
    private func decode<T: Decodable>(_ dataType: DataType<Resource>,
                                      including includedDictionary: ResourceDictionary,
                                      into type: T.Type) throws -> T {
        switch dataType {
        case .single(let resource):
            return try decode(resource, including: includedDictionary, into: type)
            
        case .collection(let resources):
            return try decodeCollection(of: resources, including: includedDictionary, into: type)
        }
    }

    private func decode<T: Decodable>(_ resource: Resource,
                                      including includedDictionary: ResourceDictionary,
                                      into type: T.Type) throws -> T {
        let dictionary = try resolvedAttributes(of: resource, including: includedDictionary)
        let data = try JSONEncoder().encode(dictionary)
        return try super.decode(type, from: data)
    }

    private func decodeCollection<T: Decodable>(of resources: [Resource],
                                                including includedDictionary: ResourceDictionary,
                                                into type: T.Type) throws -> T {
        let collection = try resources.compactMap { try resolvedAttributes(of: $0, including: includedDictionary) }
        let data = try JSONEncoder().encode(collection)
        return try super.decode(type, from: data)
    }

    private func includedDictionary(from includedData: [Resource]) -> ResourceDictionary {
        return includedData.reduce(into: [:]) { dictionary, resource in
            let identifier = ResourceIdentifier(id: resource.id, type: resource.type)
            dictionary[identifier] = resource
        }
    }
    
    private func resolvedAttributes(of resource: Resource,
                                    including includedDictionary: ResourceDictionary) throws -> JSON? {
        var attributes = resource.attributes?.nested ?? [:]
        attributes[Resource.CodingKeys.id.rawValue] = .string(resource.id)
        attributes[Resource.CodingKeys.type.rawValue] = .string(resource.type)

        try resource.relationships?.forEach { key, relationship in
            guard let type = relationship.data else { return }
            switch type {
            case .single(let identifier):
                let includedResource = try getResource(from: includedDictionary, for: identifier)
                attributes[key] = try resolvedAttributes(of: includedResource, including: includedDictionary)
                
            case .collection(let identifiers):
                let includedAttributes = try identifiers
                    .map { try getResource(from: includedDictionary, for: $0) }
                    .compactMap { try resolvedAttributes(of: $0, including: includedDictionary) }
                attributes[key] = .array(includedAttributes)
            }
        }
        return .nested(attributes)
    }

    private func getResource(from includedDictionary: ResourceDictionary,
                             for identifier: ResourceIdentifier) throws -> Resource {
        guard let resource = includedDictionary[identifier] else {
            throw Errors.JSONAPIDecodingError.resourceNotFound(identifier: identifier)
        }
        return resource
    }
}
