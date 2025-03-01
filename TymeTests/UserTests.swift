//
//  UserTests.swift
//  TymeTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
import Foundation
@testable import Tyme

struct UserTests {

    @Test("User encodes and decodes correctly")
    func testUserCodable() throws {
        let user = User(id: 1, login: "testuser", avatarUrl: "https://avatar.com", htmlUrl: "https://user.com")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(user)
        let decodedUser = try decoder.decode(User.self, from: data)
        
        #expect(decodedUser.id == user.id)
        #expect(decodedUser.login == user.login)
        #expect(decodedUser.avatarUrl == user.avatarUrl)
        #expect(decodedUser.htmlUrl == user.htmlUrl)
    }
    
    @Test("User decodes with optional fields")
    func testUserOptionalFields() throws {
        let json = """
        {
            "id": 1,
            "login": "testuser"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: json)
        
        #expect(user.id == 1)
        #expect(user.login == "testuser")
        #expect(user.avatarUrl == nil)
        #expect(user.htmlUrl == nil)
    }

}
