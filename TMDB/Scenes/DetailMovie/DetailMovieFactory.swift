//
//  DetailMovieFactory.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

final class DetailMovieFactory {
    static func make(_ movie: Movie) -> DetailMovieViewController {
        let service = DetailMovieService()
        let presenter = DetailMoviePresenter(movie: movie)
        let interactor = DetailMovieInteractor(service: service, presenter: presenter, movieId: movie.id)
        let viewController = DetailMovieViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
