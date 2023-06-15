//
//  DetailMovieView.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import SkeletonView
import SnapKit
import UIKit

final class DetailMovieView: UIView {
    // MARK: View Properties
    private lazy var backdropImageLoader: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.isSkeletonable = true
        image.showAnimatedGradientSkeleton()
        return image
    }()
    
    private lazy var posterImageLoader: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFill
        image.isSkeletonable = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16
        image.showAnimatedGradientSkeleton()
        return image
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var movieReleaseYearLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var separator1 = UIView()
    
    private lazy var clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var movieDurationLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var separator2 = UIView()
    
    private lazy var ticketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ticket")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        return label
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
}

extension DetailMovieView {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func setMovieBackdrop(_ backdropPath: String) {
        let imageEndpoint = ImageEndpoint(path: backdropPath)
        backdropImageLoader.getImage(imageEndpoint)
    }
    
    func setMoviePoster(_ posterPath: String) {
        let imageEndpoint = ImageEndpoint(path: posterPath)
        posterImageLoader.getImage(imageEndpoint)
    }
    
    func setMovieTitle(_ title: String) {
        
    }
    
    func setMovieReleaseYear(_ releaseYear: String) {
        
    }
    
    func setMovieDuration(_ duration: String) {
        
    }
    
    func setGenre(_ genre: String) {
        
    }
}

extension DetailMovieView: ViewCodeProtocol {
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    func buildViewHierarchy() {
        addSubview(backdropImageLoader)
        addSubview(posterImageLoader)
    }
    
    func buildViewConstraints() {
        backdropImageLoader.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        posterImageLoader.snp.makeConstraints {
            $0.top.equalTo(backdropImageLoader.snp.bottom).inset(60)
            $0.leading.equalTo(backdropImageLoader).offset(32)
            $0.height.equalTo(120)
            $0.width.equalTo(95)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
