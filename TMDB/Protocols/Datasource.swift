//
//  Datasource.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation
import UIKit

protocol Datasource {
    associatedtype Items: Collection
    associatedtype Delegate
    var items: Items { get set }
    var tableview: UITableView { get set }
    var delegate: Delegate { get set }
    
    func setupTableView()
}
