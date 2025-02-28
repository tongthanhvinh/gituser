//
//  UserListViewModel.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import Foundation

final class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    private var since = 0
    private let perPage = 20
    private var canLoadMore = true
//    private let urlTemplate = "https://api.github.com/users?per_page=%d&since=%d"
    private let urlTemplate = "http://127.0.0.1:5000/users?per_page=%d&since=%d"
    
    init() {
        loadData()
    }
    
    private func fetchUsers() async throws -> [User] {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        let urlString = String(format: urlTemplate, perPage, since)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let newUsersDTO = try JSONDecoder().decode([UserDTO].self, from: data)
        return newUsersDTO.map { $0.toUser() }
    }
    
    func loadData() {
        guard !isLoading && canLoadMore else { return }
        isLoading = true
        
        Task {
            do {
                let newUsers = try await fetchUsers()
                await MainActor.run {
                    self.users.append(contentsOf: newUsers)
                    self.isLoading = false
                    if newUsers.isEmpty {
                        self.canLoadMore = false
                    } else {
                        self.since = newUsers.last?.id ?? self.since
                    }
                }
            } catch {
                print("Error fetching items: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
    
}
