//
//  UserDetailsScreenUITests.swift
//  TymeUITests
//
//  Created by Vinh Tong on 1/3/25.
//

import XCTest

class UserDetailsScreenUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testUserListScreenLoadsUsers() throws {
        // Verify navigation title
        XCTAssertTrue(app.navigationBars["Github Users"].exists)
        
        // Wait for users to load
        let firstUser = app.cells.firstMatch
        XCTAssertTrue(firstUser.waitForExistence(timeout: 5))
        
        // Verify at least one user appears in the list
        XCTAssertTrue(app.cells.count > 0)
    }
    
    func testNavigatingToUserDetailsScreen() throws {
        let firstUser = app.cells.firstMatch.images.firstMatch
        XCTAssertTrue(firstUser.exists)
        
        // Tap on first user
        firstUser.tap()
        
        // Verify navigation to UserDetailsScreen
        XCTAssertTrue(app.navigationBars["User Details"].exists)
        
        // Go back to user list
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Github Users"].exists)
    }
    
    func testPullToRefresh() throws {
        let firstUser = app.cells.firstMatch
        XCTAssertTrue(firstUser.waitForExistence(timeout: 5))
        
        let list = app.collectionViews.firstMatch
        list.swipeDown()
        
        // Verify refresh by checking if progress indicator appears
        let progressIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(progressIndicator.exists)
    }
    
    func testPaginationLoadsMoreUsers() throws {
        let lastCell = app.cells.element(boundBy: app.cells.count - 1)
        XCTAssertTrue(lastCell.waitForExistence(timeout: 5))
        
        lastCell.swipeUp()
        
        // Check if new users are loaded (list count increases)
        let newLastCell = app.cells.element(boundBy: app.cells.count - 1)
        XCTAssertTrue(newLastCell.waitForExistence(timeout: 5))
    }
}
