//
//  HomeRouter.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

enum Route {
    case detail(Movie)
}

protocol HomeRouting {
    var viewController: UIViewController? { get set }
    func routeTo(_ route: Route)
}

final class HomeRouter {
    weak var viewController: UIViewController?
}

extension HomeRouter: HomeRouting {
    func routeTo(_ route: Route) {
        let navigation = viewController?.navigationController
        switch route {
        case .detail(let movie):
            let viewController = DetailMovieFactory.make(movie)
            navigation?.pushViewController(viewController, animated: true)
        }
    }
}
