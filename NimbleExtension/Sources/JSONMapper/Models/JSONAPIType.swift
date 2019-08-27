//
//  JSONAPIType.swift
//  Braive
//
//  Created by Pirush Prechathavanich on 4/5/18.
//  Copyright © 2018 Nimbl3. All rights reserved.
//

typealias JSONAPICodable = JSONAPIType & Codable

protocol JSONAPIType {
    
    var id: String { get }
    var type: String { get }
    
}
