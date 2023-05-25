//
//  DetailMovieFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

class DetailMovieFactory {
    static func make() -> DetailMovieViewController {
        let interactor = DetailMovieInteractor()
        let viewController = DetailMovieViewController(interactor: interactor)
        return viewController
    }
}
