//
//  TypeMovieDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import UIKit

final class TypeMovieDelegate: NSObject {
    
    internal enum Constants {
        static let cellHeight: CGFloat = 146
        static let cellWidth: CGFloat = 100
        static let posterProportion: CGFloat = cellHeight / cellWidth
        static let spaceBetweenColumns: CGFloat = 8
        static let spaceBetweenRows: CGFloat = 0
        static let numberOfColumns: Int = 3
    }
    
    var collectionView: UICollectionView?
    var items: [Movie]
    init(items: [Movie], collectionView: UICollectionView?) {
        self.items = items
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.delegate = self
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
        let width: CGFloat = (collectionView.frame.width - 4 * Constants.spaceBetweenColumns) / CGFloat(Constants.numberOfColumns)
        let height: CGFloat = width * Constants.posterProportion
        return CGSize(width: width, height: height)
    }
}
