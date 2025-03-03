//
//  UserAPIService.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation


class UserAPIService: UserAPIServiceProtocol {
    
    private let baseUrlStr: String
    private let urlSession: URLSession
    
    init(baseUrlStr: String = "\(Config.baseUrl)/users", urlSession: URLSession = .shared) {
        self.baseUrlStr = baseUrlStr
        self.urlSession = urlSession
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let urlString = String(format: "%@?per_page=%d&since=%d", baseUrlStr, perPage, since)
        guard let url = URL(string: urlString), url.scheme != nil else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> UserDetails {
        let urlString = String(format: "%@/%@", baseUrlStr, username)
        guard let url = URL(string: urlString), url.scheme != nil else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        return try JSONDecoder().decode(UserDetails.self, from: data)
    }
}
