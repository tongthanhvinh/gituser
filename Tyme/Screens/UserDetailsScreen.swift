//
//  UserDetailsScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserDetailsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: UserViewModel
    
    init(login: String) {
        _viewModel = StateObject(wrappedValue: UserViewModel(login: login))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let userDetails = viewModel.userDetails {
                UserDetailsHeaderView(user: viewModel.userDetails)
                
                HStack(spacing: 0) {
                    Spacer()
                    VStack {
                        Image("people")
                            .padding(12)
                            .background(.gray.opacity(0.1))
                            .clipShape(Circle())
                        Text("\(userDetails.followers)")
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
                        Text("\(userDetails.following)")
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
                if let url = URL(string: userDetails.html_url) {
                    Link(userDetails.html_url, destination: url)
                        .font(.subheadline)
                        .underline()
                        .foregroundStyle(.blue)
                }
                Spacer()
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
    }
}

#Preview {
    NavigationStack {
        UserDetailsScreen(login: "mcooke")
    }
}
