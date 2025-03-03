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
            if viewModel.isLoading {
                loadingView
            } else if let userDetails = viewModel.userDetails {
                userDetailsView(userDetails)
            } else if let errorMessage = viewModel.errorMessage {
                errorView(errorMessage)
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
    
    /// View to display user details.
    private func userDetailsView(_ userDetails: UserDetails) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            UserDetailsHeaderView(user: userDetails)
            
            followerFollowingView(userDetails)
                .padding(.top, 16)
            
            if let htmlUrl = userDetails.htmlUrl, let url = URL(string: htmlUrl) {
                blogSection(url: url, urlText: htmlUrl)
            }
            
            Spacer()
        }
    }
    
    /// Displays followers and following count with icons.
    private func followerFollowingView(_ userDetails: UserDetails) -> some View {
        HStack(spacing: 32) {
            followerFollowingItem(imageName: "people", count: userDetails.followers, label: "Followers")
            followerFollowingItem(imageName: "tag", count: userDetails.following, label: "Following")
        }
        .frame(maxWidth: .infinity)
    }
    
    /// A single item displaying either followers or following count.
    private func followerFollowingItem(imageName: String, count: Int?, label: String) -> some View {
        VStack {
            Image(imageName)
                .renderingMode(.template)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(Circle())
            Text(formatCount(count))
                .font(.caption)
            Text(label)
                .font(.footnote)
        }
    }
    
    /// Blog section with tappable link.
    private func blogSection(url: URL, urlText: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Blog")
                .font(.headline)
            Button(action: {
                UIApplication.shared.open(url)
            }) {
                Text(urlText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .underline()
            }
            .buttonStyle(.plain)
        }
    }
    
    /// View for displaying an error message.
    private func errorView(_ message: String) -> some View {
        VStack {
            Spacer()
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            Spacer()
        }
    }
    
    /// View for displaying a loading indicator.
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Loading...")
            Spacer()
        }
    }
    
    /// Formats the count for followers and following.
    private func formatCount(_ count: Int?) -> String {
        guard let count = count else { return "0" }
        return count >= 100 ? "100+" : "\(count)"
    }
}

#Preview {
    NavigationStack {
        UserDetailsScreen(login: "tongthanhvinh")
    }
}
