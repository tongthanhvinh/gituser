//
//  UserRepository.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let apiService: UserAPIService
    private let storage: UserStorage
    
    init(apiService: UserAPIService = .shared, storage: UserStorage = .shared) {
        self.apiService = apiService
        self.storage = storage
    }

    func getUsers(perPage: Int, since: Int) async throws -> [User] {
        let cachedUsers = try await storage.loadUsers(perPage: perPage, since: since)
        if !cachedUsers.isEmpty {
            return cachedUsers
        }
        let users = try await apiService.fetchUsers(perPage: perPage, since: since)
        try await storage.saveUsers(users)
        return users
    }
    
    func getUserDetails(username: String) async throws -> UserDetails {
        return try await apiService.fetchUserDetail(username: username)
    }
}
