//
//  UserListScreenUITests.swift
//  GitUserUITests
//
//  Created by Vinh Tong on 3/3/25.
//


import XCTest
import SwiftUI
//@testable import GitUser


final class UserListScreenUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        // Ensure we start fresh each time
        XCUIDevice.shared.orientation = .portrait
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testUserListScreenBasicElements() throws {
        // Given: The app is launched
        // When: UserListScreen is displayed (assuming it's the initial screen)
        // Then: Verify basic UI elements are present
        
        // Check navigation title
        let navTitle = app.staticTexts["Github Users"]
        XCTAssertTrue(navTitle.exists, "Navigation title 'Github Users' should be visible")
        
        // Check list exists
        let list = app.collectionViews.cells.firstMatch
        XCTAssertTrue(list.exists, "User list should be visible")
    }
    
    
    func testUserListNavigationToDetails() throws {
        // Given: The app is launched and users are loaded
        // Wait for initial data to load
        let firstUserCell = app.collectionViews.cells.images.firstMatch
        XCTAssertTrue(firstUserCell.waitForExistence(timeout: 5.0),
                     "At least one user cell should appear")
        
        // When: User taps on a user cell
        firstUserCell.tap()
        
        // Then: Verify navigation to UserDetailsScreen occurred
        // Note: You'll need to add identifiable elements in UserDetailsScreen
        let detailsScreenElement = app.staticTexts["User Details"] // Adjust based on your UserDetailsScreen
        XCTAssertTrue(detailsScreenElement.waitForExistence(timeout: 2.0),
                     "Should navigate to user details screen")
    }
    
    func testInfiniteScrollLoading() throws {
        // Given: The app is launched with initial users loaded
        let table = app.collectionViews.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5.0), "User list should load")
        
        // When: User scrolls to bottom
        let initialCellCount = table.cells.count
        table.swipeUp(velocity: .slow) // Scroll down
        
        // Then: More users should load
        let predicate = NSPredicate(format: "count > %d", initialCellCount)
        let expectation = expectation(for: predicate, evaluatedWith: table.cells)
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertGreaterThan(table.cells.count, initialCellCount,
                           "More users should load after scrolling")
    }
}


extension XCUIElement {
    func waitForExistence(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    func waitForNonExistence(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
