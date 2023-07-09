//
//  MovieWithDetailsTableViewCell.swift
//  TMDB
//
//  Created by Lucas on 25/06/23.
//

import SkeletonView
import SnapKit
import UIKit

class MovieWithDetailsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MovieWithDetailsTableViewCell.self)
    
    internal enum Layout {
        static let posterCornerRadius: CGFloat = 16
        static let posterSkeletonCornerRadius: Float = 16
        static let movieDetailsLabelHeight: CGFloat = 18
        static let titleFontSize: CGFloat = 16
        static let detailsFontSize: CGFloat = 12
        static let iconHeightAndWidth: CGFloat = 18
        static let posterWidth: CGFloat = 95
        static let posterHeight: CGFloat = 120
    }
    
    internal enum Constants {
        static let titleNumberOfLines: Int = 2
        static let starImage: String = "star"
        static let calendarImage: String = "calendar"
        static let ticketImage: String = "ticket"
    }
    
    // MARK: Views
    private lazy var posterImageLoader: ImageLoader = {
        let imageLoader = ImageLoader()
        imageLoader.layer.masksToBounds = true
        imageLoader.layer.cornerRadius = Layout.posterCornerRadius
        imageLoader.skeletonCornerRadius = Layout.posterSkeletonCornerRadius
        imageLoader.showAnimatedGradientSkeleton()
        return imageLoader
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Poppins.regular.font(size: Layout.titleFontSize)
        label.numberOfLines = Constants.titleNumberOfLines
        label.textColor = .white
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.starImage)
        return imageView
    }()
    
    private lazy var averageNoteLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Poppins.regular.font(size: Layout.detailsFontSize)
        label.textColor = .white
        return label
    }()
    
    private lazy var ticketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.ticketImage)
        return imageView
    }()
    
    private lazy var mainGenreLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Poppins.regular.font(size: Layout.detailsFontSize)
        label.textColor = .white
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.calendarImage)
        return imageView
    }()
    
    private lazy var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Poppins.regular.font(size: Layout.detailsFontSize)
        label.textColor = .white
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageLoader.image = nil
    }
}

extension MovieWithDetailsTableViewCell {
    func setup(_ movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            if let posterPath = movie.posterPath {
                let imageEndpoint = ImageEndpoint(path: posterPath)
                self?.posterImageLoader.getImage(imageEndpoint)
            }
            self?.movieTitleLabel.text = movie.name
            self?.averageNoteLabel.text = TMDBStrings.Search.Cell.averageNoteFormat(movie.averageNote)
            self?.mainGenreLabel.text = movie.genres.description
        }
    }
}

extension MovieWithDetailsTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(posterImageLoader)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(averageNoteLabel)
    }
    
    func buildViewConstraints() {
        posterImageLoader.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.height.equalTo(Layout.posterHeight)
            $0.width.equalTo(Layout.posterWidth)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageLoader.snp.trailing).offset(8)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
        
        starImageView.snp.makeConstraints {
            $0.width.height.equalTo(Layout.iconHeightAndWidth)
            $0.leading.equalTo(movieTitleLabel)
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
        }
        
        averageNoteLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.height.equalTo(Layout.movieDetailsLabelHeight)
            $0.leading.equalTo(starImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
