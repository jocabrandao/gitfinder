//
//  UIImageViewRouded.swift
//  gitfinder
//
//  Created by Joca on 01/08/2018.
//  Copyright © 2018 Git Finder. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CircleIV: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}

extension UIImageView {
    func load(url: URL) {
        self.image = nil
        if let cachedImage = ImageCache.instance.load(withKey: url.absoluteString) {
            self.image = cachedImage
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            ImageCache.instance.store(withKey: url.absoluteString, image: image)
                        }
                    }
                }
            }
        }
    }
}

class ImageCache {
    
    let cache = NSCache<NSString, UIImage>()
    
    static let instance = ImageCache()

    func load(withKey: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: withKey as NSString) {
            return cachedImage
        } else {
            return nil
        }
    }
    
    func store(withKey: String, image: UIImage) -> Void {
        cache.setObject(image, forKey: withKey as NSString)
    }
    
}
