//
//  DetailMovieDatasource.swift
//  TMDB
//
//  Created by Lucas on 16/06/23.
//

import UIKit

final class DetailMovieDatasource: NSObject {
    typealias Cell = TypeListCollectionViewCell
    var collectionView: UICollectionView
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
}

extension DetailMovieDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieDetailTypeEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let selected = indexPath.row
        let option = MovieDetailTypeEnum.allCases[selected]
        cell.setup(option)
        return cell
    }
}
