//
//  MockUserRepository.swift
//  GitUserTests
//
//  Created by Vinh Tong on 1/3/25.
//

@testable import GitUser


class MockUserRepository: UserRepositoryProtocol {
    
    var usersToReturn: [User]
    var userDetailsToReturn: UserDetails?
    var shouldThrowError: Bool
    
    init(usersToReturn: [User] = [], userDetailsToReturn: UserDetails? = nil, shouldThrowError: Bool = false) {
        self.usersToReturn = usersToReturn
        self.userDetailsToReturn = userDetailsToReturn
        self.shouldThrowError = shouldThrowError
    }
    
    func getUsers(perPage: Int, since: Int) async throws -> [User] {
        if shouldThrowError {
            throw TestError.mockError
        }
        return usersToReturn
    }
    
    func getUserDetails(username: String) async throws -> UserDetails {
        if shouldThrowError {
            throw TestError.mockError
        }
        guard let details = userDetailsToReturn else {
            throw TestError.noDetails
        }
        return details
    }
    
    func deleteAllUsers() async throws {
        if shouldThrowError {
            throw TestError.mockError
        }
    }
}
