//
//  SearchMovieView.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import SnapKit
import UIKit

final class SearchMovieView: UIView {
    
    internal enum Layout {
        static let imageHeightAndWidth: CGFloat = 76
        static let searchTextfieldHeight: CGFloat = 42
        static let emptyListViewHeight: CGFloat = 190
        static let emptyListViewWidth: CGFloat = 252
        static let emptyListTitleHeight: CGFloat = 52
        static let emptyListSubTitleHeight: CGFloat = 38
        static let margins: CGFloat = 16
        static let spaceInStackView: CGFloat = 8
    }
    
    internal enum Constants {
        static let emptyTitleNumberOfLines: Int = 2
        static let emptySubtitleNumberOfLines: Int = 2
        static let emptyTitleFontSize: CGFloat = 16
        static let emptySubtitleFontSize: CGFloat = 12
        
        static let emptyListImageName: String = "emptyListImage"
    }
    
    var searchMovieAction: ((String) -> Void)?
    var listSearchableMovieDelegate: MovieWithDetailsDelegate?
    var listSearchableMovieDatasource: MovieWithDetailsDatasource?
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.backgroundColor.color
        return view
    }()
    
    private lazy var searchTextfield: CustomTextfield = {
        let textfield = CustomTextfield()
        textfield.setupSearch()
        textfield.addTarget(self, action: #selector(returnPressed), for: .editingDidEndOnExit)
        textfield.searchAction = { [weak self] textToSearch in
            self?.searchMovieAction?(textToSearch)
        }
        return textfield
    }()
    
    private lazy var listSearchableTableview: ContentSizeTableView = {
        let tableView = ContentSizeTableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = ColorName.backgroundColor.color
        return tableView
    }()
    
    private lazy var emptyListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Layout.spaceInStackView
        stackView.isHidden = true
        return stackView
    }()
    
    private lazy var emptyListImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: Constants.emptyListImageName)
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var emptyListTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = Constants.emptyTitleNumberOfLines
        label.text = TMDBStrings.Search.EmptyList.title
        label.font = FontFamily.Montserrat.semiBold.font(size: Constants.emptyTitleFontSize)
        return label
    }()
    
    private lazy var emptyListSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.subtitleColor.color
        label.textAlignment = .center
        label.numberOfLines = Constants.emptySubtitleNumberOfLines
        label.font = FontFamily.Montserrat.medium.font(size: Constants.emptySubtitleFontSize)
        label.text = TMDBStrings.Search.EmptyList.subTitle
        return label
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewLayout()
        setupListSearchableMoviesTableView()
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMovieView {
    @objc
    func returnPressed() {
        if let searchableText = searchTextfield.text {
            searchMovieAction?(searchableText)
        }
        searchTextfield.resignFirstResponder()
    }
    
    func setupListSearchableMoviesTableView() {
        listSearchableMovieDelegate = MovieWithDetailsDelegate(tableView: listSearchableTableview)
        listSearchableMovieDatasource = MovieWithDetailsDatasource(tableView: listSearchableTableview)
    }
    
    func setMovies(_ movies: [Movie]) {
        if !movies.isEmpty {
            DispatchQueue.main.async { [weak self] in
                self?.emptyListStackView.isHidden = true
                self?.listSearchableTableview.isHidden = false
            }
            listSearchableMovieDelegate?.setItems(movies)
            listSearchableMovieDatasource?.setItems(movies)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.emptyListStackView.isHidden = false
                self?.listSearchableTableview.isHidden = true
            }
        }
    }
}

extension SearchMovieView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(listSearchableTableview)
        contentView.addSubview(searchTextfield)
        contentView.addSubview(emptyListStackView)
        emptyListStackView.addArrangedSubview(emptyListImage)
        emptyListStackView.addArrangedSubview(emptyListTitle)
        emptyListStackView.addArrangedSubview(emptyListSubtitle)
        
        contentView.addSubview(listSearchableTableview)
    }
    
    func buildViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.width.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(safeAreaLayoutGuide)
            $0.height.equalTo(safeAreaLayoutGuide).priority(.low)
        }
        
        searchTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Layout.margins)
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
        
        listSearchableTableview.snp.makeConstraints {
            $0.top.equalTo(searchTextfield.snp.bottom).offset(Layout.margins)
            $0.leading.equalToSuperview().offset(Layout.margins)
            $0.trailing.equalToSuperview().inset(Layout.margins)
            $0.bottom.equalToSuperview().inset(Layout.margins)
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
