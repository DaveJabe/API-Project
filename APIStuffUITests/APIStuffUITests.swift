//
//  APIStuffUITests.swift
//  APIStuffUITests
//
//  Created by David Jabech on 7/21/22.
//

import XCTest

class APIStuffUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_toDoTableScroll() {
        let app = XCUIApplication()
        app.launch()

        app.tables.cells.containing(.staticText, identifier:"1").children(matching: .other).element(boundBy: 1).swipeUp()

    }

    
    func test_CommentsButton() {
        let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.buttons["SEE COMMENTS"].staticTexts["SEE COMMENTS"]/*[[".buttons[\"SEE COMMENTS\"].staticTexts[\"SEE COMMENTS\"]",".staticTexts[\"SEE COMMENTS\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotNil(app.tables.element(matching: .staticText, identifier: "API Comments"))
    }

}
