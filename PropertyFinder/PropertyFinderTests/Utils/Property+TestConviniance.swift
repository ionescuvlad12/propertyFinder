//
//  Property+TestConviniance.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

extension Property {
    
    static func main() -> Property {
        return  Property(id: TestData.mainId, thumbnailURL: TestData.thumbnailURL, price: TestData.price, beds: TestData.beds)
    }
    
    static func alt() -> Property {
        return  Property(id: TestData.altId, thumbnailURL: TestData.thumbnailURL, price: TestData.price, beds: TestData.beds)
    }
    
    static func mainDict(completion: @escaping (_ result: NSDictionary?) -> Void) {
        JsonLoader.getJsonFrom(urlString: "https://www.propertyfinder.ae/mobileapi") { (dict) in
            completion(dict)
        }
    }
    
    static func altDict(completion: @escaping (_ result: NSDictionary?) -> Void) {
        JsonLoader.getJsonFrom(urlString: "https://www.propertyfinder.ae/mobileapi?order=pa") { (dict) in
            completion(dict)
        }
    }
}
