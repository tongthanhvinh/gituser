//
//  UserRepositoryTests.swift
//  TymeTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
@testable import Tyme


struct UserRepositoryTests {

    // Test 1: Get users from cache when available
    @Test("Returns cached users when available")
    func testGetUsersFromCache() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        let cachedUsers = [
            Mock.User(id: 1, login: "user1"),
            Mock.User(id: 2, login: "user2")
        ]
        mockStorage.cachedUsers = cachedUsers
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        let users = try await repository.getUsers(perPage: 10, since: 0)
        
        #expect(users.count == 2)
        #expect(users.map { $0.id } == [1, 2])
        // API service shouldn't be called since cache is used
    }
    
    // Test 2: Fetch users from API when cache is empty
    @Test("Fetches from API when cache is empty")
    func testGetUsersFromAPI() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        let apiUsers = [
            Mock.User(id: 3, login: "user3"),
            Mock.User(id: 4, login: "user4")
        ]
        mockAPIService.usersToReturn = apiUsers
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        let users = try await repository.getUsers(perPage: 10, since: 0)
        
        #expect(users.count == 2)
        #expect(users.map { $0.id } == [3, 4])
        #expect(mockStorage.cachedUsers.map { $0.id } == [3, 4], "Users should be cached")
    }
    
    // Test 3: Handle API error
    @Test("Handles API error when fetching users")
    func testGetUsersAPIError() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        mockAPIService.shouldThrowError = true
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        
        await #expect(throws: TestError.apiError) {
            _ = try await repository.getUsers(perPage: 10, since: 0)
        }
    }
    
    // Test 4: Handle storage error when loading cache
    @Test("Handles storage error when loading cache")
    func testGetUsersStorageError() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        mockStorage.shouldThrowError = true
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        
        await #expect(throws: TestError.storageError) {
            _ = try await repository.getUsers(perPage: 10, since: 0)
        }
    }
    
    // Test 5: Get user details
    @Test("Fetches user details successfully")
    func testGetUserDetails() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        let userDetails = Mock.UserDetails(id: 1, login: "testuser")
        mockAPIService.userDetailsToReturn = userDetails
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        let details = try await repository.getUserDetails(username: "testuser")
        
        #expect(details.id == 1)
        #expect(details.login == "testuser")
    }
    
    // Test 6: Handle user details error
    @Test("Handles error when fetching user details")
    func testGetUserDetailsError() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        mockAPIService.shouldThrowError = true
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        
        await #expect(throws: TestError.apiError) {
            _ = try await repository.getUserDetails(username: "testuser")
        }
    }
    
    // Test 7: Delete all users
    @Test("Deletes all users successfully")
    func testDeleteAllUsers() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        let cachedUsers = [Mock.User(id: 1, login: "user1")]
        mockStorage.cachedUsers = cachedUsers
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        try await repository.deleteAllUsers()
        
        #expect(mockStorage.cachedUsers.isEmpty, "All users should be deleted")
    }
    
    // Test 8: Handle delete all users error
    @Test("Handles error when deleting all users")
    func testDeleteAllUsersError() async throws {
        let mockAPIService = MockUserAPIService()
        let mockStorage = MockUserStorage()
        
        mockStorage.shouldThrowError = true
        
        let repository = UserRepository(apiService: mockAPIService, storage: mockStorage)
        
        await #expect(throws: TestError.storageError) {
            try await repository.deleteAllUsers()
        }
    }
}
