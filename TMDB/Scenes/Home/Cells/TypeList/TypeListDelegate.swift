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
        static let insetSpacing: CGFloat = 16
        static let zero: CGFloat = 0
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
        let averageWidth = (collectionView.frame.width - 32)/4
        let height = collectionView.frame.height
        var width: CGFloat
        switch indexPath.row {
        case 0:
            width = averageWidth + 16
        case 3:
            width = averageWidth - 16
        default:
            width = averageWidth
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.spaceBetweenCell
    }
}
