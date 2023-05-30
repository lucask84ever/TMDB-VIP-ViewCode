//
//  ImageLoader.swift
//  TMDB
//
//  Created by Lucas Lima on 30/05/23.
//

import SkeletonView
import UIKit.UIImageView

class ImageLoader: UIImageView {
    private let imageCache = NSCache<NSString, AnyObject>()
    
    private var imageUrl: String?
    
    func downloadImage(_ imageUrl: ImageEndpoint) {
        showAnimatedSkeleton()
        guard let cachedImage = imageCache.object(forKey: NSString(string: imageUrl.path)) as? UIImage else {
            URLSession.shared.dataTask(with: imageUrl.url) { data, _, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("DATA ERROR")
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.imageCache.setObject(image, forKey: NSString(string: imageUrl.path))
                    self?.image = image
                    self?.hideSkeleton()
                }
            }.resume()
            return
        }
        hideSkeleton()
        image = cachedImage
    }
}
