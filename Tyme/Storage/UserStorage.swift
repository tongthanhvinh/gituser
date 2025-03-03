//
//  UserStorage.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import SwiftData
import Foundation


class UserStorage: UserStorageProtocol {
    
    static let shared = UserStorage()
    
    @MainActor
    private let container: ModelContainer
    
    private init() {
        let schema = Schema([User.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            self.container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    @MainActor
    func saveUsers(_ users: [User]) async throws {
        users.forEach { container.mainContext.insert($0) }
        try container.mainContext.save()
    }
    
    @MainActor
    func loadUsers(perPage: Int, since: Int) async throws -> [User] {
        var descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id > since },
            sortBy: [SortDescriptor(\.timestamp)]
        )
        descriptor.fetchLimit = perPage
        
        let cachedUsers = try container.mainContext.fetch(descriptor)
        
        if !cachedUsers.isEmpty {
            return cachedUsers
        }
        return []
    }
    
    @MainActor
    func deleteAllUsers() async throws {
        let fetchDescriptor = FetchDescriptor<User>()
        let allItems = try container.mainContext.fetch(fetchDescriptor)
        for item in allItems {
            container.mainContext.delete(item)
        }
        try container.mainContext.save()
    }
}
