//
//  UserAPIServiceProtocol.swift
//  Tyme
//
//  Created by Vinh Tong on 2/3/25.
//

import Foundation


protocol UserAPIServiceProtocol {
    func fetchUsers(perPage: Int, since: Int) async throws -> [User]
    func fetchUserDetail(username: String) async throws -> UserDetails
}
