//
//  MovieWithDetailsDelegate.swift
//  TMDB
//
//  Created by Lucas on 25/06/23.
//

import Foundation
import UIKit

final class MovieWithDetailsDelegate: NSObject {
    typealias Cell = MovieWithDetailsTableViewCell
    private var tableView: UITableView
    private var delegate: SelectMoviesDelegate
    var items: [Movie]?
    
    init(tableView: UITableView, delegate: SelectMoviesDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        setupTableView()
    }
    
    func setItems(_ movies: [Movie]) {
        self.items = movies
    }
    
    private func setupTableView() {
        tableView.delegate = self
    }
}

extension MovieWithDetailsDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = indexPath.row
        
        if let item = items?[selected] {
            delegate.selectMovie(item)
        }
    }
}

