//
//  Property.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

struct Property: Equatable {
    let id: Int
    let thumbnailURL: String
    let price: Double
    let beds: Int
    
    static func ==(lhs: Property, rhs: Property) -> Bool {
        if lhs.id != rhs.id { return false }
        return true
    }
}
