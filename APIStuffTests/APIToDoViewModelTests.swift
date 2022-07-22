//
//  APIToDoViewModelTests.swift
//  ToDoListTests
//
//  Created by David Jabech on 7/19/22.
//

import XCTest
@testable import APIStuff

class APIToDoViewModelTests: XCTestCase {
        
    // This expectation is fulfilled once data has been received
    var expectation: XCTestExpectation?

    func test_getEmptyTitle() {
        let viewModel = APIToDoViewModel(delegate: self)
        let testTitle = viewModel.getTitle(forItemAt: 0)
        XCTAssert(testTitle == "", "testTitle should equal empty string because index is out of bounds (models is empty)")
    }
    
    // This tests the closure strategy, so we notify the test class that data has been fetched using delegation
    func test_getDataFromAPIHandlerWithClosure() {
        
        let viewModel = APIToDoViewModel(delegate: self)
        
        // Fulfilled in delegate func
        expectation = XCTestExpectation(description: "testing viewModel func with closure")
        
        viewModel.getDataFromAPIHandler()
        
        wait(for: [expectation!], timeout: 1)
    }
    
    // This tests the completion handler strategy, so we notify the test class that data has been fetched using another completion handler
    func test_getDataFromAPIHandlerWithCompletionHandler() {
        
        let viewModel = APIToDoViewModel(delegate: self)
        
        // Fulfilled in completion handler
        expectation = XCTestExpectation(description: "testing viewModel func with completionhandler")
        
        viewModel.getDataFromAPIHandler { [self] _ in
            XCTAssert(viewModel.getCount > 0, "We called APIHandler")
            expectation!.fulfill()
        }
        
        wait(for: [expectation!], timeout: 1)
    }
    
    // For the remaining tests, we use the completion handler strategy to getDataFromAPIHandler
    
    func test_getTitle() {
        
        let viewModel = APIToDoViewModel(delegate: self)
        
        expectation = XCTestExpectation(description: #function)
        
        viewModel.getDataFromAPIHandler { [self] _ in
            XCTAssert(!viewModel.getTitle(forItemAt: 0).isEmpty, "Because we fetched the API data, the title for the first item should not be nil")
            expectation!.fulfill()
        }
        wait(for: [expectation!], timeout: 1)
    }
    
    func test_getID() {
        
        let viewModel = APIToDoViewModel(delegate: self)
        
        expectation = XCTestExpectation(description: #function)
        
        viewModel.getDataFromAPIHandler { [self] _ in
            XCTAssert(viewModel.getID(forItemAt: 0) != 0, "Because we fetched the API data, the ID for the first item should have a value")
            expectation!.fulfill()
        }
        wait(for: [expectation!], timeout: 1)
    }
    
    func test_getIsCompleted() {
        
        let viewModel = APIToDoViewModel(delegate: self)
        
        expectation = XCTestExpectation(description: #function)
        
        viewModel.getDataFromAPIHandler { [self] _ in
            XCTAssertNotNil(viewModel.getIsCompleted(forItemAt: 0), "Because we fetched the API data, the isCompleted bool should have a value")
            expectation!.fulfill()
        }
        wait(for: [expectation!], timeout: 1)
    }
}

extension APIToDoViewModelTests: APIViewModelDelegate {
    func didGetData(error: Error?) {
        XCTAssertNil(error) // If the error == nil, the data has been successfully passed
        expectation!.fulfill()
    }
}
