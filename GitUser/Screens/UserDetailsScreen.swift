//
//  UserDetailsScreen.swift
//  GitUser
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserDetailsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = UserViewModel()
    
    let login: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let userDetails = viewModel.userDetails {
                UserDetailsHeaderView(user: userDetails)
                
                HStack(spacing: 0) {
                    Spacer()
                    VStack {
                        Image("people")
                            .renderingMode(.template)
                            .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(Circle())
                        Text(followersStr(userDetails.followers))
                            .font(.caption)
                        Text("Follower")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image("tag")
                            .renderingMode(.template)
                            .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(Circle())
                        Text(followingStr(userDetails.following))
                            .font(.caption)
                        Text("Following")
                            .font(.footnote)
                    }
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                Text("Blog")
                    .font(.headline)
                
                if let htmlUrl = userDetails.htmlUrl, let url = URL(string: htmlUrl) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text(htmlUrl)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .background(Color(.systemBackground))
        .navigationTitle("User Details")
        .configBackButton(dismiss: dismiss)
        .task {
            viewModel.loadUserDetails(username: login)
        }
    }
    
    private func followersStr(_ count: Int?) -> String {
        guard let count = count else {
            return "0"
        }
        if count > 100 {
            return String(format: "100+", count)
        }
        return String(format: "%d", count)
    }
    
    private func followingStr(_ count: Int?) -> String {
        guard let count = count else {
            return "0"
        }
        if count > 10 {
            return String(format: "10+", count)
        }
        return String(format: "%d", count)
    }
}

#Preview {
    NavigationStack {
        UserDetailsScreen(login: "tongthanhvinh")
    }
}
