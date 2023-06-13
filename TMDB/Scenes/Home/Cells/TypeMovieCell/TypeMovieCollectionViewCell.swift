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
    
    private lazy var posterImageLoader: ImageLoader = {
        let image = ImageLoader()
        image.isSkeletonable = true
        image.showGradientSkeleton()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
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
        addSubview(posterImageLoader)
    }
    
    func buildViewConstraints() {
        posterImageLoader.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        posterImageLoader.showGradientSkeleton()
    }
}
