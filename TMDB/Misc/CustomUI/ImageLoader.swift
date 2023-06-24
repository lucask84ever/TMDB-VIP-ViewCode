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
    
    internal enum Constants {
        static let transitionTime: CGFloat = 0.5
    }
    
    private var imageUrl: String?
    
    // MARK: Initializes
    init() {
        super.init(frame: .zero)
        showAnimatedGradientSkeleton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    // MARK: Public methdos
    func getImage(_ imageUrl: ImageEndpoint) {
        showAnimatedGradientSkeleton()
        sd_setImage(with: imageUrl.url, placeholderImage: nil, options: .queryMemoryData, progress: nil) { [weak self] image, error, _, _ in
            self?.image = image
            self?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(Constants.transitionTime))
        }
    }
    
    func getImage(_ imageUrl: String) {
        sd_setImage(with: URL(string: imageUrl)) { [weak self] image, error, _, _ in
            self?.image = image
            self?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(Constants.transitionTime))
        }
    }
}
