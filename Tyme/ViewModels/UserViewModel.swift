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
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    deinit {
        print("deinit UserViewModel")
    }
    
    func loadUserDetails(username: String) {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let userDetails = try? await repository.getUserDetails(username: username)
            await MainActor.run {
                self.isLoading = false
                self.userDetails = userDetails
            }
        }
    }
}
