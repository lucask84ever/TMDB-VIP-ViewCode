//
//  SearchMovieFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

class SearchMovieFactory {
    static func make() -> SearchMovieViewController {
        let presenter = SearchMoviePresenter()
        let service = SearchMovieService()
        let interactor = SearchMovieInteractor(presenter: presenter, service: service)
        let viewController = SearchMovieViewController(interactor: interactor)
        return viewController
    }
}
