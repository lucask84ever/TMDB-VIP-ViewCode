//
//  HomeView.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import SkeletonView
import SnapKit
import UIKit

final class HomeView: UIView {
    internal enum LayoutConstants {
        static let labelHeight: CGFloat = 28
        static let textfieldHeight: CGFloat = 48
        static let baseDistance: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let topTableViewHeight: CGFloat = 250
        static let topRatedSpaceBetweenCell: CGFloat = 32
        static let movieListHeight: CGFloat = 42
        static let minimunDistance: CGFloat = 8
    }
    // MARK: Properties
    var topRatedDataSource: TopFiveCategoryMoviesDataSource?
    var topRatedDelegate: TopFiveCategoryMovieDelegate?
    
    var typeMovieListDelegate: TypeListDelegate?
    var typeMovieListDataSource: TypeListDataSource?
    
    var bottomMoviesDelegate: TypeMovieDelegate?
    var bottomMoviesDataSource: TypeMovieDataSource?
    
    var typeMovies = Dictionary<TypeListEnum, [Movie]>()
    var selectedCategory: TypeListEnum? = nil
    
    // MARK: Actions
    var changeListType: ((TypeListEnum) -> Void)?
    var selectMovie: ((Movie) -> Void)?
    
    // MARK: UIElements
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var wantToWatchLabel: UILabel = {
        let label = UILabel()
        label.text = TMDBStrings.Home.Label.wantToWatch
        label.font = FontFamily.Poppins.semiBold.font(size: 18)
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var topMoviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = ColorName.backgroundColor.color
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var moviesListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = ColorName.backgroundColor.color
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var bottomMoviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = ColorName.backgroundColor.color
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTypeMovieLayout()
        setupBottomMoviesCollectionView()
        setupTopRatedCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    private func setupTopRatedCollectionView() {
        topRatedDataSource = TopFiveCategoryMoviesDataSource(collectionView: topMoviesCollectionView, items: [])
        topRatedDelegate = TopFiveCategoryMovieDelegate(collectionView: topMoviesCollectionView, delegate: self)
    }
    
    private func setupTypeMovieLayout() {
        typeMovieListDelegate = TypeListDelegate(collectionView: moviesListCollectionView, delegate: self)
        typeMovieListDataSource = TypeListDataSource(collectionView: moviesListCollectionView)
    }
    
    private func setupBottomMoviesCollectionView() {
        bottomMoviesDelegate = TypeMovieDelegate(items: [], collectionView: bottomMoviesCollectionView, delegate: self)
        bottomMoviesDataSource = TypeMovieDataSource(items: [], collectionView: bottomMoviesCollectionView)
        
    }
    
    private func addMoviesTop5(_ movies: [Movie]) {
        topRatedDataSource?.addMovies(movies)
        topRatedDelegate?.addMovies(movies)
    }
    
    private func addMoviesBottomCollection(_ movies: [Movie]) {
        bottomMoviesDataSource?.updateMovieType(movies)
        bottomMoviesDelegate?.addMovies(movies)
        DispatchQueue.main.async { [weak self] in
            self?.remakeMovieListConstraints()
        }
    }
}

extension HomeView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wantToWatchLabel)
        contentView.addSubview(topMoviesCollectionView)
        contentView.addSubview(moviesListCollectionView)
        contentView.addSubview(bottomMoviesCollectionView)
    }
    
    func buildViewConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.width.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        wantToWatchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(LayoutConstants.minimunDistance)
            $0.leading.equalToSuperview().offset(LayoutConstants.baseDistance)
            $0.trailing.equalToSuperview().inset(LayoutConstants.baseDistance)
            $0.height.equalTo(LayoutConstants.labelHeight)
        }

        topMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(wantToWatchLabel.snp.bottom).offset(LayoutConstants.baseDistance)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(LayoutConstants.topTableViewHeight)
        }

        moviesListCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(wantToWatchLabel)
            $0.height.equalTo(LayoutConstants.movieListHeight)
            $0.top.equalTo(topMoviesCollectionView.snp.bottom)
        }
        
        bottomMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(moviesListCollectionView.snp.bottom).offset(LayoutConstants.baseDistance)
            $0.leading.trailing.equalTo(moviesListCollectionView)
            $0.bottom.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        topMoviesCollectionView.isSkeletonable = true
    }
    
    func remakeMovieListConstraints() {
        if let totalHeight = bottomMoviesDelegate?.getTotalHeight() {
            bottomMoviesCollectionView.snp.remakeConstraints {
                $0.top.equalTo(moviesListCollectionView.snp.bottom).offset(LayoutConstants.baseDistance)
                $0.leading.trailing.equalTo(moviesListCollectionView)
                $0.height.equalTo(totalHeight).priority(.high)
                $0.bottom.equalToSuperview().inset(LayoutConstants.minimunDistance)
            }
        }
    }
}

extension HomeView {
    func setInitialSelection() {
        if selectedCategory == nil {
            typeMovieListDelegate?.setInitialValue()
        }
    }
}

extension HomeView {
    func setTopRated(_ movies: [Movie]) {
        typeMovies[.topRated] = movies
        addMoviesTop5(movies)
        addMoviesBottomCollection(movies)
    }
    
    func setPopular(_ movies: [Movie]) {
        typeMovies[.popular] = movies
        addMoviesTop5(movies)
        addMoviesBottomCollection(movies)
    }
    
    func setNowPlaying(_ movies: [Movie]) {
        typeMovies[.nowPlaying] = movies
        addMoviesTop5(movies)
        addMoviesBottomCollection(movies)
    }
    
    func setUpcoming(_ movies: [Movie]) {
        typeMovies[.upcoming] = movies
        addMoviesTop5(movies)
        addMoviesBottomCollection(movies)
    }
}

extension HomeView: SelectMoviesDelegate {
    func selectMovie(_ movie: Movie) {
        selectMovie?(movie)
    }
}

extension HomeView: HomeMovieListDelegate {
    func selectedType(_ listType: TypeListEnum) {
        scrollToInit()
        selectedCategory = listType
        guard let movies = typeMovies[listType], !movies.isEmpty else {
            changeListType?(listType)
            return
        }
        topRatedDelegate?.addMovies(movies)
        topRatedDataSource?.addMovies(movies)
        addMoviesBottomCollection(movies)
    }
    
    private func scrollToInit() {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentInset.top), animated: true)
        topMoviesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
}
