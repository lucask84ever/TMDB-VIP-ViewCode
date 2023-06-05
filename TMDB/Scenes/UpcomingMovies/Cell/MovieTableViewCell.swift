//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import SkeletonView
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "movieCell"
    
    lazy var moviePoster: ImageLoader = {
        let imageView = ImageLoader()
        imageView.layer.cornerRadius = 8
        imageView.isSkeletonable = true
        imageView.layer.shadowRadius = 8
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = ColorName.textColor.color
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrided cell methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        selectionStyle = .none
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePoster.image = nil
    }
    
    // MARK: - Custom methods
    func setup(movie: Movie) {
        movieTitle.text = movie.name
        moviePoster.getImage(ImageEndpoint.getImageUrl(movie.posterPath))
    }
    
}
// MARK: - LAYOUT
extension MovieTableViewCell: ViewcodeProtocol {
    // MARK: Layout methods
    func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    func buildViewHierarchy() {
        addSubview(movieTitle)
        addSubview(moviePoster)
    }
    
    func buildViewConstraints() {
        
        moviePoster.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.width.equalTo(140)
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        movieTitle.snp.makeConstraints {
            $0.top.equalTo(self.moviePoster)
            $0.right.equalToSuperview().offset(-8)
            $0.left.equalTo(moviePoster.snp.right).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
