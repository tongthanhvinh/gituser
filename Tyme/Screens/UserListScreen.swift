//
//  UserListScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserListScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(0...12, id: \.self) { index in
            ZStack {
                NavigationLink("") {
                    UserDetailsScreen()
                }
                .opacity(0)
                UserItemView()
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
