//
//  UserViewModel.swift
//  GitUser
//
//  Created by Vinh Tong on 28/2/25.
//

import Foundation

final class UserViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    /// Loads user details from the repository asynchronously.
        /// - Parameter username: The GitHub username to fetch details for.
    func loadUserDetails(username: String) {
        guard !isLoading else { return } // Prevent duplicate requests
        
        isLoading = true
        Task {
            let result = await fetchUserDetails(username: username)
            await MainActor.run { self.handleFetchResult(result) }
        }
    }
    
    /// Fetches user details asynchronously from the repository.
        /// - Parameter username: The GitHub username to fetch details for.
        /// - Returns: A `Result` containing either the `UserDetails` object or an `Error`.
        private func fetchUserDetails(username: String) async -> Result<UserDetails, Error> {
            do {
                let userDetails = try await repository.getUserDetails(username: username)
                return .success(userDetails)
            } catch {
                return .failure(error)
            }
        }
        
        /// Handles the result of the user details fetch operation.
        /// - Parameter result: The result containing either user details or an error.
        private func handleFetchResult(_ result: Result<UserDetails, Error>) {
            isLoading = false
            
            switch result {
            case .success(let userDetails):
                self.userDetails = userDetails
            case .failure:
                self.errorMessage = UserError(.notFound).description
            }
        }
}
