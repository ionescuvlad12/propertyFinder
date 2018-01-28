//
//  PropertyTableViewControllerTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder

class PropertyTableViewControllerTest: XCTestCase {
    
    // MARK: - Parameters & Constants.
    
    let storyboardName = "Main"
    
    
    // MARK: - Test vatiables.
    
    var sut: PropertyTableViewController!
    var presenter: PropertyListPresenterMock!
    
    
    // MARK: - Set up and tear down.
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: PropertyTableViewController.ID) as? PropertyTableViewController
        presenter = PropertyListPresenterMock(useCaseFactory: UseCaseFactory(entityGateway: EntityGatewayTestDummy()))
        sut.presenter = self.presenter
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    // MARK: - Basic test.
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "Sut must not be nil.")
    }
    
    func testQueriesPresenterForNumberOfRows() {
        _ = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(1, presenter.numberOfPropertiesInvoked)
    }
    
    func testPresenterConfiguresCells() {
        presenter.numOfProperties = 1
        
        _ = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(1, presenter.configureCellAtInvoked)
    }
    
    // MARK: - UI Actions
    
    func testSortInvokesSortPropertyInPresenter() {
        sut.sort(UIBarButtonItem())
        
        XCTAssertEqual(1, presenter.sortButtonTappedInvoked)
    }
    
    // MARK: - View Protocol
    
    func testNavigateToSortPropertyPerformsSegue() {
        let altSut = PropertiesTableViewControllerMock()
        
        altSut.navigateToSortPropery()
        XCTAssertEqual(PropertyTableViewController.SegueIdentifier.sortProperty.rawValue, altSut.identifier)
    }
    
    
    func testRefreshReloadsTableViewData() {
        let tableViewMock = TableViewMock()
        sut.tableView = tableViewMock
        
        sut.refresh()
        
        XCTAssertEqual(1, tableViewMock.reloadDataWasInvoked)
    }
    
    
    // MARK: - Segues
    
    func testSegueToSortPropertyInvokesConnectorToNavigate() {
        let connectorMock = PropertiesListConnectorMock(entityGateway: EntityGatewayTestDummy())
        sut.connector = connectorMock
        
        sut.performSegue(withIdentifier: PropertiesTableViewControllerMock.SegueIdentifier.sortProperty, sender: sut)
        
        XCTAssertEqual(1, connectorMock.navigateToSortPropertyInvoked)
    }
    
    func testMethodForUnwindToPropertiesListIsDefined() {
        XCTAssertTrue(sut.responds(to: #selector(PropertyTableViewController.unwindToPropertyList(segue:))))
    }
    
    
    func testUnwindWithChangesNotifiesPresenter() {
        sut.unwindToPropertyList(segue: UIStoryboardSegue(identifier: PropertySortViewController.UnwindSegueIdentifier.toPropertyLists.rawValue, source: UIViewController(), destination: UIViewController()))
        
        XCTAssertEqual(1, presenter.dataChangedWasInvoked)
    }
    
    
    // MARK: - Table view delegate
    
    
    // MARK: - Stubs & Mocks.
    
    class PropertyListPresenterMock: PropertyListPresenter {
        var numOfProperties = 0
        var viewReadyInvoked = 0
        var numberOfPropertiesInvoked = 0
        var configureCellAtInvoked = 0
        var sortButtonTappedInvoked = 0
        var dataChangedWasInvoked = 0
        
        
        override var numberOfProperties: Int {
            numberOfPropertiesInvoked += 1
            return numOfProperties
        }
        
        override func viewReady() {
            viewReadyInvoked += 1
        }
        
        override func configure(cell: PropertyListItemView, forRow row: Int) {
            configureCellAtInvoked += 1
        }
        
        override func sortButtonTapped() {
            sortButtonTappedInvoked += 1
        }
        
        override func dataChanged() {
            dataChangedWasInvoked += 1
        }
    }
    
    class PropertiesTableViewControllerMock: PropertyTableViewController {
        var identifier = ""
        override func performSegue(withIdentifier identifier: String, sender: Any?) {
            self.identifier = identifier
        }
    }
    
    class PropertiesListConnectorMock: PropertyListConnector {
        var navigateToSortPropertyInvoked = 0
        
        override func navigateToSortProperty(viewController: UIViewController) {
            navigateToSortPropertyInvoked += 1
        }
    }
    
    class TableViewMock: UITableView {
        var reloadDataWasInvoked = 0
        
        override func reloadData() {
            reloadDataWasInvoked += 1
        }
    }
}
