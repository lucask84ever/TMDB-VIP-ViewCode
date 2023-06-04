//
//  UpcomingMoviesDatasource.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation
import UIKit

final class UpcomingMoviesDatasource: NSObject, Datasource {
    // MARK: - Typealias
    typealias Items = [Movie]
    typealias Delegate = UpcomingMoviesDelegate
    
    // MARK: - Properties
    var delegate: UpcomingMoviesDelegate
    var items: [Movie]
    var tableview: UITableView
    
    // MARK: - Init
    init(delegate: UpcomingMoviesDelegate, items: [Movie], tableview: UITableView) {
        self.delegate = delegate
        self.items = items
        self.tableview = tableview
        super.init()
        setupTableView()
    }
    
    // MARK: - RegisterTableView
    func setupTableView() {
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
    }
}

// MARK: - Tableview datasource extension
extension UpcomingMoviesDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.setup(movie: items[indexPath.row])
        return cell
    }
}

// MARK: - Tableview delegate extension
extension UpcomingMoviesDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        if items.indices.contains(selectedIndex) {
            delegate.selectMovie(items[selectedIndex])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
