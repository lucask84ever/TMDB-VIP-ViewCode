//
//  DetailMovieView.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation
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
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = ColorName.textColor.color
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
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var separator1: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.textfieldBackground.color
        return view
    }()
    
    private lazy var clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var movieDurationLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var separator2: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.textfieldBackground.color
        return view
    }()
    
    private lazy var ticketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ticket")
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorName.textColor.color
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
    
    func setMovieBackdrop(_ backdropPath: String) {
        let imageEndpoint = ImageEndpoint(path: backdropPath)
        backdropImageLoader.getImage(imageEndpoint)
    }
    
    func setMoviePoster(_ posterPath: String) {
        let imageEndpoint = ImageEndpoint(path: posterPath)
        posterImageLoader.getImage(imageEndpoint)
    }
    
    func setMovieTitle(_ title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.movieTitleLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.movieTitleLabel.text = title
        }
    }
    
    func setMovieReleaseYear(_ releaseYear: String) {
        DispatchQueue.main.async { [weak self] in
            self?.movieReleaseYearLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.movieReleaseYearLabel.text = releaseYear
        }
    }
    
    func setMovieDuration(_ duration: String) {
        DispatchQueue.main.async { [weak self] in
            self?.movieDurationLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.movieDurationLabel.text = duration
        }
    }
    
    func setGenre(_ genre: String) {
        DispatchQueue.main.async { [weak self] in
            self?.genreLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.genreLabel.text = genre
        }
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
        addSubview(movieTitleLabel)
        addSubview(calendarImageView)
        addSubview(movieReleaseYearLabel)
        addSubview(separator1)
        addSubview(clockImageView)
        addSubview(movieDurationLabel)
        addSubview(separator2)
        addSubview(ticketImageView)
        addSubview(genreLabel)
        
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
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backdropImageLoader.snp.bottom)
            $0.leading.equalTo(posterImageLoader.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(posterImageLoader)
        }
        
        movieDurationLabel.snp.makeConstraints {
            $0.height.equalTo(21)
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        clockImageView.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.centerY.equalTo(movieDurationLabel)
            $0.right.equalTo(movieDurationLabel.snp.left).offset(-8)
        }
        
        separator1.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.equalTo(21)
            $0.right.equalTo(clockImageView.snp.left).offset(-16)
            $0.centerY.equalTo(movieDurationLabel)
        }
        
        movieReleaseYearLabel.snp.makeConstraints {
            $0.right.equalTo(separator1.snp.left).inset(-16)
            $0.height.equalTo(21)
            $0.centerY.equalTo(movieDurationLabel)
        }
        
        calendarImageView.snp.makeConstraints {
            $0.right.equalTo(movieReleaseYearLabel.snp.left).inset(-16)
            $0.height.width.equalTo(21)
            $0.centerY.equalTo(movieDurationLabel)
        }
        
        separator2.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.equalTo(21)
            $0.left.equalTo(movieDurationLabel.snp.right).offset(16)
            $0.centerY.equalTo(movieDurationLabel)
        }
        
        ticketImageView.snp.makeConstraints {
            $0.left.equalTo(separator2.snp.right).offset(16)
            $0.width.height.equalTo(21)
            $0.centerY.equalTo(movieDurationLabel)
        }
        
        genreLabel.snp.makeConstraints {
            $0.left.equalTo(ticketImageView.snp.right).offset(8)
            $0.height.equalTo(21)
            $0.centerY.equalTo(movieDurationLabel)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        movieTitleLabel.showSkeleton()
        movieReleaseYearLabel.showAnimatedGradientSkeleton()
    }
}
