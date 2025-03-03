//
//  UserStorageProtocol.swift
//  Tyme
//
//  Created by Vinh Tong on 2/3/25.
//

import Foundation


protocol UserStorageProtocol {
    @MainActor func saveUsers(_ users: [any UserProtocol]) async throws
    @MainActor func loadUsers(perPage: Int, since: Int) async throws -> [any UserProtocol]
    @MainActor func deleteAllUsers() async throws
}
