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
        DispatchQueue.main.async { [weak self] in
            self?.items = movies
            self?.collectionView?.reloadData()
        }
    }
}

extension TopFiveCategoryMoviesDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
        cell.showAnimatedGradientSkeleton()
        return cell
    }
}
