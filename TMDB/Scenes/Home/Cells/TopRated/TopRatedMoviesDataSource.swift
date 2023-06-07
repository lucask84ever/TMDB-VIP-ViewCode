//
//  TopRatedMoviesDatasource.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import UIKit

final class TopRatedMoviesDataSource: NSObject {
    weak var collectionView: UICollectionView?
    var items: [Movie]
    
    typealias Cell = TopRatedCollectionViewCell
    
    init(collectionView: UICollectionView,
         items: [Movie]) {
        self.collectionView = collectionView
        self.items = items
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
            self?.collectionView?.reloadData()
        }
    }
}

extension TopRatedMoviesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        let current = indexPath.row
        let movie = items[current]
        cell.setup(movie, current)
        return cell
    }
}
