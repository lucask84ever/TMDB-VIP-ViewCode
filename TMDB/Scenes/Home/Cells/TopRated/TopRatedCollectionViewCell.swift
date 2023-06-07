//
//  TopRatedCollectionViewCell.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import UIKit

final class TopRatedCollectionViewCell: UICollectionViewCell {
    // MARK: ReuseIdentifier
    static let reuseIdentifier = "topRatedMovieCell"
    
    // MARK: Layout constants
    internal enum Layout {
        static let posterHeight: CGFloat = 210
        static let posterWidth: CGFloat = 144
        static let posterCornerRadius: CGFloat = 16
        static let positionHeight: CGFloat = 60
        static let positionWidth: CGFloat = 60
    }
    
    // MARK: UIElements
    private lazy var posterImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Layout.posterCornerRadius
        
        imageView.isSkeletonable = true
        imageView.startSkeletonAnimation()
        return imageView
    }()
    
    private lazy var positionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.clipsToBounds = false
        return imageView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom methods
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    func setup(_ movie: Movie, _ position: Int) {
        positionImageView.image = UIImage(named: "\(position + 1)")
        positionImageView.isHidden = false
        let imageUrl = ImageEndpoint(path: movie.posterPath)
        posterImageView.getImage(imageUrl)
    }
}

extension TopRatedCollectionViewCell: ViewcodeProtocol {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(positionImageView)
    }
    
    func buildViewConstraints() {
        posterImageView.snp.makeConstraints {
            $0.width.equalTo(Layout.posterWidth)
            $0.height.equalTo(Layout.posterHeight)
            $0.center.equalToSuperview()
        }
        
        positionImageView.snp.makeConstraints {
            $0.centerX.equalTo(posterImageView.snp.left)
            $0.height.equalTo(Layout.positionHeight)
            $0.width.equalTo(Layout.positionWidth)
            $0.bottom.equalTo(posterImageView).offset(Layout.positionHeight/4)
        }
    }
    
    func additionalConfig() {
        clipsToBounds = false
    }
}
