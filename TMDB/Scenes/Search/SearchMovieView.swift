//
//  SearchMovieView.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

final class SearchMovieView: UIView {
    
    internal enum LayoutContraints {
        static let imageHeightAndWidth: CGFloat = 76
    }
    
    lazy var emptyListImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "empty")
        return imageview
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
}

extension SearchMovieView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(emptyListImage)
    }
    
    func buildViewConstraints() {
        emptyListImage.snp.makeConstraints {
            $0.height.width.equalTo(LayoutContraints.imageHeightAndWidth)
            $0.center.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
