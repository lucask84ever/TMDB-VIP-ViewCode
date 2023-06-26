//
//  MovieWithDetailsDatasource.swift
//  TMDB
//
//  Created by Lucas on 25/06/23.
//

import Foundation
import UIKit

final class MovieWithDetailsDatasource: NSObject {
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
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.dataSource = self
    }
}

extension MovieWithDetailsDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let selected = indexPath.row
        if let item = items?[selected] {
            cell.setup(item)
        }
        return cell
    }
}
