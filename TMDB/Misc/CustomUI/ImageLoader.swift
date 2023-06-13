//
//  ImageLoader.swift
//  TMDB
//
//  Created by Lucas Lima on 30/05/23.
//

import SDWebImage
import SkeletonView
import UIKit.UIImageView

final class ImageLoader: UIImageView {
    private var imageUrl: String?
    
    // MARK: Initializes
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    // MARK: Public methdos
    func getImage(_ imageUrl: ImageEndpoint) {
        showAnimatedGradientSkeleton()
        sd_setImage(with: imageUrl.url) { [weak self] image, error, _, _ in
            if let error = error {
                print(error.localizedDescription)
                self?.image = UIImage()
            }
            self?.image = image
            self?.hideSkeleton()
        }
    }
}
