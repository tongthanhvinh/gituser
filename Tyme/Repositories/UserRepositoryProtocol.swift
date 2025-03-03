//
//  UserRepositoryProtocol.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation


protocol UserRepositoryProtocol {
    func getUsers(perPage: Int, since: Int) async throws -> [any UserProtocol]
    func getUserDetails(username: String) async throws -> any UserDetailsProtocol
    func deleteAllUsers() async throws
}
