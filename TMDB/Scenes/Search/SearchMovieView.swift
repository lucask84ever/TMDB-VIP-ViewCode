//
//  SearchMovieView.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import SnapKit
import UIKit

final class SearchMovieView: UIView {
    var searchMovieAction: ((String) -> Void)?
    
    internal enum Layout {
        static let imageHeightAndWidth: CGFloat = 76
        static let searchTextfieldHeight: CGFloat = 42
        static let emptyListViewHeight: CGFloat = 190
        static let emptyListViewWidth: CGFloat = 252
        static let emptyListTitleHeight: CGFloat = 52
        static let emptyListSubTitleHeight: CGFloat = 38
        static let margins: CGFloat = 16
    }
    
    lazy var searchTextfield: CustomTextfield = {
        let textfield = CustomTextfield()
        textfield.setupSearch()
        return textfield
    }()
    
    lazy var emptyListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var emptyListImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "empty")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    lazy var emptyListTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = TMDBStrings.Search.EmptyList.title
        label.font = FontFamily.Montserrat.semiBold.font(size: 16)
        return label
    }()
    
    lazy var emptyListSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.subtitleColor.color
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = FontFamily.Montserrat.medium.font(size: 12)
        label.text = TMDBStrings.Search.EmptyList.subTitle
        return label
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMovieView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(searchTextfield)
        addSubview(emptyListStackView)
        emptyListStackView.addArrangedSubview(emptyListImage)
        emptyListStackView.addArrangedSubview(emptyListTitle)
        emptyListStackView.addArrangedSubview(emptyListSubtitle)
    }
    
    func buildViewConstraints() {
        searchTextfield.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Layout.margins)
            $0.leading.equalToSuperview().offset(Layout.margins)
            $0.trailing.equalToSuperview().inset(Layout.margins)
            $0.height.equalTo(Layout.searchTextfieldHeight)
        }
        
        emptyListStackView.snp.makeConstraints {
            $0.width.equalTo(Layout.emptyListViewWidth)
            $0.center.equalToSuperview()
        }
        
        emptyListImage.snp.makeConstraints {
            $0.height.equalTo(Layout.imageHeightAndWidth)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
