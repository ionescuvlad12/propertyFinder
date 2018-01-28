//
//  ShowPropertyListUseCaseTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class ShowPropertyListUseCaseTest: XCTestCase {
    
    // MARK: - Parameters & Constants.
    
    
    // MARK: - Test vatiables.
    
    var sut: ShowPropertiesListUseCase!
    var entityGateway: EntityGatewayMock!
    var handler: MultiplePropertyResponsesHandlerMock!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        entityGateway = EntityGatewayMock()
        handler = MultiplePropertyResponsesHandlerMock()
        sut = ShowPropertiesListUseCase(entityGateway: entityGateway, handler: handler)
    }
    
    override func tearDown() {
        sut = nil
        entityGateway = nil
        handler = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testRepoWithNoEntitiesGeneratesNoPropertyResponses() {
        entityGateway.properties = []
        
        sut.execute { (sucess) in
            XCTAssertEqual(0, self.handler.responses.count, "PropertyResponses")
        }
        
        
    }
    
    func testTransformsPropertyEntityIntoResponse() {
        entityGateway.properties = [ Property.main(), ]
        let expected = [ PropertyResponse.main() ]
        
        sut.execute { (success) in
            XCTAssertEqual(expected, self.handler.responses)
        }
        
    }
    
    func testTransformsTwoPropertyEntitiesIntoResponses() {
        entityGateway.properties = [ Property.main(),
                                      Property.alt(),]
        let expected = [ PropertyResponse.main(),
                         PropertyResponse.alt(), ]
        
        sut.execute { (success) in
            XCTAssertEqual(expected, self.handler.responses)
        }
        
       
    }
    
    // MARK: - Stubs & Mocks.
    
    class EntityGatewayMock: EntityGatewayTestDummy {
        var properties: [Property] = []
        override func fetchProperties() -> [Property] {
            return properties
        }
    }
}
    class MultiplePropertyResponsesHandlerMock: MultiplePropertiesResponsesHandler {
        var responses: [PropertyResponse] = []
        func handleMultiplePropertiesResponses(properties: [PropertyResponse]) {
            responses = properties
        }
        
        func appendMultiplePropertiesResponses(properties: [PropertyResponse]) {
            responses.append(contentsOf: properties)
        }
        
        
        func handleMultiplePropertyResponses(programmers: [PropertyResponse]) {
            responses = programmers
        }
    }
