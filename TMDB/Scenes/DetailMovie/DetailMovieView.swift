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
    // MARK: Properties
    var detailTypeDelegate: MovieDetailTypeDelegate?
    var detailTypeDataSource: DetailMovieDatasource?
    
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
        label.font = .systemFont(ofSize: 14)
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
        label.font = .systemFont(ofSize: 14)
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
        label.font = .systemFont(ofSize: 14)
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var detailTypeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var noteBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.backgroundColorWithAlpha.color
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.text = "9.6"
        label.font = .systemFont(ofSize: 14)
        label.textColor = ColorName.noteColor.color
        return label
    }()
    
    private lazy var startImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = ColorName.noteColor.color
        imageView.isSkeletonable = true
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
}

// MARK: Setting  values
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
    
    func setNote(_ note: String) {
        DispatchQueue.main.async { [weak self] in
            self?.noteLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.noteLabel.text = note
        }
    }
}

// MARK: - Layout
extension DetailMovieView: ViewCodeProtocol {
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
        setupDetailTypeCollectionView()
    }
    
    func buildViewHierarchy() {
        addSubview(backdropImageLoader)
        backdropImageLoader.addSubview(noteBackgroundView)
        noteBackgroundView.addSubview(noteLabel)
        noteBackgroundView.addSubview(startImageView)
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
        addSubview(detailTypeCollectionView)
    }
    
    func buildViewConstraints() {
        backdropImageLoader.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        noteBackgroundView.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().inset(16)
            $0.width.equalTo(56)
            $0.height.equalTo(24)
        }
        
        noteLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
            $0.height.equalTo(18)
        }
        
        startImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.height.width.equalTo(18)
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
        
        detailTypeCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
            $0.top.equalTo(movieDurationLabel.snp.bottom).offset(16)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        movieTitleLabel.showSkeleton()
        movieReleaseYearLabel.showAnimatedGradientSkeleton()
    }
}

// MARK: Setup Collection
extension DetailMovieView {
    private func setupDetailTypeCollectionView() {
        detailTypeDelegate = MovieDetailTypeDelegate(detailTypeCollectionView, self)
        detailTypeDataSource = DetailMovieDatasource(detailTypeCollectionView)
    }
    
    func setInitialSelection() {
        detailTypeDelegate?.setInitialValue()
    }
    
}

extension DetailMovieView: _MovieDetailTypeProtocol {
    func selectedType(_ detailType: MovieDetailTypeEnum) {
        print(detailType.text)
    }
}
