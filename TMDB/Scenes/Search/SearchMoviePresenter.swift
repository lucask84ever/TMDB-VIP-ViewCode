//
//  SearchMoviePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation


class SearchMoviePresenter: SearchMoviePresenting {
    var viewController: SearchMovieDisplaying?
    
    func fetchedMovies(_ movies: MoviesResponse) {
        viewController?.fetchedMovies(movies)
    }
}
