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
                CachedAsyncImageView(urlStr: user.avatar_url)
                    .foregroundStyle(.gray.opacity(0.3))
                    .frame(width: imageSize, height: imageSize)
                    .background(Color(red: 234/255, green: 227/255, blue: 244/255))
                    .clipShape(Circle())
                    .padding(8)
            }
            .fixedSize()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.login)
                    .font(.headline)
                    .lineLimit(1)
                Divider()
                if let url = URL(string: user.html_url) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Text(user.html_url)
                            .font(.subheadline)
                            .underline()
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.plain)
                }
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
    UserItemView(
        user: User(
            id: 10725542,
            login: "tongthanhvinh",
            avatar_url: "https://avatars.githubusercontent.com/u/10725542?v=4",
            html_url: "https://github.com/tongthanhvinh"
        )
    )
    .padding(16)
}
