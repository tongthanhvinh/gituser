//
//  User.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftData
import Foundation


@Model
final class User: Identifiable, Codable {
    
    @Attribute(.unique) var id: Int
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var timestamp = Date().timeIntervalSince1970
    
    init(id: Int, login: String, avatarUrl: String, htmlUrl: String) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(htmlUrl, forKey: .htmlUrl)
    }
}
