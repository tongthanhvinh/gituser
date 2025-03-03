//
//  UserListViewModel.swift
//  GitUser
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUICore
import SwiftData

final class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    private let perPage = 20
    private var since = 0
    private var canLoadMore = true
    private let loadThreshold = 3
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
        loadMoreUsers()
    }
    
    func loadMoreUsers() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        Task {
            do {
                let newUsers = try await repository.getUsers(perPage: perPage, since: since)
                await MainActor.run {
                    isLoading = false
                    users.append(contentsOf: newUsers)
                    if newUsers.isEmpty {
                        canLoadMore = false
                    } else {
                        since = newUsers.last?.id ?? since
                    }
                }
            } catch {
                print("Error fetching users: \(error)")
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    func shouldLoadMoreData(currentItem: User) -> Bool {
        guard let index = users.firstIndex(of: currentItem) else { return false }
        return index >= users.count - loadThreshold && canLoadMore && !isLoading
    }
    
    func refreshData() {
        Task {
            do {
                try await repository.deleteAllUsers()
                await MainActor.run {
                    since = 0
                    canLoadMore = true
                    users = []
                    loadMoreUsers()
                }
            } catch {
                print("Error refresh users: \(error)")
            }
        }
    }
}
