//
//  UserViewModel.swift
//  GitUser
//
//  Created by Vinh Tong on 28/2/25.
//

import Foundation

final class UserViewModel: ObservableObject {
    
    @Published var userDetails: (any UserDetailsProtocol)?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func loadUserDetails(username: String) {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let userDetails = try await repository.getUserDetails(username: username)
                await MainActor.run {
                    self.isLoading = false
                    self.userDetails = userDetails
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = UserError(.notFound).description
                }
            }
        }
    }
}
