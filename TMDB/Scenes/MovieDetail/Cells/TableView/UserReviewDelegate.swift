//
//  UserReviewDelegate.swift
//  TMDB
//
//  Created by Lucas on 19/06/23.
//

import UIKit

class UserReviewDelegate: NSObject {
    typealias Cell = UserReviewTableViewCell
    var expandedIndexSet: IndexSet? = []
    private var tableView: UITableView
    var delegate: SelectReviewProtocol
    
    private var items: [UserReview]?
    
    init(tableView: UITableView, delegate: SelectReviewProtocol) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        self.tableView.delegate = self
    }
    
    func setItems(_ items: [UserReview]) {
        self.items = items
    }
    
    func setInitialValue() {
        
    }
}

extension UserReviewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        if let review = items?[selectedIndex] {
            delegate.selectedReview(review)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
