//
//  ImageView+.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CacheImage: UIImageView {
    
    func loadImage(url: String) {
        guard let urlString = URL(string: url) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: url)) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: urlString) { data, res, error in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: NSString(string: url))
                self.image = imageToCache
            }
        }.resume()
    }
}
