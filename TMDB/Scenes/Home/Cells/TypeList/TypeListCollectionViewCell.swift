//
//  MovieListCollectionViewCell.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import UIKit

enum TypeListEnum: CaseIterable {
    case nowPlaying
    case upcoming
    case topRated
    case popular
    
    var text: String {
        switch self {
        case .nowPlaying:
            return TMDBStrings.Home.ListMovie.nowPlaying
        case .upcoming:
            return TMDBStrings.Home.ListMovie.upcoming
        case .topRated:
            return TMDBStrings.Home.ListMovie.topRated
        case .popular:
            return TMDBStrings.Home.ListMovie.popular
        }
    }
}

final class TypeListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "typeMovieList"
    
    override var isSelected: Bool {
        didSet {
            selectionLine.isHidden = !isSelected
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textColor.color
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var selectionLine: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.textfieldBackground.color
        view.isHidden = true
        return view
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
    
    // MARK: Custom methods
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
    }
    
    func setup(_ type: TypeListEnum) {
        textLabel.text = type.text
    }
}

extension TypeListCollectionViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(textLabel)
        addSubview(selectionLine)
    }
    
    func buildViewConstraints() {
        textLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        selectionLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(4)
        }
    }
}
