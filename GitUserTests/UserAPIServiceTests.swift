//
//  UserAPIServiceTests.swift
//  GitUserTests
//
//  Created by Vinh Tong on 2/3/25.
//

import Testing
import Foundation
@testable import GitUser

@Suite(.serialized)
struct UserAPIServiceTests {
    
    let service: UserAPIService
    let mockSession: URLSession
    
    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        service = UserAPIService(baseUrlStr: "https://api.example.com/users", urlSession: mockSession)
    }
    
    @Test("Fetch users successfully returns decoded users")
    func fetchUsersSuccess() async throws {
        let mockUsers = [Mock.user(id: 1, login: "user1")]
        let jsonData = try JSONEncoder().encode(mockUsers)
        let url = URL(string: "https://api.example.com/users?per_page=10&since=0")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.handler = { request in
            #expect(request.url?.absoluteString == "https://api.example.com/users?per_page=10&since=0")
            return (response, jsonData)
        }
        
        let users = try await service.fetchUsers(perPage: 10, since: 0)
        #expect(users.count == mockUsers.count)
        #expect(users.first?.id == mockUsers.first?.id)
        #expect(users.first?.login == mockUsers.first?.login)
    }
    
    @Test("Fetch users with invalid URL throws badURL error")
    func fetchUsersInvalidURL() async throws {
        let invalidService = UserAPIService(baseUrlStr: "invalid-url", urlSession: mockSession)
        
        await #expect(throws: URLError.self) {
            try await invalidService.fetchUsers(perPage: 10, since: 0)
        }
    }
    
    @Test("Fetch user details successfully returns decoded details")
    func fetchUserDetailSuccess() async throws {
        let mockDetails = Mock.userDetails(
            id: 1,
            login: "testuser",
            avatarUrl: "https://avatar.com",
            htmlUrl: "https://html.com",
            location: "Location",
            followers: 1000,
            following: 100
        )
        let jsonData = try JSONEncoder().encode(mockDetails)
        let url = URL(string: "https://api.example.com/users/testuser")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.handler = { request in
            #expect(request.url?.absoluteString == "https://api.example.com/users/testuser")
            return (response, jsonData)
        }
        
        let details = try await service.fetchUserDetail(username: "testuser")
        #expect(details.id == mockDetails.id)
        #expect(details.login == mockDetails.login)
        #expect(details.avatarUrl == mockDetails.avatarUrl)
        #expect(details.htmlUrl == mockDetails.htmlUrl)
        #expect(details.location == mockDetails.location)
        #expect(details.followers == mockDetails.followers)
        #expect(details.following == mockDetails.following)
    }
    
    @Test("Fetch user details with invalid JSON throws decoding error")
    func fetchUserDetailDecodingError() async throws {
        let jsonData = "invalid json".data(using: .utf8)!
        let url = URL(string: "https://api.example.com/users/testuserInvalidJson")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.handler = { _ in
            return (response, jsonData)
        }
        
        await #expect(throws: DecodingError.self) {
            try await service.fetchUserDetail(username: "testuserInvalidJson")
        }
    }
    
    @Test("Fetch user details with Invalid URL throws badURL error")
    func testUserDetailsInvalidURL() async throws {
        let invalidService = UserAPIService(baseUrlStr: "invalid-url", urlSession: mockSession)
        
        // Act & Assert
        await #expect(throws: URLError(.badURL)) {
            try await invalidService.fetchUserDetail(username: "invalid-url")
        }
    }
}
