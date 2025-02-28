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
                    .onAppear(perform: loadImage)
            }
        }
    }

    private func loadImage() {
        guard let urlStr = urlStr else {
            return
        }
        if let cachedImage = ImageCache.shared.get(forKey: urlStr) {
            self.image = cachedImage
        } else {
            downloadImage()
        }
    }

    private func downloadImage() {
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                ImageCache.shared.set(uiImage, forKey: url.absoluteString)
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
        .resume()
    }
}

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
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
