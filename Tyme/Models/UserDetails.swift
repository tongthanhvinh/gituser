//
//  UserDetails.swift
//  Tyme
//
//  Created by Vinh Tong on 28/2/25.
//

import Foundation
import SwiftData

struct UserDetailsDTO: Identifiable, Codable {
    
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
    let location: String
    let followers: Int
    let following: Int

    func toUser() -> UserDetails {
        return UserDetails(
            id: id,
            login: login,
            avatar_url: avatar_url,
            html_url: html_url,
            location: location,
            followers: followers,
            following: following
        )
    }
}

@Model
final class UserDetails {
    
    @Attribute(.unique) var id: Int
    var login: String
    var avatar_url: String
    var html_url: String
    var location: String
    var followers: Int
    var following: Int

    init(
        id: Int,
        login: String,
        avatar_url: String,
        html_url: String,
        location: String,
        followers: Int,
        following: Int
    ) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
        self.html_url = html_url
        self.location = location
        self.followers = followers
        self.following = following
    }
}
