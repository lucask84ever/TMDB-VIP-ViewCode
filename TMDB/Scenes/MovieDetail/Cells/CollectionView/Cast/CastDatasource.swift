//
//  CastDatasource.swift
//  TMDB
//
//  Created by Lucas on 23/06/23.
//

import Foundation
import UIKit

final class CastDatasource: NSObject {
    private typealias Cell = CastCollectionViewCell
    private let collectView: UICollectionView
    
    var items: [Cast] = []
    
    init(collectView: UICollectionView) {
        self.collectView = collectView
        super.init()
        setupCollectionView()
    }
    
    func setItems(_ items: [Cast]) {
        self.items = items
        collectView.reloadData()
    }
    
    private func setupCollectionView() {
        collectView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectView.dataSource = self
    }
}

extension CastDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count > 30 ? 30 : items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let item = items[indexPath.row]
        cell.setName(item.name)
        cell.setPhotoPath(item.imagePath ?? "")
        return cell
    }
}
