//
//  DetailMovieInteractor.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

protocol DetailMovieInteracting {
    var service: DetailMovieServicing { get set }
    var presenter: DetailMoviePresenting { get set }
    var movieId: Int { get set }
    
    func fetchMovieDetails()
    func fetchTrailer()
    
    func getMovieBackdrop() -> String?
    func getMoviePosterPath() -> String
}

final class DetailMovieInteractor: DetailMovieInteracting {
    var service: DetailMovieServicing
    
    var presenter: DetailMoviePresenting
    
    var movieId: Int
    
    init(service: DetailMovieServicing, presenter: DetailMoviePresenting, movieId: Int) {
        self.service = service
        self.presenter = presenter
        self.movieId = movieId
    }
    
    func fetchMovieDetails() {
        
    }
    
    func fetchTrailer() {
        
    }
    
    func getMovieBackdrop() -> String? {
        return presenter.getBackdrop()
    }
    
    func getMoviePosterPath() -> String {
        return presenter.getPosterPath()
    }
}
