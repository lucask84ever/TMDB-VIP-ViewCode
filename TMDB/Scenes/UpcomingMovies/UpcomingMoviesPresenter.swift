//
//  UpcomingMoviesPresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

final class UpcomingMoviesPresenter: UpcomingMoviesPresenting {
    weak var viewController: UpcomingMoviesDisplaying?
    
    func fetchedMovies(_ movies: MoviesResponse) {
        viewController?.fetchedMovies(movies)
    }
}
