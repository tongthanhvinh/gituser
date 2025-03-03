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
    
    // Test 1: Basic Initializer
    @Test("User init with all parameters")
    func testBasicInit() throws {
        let id = 1
        let login = "testuser"
        let avatarUrl = "https://avatar.com"
        let htmlUrl = "https://user.com"
        
        let user = User(id: id, login: login, avatarUrl: avatarUrl, htmlUrl: htmlUrl)
        
        #expect(user.id == id)
        #expect(user.login == login)
        #expect(user.avatarUrl == avatarUrl)
        #expect(user.htmlUrl == htmlUrl)
        #expect(user.timestamp > 0) // Timestamp should be set to current time
    }
    
    // Test 2: Initializer with nil optional parameters
    @Test("User init with nil optional parameters")
    func testInitWithNilOptionals() throws {
        let id = 2
        let login = "testuser2"
        
        let user = User(id: id, login: login, avatarUrl: nil, htmlUrl: nil)
        
        #expect(user.id == id)
        #expect(user.login == login)
        #expect(user.avatarUrl == nil)
        #expect(user.htmlUrl == nil)
        #expect(user.timestamp > 0)
    }
    
    // Test 3: Decoding from JSON (init(from:))
    @Test("User decodes from JSON with all fields")
    func testDecodeFullJSON() throws {
        let json = """
            {
                "id": 3,
                "login": "testuser3",
                "avatar_url": "https://avatar3.com",
                "html_url": "https://user3.com"
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: json)
        
        #expect(user.id == 3)
        #expect(user.login == "testuser3")
        #expect(user.avatarUrl == "https://avatar3.com")
        #expect(user.htmlUrl == "https://user3.com")
        #expect(user.timestamp > 0)
    }
    
    // Test 4: Decoding minimal JSON
    @Test("User decodes from minimal JSON")
    func testDecodeMinimalJSON() throws {
        let json = """
            {
                "id": 4,
                "login": "testuser4"
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: json)
        
        #expect(user.id == 4)
        #expect(user.login == "testuser4")
        #expect(user.avatarUrl == nil)
        #expect(user.htmlUrl == nil)
        #expect(user.timestamp > 0)
    }
    
    // Test 5: Encoding to JSON (encode(to:))
    @Test("User encodes to JSON with all fields")
    func testEncodeFull() throws {
        let user = User(id: 5, login: "testuser5", avatarUrl: "https://avatar5.com", htmlUrl: "https://user5.com")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys // For consistent output
        
        let data = try encoder.encode(user)
        let jsonString = String(data: data, encoding: .utf8)!
        
        let expectedJSON = """
            {"avatar_url":"https:\\/\\/avatar5.com","html_url":"https:\\/\\/user5.com","id":5,"login":"testuser5"}
            """
        
        #expect(jsonString == expectedJSON)
    }
    
    // Test 6: Encoding with nil optionals
    @Test("User encodes to JSON with nil optionals")
    func testEncodeWithNilOptionals() throws {
        let user = User(id: 6, login: "testuser6", avatarUrl: nil, htmlUrl: nil)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        
        let data = try encoder.encode(user)
        let jsonString = String(data: data, encoding: .utf8)!
        
        let expectedJSON = """
            {"avatar_url":null,"html_url":null,"id":6,"login":"testuser6"}
            """
        
        #expect(jsonString == expectedJSON)
    }
    
    // Test 7: Decoding invalid JSON should throw
    @Test("User decoding fails with invalid JSON")
    func testDecodeInvalidJSON() throws {
        let invalidJSON = """
            {
                "id": "not_a_number",
                "login": "testuser"
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        #expect(throws: DecodingError.self) {
            _ = try decoder.decode(User.self, from: invalidJSON)
        }
    }
    
}
