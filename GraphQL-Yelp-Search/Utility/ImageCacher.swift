//
//  ImageCache.swift
//  GraphQL-Yelp-Search
//
//  Created by Kyle Stewart on 1/10/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageCacher {
    static func downloadImage(url: URL, callback: @escaping () -> Void) {
        // Check the cache
        if let _ = imageCache.object(forKey: url as AnyObject) as? UIImage {
            callback()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url as AnyObject)
            }
            callback()
        }).resume()
    }

    static func getImage(url: URL) -> UIImage? {
        return imageCache.object(forKey: url as AnyObject) as? UIImage
    }
}
