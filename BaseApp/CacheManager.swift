//
//  CacheManager.swift
//  gear
//
//  Created by Anh Nguyen on 4/27/16.
//  Copyright © 2016 BuzzElement. All rights reserved.
//

import Foundation
import SDWebImage

class CacheManager {

    static let imageKeyPrefix: String = "http://gear_cache.com/"
    static let voiceClipKeyPrefix: String = "evidence_voiceclip_"
    static let defaultBackGroundImageKey: String = "default_user_background.jpeg"

    static func fileExists(atPath path: URL) -> Bool {
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    // MARK:- Image Cache
    static func cacheImage(_ image: UIImage!, imageId: String!) {
        SDImageCache.shared().store(image, forKey: self.imageKeyPrefix + imageId)
    }

    static func getCachedImage(imageId: String) -> UIImage? {
        if let imageCache: UIImage = SDImageCache.shared().imageFromDiskCache(forKey: self.imageKeyPrefix + imageId) {
            return imageCache
        }
        return nil
    }

    static func removeCachedImage(imageId: String) {
        SDImageCache.shared().removeImage(forKey: self.imageKeyPrefix + imageId, fromDisk: true)
    }

    static func cacheBackGroundImage(_ image: UIImage!) {
        SDImageCache.shared().store(image, forKey: self.imageKeyPrefix + self.defaultBackGroundImageKey)
    }

    static func getCachedBackGroundImage() -> UIImage? {
        if let imageCache: UIImage = SDImageCache.shared().imageFromDiskCache(forKey: self.imageKeyPrefix + self.defaultBackGroundImageKey) {
            return imageCache
        }
        return nil
    }

    static func removeCachedBackGroundImage() {
        self.removeCachedImage(imageId: self.imageKeyPrefix + self.defaultBackGroundImageKey)
    }
}
