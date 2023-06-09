//
//  TypeMovieDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import UIKit

final class TypeMovieDelegate: NSObject {
    
    internal enum Layout {
        static let cellHeight: CGFloat = 146
        static let cellWidth: CGFloat = 100
        static let posterProportion: CGFloat = cellHeight / cellWidth
        static let spaceBetweenColumns: CGFloat = 8
        static let spaceBetweenRows: CGFloat = 8
    }
    
    internal enum Constants {
        static let numberOfRows: Int = 7
        static let numberOfColumns: Int = 3
        static let numberOfSpacesBetweenRowsInCollectionView: Int = 16
        static let numberOfSpacesBetweenColumnsInCollectionView: Int = 4
    }
    
    var collectionView: UICollectionView?
    var items: [Movie]
    var movieHeight: CGFloat = 0
    
    init(items: [Movie], collectionView: UICollectionView?) {
        self.items = items
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.delegate = self
    }
    
    func getTotalHeight() -> CGFloat {
        return CGFloat(Constants.numberOfRows) * movieHeight + CGFloat(Constants.numberOfSpacesBetweenRowsInCollectionView) * Layout.spaceBetweenRows
    }
}

extension TypeMovieDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = indexPath.row
        let selectedMovieName = items[selectedItem].name
        print(selectedMovieName)
    }
}

extension TypeMovieDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spaceBetweenColumns: CGFloat = CGFloat(Constants.numberOfSpacesBetweenColumnsInCollectionView)
        let width: CGFloat = (collectionView.frame.width - spaceBetweenColumns * Layout.spaceBetweenColumns) / CGFloat(Constants.numberOfColumns)
        movieHeight = width * Layout.posterProportion
        return CGSize(width: width, height: movieHeight)
    }
}
