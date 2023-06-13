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
        static let windowWidth: CGFloat = UIWindow().bounds.width
        static let margins: CGFloat = 32 // 16 from leading and trailing
        static let collectionWidth: CGFloat = windowWidth - margins
    }
    
    internal enum Constants {
        static let numberOfRows: Int = 7
        static let numberOfColumns: Int = 3
        static let numberOfSpacesBetweenRowsInCollectionView: Int = 8
        static let numberOfSpacesBetweenColumnsInCollectionView: Int = 4
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
    
    func getTotalHeight() -> CGFloat {
        let spaceBetweenColumns: CGFloat = CGFloat(Constants.numberOfSpacesBetweenColumnsInCollectionView)
        let width: CGFloat = (Layout.collectionWidth - spaceBetweenColumns * Layout.spaceBetweenColumns) / CGFloat(Constants.numberOfColumns)
        let height = width * Layout.posterProportion
        let cellsHeight = CGFloat(Constants.numberOfRows) * height
        let spaceBetweenRows = CGFloat(Constants.numberOfSpacesBetweenRowsInCollectionView) * Layout.spaceBetweenRows
        let totalSpace = cellsHeight + spaceBetweenRows
        return totalSpace
    }
    
    func addMovies(_ movies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            self?.items = movies
            self?.collectionView?.reloadData()
        }
        
    }
}

extension TypeMovieDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = indexPath.row
        if items.indices.contains(selectedItem) {
            let selectedMovieName = items[selectedItem].name
            print(selectedMovieName)
        }
    }
}

extension TypeMovieDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spaceBetweenColumns: CGFloat = CGFloat(Constants.numberOfSpacesBetweenColumnsInCollectionView)
        let width: CGFloat = (collectionView.frame.width - spaceBetweenColumns * Layout.spaceBetweenColumns) / CGFloat(Constants.numberOfColumns)
        let movieHeight = width * Layout.posterProportion
        return CGSize(width: width, height: movieHeight)
    }
}
