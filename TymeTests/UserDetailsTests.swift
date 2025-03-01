//
//  UserDetailsTests.swift
//  TymeTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
import Foundation
@testable import Tyme

struct UserDetailsTests {
    
    @Test("UserDetails encodes and decodes correctly")
    func testUserDetailsCodable() throws {
        let details = UserDetails(
            id: 1,
            login: "testuser",
            avatarUrl: "https://avatar.com",
            htmlUrl: "https://user.com",
            location: "Test Location",
            followers: 10,
            following: 5
        )
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(details)
        let decodedDetails = try decoder.decode(UserDetails.self, from: data)
        
        #expect(decodedDetails.id == details.id)
        #expect(decodedDetails.login == details.login)
        #expect(decodedDetails.avatarUrl == details.avatarUrl)
        #expect(decodedDetails.htmlUrl == details.htmlUrl)
        #expect(decodedDetails.location == details.location)
        #expect(decodedDetails.followers == details.followers)
        #expect(decodedDetails.following == details.following)
    }
    
    @Test("UserDetails decodes with optional fields")
    func testUserDetailsOptionalFields() throws {
        let json = """
        {
            "id": 1,
            "login": "testuser",
            "followers": 10,
            "following": 5
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let details = try decoder.decode(UserDetails.self, from: json)
        
        #expect(details.id == 1)
        #expect(details.login == "testuser")
        #expect(details.avatarUrl == nil)
        #expect(details.htmlUrl == nil)
        #expect(details.location == nil)
        #expect(details.followers == 10)
        #expect(details.following == 5)
    }

}
