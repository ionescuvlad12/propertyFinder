//
//  InMemoryRepoTest.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import XCTest
@testable import PropertyFinder


class InMemoryRepoTests: XCTestCase {
    
    // MARK: - Test vatiables.
    
    var sut: InMemoryRepo!
    var data = NSMutableDictionary()
    
    
    // MARK: - Basic test.
    
    func testFetchReturnsNothingIfRepoIsEmpty() {
        sut = InMemoryRepo(propertiesDictinary: NSDictionary())
        
        XCTAssertEqual([Property](), sut.fetchProperties())
    }
    
    func testFetchReturnsRepoContents() {
        // An expectation is used to make the test runner wait for an
        // async operation to be completed.
        let delayExpectation = expectation(description: "Waiting for list to be Fetched")
        // Fulfill the expectation after 10 seconds
        // (which matches our document save interval)
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            delayExpectation.fulfill()
        }
        Property.mainDict { (dict) in
            self.data = NSMutableDictionary(dictionary: dict!)
            self.sut = InMemoryRepo(propertiesDictinary: self.data)
            }
        waitForExpectations(timeout: 15)
         XCTAssertNotNil(self.sut.fetchProperties())
    }
}

