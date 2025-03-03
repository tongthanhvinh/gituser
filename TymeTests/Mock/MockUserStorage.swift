//
//  MockUserStorage.swift
//  TymeTests
//
//  Created by Vinh Tong on 2/3/25.
//

@testable import Tyme


class MockUserStorage: UserStorageProtocol {
    
    var cachedUsers: [User] = []
    var shouldThrowError = false
    
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
