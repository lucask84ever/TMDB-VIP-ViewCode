//
//  DatailMovieDelegate.swift
//  TMDB
//
//  Created by Lucas on 16/06/23.
//

import Foundation
import UIKit

final class MovieDetailTypeDelegate: NSObject {
    weak var collectionView: UICollectionView?
    var delegate: _MovieDetailTypeProtocol
    init(_ collectionView: UICollectionView, _ delegate: _MovieDetailTypeProtocol) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        collectionView.delegate = self
    }
    
    func setInitialValue() {
        let initialSelection = IndexPath(row: 0, section: 0)
        collectionView?.selectItem(at: initialSelection, animated: false, scrollPosition: .top)
    }
}

extension MovieDetailTypeDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let selectedDetail = MovieDetailTypeEnum.allCases[selectedIndex]
        delegate.selectedType(selectedDetail)
    }
}

extension MovieDetailTypeDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let averageWidth = (collectionView.frame.width - 32)/4
        let height = collectionView.frame.height
        let width = indexPath.row == 0 ? averageWidth + 12 : averageWidth - 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
