//
//  SearchMovieRouter.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

enum SearchRoute {
    case detail(Movie)
}

protocol SearchMovieRouting {
    var viewController: UIViewController? { get set }
    
    func routeTo(_ route: SearchRoute)
}

final class SearchMovieRouter: SearchMovieRouting {
    weak var viewController: UIViewController?
    
    func routeTo(_ route: SearchRoute) {
        let navigation = viewController?.navigationController
        switch route {
        case .detail(let movie):
            let viewController = MovieDetailFactory.make(movie)
            navigation?.pushViewController(viewController, animated: true)
        }
    }
}
