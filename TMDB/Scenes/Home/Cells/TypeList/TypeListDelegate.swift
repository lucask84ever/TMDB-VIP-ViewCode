//
//  MovieListDelegate.swift
//  TMDB
//
//  Created by Lucas Lima on 07/06/23.
//

import UIKit

final class TypeListDelegate: NSObject {
    internal enum Layout {
        static let cellHeight: CGFloat = 42
        static let spaceBetweenCell: CGFloat = 8
        static let defaultWidth: CGFloat = 77
        static let nowPlayingWidth: CGFloat = 88
        static let popularWidth: CGFloat = 72
    }
    
    private var collectionView: UICollectionView
    private var typeMovieList: [TypeListEnum] = TypeListEnum.allCases
    private var delegate: HomeMovieListDelegate
    
    init(collectionView: UICollectionView, delegate: HomeMovieListDelegate) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.delegate = self
        collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
}

extension TypeListDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        delegate.selectedType(typeMovieList[selectedIndex])
    }
}


extension TypeListDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: Layout.nowPlayingWidth, height: Layout.cellHeight)
        }
        if indexPath.row == 3 {
            return CGSize(width: Layout.popularWidth, height: Layout.cellHeight)
        }
        return CGSize(width: Layout.defaultWidth, height: Layout.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spaceBetweenCell
    }
}
