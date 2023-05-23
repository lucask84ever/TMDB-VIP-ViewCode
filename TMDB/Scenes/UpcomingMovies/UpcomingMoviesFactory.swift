//
//  UpcomingMoviesFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

class UpcomingMoviesFactory {
    static func make() -> UpcomingMoviesViewController {
        let service: UpcomingMoviesServicing = UpcomingMoviesService()
        var presenter: UpcomingMoviesPresenting = UpcomingMoviesPresenter()
        let interactor: UpcomingMoviesInteracting = UpcomingMoviesInteractor(presenter: presenter, service: service)
        let viewController = UpcomingMoviesViewController(interactor: interactor)
        
        presenter.viewController = viewController
        return viewController
    }
}
