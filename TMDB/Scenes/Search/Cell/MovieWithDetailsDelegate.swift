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
    var items: [Movie]?
    
    init(tableView: UITableView) {
        self.tableView = tableView
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
            print(item)
        }
    }
}

