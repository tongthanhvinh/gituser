//
//  CachedAsyncImageView.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct CachedAsyncImageView: View {
    let url: URL
    let placeholder: Image

    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .resizable()
                    .onAppear(perform: loadImage)
            }
        }
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cachedImage
        } else {
            downloadImage()
        }
    }

    private func downloadImage() {
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

