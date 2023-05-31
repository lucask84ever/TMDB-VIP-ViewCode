//
//  SearchMoviePresenting.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

protocol SearchMoviePresenting {
    var viewController: SearchMovieDisplaying? { get set }
    func fetchedMovies(_ movies: MoviesResponse)
}
