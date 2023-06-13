//
//  TopRatedCollectionViewDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import UIKit

final class TopFiveCategoryMovieDelegate: NSObject {
    
    internal enum Layout {
        static let cellWidth: CGFloat = 144
        static let cellHeight: CGFloat = 190
        static let spaceBetweenCell: CGFloat = 32
        static let insetSpacing: CGFloat = 16
        static let zero: CGFloat = 0
    }
    
    var collectionView: UICollectionView?
    var delegate: HomeTopRatedMoviesDelegate
    var items: [Movie]?
    
    init(collectionView: UICollectionView,
         delegate: HomeTopRatedMoviesDelegate) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView?.delegate = self
    }
    
    func addMovies(_ movies: [Movie]) {
        items = movies
    }
}

extension TopFiveCategoryMovieDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = indexPath.row
        if let contains = items?.indices.contains(selectedItem), contains, let selectedMovie = items?[selectedItem] {
            delegate.selectMovie(selectedMovie)
        }
    }
}

extension TopFiveCategoryMovieDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Layout.cellWidth, height: Layout.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Layout.zero, left: Layout.insetSpacing, bottom: Layout.insetSpacing, right: Layout.insetSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spaceBetweenCell
    }
}
