//
//  WatchListView.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

class WatchListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
}

extension WatchListView: ViewcodeProtocol {
    func buildViewHierarchy() {
        
    }
    
    func buildViewConstraints() {
        
    }
    
    func additionalConfig() {
        backgroundColor = ColorName.backgroundColor.color
    }
}
