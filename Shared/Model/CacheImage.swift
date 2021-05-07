//
//  CacheImage.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 08.05.21.
//

import SwiftUI

class CacheImage {
    static let shared = CacheImage()
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
