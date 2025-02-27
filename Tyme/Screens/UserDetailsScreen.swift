//
//  UserDetailsScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserDetailsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            UserItemView()
            
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    Image("people")
                        .padding(12)
                        .background(.gray.opacity(0.1))
                        .clipShape(Circle())
                    Text("100+")
                        .font(.caption)
                        .foregroundColor(.black)
                    Text("Follower")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack {
                    Image("people")
                        .padding(12)
                        .background(.gray.opacity(0.1))
                        .clipShape(Circle())
                    Text("100+")
                        .font(.caption)
                        .foregroundColor(.black)
                    Text("Follower")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            
            Text("Blog")
                .font(.headline)
            
            Text("https://blog.abc")
                .foregroundStyle(.black)
                .font(.footnote)
            
            Spacer()
        }
        .padding(16)
        .navigationTitle("User Details")
        .configBackButton(dismiss: dismiss)
    }
}

#Preview {
    NavigationStack {
        UserDetailsScreen()
    }
}
