//
//  PropertyListConnectorTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertyListConnectorTest: XCTestCase {
    
 
    // MARK: - Parameters & Constants.
    
    
    
    // MARK: - Test vatiables.
    
    var sut: PropertyListConnector!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        sut = PropertyListConnector(entityGateway: EntityGatewayTestDummy())
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
        let vc = PropertyTableViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertNotNil(vc.presenter)
    }
    
    func testViewIsAssignedToPresenter() {
        let vc = PropertyTableViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertNotNil(vc.presenter.view)
    }
    
    func testConnectorIsAssignedToView() {
        let vc = PropertyTableViewController()
        
        sut.assembleModule(view: vc)
        
        XCTAssertTrue(vc.connector === sut)
    }
    
    func testNavigateToSortPropertyInvokesPropertySortConnectorInit() {
        let vc = PropertySortViewController()
        var nextConnectorInitialized = false
        sut.propertySortConnectorInit = { entityGateway in
            nextConnectorInitialized = true
            return PropertySortConnectorMock(entityGateway: entityGateway)
        }        
        sut.navigateToSortProperty(viewController: vc)
        
        XCTAssertTrue(nextConnectorInitialized)
    }
    
    func testNavigateToSortPropertyInvokesAssembleModuleOfPropertySortConnector() {
        let vc = PropertySortViewController()
        let connectorMock = PropertySortConnectorMock(entityGateway: EntityGatewayTestDummy())
        sut.propertySortConnectorInit = { entityGateway in
            return connectorMock
        }
        sut.navigateToSortProperty(viewController: vc)
        
        XCTAssertEqual(1, connectorMock.assembleModuleWasInvoked)
    }
    
    // MARK: - Stubs & Mocks.
    
    class PropertySortConnectorMock: PropertySortConnector {
        var assembleModuleWasInvoked = 0
        override func assembleModule(view: PropertySortViewController) {
            assembleModuleWasInvoked += 1
        }
    }
    
    class PropertyListPresenterMock: PropertyListPresenter {
        
    }
}
