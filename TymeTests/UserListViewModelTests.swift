//
//  UserListViewModelTests.swift
//  TymeTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
@testable import Tyme



struct UserListViewModelTests {
    // Helper function to create test users
    func createTestUser(id: Int, login: String) -> User {
        return User(id: id, login: login, avatarUrl: "https://avatar\(id).com", htmlUrl: "https://user\(id).com")
    }
    
    // Test 1: Initial load
    @Test("Initial load populates users")
    func testInitialLoad() async throws {
        let mockRepo = MockUserRepository()
        let testUsers = [
            createTestUser(id: 1, login: "user1"),
            createTestUser(id: 2, login: "user2")
        ]
        mockRepo.usersToReturn = testUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.users.count == testUsers.count)
        #expect(viewModel.users.map { $0.id } == testUsers.map { $0.id })
        #expect(viewModel.isLoading == false)
        #expect(viewModel.users.last?.id == 2)
    }
    
    // Test 2: Load more users
    @Test("Load more users appends to existing users")
    func testLoadMoreUsers() async throws {
        let mockRepo = MockUserRepository()
        let initialUsers = [createTestUser(id: 1, login: "user1")]
        let moreUsers = [createTestUser(id: 2, login: "user2")]
        mockRepo.usersToReturn = initialUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        mockRepo.usersToReturn = moreUsers
        viewModel.loadMoreUsers()
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.users.count == 2)
        #expect(viewModel.users.map { $0.id } == [1, 2])
    }
    
    // Test 3: Should load more data
    @Test("Should load more data returns correct values")
    func testShouldLoadMoreData() async throws {
        let mockRepo = MockUserRepository()
        let testUsers = (1...5).map { createTestUser(id: $0, login: "user\($0)") }
        mockRepo.usersToReturn = testUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.shouldLoadMoreData(currentItem: testUsers[1]) == false)
        #expect(viewModel.shouldLoadMoreData(currentItem: testUsers[3]) == true)
        #expect(viewModel.shouldLoadMoreData(currentItem: createTestUser(id: 999, login: "notInList")) == false)
    }
    
    // Test 4: Refresh data
    @Test("Refresh resets and reloads data")
    func testRefreshData() async throws {
        let mockRepo = MockUserRepository()
        let initialUsers = [createTestUser(id: 1, login: "user1")]
        let newUsers = [createTestUser(id: 2, login: "user2")]
        mockRepo.usersToReturn = initialUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        mockRepo.usersToReturn = newUsers
        viewModel.refreshData()
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.users.map { $0.id } == [2])
        #expect(viewModel.users.count == 1)
    }
    
    // Test 5: Error handling for user list
    @Test("Handles loading error gracefully")
    func testListErrorHandling() async throws {
        let mockRepo = MockUserRepository()
        mockRepo.shouldThrowError = true
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.users.isEmpty)
        #expect(viewModel.isLoading == false)
    }
    
    // Test 6: No loading when already loading
    @Test("Doesn't load more when already loading")
    func testNoDuplicateLoading() async throws {
        let mockRepo = MockUserRepository()
        let testUsers = [createTestUser(id: 1, login: "user1")]
        mockRepo.usersToReturn = testUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        viewModel.isLoading = true
        viewModel.loadMoreUsers()
        
        #expect(viewModel.users.isEmpty)
    }
}
