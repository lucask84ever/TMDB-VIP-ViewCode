//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation
import SkeletonView
import SnapKit
import UIKit
import youtube_ios_player_helper

protocol SelectReviewProtocol {
    func selectedReview(_ review: UserReview)
}

final class MovieDetailView: UIView {
    // MARK: Properties
    var detailTypeDelegate: MovieDetailTypeDelegate?
    var detailTypeDataSource: MovieDetailTypeDatasource?
    
    var userReviewDelegate: UserReviewDelegate?
    var userReviewDataSource: UserReviewDataSource?
    
    var castDelegate: CastDelegate?
    var castDatasource: CastDatasource?
    
    var selectDetailType: ((MovieDetailTypeEnum) -> Void)?
    var selectDetailReview: ((UserReview) -> Void)?
    
    var youtubeDelegate = YoutubePlayerDelegate()
    var isLoaded: Bool = false
    
    // MARK: View Properties
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
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
        label.font = FontFamily.Poppins.bold.font(size: 18)//.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = ColorName.textColor.color
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.tintColor = ColorName.subtitleColor.color
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var movieReleaseYearLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = FontFamily.Montserrat.medium.font(size: 12)
        label.textColor = ColorName.subtitleColor.color
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
        imageView.tintColor = ColorName.subtitleColor.color
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var movieDurationLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = FontFamily.Montserrat.medium.font(size: 12)
        label.textColor = ColorName.subtitleColor.color
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
        imageView.tintColor = ColorName.subtitleColor.color
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = FontFamily.Montserrat.medium.font(size: 12)
        label.textColor = ColorName.subtitleColor.color
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
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = FontFamily.Montserrat.semiBold.font(size: 12)
        label.textColor = ColorName.noteColor.color
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.tintColor = ColorName.noteColor.color
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var overviewBackgroundView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textAlignment = .left
        label.textColor = ColorName.textColor.color
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var trailerBackgroundView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private lazy var trailerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.delegate = youtubeDelegate
        playerView.showAnimatedGradientSkeleton()
        playerView.isSkeletonable = true
        return playerView
    }()
    
    private lazy var castCollectionView: ContentSizeCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = ContentSizeCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = .clear
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var reviewTableView: ContentSizeTableView = {
        let tableview = ContentSizeTableView()
        tableview.isSkeletonable = true
        tableview.rowHeight = UITableView.automaticDimension
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.isHidden = true
        return tableview
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
extension MovieDetailView {
    func setMovieBackdrop(_ backdropPath: String) {
        DispatchQueue.main.async { [weak self] in
            let imageEndpoint = ImageEndpoint(path: backdropPath)
            self?.backdropImageLoader.getImage(imageEndpoint)
            
        }
    }
    
    func setMoviePoster(_ posterPath: String) {
        DispatchQueue.main.async { [weak self] in
            let imageEndpoint = ImageEndpoint(path: posterPath)
            self?.posterImageLoader.getImage(imageEndpoint)
        }
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
            self?.noteBackgroundView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.noteLabel.text = note
        }
    }
    
    func setOverview(_ overview: String) {
        DispatchQueue.main.async { [weak self] in
            self?.overviewBackgroundView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.overviewLabel.text = overview
        }
    }
    
    func setTrailer(_ url: String) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoaded = true
            self?.trailerView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.trailerView.load(withVideoId: url)
        }
    }
    
    func setReviws(_ reviews: [UserReview]) {
        DispatchQueue.main.async { [weak self] in
            self?.reviewTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self?.setupUserReviewsTableView()
            self?.userReviewDataSource?.setItems(reviews)
            self?.userReviewDelegate?.setItems(reviews)
            self?.reviewTableView.reloadData()
        }
    }
    
    func setCasting(_ casting: [Cast]) {
        DispatchQueue.main.async { [weak self] in
            self?.castDatasource?.setItems(casting)
        }
    }
}

// MARK: - Layout
extension MovieDetailView: ViewCodeProtocol {
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImageLoader)
        backdropImageLoader.addSubview(noteBackgroundView)
        noteBackgroundView.addSubview(noteLabel)
        noteBackgroundView.addSubview(starImageView)
        contentView.addSubview(posterImageLoader)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(calendarImageView)
        contentView.addSubview(movieReleaseYearLabel)
        contentView.addSubview(separator1)
        contentView.addSubview(clockImageView)
        contentView.addSubview(movieDurationLabel)
        contentView.addSubview(separator2)
        contentView.addSubview(ticketImageView)
        contentView.addSubview(genreLabel)
        contentView.addSubview(detailTypeCollectionView)
        contentView.addSubview(overviewBackgroundView)
        overviewBackgroundView.addSubview(overviewLabel)
        contentView.addSubview(trailerBackgroundView)
        trailerBackgroundView.addSubview(trailerView)
        contentView.addSubview(reviewTableView)
        contentView.addSubview(castCollectionView)
    }
    
    func buildViewConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.width.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(safeAreaLayoutGuide)
            $0.height.equalTo(safeAreaLayoutGuide).priority(.low)
        }
        
        backdropImageLoader.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }

        noteBackgroundView.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }

        noteLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
            $0.height.equalTo(18)
        }

        starImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(noteLabel.snp.left).offset(-8)
            $0.height.width.equalTo(14)
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

        overviewBackgroundView.snp.makeConstraints {
            $0.top.equalTo(detailTypeCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        overviewLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        trailerBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(overviewBackgroundView)
            $0.height.equalTo(trailerBackgroundView.snp.width).multipliedBy(9.0/16.0)
        }

        trailerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        castCollectionView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(detailTypeCollectionView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        reviewTableView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(detailTypeCollectionView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        setupDetailTypeCollectionView()
        setupCastCollectionView()
        movieTitleLabel.showAnimatedGradientSkeleton()
        backdropImageLoader.showAnimatedGradientSkeleton()
        posterImageLoader.showAnimatedGradientSkeleton()
        movieReleaseYearLabel.showAnimatedGradientSkeleton()
        noteBackgroundView.showAnimatedGradientSkeleton()
        trailerView.showAnimatedGradientSkeleton()
    }
}

// MARK: Setup Collection
extension MovieDetailView {
    private func setupDetailTypeCollectionView() {
        detailTypeDelegate = MovieDetailTypeDelegate(detailTypeCollectionView, self)
        detailTypeDataSource = MovieDetailTypeDatasource(detailTypeCollectionView)
    }
    
    func setInitialSelection() {
        detailTypeDelegate?.setInitialValue()
    }
    
    
    func setupUserReviewsTableView() {
        userReviewDelegate = UserReviewDelegate(tableView: reviewTableView, delegate: self)
        userReviewDataSource = UserReviewDataSource(tableView: reviewTableView)
    }
    
    func setupCastCollectionView() {
        castDelegate = CastDelegate(collectionView: castCollectionView)
        castDatasource = CastDatasource(collectView: castCollectionView)
    }
    
}

extension MovieDetailView: _MovieDetailTypeProtocol {
    func selectedType(_ detailType: MovieDetailTypeEnum) {
        switch detailType {
        case .about:
            enablePreview()
        case .trailer:
            enableTrailer()
        case .cast:
            enableCast()
        case .reviews:
            enableReviews()
        }
        selectDetailType?(detailType)
    }
    
    private func enablePreview() {
        overviewBackgroundView.isHidden = false
        trailerBackgroundView.isHidden = true
        reviewTableView.isHidden = true
        castCollectionView.isHidden = true
        disableScroll()
        pauseVideoIfNeeded()
    }
    
    private func enableTrailer() {
        overviewBackgroundView.isHidden = true
        trailerBackgroundView.isHidden = false
        reviewTableView.isHidden = true
        castCollectionView.isHidden = true
        disableScroll()
    }
    
    private func enableCast() {
        overviewBackgroundView.isHidden = true
        trailerBackgroundView.isHidden = true
        reviewTableView.isHidden = true
        castCollectionView.isHidden = false
        scrollView.isScrollEnabled = true
        pauseVideoIfNeeded()
    }
    
    private func enableReviews() {
        reviewTableView.showAnimatedGradientSkeleton()
        overviewBackgroundView.isHidden = true
        trailerBackgroundView.isHidden = true
        reviewTableView.isHidden = false
        castCollectionView.isHidden = true
        scrollView.isScrollEnabled = true
        pauseVideoIfNeeded()
    }
    
    private func disableScroll() {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentInset.top), animated: true)
        scrollView.isScrollEnabled = false
    }
    
    private func pauseVideoIfNeeded() {
        trailerView.playerState { [weak self] state, _ in
            switch state {
            case .playing:
                self?.trailerView.pauseVideo()
            default:
                return
            }
        }
    }
}

extension MovieDetailView: SelectReviewProtocol {
    func selectedReview(_ review: UserReview) {
        selectDetailReview?(review)
    }
}
