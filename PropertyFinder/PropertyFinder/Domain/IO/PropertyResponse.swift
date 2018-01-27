//
//  PropertyResponse.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

struct PropertyResponse {
    let id: String
    let thumbNailURL: String
    let price: Double
    let beds: Int
}

extension PropertyResponse {
    init(property: Property) {
        id = property.id
        price = property.price
        thumbNailURL = property.thumbNailURL
        beds = property.beds
    }
}
