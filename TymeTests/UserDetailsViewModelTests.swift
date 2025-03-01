//
//  UserDetailsViewModelTests.swift
//  TymeTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
@testable import Tyme


struct UserDetailsViewModelTests {
    
    func createTestUserDetails(id: Int, login: String) -> UserDetails {
        return UserDetails(
            id: id,
            login: login,
            avatarUrl: "https://avatar\(id).com",
            htmlUrl: "https://user\(id).com",
            location: "Test Location",
            followers: 10,
            following: 5
        )
    }

    // Test 1: Load user details
    @Test("Loads user details successfully")
    func testLoadUserDetails() async throws {
        let mockRepo = MockUserRepository()
        let testDetails = createTestUserDetails(id: 1, login: "user1")
        mockRepo.userDetailsToReturn = testDetails
        
        let viewModel = UserViewModel(repository: mockRepo)
        viewModel.loadUserDetails(username: "user1")
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.userDetails?.id == testDetails.id)
        #expect(viewModel.userDetails?.login == testDetails.login)
        #expect(viewModel.userDetails?.followers == testDetails.followers)
    }
    
    // Test 2: User details error handling
    @Test("Handles user details loading error")
    func testUserDetailsError() async throws {
        let mockRepo = MockUserRepository()
        mockRepo.shouldThrowError = true
        
        let viewModel = UserViewModel(repository: mockRepo)
        viewModel.loadUserDetails(username: "user1")
        try await Task.sleep(for: .seconds(1))
        
        #expect(viewModel.userDetails == nil)
    }

}
