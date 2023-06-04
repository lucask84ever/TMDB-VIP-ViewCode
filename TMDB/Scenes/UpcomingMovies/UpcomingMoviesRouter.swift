//
//  UpcomingMoviesRouter.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

class UpcomingMoviesRouter: UpcomingMoviesRouting {
    var viewController: UIViewController?
    
    func routeTo(_ action: UpcomingMovieAction) {
        let navigationController = viewController?.navigationController
        var viewController: UIViewController?
        
        switch action {
        case .detailMovie(let movie):
            viewController = DetailMovieFactory.make(movie)
        }
        
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
