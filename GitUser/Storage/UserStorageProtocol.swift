//
//  UserStorageProtocol.swift
//  GitUser
//
//  Created by Vinh Tong on 2/3/25.
//

import Foundation


protocol UserStorageProtocol {
    @MainActor func saveUsers(_ users: [User]) async throws
    @MainActor func loadUsers(perPage: Int, since: Int) async throws -> [User]
    @MainActor func deleteAllUsers() async throws
}
