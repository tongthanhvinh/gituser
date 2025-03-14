//
//  UserDetailsHeaderView.swift
//  GitUser
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct UserDetailsHeaderView: View {
    
    var user: UserDetails?
    
    private let imageSize: CGFloat = 80
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                CachedAsyncImageView(urlStr: user?.avatarUrl)
                    .foregroundStyle(Color(.secondarySystemBackground))
                    .frame(width: imageSize, height: imageSize)
                    .background(Color(red: 234/255, green: 227/255, blue: 244/255))
                    .clipShape(Circle())
                    .padding(8)
            }
            .fixedSize()
            VStack(alignment: .leading, spacing: 8) {
                Text(user?.login ?? "")
                    .font(.headline)
                    .lineLimit(1)
                Divider()
                    .background(.primary)
                HStack(spacing: 2) {
                    Image("location")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.primary)
                    Text(user?.location ?? "nil")
                        .font(.caption)
                }
                Spacer()
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    UserDetailsHeaderView(
        user: UserDetails(
            id: 10725542,
            login: "tongthanhvinh",
            avatarUrl: "https://avatars.githubusercontent.com/u/10725542?v=4",
            htmlUrl: "https://github.com/tongthanhvinh",
            location: "Viet Nam",
            followers: 1000,
            following: 100
        )
    )
    .padding(16)
}
