//
//  TypeListDataSource.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import UIKit

final class TypeListDataSource: NSObject {
    var collectionView: UICollectionView?
    
    typealias Cell = TypeListCollectionViewCell
    
    init(collectionView: UICollectionView? = nil) {
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView?.dataSource = self
    }
}

extension TypeListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypeListEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let currentIndex = indexPath.row
        let currentType = TypeListEnum.allCases[currentIndex]
        cell.setup(currentType)
        return cell
    }
}
