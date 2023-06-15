//
//  DetailMoviePresenter.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

protocol DetailMoviePresenting {
    var viewController: DetailMovieViewController? { get set }
    var movie: Movie { get set }
    
    func fetchMovieDetails(_ movie: DetailedMovie)
    func fetchMovieTrailer(_ trailer: Video)
    
    func getBackdrop() -> String?
    func getPosterPath() -> String
}

final class DetailMoviePresenter: DetailMoviePresenting {
    weak var viewController: DetailMovieViewController?
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    func fetchMovieDetails(_ movie: DetailedMovie) {
        // chamada para a viewcontroller mandar para a view
    }
    
    func fetchMovieTrailer(_ trailer: Video) {
        // chamada para a viewcontroller mandar para a view
    }
    
    func getBackdrop() -> String? {
        return movie.backdropPath
    }
    
    func getPosterPath() -> String {
        return movie.posterPath
    }
}
