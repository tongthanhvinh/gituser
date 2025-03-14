//
//  MockUserAPIService.swift
//  GitUserTests
//
//  Created by Vinh Tong on 2/3/25.
//

@testable import GitUser

class MockUserAPIService: UserAPIServiceProtocol {
    
    var usersToReturn: [User]
    var userDetailsToReturn: UserDetails?
    var shouldThrowError: Bool
    
    init(usersToReturn: [User] = [], userDetailsToReturn: UserDetails? = nil, shouldThrowError: Bool = false) {
        self.usersToReturn = usersToReturn
        self.userDetailsToReturn = userDetailsToReturn
        self.shouldThrowError = shouldThrowError
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        if shouldThrowError {
            throw TestError.apiError
        }
        return usersToReturn
    }
    
    func fetchUserDetail(username: String) async throws -> UserDetails {
        if shouldThrowError {
            throw TestError.apiError
        }
        guard let details = userDetailsToReturn else {
            throw TestError.noDetails
        }
        return details
    }
}
