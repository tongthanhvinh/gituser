//
//  StorageTests.swift
//  GitUserTests
//
//  Created by Vinh Tong on 3/3/25.
//

import Testing
import SwiftData
import Foundation
@testable import GitUser

struct StorageTests {
    
    // Helper function to create a test container
    private func createTestContainer() -> ModelContainer {
        let schema = Schema([User.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try! ModelContainer(for: schema, configurations: [config])
    }
    
    @MainActor
    @Test("Save Users Successfully")
    func testSaveUsers() async throws {
        // Arrange
        let container = createTestContainer()
        let storage = UserStorage(container: container) // We'll need to modify init for testing
        let testUsers = [
            Mock.user(id: 1),
            Mock.user(id: 2),
        ]
        
        // Act
        try await storage.saveUsers(testUsers)
        
        // Assert
        let savedUsers = try await storage.loadUsers(perPage: 2, since: 0)
        #expect(savedUsers.count == 2)
        #expect(savedUsers[0].id == 1)
        #expect(savedUsers[1].id == 2)
    }
    
    @Test("Load Users with Pagination")
    func testLoadUsers() async throws {
        // Arrange
        let container = createTestContainer()
        let storage = UserStorage(container: container)
        let dates = [
            Date(timeIntervalSinceNow: -100),
            Date(timeIntervalSinceNow: -50),
            Date()
        ]
        let testUsers = [
            Mock.user(id: 1, date: dates[0]),
            Mock.user(id: 2, date: dates[1]),
            Mock.user(id: 3, date: dates[2])
        ]
        try await storage.saveUsers(testUsers)
        
        // Act
        let loadedUsers = try await storage.loadUsers(perPage: 2, since: 1)
        
        // Assert
        #expect(loadedUsers.count == 2)
        #expect(loadedUsers[0].id == 2)
        #expect(loadedUsers[1].id == 3)
        #expect(loadedUsers[0].timestamp < loadedUsers[1].timestamp) // Verify sorting
    }
    
    @Test("Load Empty When No Matching Users")
    func testLoadUsersEmpty() async throws {
        // Arrange
        let container = createTestContainer()
        let storage = UserStorage(container: container)
        
        // Act
        let loadedUsers = try await storage.loadUsers(perPage: 10, since: 0)
        
        // Assert
        #expect(loadedUsers.isEmpty)
    }
    
    @MainActor
    @Test("Delete All Users")
    func testDeleteAllUsers() async throws {
        // Arrange
        let container = createTestContainer()
        let storage = UserStorage(container: container)
        let testUsers = [
            Mock.user(id: 1),
            Mock.user(id: 2)
        ]
        try await storage.saveUsers(testUsers)
        
        // Act
        try await storage.deleteAllUsers()
        
        // Assert
        let fetchDescriptor = FetchDescriptor<User>()
        let remainingUsers = try container.mainContext.fetch(fetchDescriptor)
        #expect(remainingUsers.isEmpty)
    }
}
