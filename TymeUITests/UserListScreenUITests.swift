//
//  UserListScreenUITests.swift
//  TymeUITests
//
//  Created by Vinh Tong on 3/3/25.
//


import XCTest
import SwiftUI
@testable import Tyme


final class UserListScreenUITests: XCTestCase {
    
    
    // MARK: - Setup
    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        // Ensure UI tests run on main thread
        DispatchQueue.main.async {
            UIView.setAnimationsEnabled(false)
        }
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testInitialViewComponents() throws {
        // Arrange
        let repository = MockUserRepository()
        let viewModel = UserListViewModel(repository: repository)
        let sut = UIHostingController(rootView: UserListScreen(viewModel: viewModel))
        
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(sut.navigationItem.title, "Github Users")
        XCTAssertTrue(sut.view.backgroundColor == .white)
        // Verify initial loading state
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testUserListRendering() throws {
        // Arrange
        let repository = MockUserRepository()
        let mockUsers = [
            Mock.User(id: 1, login: "testuser1"),
            Mock.User(id: 2, login: "testuser2"),
        ]
        repository.usersToReturn = mockUsers
        let viewModel = UserListViewModel(repository: repository)
        let sut = UIHostingController(rootView: UserListScreen(viewModel: viewModel))
        
        // Act
        sut.loadViewIfNeeded()
        let expectation = XCTestExpectation(description: "Initial users loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        // Assert
        let tableView = try XCTUnwrap(sut.view.subviews.first { $0 is UITableView } as? UITableView)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
        // Verify navigation setup (can't test destination directly without ViewInspector)
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
//    func testLoadingIndicator() throws {
//        // Arrange
//        let repository = MockUserRepository()
//        let viewModel = UserListViewModel(repository: repository)
//        let sut = UIHostingController(rootView: UserListScreen(viewModel: viewModel))
//        
//        // Act
//        sut.loadViewIfNeeded()
//        
//        // Assert
//        XCTAssertTrue(viewModel.isLoading)
//        let tableView = try XCTUnwrap(sut.view.subviews.first { $0 is UITableView } as? UITableView)
//        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
//        XCTAssertTrue(cell?.subviews.contains { $0 is UIActivityIndicatorView } ?? false)
//    }
//    
//    func testRefreshData() throws {
//        // Arrange
//        let repository = MockUserRepository()
//        let initialUsers = [User(login: "initial", id: 1, avatarUrl: "")]
//        repository.mockUsers = initialUsers
//        let viewModel = UserListViewModel(repository: repository)
//        let sut = UIHostingController(rootView: UserListScreen(viewModel: viewModel))
//        
//        // Wait for initial load
//        sut.loadViewIfNeeded()
//        let loadExpectation = XCTestExpectation(description: "Initial load")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            loadExpectation.fulfill()
//        }
//        wait(for: [loadExpectation], timeout: 1.0)
//        
//        // Act
//        let refreshExpectation = XCTestExpectation(description: "Refresh completed")
//        repository.mockUsers = [User(login: "newuser", id: 2, avatarUrl: "")]
//        
//        // Simulate pull-to-refresh
//        viewModel.refreshData()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            refreshExpectation.fulfill()
//        }
//        
//        // Assert
//        wait(for: [refreshExpectation], timeout: 1.0)
//        XCTAssertEqual(viewModel.users.count, 1)
//        XCTAssertEqual(viewModel.users.first?.login, "newuser")
//        XCTAssertEqual(viewModel.since, 0)
//        XCTAssertTrue(viewModel.canLoadMore)
//        
//        let tableView = try XCTUnwrap(sut.view.subviews.first { $0 is UITableView } as? UITableView)
//        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
//    }
//    
//    func testLoadMoreUsersTrigger() throws {
//        // Arrange
//        let repository = MockUserRepository()
//        let mockUsers = (1...20).map { User(login: "user\($0)", id: $0, avatarUrl: "") }
//        repository.mockUsers = mockUsers
//        let viewModel = UserListViewModel(repository: repository)
//        let sut = UIHostingController(rootView: UserListScreen(viewModel: viewModel))
//        
//        // Wait for initial load
//        sut.loadViewIfNeeded()
//        let loadExpectation = XCTestExpectation(description: "Initial load")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            loadExpectation.fulfill()
//        }
//        wait(for: [loadExpectation], timeout: 1.0)
//        
//        // Act
//        let moreUsersExpectation = XCTestExpectation(description: "Load more triggered")
//        repository.mockUsers = [User(login: "user21", id: 21, avatarUrl: "")]
//        
//        // Simulate scrolling to trigger load more
//        let tableView = try XCTUnwrap(sut.view.subviews.first { $0 is UITableView } as? UITableView)
//        tableView.delegate?.tableView?(tableView, willDisplay: UITableViewCell(),
//                                       forRowAt: IndexPath(row: 17, section: 0))
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            moreUsersExpectation.fulfill()
//        }
//        
//        // Assert
//        wait(for: [moreUsersExpectation], timeout: 1.0)
//        XCTAssertEqual(viewModel.users.count, 21)
//        XCTAssertEqual(viewModel.since, 21)
//        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 21)
//    }
}
