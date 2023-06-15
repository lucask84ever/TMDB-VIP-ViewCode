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
        static let spaceBetweenCell: CGFloat = 4
        static let defaultWidth: CGFloat = 68
        static let nowPlayingWidth: CGFloat = 84
        static let upcomingWidth: CGFloat = 88
    }
    
    internal enum Constants {
        static let nowPlayingIndex: Int = 0
        static let upcomingIndex: Int = 1
        static let zero: Int = 0
    }
    
    private var collectionView: UICollectionView
    private var typeMovieList: [TypeListEnum] = TypeListEnum.allCases
    private var delegate: HomeMovieListDelegate
    
    init(collectionView: UICollectionView, delegate: HomeMovieListDelegate) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.delegate = self
    }
    
    func setInitialValue() {
        let initialSelection = IndexPath(row: Constants.zero, section: Constants.zero)
        collectionView.selectItem(at: initialSelection, animated: false, scrollPosition: .top)
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
        if indexPath.row == Constants.nowPlayingIndex {
            return CGSize(width: Layout.nowPlayingWidth, height: Layout.cellHeight)
        }
        
        if indexPath.row == Constants.upcomingIndex {
            return CGSize(width: Layout.upcomingWidth, height: Layout.cellHeight)
        }
        return CGSize(width: Layout.defaultWidth, height: Layout.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spaceBetweenCell
    }
}
