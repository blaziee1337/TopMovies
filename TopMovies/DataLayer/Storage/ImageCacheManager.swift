//
//  ImageCacheManager.swift
//  TopMovies
//
//  Created by Halil Yavuz on 02.12.2024.
//

import UIKit

final class ImageCacheManager {
    
    private let cache = NSCache<NSString, UIImage>()
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func loadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = getImage(forKey: url.absoluteString) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        cacheImage(image, forKey: url.absoluteString)
        return image
    }
}
