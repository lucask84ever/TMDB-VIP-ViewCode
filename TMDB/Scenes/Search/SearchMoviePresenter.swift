//
//  SearchMoviePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

protocol SearchMoviePresenting {
    
    var viewController: SearchMovieDisplaying? { get set }
    
    func fetchedMovies(_ movies: MoviesResponse)
}


final class SearchMoviePresenter: SearchMoviePresenting {
    var viewController: SearchMovieDisplaying?
    
    func fetchedMovies(_ movies: MoviesResponse) {
        viewController?.fetchedMovies("", movies)
    }
}
