//
//  UserListViewModelTests.swift
//  GitUserTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
@testable import GitUser



struct UserListViewModelTests {
    // Test 1: Initial load
    @Test("Initial load populates users")
    func testInitialLoad() async throws {
        let mockRepo = MockUserRepository()
        let testUsers = [
            GitUser.User(id: 1, login: "user1", avatarUrl: nil, htmlUrl: nil),
            GitUser.User(id: 2, login: "user2", avatarUrl: nil, htmlUrl: nil)
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
        let initialUsers = [Mock.user(id: 1, login: "user1")]
        let moreUsers = [Mock.user(id: 2, login: "user2")]
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
        let testUsers = (1...5).map { Mock.user(id: $0, login: "user\($0)") }
        mockRepo.usersToReturn = testUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.shouldLoadMoreData(currentItem: testUsers[1]) == false)
        #expect(viewModel.shouldLoadMoreData(currentItem: testUsers[3]) == true)
        #expect(viewModel.shouldLoadMoreData(currentItem: Mock.user(id: 999, login: "notInList")) == false)
    }
    
    // Test 4: Refresh data
    @Test("Refresh resets and reloads data")
    func testRefreshData() async throws {
        let mockRepo = MockUserRepository()
        let initialUsers = [Mock.user(id: 1, login: "user1")]
        let newUsers = [Mock.user(id: 2, login: "user2")]
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
        let testUsers = [Mock.user(id: 1, login: "user1")]
        mockRepo.usersToReturn = testUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        viewModel.isLoading = true
        viewModel.loadMoreUsers()
        
        #expect(viewModel.users.isEmpty)
    }
    
    // Test 7: Refresh data fail
    @Test("Refresh data fail")
    func testRefreshDataFail() async throws {
        let mockRepo = MockUserRepository()
        let initialUsers = [Mock.user(id: 1, login: "user1")]
        let newUsers = [Mock.user(id: 2, login: "user2")]
        mockRepo.usersToReturn = initialUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        mockRepo.usersToReturn = newUsers
        mockRepo.shouldThrowError = true
        viewModel.refreshData()
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.users.map { $0.id } == [1])
        #expect(viewModel.users.count == 1)
    }
    
    // Test 7: Load more data returns empty
    @Test("Load more data returns empty")
    func testLoadMoreEmpty() async throws {
        let mockRepo = MockUserRepository()
        let initialUsers = [Mock.user(id: 1, login: "user1")]
        mockRepo.usersToReturn = initialUsers
        
        let viewModel = UserListViewModel(repository: mockRepo)
        try await Task.sleep(for: .seconds(1))
        
        mockRepo.usersToReturn = []
        viewModel.loadMoreUsers()
        try await Task.sleep(for: .seconds(1))
        #expect(viewModel.shouldLoadMoreData(currentItem: initialUsers.first!) == false)
        #expect(viewModel.users.map { $0.id } == [1])
        #expect(viewModel.users.count == 1)
    }
}
