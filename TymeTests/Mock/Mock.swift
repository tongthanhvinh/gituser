//
//  Mock.swift
//  TymeTests
//
//  Created by Vinh Tong on 2/3/25.
//

@testable import Tyme

enum Mock {
    static func User(id: Int, login: String) -> User {
        return Tyme.User(
            id: id,
            login: login,
            avatarUrl: "https://avatar\(id).com",
            htmlUrl: "https://user\(id).com"
        )
    }
    
    static func UserDetails(
        id: Int,
        login: String,
        location: String? = "Test Location",
        followers: Int = 10,
        following: Int = 5
    ) -> UserDetails {
        return Tyme.UserDetails(
            id: id,
            login: login,
            avatarUrl: "https://avatar\(id).com",
            htmlUrl: "https://user\(id).com",
            location: location,
            followers: followers,
            following: following
        )
    }
}
