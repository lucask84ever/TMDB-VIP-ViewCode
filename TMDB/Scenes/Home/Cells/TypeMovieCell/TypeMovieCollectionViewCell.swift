//
//  TypeMovieCollectionViewCell.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import SkeletonView
import UIKit

final class TypeMovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: TypeMovieCollectionViewCell.self)
    
    // MARK: Layout constants
    internal enum Layout {
        static let posterCornerRadius: CGFloat = 16
    }
    
    private lazy var posterImageLoader: ImageLoader = {
        let imageView = ImageLoader()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Layout.posterCornerRadius
        
        imageView.isSkeletonable = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageLoader.image = nil
    }
    
    func setupPoster(_ moviePosterUrl: String) {
        let imageEndpoint = ImageEndpoint(path: moviePosterUrl)
        posterImageLoader.getImage(imageEndpoint)
    }
}

extension TypeMovieCollectionViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(posterImageLoader)
    }
    
    func buildViewConstraints() {
        posterImageLoader.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        clipsToBounds = false
        isSkeletonable = true
        contentView.isSkeletonable = true
        posterImageLoader.isSkeletonable = true
        posterImageLoader.showAnimatedGradientSkeleton()
    }
}
