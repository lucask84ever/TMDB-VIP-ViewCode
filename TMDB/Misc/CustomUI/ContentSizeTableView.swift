//
//  ContentSizeTableView.swift
//  TMDB
//
//  Created by Lucas on 19/06/23.
//

import UIKit

final class ContentSizeTableView: UITableView {
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
