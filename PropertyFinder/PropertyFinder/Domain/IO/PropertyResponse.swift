//
//  PropertyResponse.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation
import UIKit

struct PropertyResponse: Equatable {
    let id: Int
    let price: Double
    let beds: Int
    // usualy we should have only primitives and the response should not know about UIKit, but in this case we consider UIImage as a primitive, we could also load it in viewController
    let thumbnailImage:UIImage
    
    static func ==(lhs: PropertyResponse, rhs: PropertyResponse) -> Bool {
        if lhs.id != rhs.id { return false }
        return true
    }
}

extension PropertyResponse {
    init(property: Property) {
        id = property.id
        price = property.price
        thumbnailImage = URLImageLoader.getImageFrom(urlString: property.thumbnailURL)
        beds = property.beds
    }
}
