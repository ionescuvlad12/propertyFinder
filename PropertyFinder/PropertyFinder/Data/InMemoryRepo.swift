//
//  InMemoryRepo.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class InMemoryRepo {
    private var properties: [Property] = []
    
    init(propertiesDictinary: NSDictionary) {
        if let propertiesDictionaries = propertiesDictinary.value(forKey: "res") as? [NSDictionary] {
            for dict in  propertiesDictionaries{
                let id:String = String(describing: dict.value(forKey: "id"))
                let thumbnailURL: String = dict.value(forKey: "thumbnail") as! String
                let price: Double = dict.value(forKey: "price_value_raw") as! Double
                let beds: Int = dict.value(forKey: "bedrooms") as! Int
                let property = Property(id: id, thumbnailURL: thumbnailURL, price: price, beds: beds)
                self.properties.append(property)
            }
        }
    }
}


extension InMemoryRepo: EntityGateway {
    func fetchProperties() -> [Property] {
        return properties
    }
    
   
}
