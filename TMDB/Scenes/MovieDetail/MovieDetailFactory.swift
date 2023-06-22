//
//  DetailMovieFactory.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

final class MovieDetailFactory {
    static func make(_ movie: Movie) -> MovieDetailViewController {
        let router = MovieDetailRouter()
        let service = MovieDetailService()
        let presenter = MovieDetailPresenter(movie: movie)
        let interactor = MovieDetailInteractor(service: service, presenter: presenter, movieId: movie.id)
        let viewController = MovieDetailViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
