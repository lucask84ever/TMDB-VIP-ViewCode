//
//  UpcomingMoviesView.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import UIKit
import SnapKit

protocol UpcomingMoviesDelegate {
    func selectMovie(_ movie: Movie)
}

final class UpcomingMoviesView: UIView {
    
    var selectedMovie: ((Movie) -> Void)?
    
    let stack: UIStackView = {
        let stack = UIStackView()
        
        return stack
    }()
    // MARK: - Properties
    var datasource: UpcomingMoviesDatasource?
    private var movies: [Movie] = []
    // MARK: - View Items
    lazy var moviesTableview: UITableView = {
        let tableview = UITableView()
        tableview.separatorColor = .black
        return tableview
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        buildViewConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init coder is not implemented")
    }
}

// MARK: - ViewCode protocol
extension UpcomingMoviesView: ViewcodeProtocol {
    func buildViewHierarchy() {
        addSubview(moviesTableview)
    }
    
    func buildViewConstraints() {
        moviesTableview.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = .white
    }
}

extension UpcomingMoviesView: UpcomingMoviesDelegate {
    func selectMovie(_ movie: Movie) {
        selectedMovie?(movie)
    }
}

// MARK: - Setup datasource
extension UpcomingMoviesView {
    func setupDatasource(_ list: [Movie]) {
        datasource = UpcomingMoviesDatasource(delegate: self, items: list, tableview: moviesTableview)
    }
}
