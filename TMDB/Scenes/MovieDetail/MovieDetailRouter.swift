//
//  MovieDetailRouter.swift
//  TMDB
//
//  Created by Lucas on 22/06/23.
//

import UIKit

enum MovieDetailRoute {
    case review(UserReview)
}

protocol MovieDetailRouting {
    var viewController: UIViewController? { get set }
    
    func routeTo(_ route: MovieDetailRoute)
}

final class MovieDetailRouter: MovieDetailRouting {
    var viewController: UIViewController?
    
    func routeTo(_ route: MovieDetailRoute) {
        let navigation = viewController?.navigationController
        switch route {
        case .review(let review):
            let viewController = ReviewDetailFactory.make(review)
            viewController.title = review.details.username
            navigation?.present(viewController, animated: true, completion: nil)
        }
    }
}
