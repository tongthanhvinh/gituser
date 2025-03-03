//
//  MockUserAPIService.swift
//  TymeTests
//
//  Created by Vinh Tong on 2/3/25.
//

@testable import Tyme


class MockUserAPIService: UserAPIServiceProtocol {
    
    var usersToReturn: [User] = []
    var userDetailsToReturn: UserDetails?
    var shouldThrowError = false
    
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
