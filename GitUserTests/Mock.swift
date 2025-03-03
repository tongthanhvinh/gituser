//
//  Mock.swift
//  GitUserTests
//
//  Created by Vinh Tong on 2/3/25.
//

import Foundation
@testable import GitUser


enum Mock {
    static func user(id: Int, login: String? = nil, date: Date? = nil) -> User {
        return User(
            id: id,
            login: login ?? "user\(id)",
            avatarUrl: "https://avatar\(id).com",
            htmlUrl: "https://user\(id).com",
            date: date
        )
    }
    
    static func userDetails(
        id: Int,
        login: String? = nil,
        avatarUrl: String? = nil,
        htmlUrl: String? = nil,
        location: String? = "Test Location",
        followers: Int = 10,
        following: Int = 5
    ) -> UserDetails {
        return UserDetails(
            id: id,
            login: login ?? "user\(id)",
            avatarUrl: avatarUrl ?? "https://avatar\(id).com",
            htmlUrl: htmlUrl ?? "https://user\(id).com",
            location: location,
            followers: followers,
            following: following
        )
    }
}
