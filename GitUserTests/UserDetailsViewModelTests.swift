//
//  UserDetailsViewModelTests.swift
//  GitUserTests
//
//  Created by Vinh Tong on 1/3/25.
//

import Testing
@testable import GitUser


struct UserDetailsViewModelTests {

    // Test 1: Load user details
    @Test("Loads user details successfully")
    func testLoadUserDetails() async throws {
        let mockRepo = MockUserRepository()
        let testDetails = Mock.userDetails(id: 1, login: "user1")
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
