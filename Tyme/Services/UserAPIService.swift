//
//  UserAPIService.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation


final class UserAPIService {
    
    static let shared = UserAPIService()
    
    private let baseUrlString = "http://127.0.0.1:5000/users"
//    private let baseUrlString = "https://api.github.com/users"
    
    private init() {}
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let urlString = String(format: "%@?per_page=%d&since=%d", baseUrlString, perPage, since)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> UserDetails {
        let urlString = String(format: "%@/%@", baseUrlString, username)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(UserDetails.self, from: data)
    }
}
