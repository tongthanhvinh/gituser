//
//  UserItemView.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserItemView: View {
    
    var user: User
    
    private let imageSize: CGFloat = 80
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                CachedAsyncImageView(
                    url: URL(string: user.avatar_url)!,
                    placeholder: Image("image")
                )
                .foregroundStyle(.gray.opacity(0.3))
                .frame(width: imageSize, height: imageSize)
                .background(Color(red: 234/255, green: 227/255, blue: 244/255))
                .clipShape(Circle())
                .padding(8)
            }
            .fixedSize()
            VStack(alignment: .leading, spacing: 8) {
                Text(user.login + " - \(user.id)")
                    .font(.headline)
                Divider()
                Text(user.html_url)
                    .font(.subheadline)
                    .underline()
                Spacer()
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    UserItemView(user: User(id: 5, login: "", avatar_url: "", html_url: ""))
        .padding(16)
}
