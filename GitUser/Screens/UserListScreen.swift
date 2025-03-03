//
//  UserListScreen.swift
//  GitUser
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
        
        // Error Message Display (Toast Style)
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            VStack {
                Spacer()
                Text(errorMessage)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        withAnimation {
                            viewModel.errorMessage = nil
                        }
                    }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}

#Preview {
    NavigationStack {
        UserListScreen()
    }
}
