//
//  MockUserStorage.swift
//  GitUserTests
//
//  Created by Vinh Tong on 2/3/25.
//

@testable import GitUser


class MockUserStorage: UserStorageProtocol {
    
    var cachedUsers: [User]
    var shouldThrowError: Bool
    
    init(cachedUsers: [User] = [], shouldThrowError: Bool = false) {
        self.cachedUsers = cachedUsers
        self.shouldThrowError = shouldThrowError
    }
    
    func loadUsers(perPage: Int, since: Int) async throws -> [User] {
        if shouldThrowError {
            throw TestError.storageError
        }
        return cachedUsers
    }
    
    func saveUsers(_ users: [User]) async throws {
        if shouldThrowError {
            throw TestError.storageError
        }
        cachedUsers = users
    }
    
    func deleteAllUsers() async throws {
        if shouldThrowError {
            throw TestError.storageError
        }
        cachedUsers.removeAll()
    }
}
