//
//  PropertyListPresenterListTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertyListPresenterListTest: XCTestCase {
    
    // MARK: - Test vatiables.
    
    var sut: PropertyListPresenter!
    var useCaseFactory: UseCaseFactoryMock!
    var view: PropertyListViewMock!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        useCaseFactory = UseCaseFactoryMock(entityGateway: EntityGatewayTestDummy())
        view = PropertyListViewMock()
        sut = PropertyListPresenter(useCaseFactory: useCaseFactory)
        sut.view = view
    }
    
    override func tearDown() {
        sut = nil
        useCaseFactory = nil
        view = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testViewReadyInvokesUseCase() {
        sut.viewReady()
        
        XCTAssertEqual(1, useCaseFactory.useCase.executeWasInvoked)
    }
    
    func testNumberOfPropertiesIsZeroIfNoDataIsPassed() {
        sut.handleMultiplePropertiesResponses(properties: [])
        XCTAssertEqual(0, sut.numberOfProperties)
    }
    
    func testNumberOfDataIsTheCountOfDataPassed() {
        let data = [ PropertyResponse.main(), PropertyResponse.alt() ]
        sut.handleMultiplePropertiesResponses(properties: data)
        
        XCTAssertEqual(data.count, sut.numberOfProperties)
    }
    
    func testCellIsConfiguredWithPriceOfFetchedProperty() {
        let cell: PropertyListItemViewMock
        let data = [ PropertyResponse.main(), PropertyResponse.alt() ]
        cell = PropertyListItemViewMock()
        sut.handleMultiplePropertiesResponses(properties: data)
        
        sut.configure(cell: cell, forRow: 1)
        
        XCTAssertEqual(TestData.price, cell.displayedPrice)
    }
    
    
    func testSortButtonTappedTellsViewToNavigateToSortProperty() {
        sut.sortButtonTapped()
        
        XCTAssertEqual(1, view.navigateToSortPropertyInvoked)
    }
    
    func testDataHasChangedInvokesUseCase() {
        sut.dataChanged()
        
        XCTAssertEqual(1, useCaseFactory.useCase.executeWasInvoked)
    }
    
    
    // MARK: - Stubs & Mocks.
    
    class UseCaseFactoryMock: UseCaseFactory {
        let useCase = UseCaseMock()
        
        override func showPropertiesListUseCase(handler: MultiplePropertiesResponsesHandler) -> UseCase {
            useCase.handler = handler
            return useCase
        }
        
    }
    
    class UseCaseMock: UseCase {
        var executeWasInvoked = 0
        var handler: MultiplePropertiesResponsesHandler?
        var properties: [PropertyResponse] = []
        func execute(completion: @escaping (Bool) -> Void) {
            executeWasInvoked += 1
            handler?.handleMultiplePropertiesResponses(properties: properties)
        }
    }
    
    class PropertyListViewMock: PropertyListView {
        var refreshWasInvoke = 0
        var appendWasInvoked = 0
        var navigateToSortPropertyInvoked = 0
        
        func refresh() {
            refreshWasInvoke += 1
        }
        
        func navigateToSortPropery() {
            navigateToSortPropertyInvoked += 1
        }
        
        func appendRows() {
            appendWasInvoked += 1
        }
    }
    
    class PropertyListItemViewMock: PropertyListItemView {
        var displayedPrice:Double = 1221
        var displayedBeds = 4
        var displayedImg = UIImage()
        func display(thumbnailImage: UIImage) {
            displayedImg = thumbnailImage
        }
        
        func display(price: Double) {
            displayedPrice = price
        }
        
        func display(beds: Int) {
            displayedBeds = beds
        }
    }
}
