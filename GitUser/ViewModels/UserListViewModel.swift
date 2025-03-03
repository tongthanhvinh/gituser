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
    @Published var errorMessage: String?
    
    private let perPage = 20
    private var since = 0 // Tracks the last fetched user ID for pagination
    private var canLoadMore = true
    private let loadThreshold = 3 // Defines how close the user should be to the end of the list before triggering pagination
    
    private let repository: UserRepositoryProtocol // Data repository handling user fetching and storage
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
        loadMoreUsers()
    }
    
    /// Loads more users from the repository if possible.
    func loadMoreUsers() {
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        Task {
            let result = await fetchUsers()
            await MainActor.run { self.handleFetchResult(result) }
        }
    }
    
    /// Fetches users asynchronously from the repository.
    /// - Returns: A `Result` containing either an array of `User` or an `Error`.
    private func fetchUsers() async -> Result<[User], Error> {
        do {
            let newUsers = try await repository.getUsers(perPage: perPage, since: since)
            return .success(newUsers)
        } catch {
            return .failure(error)
        }
    }
    
    /// Handles the result of the fetch operation.
    /// - Parameter result: The result containing either new users or an error.
    private func handleFetchResult(_ result: Result<[User], Error>) {
        isLoading = false
        
        switch result {
        case .success(let newUsers):
            users.append(contentsOf: newUsers)
            canLoadMore = !newUsers.isEmpty
            since = newUsers.last?.id ?? since
            
        case .failure(let error):
            errorMessage = "Error fetching users: \(error.localizedDescription)"
        }
    }
    
    /// Determines whether more data should be loaded based on the user's scroll position.
    /// - Parameter currentItem: The last visible user in the list.
    /// - Returns: `true` if more data should be loaded; otherwise, `false`.
    func shouldLoadMoreData(currentItem: User) -> Bool {
        guard let index = users.firstIndex(of: currentItem) else { return false }
        return index >= users.count - loadThreshold && canLoadMore && !isLoading
    }
    
    /// Refreshes the user list by clearing stored data and fetching fresh data.
    func refreshData() {
        Task {
            let result = await clearAndReloadUsers()
            await MainActor.run { self.handleRefreshResult(result) }
        }
    }
    
    /// Deletes all stored users and resets pagination.
    /// - Returns: A `Result` indicating success or failure.
    private func clearAndReloadUsers() async -> Result<Void, Error> {
        do {
            try await repository.deleteAllUsers()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    /// Handles the result of the refresh operation.
    /// - Parameter result: The result containing either success or an error.
    private func handleRefreshResult(_ result: Result<Void, Error>) {
        switch result {
        case .success:
            since = 0
            canLoadMore = true
            users.removeAll()
            loadMoreUsers()
            
        case .failure(let error):
            errorMessage = "Error refreshing users: \(error.localizedDescription)"
        }
    }
}
