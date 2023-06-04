//
//  UpcomingMoviesFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

class UpcomingMoviesFactory {
    static func make() -> UpcomingMoviesViewController {
        var router: UpcomingMoviesRouting = UpcomingMoviesRouter()
        let service: UpcomingMoviesServicing = UpcomingMoviesService()
        var presenter: UpcomingMoviesPresenting = UpcomingMoviesPresenter(router: router)
        let interactor: UpcomingMoviesInteracting = UpcomingMoviesInteractor(presenter: presenter, service: service)
        let viewController = UpcomingMoviesViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
