//
//  UserListScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserListScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = UserListViewModel()
    
    private let loadThreshold = 3 // Trigger load when 3 items from the end
    
    var body: some View {
        List {
            ForEach(viewModel.users) { user in
                ZStack {
                    NavigationLink("") {
                        UserDetailsScreen(login: user.login)
                    }
                    .opacity(0)
                    UserItemView(user: user)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .onAppear {
                    // Check if this item is within the threshold of the last item
                    if let index = viewModel.users.firstIndex(of: user),
                       index >= viewModel.users.count - loadThreshold {
                        viewModel.loadData()
                    }
                }
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .id(UUID())
                .listRowSeparator(.hidden)
            }
        }
        .background(Color.white)
        .contentMargins(.zero)
        .listStyle(.plain)
        .navigationTitle("Github Users")
        .configBackButton(dismiss: dismiss)
    }
}

#Preview {
    NavigationStack {
        UserListScreen()
    }
}
