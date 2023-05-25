//
//  UpcomingMoviesView.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import UIKit
import SnapKit

protocol UpcomingMoviesDelegate {
    func selectMovie(_ movieName: String)
}

final class UpcomingMoviesView: UIView {
    
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
            $0.edges.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = .white
    }
}

extension UpcomingMoviesView: UpcomingMoviesDelegate {
    func selectMovie(_ movieName: String) {
        print(movieName)
    }
}

// MARK: - Setup datasource
extension UpcomingMoviesView {
    func setupDatasource(_ list: [Movie]) {
        datasource = UpcomingMoviesDatasource(delegate: self, items: list, tableview: moviesTableview)
    }
}
