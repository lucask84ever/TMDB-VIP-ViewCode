//
//  ReviewDetailFactory.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import Foundation

final class ReviewDetailFactory {
    static func make(_ review: UserReview) -> ReviewDetailViewController {
        let router = ReviewDetailRouter()
        let presenter = ReviewDetailPresenter(review: review)
        let interactor = ReviewDetailInteractor(presenter: presenter)
        let viewController = ReviewDetailViewController(interactor: interactor)
        
        presenter.viewController = viewController
        presenter.router = router
        router.viewController = viewController
        return viewController
    }
}
