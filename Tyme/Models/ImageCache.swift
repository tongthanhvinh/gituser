//
//  ImageCache.swift
//  Tyme
//
//  Created by Vinh Tong on 28/2/25.
//

import UIKit


class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    @MainActor
    func loadImage(urlStr: String?) async -> UIImage? {
        guard let urlStr, let url = URL(string: urlStr) else { return nil }

        if let cachedImage = ImageCache.shared.get(forKey: urlStr) {
            return cachedImage
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.set(uiImage, forKey: urlStr)
                return uiImage
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        return nil
    }
}
