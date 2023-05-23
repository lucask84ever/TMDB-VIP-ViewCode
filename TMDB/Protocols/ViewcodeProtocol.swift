//
//  ViewcodeProtocol.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

protocol ViewcodeProtocol : AnyObject {
    func buildViewHierarchy()
    func buildViewConstraints()
    func additionalConfig()
    func buildViewLayout()
}

extension ViewcodeProtocol {
    func buildViewLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }

    func additionalConfig() { /* Intentionally unimplemented */ }
}
