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
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true

        let urlString = "https://api.github.com/users?per_page=\(perPage)&since=\(since)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            do {
                let newUsersDTO = try JSONDecoder().decode([UserDTO].self, from: data)
                let newUsers = newUsersDTO.map { $0.toUser() }
                DispatchQueue.main.async {
//                    self.saveUsersToDatabase(users: newUsers)
                    self.users = newUsers
                    self.since = newUsers.last?.id ?? self.since
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
}
