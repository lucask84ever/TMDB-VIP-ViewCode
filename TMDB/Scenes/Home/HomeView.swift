//
//  HomeView.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

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
    }
    
    var topRatedDataSource: TopRatedMoviesDataSource?
    var topRatedDelegate: TopRatedMoviesDelegate?
    
    var typeMovieListDelegate: TypeListDelegate?
    var typeMovieListDataSource: TypeListDataSource?
    
    var bottomMoviesDelegate: TypeMovieDelegate?
    var bottomMoviesDataSource: TypeMovieDataSource?
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var wantToWatchLabel: UILabel = {
        let label = UILabel()
        label.text = TMDBStrings.Home.Label.wantToWatch
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var searchMovieTextfield: CustomTextfield = {
        let textfield = CustomTextfield()
        if let image = UIImage(named: "search"), let ciImage = CIImage(image: image) {
            
            let lensImage = UIImageView(image: image)
            lensImage.tintColor = ColorName.textfieldTextIcon.color
            lensImage.transform = CGAffineTransform(scaleX: -1, y: 1)
            textfield.rightView = lensImage
            
            textfield.rightViewMode = .always
        }
        textfield.layer.cornerRadius = LayoutConstants.cornerRadius
        textfield.textColor = ColorName.textfieldTextIcon.color
        let attributedPlaceholder = NSAttributedString(string: TMDBStrings.Home.Textfield.searchPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.textfieldTextIcon.color])
        textfield.attributedPlaceholder = attributedPlaceholder
        textfield.backgroundColor = ColorName.textfieldBackground.color
        textfield.leftView = UIView()
        textfield.leftViewMode = .always
        return textfield
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
    
    private func setupTopRatedCollectionView(_ movies: [Movie]) {
        topRatedDataSource = TopRatedMoviesDataSource(collectionView: topMoviesCollectionView, items: movies)
        
        topRatedDelegate = TopRatedMoviesDelegate(collectionView: topMoviesCollectionView, delegate: self, items: movies)
        DispatchQueue.main.async { [weak self] in
            self?.topMoviesCollectionView.delegate = self?.topRatedDelegate
            self?.topMoviesCollectionView.dataSource = self?.topRatedDataSource
            self?.topMoviesCollectionView.reloadData()
            self?.bottomMoviesDataSource?.updateMovieType(movies)
        }
    }
    
    private func setupTypeMovieLayout() {
        typeMovieListDelegate = TypeListDelegate(collectionView: moviesListCollectionView, delegate: self)
        typeMovieListDataSource = TypeListDataSource(collectionView: moviesListCollectionView)
        moviesListCollectionView.reloadData()
    }
    
    private func setupBottomMoviesCollectionView() {
        bottomMoviesDelegate = TypeMovieDelegate(items: [], collectionView: bottomMoviesCollectionView)
        bottomMoviesDataSource = TypeMovieDataSource(items: [], collectionView: bottomMoviesCollectionView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
}

extension HomeView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wantToWatchLabel)
        contentView.addSubview(searchMovieTextfield)
        contentView.addSubview(topMoviesCollectionView)
        contentView.addSubview(moviesListCollectionView)
        contentView.addSubview(bottomMoviesCollectionView)
    }
    
    func buildViewConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        wantToWatchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(LayoutConstants.labelHeight)
        }
        
        searchMovieTextfield.snp.makeConstraints {
            $0.leading.trailing.equalTo(wantToWatchLabel)
            $0.height.equalTo(LayoutConstants.textfieldHeight)
            $0.top.equalTo(wantToWatchLabel.snp.bottom).offset(LayoutConstants.baseDistance)
        }

        topMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchMovieTextfield.snp.bottom).offset(LayoutConstants.baseDistance)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(LayoutConstants.topTableViewHeight)
        }

        moviesListCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(searchMovieTextfield)
            $0.height.equalTo(LayoutConstants.movieListHeight)
            $0.top.equalTo(topMoviesCollectionView.snp.bottom).offset(LayoutConstants.baseDistance)
        }
        
        bottomMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(moviesListCollectionView.snp.bottom).offset(LayoutConstants.baseDistance)
            $0.leading.trailing.equalTo(moviesListCollectionView)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
    
    func remakeMovieListConstraints() {
        if let totalHeight = bottomMoviesDelegate?.getTotalHeight() {
            bottomMoviesCollectionView.snp.remakeConstraints {
                $0.top.equalTo(moviesListCollectionView.snp.bottom).offset(LayoutConstants.baseDistance)
                $0.leading.trailing.equalTo(moviesListCollectionView)
                $0.height.equalTo(totalHeight)
                $0.bottom.equalToSuperview()
            }
        }
    }
}

extension HomeView {
    func setInitialSelection() {
        typeMovieListDelegate?.setInitialValue()
    }
}

extension HomeView {
    func setTopRated(_ movies: [Movie]) {
        setupTopRatedCollectionView(movies)
    }
}

extension HomeView: HomeTopRatedMoviesDelegate {
    func selectMovie(_ movie: Movie) {
        print(movie.name)
    }
}

extension HomeView: HomeMovieListDelegate {
    func selectedType(_ listType: TypeListEnum) {
        print(listType.text)
    }
}
