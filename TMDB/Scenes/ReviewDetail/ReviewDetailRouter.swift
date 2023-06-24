//
//  ReviewDetailRouter.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import Foundation

protocol ReviewDetailRouting {
    var viewController: ReviewDetailViewController? { get set }
    
    func close()
}

final class ReviewDetailRouter: ReviewDetailRouting {
    var viewController: ReviewDetailViewController?
    
    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
