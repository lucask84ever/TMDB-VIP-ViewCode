
//
//  DetailMovieView.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import UIKit
import youtube_ios_player_helper

class DetailMovieView: UIView {
    // MARK: UIElements
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    lazy var dropImageBackground: ImageLoader = {
        let imageView = ImageLoader()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.startSkeletonAnimation()
        return imageView
    }()
    
    lazy var posterUIImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.startSkeletonAnimation()
        return imageView
    }()
    
    lazy var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.textColor.color
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .justified
        label.sizeToFit()
        return label
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.textColor.color
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        return label
    }()
    
    lazy var youtubeEmbededView: YTPlayerView = {
        let youtubeView = YTPlayerView(frame: .zero)
        youtubeView.translatesAutoresizingMaskIntoConstraints = false
        youtubeView.contentMode = .scaleAspectFit
        return youtubeView
    }()
    
    lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = ColorName.textColor.color
        imageView.image = UIImage(named: "calendar")
        return imageView
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorName.textColor.color
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init coder is not implemented")
    }
}

extension DetailMovieView: ViewcodeProtocol {
    func buildViewHierarchy() {
        
        contentView.addSubview(youtubeEmbededView)
        contentView.addSubview(movieOverviewLabel)
        contentView.addSubview(dropImageBackground)
        contentView.addSubview(posterUIImageView)
        contentView.addSubview(calendarImageView)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(movieTitleLabel)
        scrollview.addSubview(contentView)
        addSubview(scrollview)
    }
    
    func buildViewConstraints() {
        
        scrollview.snp.makeConstraints {
            $0.bottom.top.equalTo(self.safeAreaLayoutGuide)
            $0.width.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(600).priority(.required)
        }
        
        dropImageBackground.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        
        posterUIImageView.snp.makeConstraints {
            $0.left.equalTo(dropImageBackground).inset(32)
            $0.top.equalTo(dropImageBackground.snp.bottom).inset(64)
            $0.height.equalTo(180)
            $0.width.equalTo(136)
        }
        
        calendarImageView.snp.makeConstraints {
            $0.top.equalTo(posterUIImageView.snp.bottom).offset(16)
            $0.left.equalTo(posterUIImageView)
            $0.width.height.equalTo(16)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(calendarImageView)
            $0.left.equalTo(calendarImageView.snp.right).offset(4)
        }
        
        movieOverviewLabel.snp.makeConstraints {
            $0.left.right.equalTo(dropImageBackground)
            $0.top.equalTo(self.calendarImageView.snp.bottom).offset(16)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dropImageBackground.snp.bottom).offset(8)
            $0.left.equalTo(posterUIImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalTo(posterUIImageView)
        }
    }
    
    func additionalConfig() {
        contentView.backgroundColor = ColorName.backgroundColor.color
    }
}

// MARK: - View
extension DetailMovieView {
    func updateOverview(_ overview: String) {
        movieOverviewLabel.text = overview
    }
    
    func updateMoviePoster(_ imageData: Data?) {
        if let imageData = imageData {
            dropImageBackground.image = UIImage(data: imageData)
        }
    }
    
    func setupMovieTrailer(_ trailer: VideosResponse) {
        DispatchQueue.main.async {
            self.youtubeEmbededView.isHidden = trailer.videos.isEmpty
            guard let ptBRTrailer = trailer.videos.filter ({ $0.idiom == "pt-BR" }).first else {
                if let first = trailer.videos.first {
                    self.youtubeEmbededView.load(withVideoId: first.urlEnd)
                }
                return
            }
            self.youtubeEmbededView.load(withVideoId: ptBRTrailer.urlEnd)
        }
    }
    
    func setImageBackdrop(_ backdropImageUrl: String) {
        dropImageBackground.getImage(ImageEndpoint(path: backdropImageUrl))
    }
    
    func setOverview(_ overview: String) {
        movieOverviewLabel.text = overview
    }
    
    func setPosterImage(_ posterImageUrl: String) {
        posterUIImageView.getImage(ImageEndpoint(path: posterImageUrl))
    }
    
    func setMovieTitle(_ movieTitle: String) {
        movieTitleLabel.text = movieTitle
    }
    
    
    func setMovieReleaseYear(_ releaseYear: String) {
        releaseDateLabel.text = releaseYear
    }
}
