//
//  CachedAsyncImageView.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct CachedAsyncImageView: View {
    
    let urlStr: String?

    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image("image")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .padding()
                    .task {
                        image = await ImageCache.shared.loadImage(urlStr: urlStr)
                    }
            }
        }
    }
}


#Preview {
    CachedAsyncImageView(urlStr: nil)
        .frame(width: 100, height: 100)
        .foregroundStyle(.gray.opacity(0.3))
        .background(Color(red: 234/255, green: 227/255, blue: 244/255))
        .clipShape(Circle())
        .padding(8)
}
