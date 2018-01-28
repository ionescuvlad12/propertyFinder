//
//  PropertyTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertyTest: XCTestCase {
    
    // MARK: - Parameters & Constants.
    
    // MARK: - Test vatiables.
    
    var sut: Property!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        sut = Property.main()
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
        let other = Property (id: TestData.altId, thumbnailURL: TestData.thumbnailURL, price: TestData.price, beds: TestData.beds)
        XCTAssertNotEqual(sut, other)
    }
    
}
