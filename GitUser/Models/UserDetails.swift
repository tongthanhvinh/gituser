//
//  UserDetails.swift
//  GitUser
//
//  Created by Vinh Tong on 28/2/25.
//

import SwiftData


@Model
final class UserDetails: Identifiable, Codable {
    
    @Attribute(.unique) var id: Int
    var login: String
    var avatarUrl: String?
    var htmlUrl: String?
    var location: String?
    var followers: Int
    var following: Int

    init(
        id: Int,
        login: String,
        avatarUrl: String?,
        htmlUrl: String?,
        location: String?,
        followers: Int,
        following: Int
    ) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.location = location
        self.followers = followers
        self.following = following
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case location
        case followers
        case following
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(location, forKey: .location)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
    }
}
