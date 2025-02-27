//
//  User.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import Foundation
import SwiftData

struct UserDTO: Identifiable, Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String

    func toUser() -> User {
        return User(id: id, login: login, avatar_url: avatar_url, html_url: html_url)
    }
}

@Model
final class User {
    @Attribute(.unique) var id: Int
    var login: String
    var avatar_url: String
    var html_url: String

    init(id: Int, login: String, avatar_url: String, html_url: String) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
        self.html_url = html_url
    }
}
