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
        static let topTableViewHeight: CGFloat = 250
        static let topRatedSpaceBetweenCell: CGFloat = 32
    }
    
    var topRatedDataSource: TopRatedMoviesDatasource?
    var topRatedDelegate: TopRatedMoviesDelegate?
    
    private lazy var wantToWatchLabel: UILabel = {
        let label = UILabel()
        label.text = TMDBStrings.Home.Label.wantToWatch
        label.textColor = ColorName.textColor.color
        return label
    }()
    
    private lazy var searchMovieTextfield: CustomTextfield = {
        let textfield = CustomTextfield()
        let lensImage = UIImageView(image: UIImage(named: "search"))
        textfield.layer.cornerRadius = 16
        lensImage.tintColor = ColorName.textfieldTextIcon.color
        textfield.textColor = ColorName.textfieldTextIcon.color
        let attributedPlaceholder = NSAttributedString(string: TMDBStrings.Home.Textfield.searchPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor: ColorName.textfieldTextIcon.color])
        textfield.attributedPlaceholder = attributedPlaceholder
        textfield.backgroundColor = ColorName.textfieldBackground.color
        textfield.leftView = UIView()
        textfield.leftViewMode = .always
        textfield.rightView = lensImage
        textfield.rightViewMode = .always
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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
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
        topRatedDataSource = TopRatedMoviesDatasource(collectionView: topMoviesCollectionView, items: movies)
        
        topRatedDelegate = TopRatedMoviesDelegate(collectionView: topMoviesCollectionView, delegate: self, items: movies)
        DispatchQueue.main.async { [weak self] in
            self?.topMoviesCollectionView.delegate = self?.topRatedDelegate
            self?.topMoviesCollectionView.dataSource = self?.topRatedDataSource
            self?.topMoviesCollectionView.reloadData()
        }
    }
}

extension HomeView: ViewcodeProtocol {
    func buildViewHierarchy() {
        addSubview(wantToWatchLabel)
        addSubview(searchMovieTextfield)
        addSubview(topMoviesCollectionView)
    }
    
    func buildViewConstraints() {
        wantToWatchLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
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
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(touchOutside))
        self.addGestureRecognizer(tapOutside)
    }
    
    @objc
    private func touchOutside() {
        endEditing(true)
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
