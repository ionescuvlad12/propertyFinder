//
//  UseCaseFactoryTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class UseCaseFactoryTest: XCTestCase {
    
    // MARK: - Test vatiables.
    
    var sut: UseCaseFactory!
    var entityGateway: EntityGateway!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        entityGateway = EntityGatewayTestDummy()
        sut = UseCaseFactory(entityGateway: entityGateway)
    }
    
    override func tearDown() {
        sut = nil
        entityGateway = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testFactoryCreatesShowPropertyUseCase() {
        let useCase = sut.showPropertiesListUseCase(handler: MultiplePropertyResponsesHandlerMock())
        XCTAssertNotNil(useCase as? ShowPropertiesListUseCase)
    }
    
    func testFactoryCreatesSortPropertysListUseCase() {
        let useCase = sut.sortPropertiesListUseCases(url: TestData.thumbnailURL)
        XCTAssertNotNil(useCase as? SortPropertyListUseCase)
    }
    
    // MARK: - Stubs & Mocks.
    
    class MultiplePropertyResponsesHandlerDummyTest: MultiplePropertiesResponsesHandler {
        var handlerMethodInvoked = 0
        
        func handleMultiplePropertiesResponses(properties: [PropertyResponse]) {
            handlerMethodInvoked += 1
        }
        
        func appendMultiplePropertiesResponses(properties: [PropertyResponse]) {
            handlerMethodInvoked += 1
        }
    }
}
