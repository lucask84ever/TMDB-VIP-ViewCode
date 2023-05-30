//
//  ImageLoader.swift
//  TMDB
//
//  Created by Lucas Lima on 30/05/23.
//

import SkeletonView
import UIKit.UIImageView

class ImageLoader: UIImageView {
    // Properties
    private var imageCache: NSCache<NSString, AnyObject>
    
    private var imageUrl: String?
    
    // MARK: Initializes
    init() {
        imageCache = NSCache<NSString, AnyObject>()
        super.init(frame: .zero)
        setupImageCache()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    // MARK: Public methdos
    func getImage(_ imageUrl: ImageEndpoint) {
        showAnimatedSkeleton()
        guard let cachedImage = retrieveImageInCacheIfExists(imageUrl) else {
            downloadImage(imageUrl)
            return
        }
        image = cachedImage
    }
    
    // MARK:  Private methods
    private func setupImageCache() {
        imageCache.totalCostLimit = 100 * 1024 * 1024 // 100 Mb cache
    }
    
    private func downloadImage(_ imageUrl: ImageEndpoint) {
        URLSession.shared.dataTask(with: imageUrl.url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("DATA ERROR")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.storeImageInCache(imageUrl.path, image)
                self?.image = image
                self?.hideSkeleton()
            }
        }.resume()
    }
    
    private func retrieveImageInCacheIfExists(_ imageUrl: ImageEndpoint) -> UIImage? {
        return imageCache.object(forKey: NSString(string: imageUrl.path)) as? UIImage
    }
    
    private func storeImageInCache(_ imageKey: String, _ image: UIImage) {
        imageCache.setObject(image, forKey: NSString(string: imageKey))
    }
}
