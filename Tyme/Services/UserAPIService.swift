//
//  UserAPIService.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation


final class UserAPIService {
    
    static let shared = UserAPIService()
    
    private let baseUrlStr = "\(Config.baseUrl)/users"
    
    private init() {}
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let urlString = String(format: "%@?per_page=%d&since=%d", baseUrlStr, perPage, since)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> UserDetails {
        let urlString = String(format: "%@/%@", baseUrlStr, username)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(UserDetails.self, from: data)
    }
}
