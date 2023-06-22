//
//  UserReviewDataSource.swift
//  TMDB
//
//  Created by Lucas on 19/06/23.
//

import UIKit

class UserReviewDataSource: NSObject {
    
    typealias Cell = UserReviewTableViewCell
    
    private var items: [UserReview] = []
    var expandedIndexSet: IndexSet? = []
    
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    func setItems(_ items: [UserReview]) {
        self.items = items
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
}

extension UserReviewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        
        if items.indices.contains(indexPath.row) {
            cell.setupCell(items[indexPath.row])
        }
        
        return cell
    }
}
