//
//  ContentSizeCollectionView.swift
//  TMDB
//
//  Created by Lucas on 23/06/23.
//

import UIKit

final class ContentSizeCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
