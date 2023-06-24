//
//  CastDelegate.swift
//  TMDB
//
//  Created by Lucas on 23/06/23.
//

import Foundation
import UIKit

final class CastDelegate: NSObject {
    
    internal enum Constants {
        static let screenWidth: CGFloat = UIWindow().bounds.width
        static let margins: CGFloat = 32
        static let spaceBetweenCells: CGFloat = 8
        static let cellWidth: CGFloat = screenWidth/2 - spaceBetweenCells - margins
        static let cellHeight: CGFloat = cellWidth
    }
    
    var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
    }
}

extension CastDelegate: UICollectionViewDelegate {
    
}

extension CastDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
    }
}
