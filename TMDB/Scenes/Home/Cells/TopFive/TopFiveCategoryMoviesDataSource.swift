//
//  TopRatedMoviesDatasource.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import SkeletonView
import UIKit

final class TopFiveCategoryMoviesDataSource: NSObject {
    weak var collectionView: UICollectionView?
    var items: [Movie]
    
    typealias Cell = TopFiveCategoryMovieCollectionViewCell
    
    init(collectionView: UICollectionView,
         items: [Movie]) {
        self.collectionView = collectionView
        self.items = items
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView?.dataSource = self
    }
    
    func addMovies(_ movies: [Movie]) {
        items = movies
        collectionView?.reloadData()
    }
}

extension TopFiveCategoryMoviesDataSource: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Cell.reuseIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
        cell?.isSkeletonable = true
        cell?.showSkeleton()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.isEmpty ? 3 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let current = indexPath.row
        if items.indices.contains(current) {
            let movie = items[current]
            cell.setup(movie, current)
        }
        return cell
    }
}
