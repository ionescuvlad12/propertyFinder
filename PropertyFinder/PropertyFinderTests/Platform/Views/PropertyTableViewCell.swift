//
//  PropertyTableViewCell.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder


class PropertyTableViewCellTests: XCTestCase {
    
    // MARK: - Parameters & Constants.
    
    
    // MARK: - Test vatiables.
    
    var sut: PropertyTableViewCell!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        sut = PropertyTableViewCell()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testDisplayPriceSetsPriceLabelText() {
        let priceLabel = UILabel()
        sut.priceLabel = priceLabel
        
        sut.display(price: TestData.price)
        
        XCTAssertEqual(TestData.priceString, priceLabel.text)
    }
    
    func testDisplayBedseSetsBedsLabelText() {
        let bedLabel = UILabel()
        sut.badsLabel = bedLabel
        
        sut.display(beds: TestData.beds)
        XCTAssertEqual(TestData.bedsString, bedLabel.text)
    }
}

