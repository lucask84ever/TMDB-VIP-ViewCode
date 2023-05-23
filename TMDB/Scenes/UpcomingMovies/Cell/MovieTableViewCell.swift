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
    
    lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.isSkeletonable = true
        imageView.layer.shadowRadius = 8
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        moviePoster.image = nil
    }
    
    // MARK: - Custom methods
    func setup(movieName: String) {
        movieTitle.text = movieName
        moviePoster.showAnimatedSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.moviePoster.image = UIImage(named: "shrek")
            self?.moviePoster.hideSkeleton()
        })
    }
    
}
// MARK: - LAYOUT
extension MovieTableViewCell: ViewcodeProtocol {
    // MARK: Layout methods
    func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
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
            $0.centerX.equalToSuperview()
        }

        movieTitle.snp.makeConstraints {
            $0.top.equalTo(self.moviePoster.snp.bottom).offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.left.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}
