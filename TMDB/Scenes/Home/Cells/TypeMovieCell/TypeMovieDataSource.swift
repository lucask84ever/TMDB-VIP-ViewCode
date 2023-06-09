//
//  TypeMovieDataSource.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import UIKit

final class TypeMovieDataSource: NSObject {
    private var items: [Movie]
    private weak var collectionView: UICollectionView?
    
    typealias Cell = TypeMovieCollectionViewCell
    
    init(items: [Movie], collectionView: UICollectionView?) {
        self.collectionView = collectionView
        self.items = items
        super.init()
        setupCollectionView()
    }
    
    func updateMovieType(_ movies: [Movie]) {
        items.removeAll()
        items.append(contentsOf: movies)
        collectionView?.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        self.collectionView?.dataSource = self
    }
}

extension TypeMovieDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return Cell()
        }
        let currentIndex = indexPath.row
        let currentMoviePoster = items[currentIndex].posterPath
        cell.setupPoster(currentMoviePoster)
        return cell
    }
}
