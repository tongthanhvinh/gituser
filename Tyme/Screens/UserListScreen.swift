//
//  UserListScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserListScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        List(viewModel.users, id: \.self.id) { user in
            ZStack {
                NavigationLink("") {
                    UserDetailsScreen(user: user)
                }
                .opacity(0)
                UserItemView(user: user)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        }
        .background(Color.white)
        .contentMargins(.zero)
        .listStyle(.plain)
        .navigationTitle("Github Users")
        .configBackButton(dismiss: dismiss)
        .onAppear {
            print("load more")
        }
    }
}

#Preview {
    NavigationStack {
        UserListScreen()
    }
}
