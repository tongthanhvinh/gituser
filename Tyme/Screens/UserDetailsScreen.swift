//
//  UserDetailsScreen.swift
//  Tyme
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
                            .padding(12)
                            .background(.gray.opacity(0.1))
                            .clipShape(Circle())
                        Text(followersStr(userDetails.followers))
                            .font(.caption)
                            .foregroundColor(.black)
                        Text("Follower")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    VStack {
                        Image("tag")
                            .padding(12)
                            .background(.gray.opacity(0.1))
                            .clipShape(Circle())
                        Text(followingStr(userDetails.following))
                            .font(.caption)
                            .foregroundColor(.black)
                        Text("Following")
                            .font(.footnote)
                            .foregroundColor(.black)
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
            }
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            }
            
        }
        .padding(16)
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
