//
//  PropertyResponse.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertyResponseTest: XCTestCase {
    
    // MARK: - Parameters & Constants.
    
    // MARK: - Test vatiables.
    
    var sut: PropertyResponse!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        sut = PropertyResponse.main()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testEqualsToItself() {
        XCTAssertEqual(sut, sut)
    }
    
    func testIsntEqualToDifferentIfIdIsDifferent() {
        let other =  PropertyResponse(id: TestData.altId, price: TestData.price, beds: TestData.beds, thumbnailImage: UIImage())
        XCTAssertNotEqual(sut, other)
    }
    
}
