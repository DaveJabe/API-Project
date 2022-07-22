//
//  APICommentViewModelTests.swift
//  ToDoListTests
//
//  Created by David Jabech on 7/20/22.
//

import XCTest
@testable import APIStuff

class APICommentViewModelTests: XCTestCase {
    
    // This expectation is fulfilled once data has been received
    var expectation: XCTestExpectation?
    
    // This tests the closure strategy, so we notify the test class that data has been fetched using delegation
    func test_getDataFromAPIHandlerWithClosure() {
        
        let viewModel = APICommentViewModel(delegate: self)
        
        // Fulfilled in delegate func
        expectation = XCTestExpectation(description: "testing viewModel func with closure")
        
        viewModel.getDataFromAPIHandler()
        
        wait(for: [expectation!], timeout: 1)
        
    }
    
    // This tests the completion handler strategy, so we notify the test class that data has been fetched using another completion handler
    func test_getDataFromAPIHandlerWithCompletionHandler() {
        
        let viewModel = APICommentViewModel(delegate: self)
        
        // Fulfilled in completion handler
        expectation = XCTestExpectation(description: "testing viewModel func with completionhandler")
        
        viewModel.getDataFromAPIHandler { [self] _ in
            XCTAssert(viewModel.getCount > 0, "We called APIHandler")
            expectation!.fulfill()
        }
        
        wait(for: [expectation!], timeout: 1)
    }
    
    // For the remaining test, we use the completion handler strategy to getDataFromAPIHandler
    
    func test_getBody() {
        
        let viewModel = APICommentViewModel(delegate: self)
        
        viewModel.getDataFromAPIHandler()
        
        expectation = XCTestExpectation(description: #function)
        
        wait(for: [expectation!], timeout: 1)
        XCTAssert(!viewModel.getBody(forItemAt: 0).isEmpty, "After initializing viewModel, we should have retrieved data and models should be populated with elements with bodies")
    }
}

extension APICommentViewModelTests: APIViewModelDelegate {
    func didGetData(error: Error?) {
        XCTAssertNil(error) // If the error == nil, the data has been successfully passed
        expectation?.fulfill()
    }
}
