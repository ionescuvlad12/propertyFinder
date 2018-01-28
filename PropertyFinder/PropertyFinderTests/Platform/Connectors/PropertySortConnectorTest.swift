//
//  PropertySortConnectorTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertySortConnectorTest: XCTestCase {
    
    // MARK: - Test vatiables.
    
    var sut: PropertySortConnector!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        sut = PropertySortConnector(entityGateway: EntityGatewayTestDummy())
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testPresenterIsAssignedToView() {
        let vc = PropertySortViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertNotNil(vc.presenter)
    }
    
    func testConnectorIsAssignedToView() {
        let vc = PropertySortViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertTrue(vc.connector === sut)
    }
    
    func testViewIsAssignedToPresenter() {
        let vc = PropertySortViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertNotNil(vc.presenter.view)
    }
}

