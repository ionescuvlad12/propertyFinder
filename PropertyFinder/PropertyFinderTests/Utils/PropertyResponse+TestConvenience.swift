//
//  PropertyResponse+TestConvenience.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

extension PropertyResponse {
    
    static func main() -> PropertyResponse {
        return PropertyResponse(id: TestData.mainId, price: TestData.price, beds: TestData.beds, thumbnailImage: UIImage())
    }
    
    static func alt() -> PropertyResponse {
        return PropertyResponse(id: TestData.altId, price: TestData.price, beds: TestData.beds, thumbnailImage: UIImage())
    }
}
