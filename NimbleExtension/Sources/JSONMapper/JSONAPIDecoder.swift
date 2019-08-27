//
//  JSONAPIDecoder.swift
//  Braive
//
//  Created by Pirush Prechathavanich on 4/4/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

import Foundation

class JSONAPIDecoder: JSONDecoder {
    
    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let jsonAPIObject = try super.decode(JSONAPIObject.self, from: data)
        
        let includedData = jsonAPIObject.included ?? []
        let dictionary = includedDictionary(from: includedData)
        
        switch jsonAPIObject.type {
        case .data(let data):       return try decode(data, including: dictionary, into: type)
        case .meta(let meta):       return try decode(meta, into: type)
        case .errors(let errors):   throw errors
        }
    }
    
    // MARK: - private helpers
    
    private typealias ResourceDictionary = [ResourceIdentifier: Resource]
    
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
    
    private func resolvedAttributes(of resource: Resource, including includedDictionary: ResourceDictionary) throws -> JSON? {
        guard var attributes = resource.attributes?.nested else { return nil } //todo:- should throw instead?
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
            throw Errors.JSONAPIDecoding.resourceNotFound(identifier: identifier)
        }
        return resource
    }
    
}
