//
//  SearchMoviePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

protocol SearchMoviePresenting {
    
    var viewController: SearchMovieDisplaying? { get set }
    var router: SearchMovieRouting? { get set }
    
    func setMovies(_ movies: [Movie])
    
    func presentMovieDetail(_ movie: Movie)
}


final class SearchMoviePresenter: SearchMoviePresenting {
    var viewController: SearchMovieDisplaying?
    var router: SearchMovieRouting?
    
    func setMovies(_ movies: [Movie]) {
        viewController?.setMovies(movies)
    }
    
    func presentMovieDetail(_ movie: Movie) {
        print(movie.name)
    }
}
