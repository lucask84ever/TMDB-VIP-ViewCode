//
//  DetailMovieView.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import UIKit

class DetailMovieView: UIView {
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
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
        return stack
    }()
    
    lazy var posterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
}

extension DetailMovieView: ViewcodeProtocol {
    func buildViewHierarchy() {
        addSubview(scrollview)
        scrollview.addSubview(contentView)
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(posterUIImageView)
        contentStack.addArrangedSubview(movieOverviewLabel)
        contentStack.addArrangedSubview(UIView())
    }
    
    func buildViewConstraints() {
        scrollview.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        posterUIImageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        movieOverviewLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
    }
    
    func additionalConfig() {
        backgroundColor = .white
    }
}

// MARK: - View
extension DetailMovieView {
    func updateOverview(_ overview: String) {
        movieOverviewLabel.text = overview
    }
    
    func updateMoviePoster(_ imageData: Data?) {
        if let imageData = imageData {
            posterUIImageView.image = UIImage(data: imageData)
        }
    }
}
