//
//  UserViewModel.swift
//  Tyme
//
//  Created by Vinh Tong on 28/2/25.
//

import Foundation

final class UserViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails?
    @Published var isLoading = false
    
    private let login: String
    
    init(login: String) {
        self.login = login
        self.loadUserDetails()
    }
    
    deinit {
        print("deinit UserViewModel")
    }
    
    private let urlTemplate = "http://127.0.0.1:5000/users/%@"
//    private let urlTemplate = "https://api.github.com/users/%@"
    
    private func fetchUser() async throws -> UserDetails {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        let urlString = String(format: urlTemplate, login)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let newUserDTO = try JSONDecoder().decode(UserDetailsDTO.self, from: data)
        return newUserDTO.toUser()
    }
    
    func loadUserDetails() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let userDetails = try? await fetchUser()
            await MainActor.run {
                self.isLoading = false
                self.userDetails = userDetails
            }
        }
    }
}
