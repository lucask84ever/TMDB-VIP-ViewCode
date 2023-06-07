//
//  TopRatedCollectionViewDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 06/06/23.
//

import UIKit

final class TopRatedMoviesDelegate: NSObject {
    
    internal enum Layout {
        static let cellWidth: CGFloat = 144
        static let cellHeight: CGFloat = 190
        static let spaceBetweenCell: CGFloat = 32
        static let insetSpacing: CGFloat = 16
        static let zero: CGFloat = 0
    }
    
    weak var collectionView: UICollectionView?
    var delegate: HomeTopRatedMoviesDelegate
    var items: [Movie]
    
    init(collectionView: UICollectionView,
         delegate: HomeTopRatedMoviesDelegate,
         items: [Movie]) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.items = items
        super.init()
    }
}

extension TopRatedMoviesDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = items[indexPath.row]
        delegate.selectMovie(selectedMovie)
    }
}

extension TopRatedMoviesDelegate: UICollectionViewDelegateFlowLayout {
    
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
