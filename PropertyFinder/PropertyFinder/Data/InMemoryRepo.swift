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
           properties = addPropertiesFrom(dictioanrys: propertiesDictionaries)
        }
    }
    
    private func addPropertiesFrom(dictioanrys: [NSDictionary]) -> [Property]{
        var propertyArray:[Property] = []
        for dict in  dictioanrys {
            guard let id:Int =  dict.value(forKey: "id") as? Int else {continue}
            guard let thumbnailURL: String = dict.value(forKey: "thumbnail") as? String else {continue}
            guard let price: Double = dict.value(forKey: "price_value_raw") as? Double else {continue}
            guard let beds: Int = dict.value(forKey: "bedrooms") as? Int else {continue}
            let property = Property(id: id, thumbnailURL: thumbnailURL, price: price, beds: beds)
            propertyArray.append(property)
        }
        return propertyArray
    }
}


extension InMemoryRepo: EntityGateway {
    
    func appendNewPropertiesFrom(dict: NSDictionary) -> [Property] {
        if let propertiesDictionaries = dict.value(forKey: "res") as? [NSDictionary], propertiesDictionaries.count > 0 {
           properties.append(contentsOf:addPropertiesFrom(dictioanrys: propertiesDictionaries))
            return properties
        }
        return []
    }
    
    func sortProperties(with dict: NSDictionary) {
        properties.removeAll()
        if let propertiesDictionaries = dict.value(forKey: "res") as? [NSDictionary] {
           properties = addPropertiesFrom(dictioanrys: propertiesDictionaries)
        }
    }
    
    func fetchProperties() -> [Property] {
        return properties
    }
}
