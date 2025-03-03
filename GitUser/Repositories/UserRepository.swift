//
//  UserRepository.swift
//  GitUser
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let apiService: UserAPIServiceProtocol
    private let storage: UserStorageProtocol
    
    init(
        apiService: UserAPIServiceProtocol = UserAPIService(),
        storage: UserStorageProtocol = UserStorage.shared
    ) {
        self.apiService = apiService
        self.storage = storage
    }

    func getUsers(perPage: Int, since: Int) async throws -> [any UserProtocol] {
        let cachedUsers = try await storage.loadUsers(perPage: perPage, since: since)
        if !cachedUsers.isEmpty {
            return cachedUsers
        }
        let users = try await apiService.fetchUsers(perPage: perPage, since: since)
        try await storage.saveUsers(users)
        return users
    }
    
    func getUserDetails(username: String) async throws -> any UserDetailsProtocol {
        return try await apiService.fetchUserDetail(username: username)
    }
    
    func deleteAllUsers() async throws {
        try await storage.deleteAllUsers()
    }
}
