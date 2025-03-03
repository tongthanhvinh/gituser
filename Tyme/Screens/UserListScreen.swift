//
//  UserListScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI
import SwiftData

struct UserListScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel = UserListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                    if viewModel.shouldLoadMoreData(currentItem: user) {
                        viewModel.loadMoreUsers()
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .id(UUID())
                    .listRowSeparator(.hidden)
            }
        }
        .contentMargins(.zero)
        .listStyle(.plain)
        .navigationTitle("Github Users")
        .configBackButton(dismiss: dismiss)
        .refreshable {
            viewModel.refreshData()
        }
    }
}

#Preview {
    NavigationStack {
        UserListScreen()
    }
}
