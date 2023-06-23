//
//  ReviewDetailInteractor.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import Foundation

protocol ReviewDetailInteracting {
    var presenter: ReviewDetailPresenting { get set }
    
    func back()
}

final class ReviewDetailInteractor: ReviewDetailInteracting {
    var presenter: ReviewDetailPresenting
    
    init(presenter: ReviewDetailPresenting) {
        self.presenter = presenter
    }
    
    func back() {
        presenter.closeViewController()
    }
}
