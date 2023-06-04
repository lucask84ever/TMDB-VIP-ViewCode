//
//  DetailMovieFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

class DetailMovieFactory {
    static func make(_ movie: Movie) -> DetailMovieViewController {
        let service = DetailMovieService()
        
        let presenter = DetailMoviePresenter(movie: movie)
        let interactor = DetailMovieInteractor(service: service, presenter: presenter)
        let viewController = DetailMovieViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
