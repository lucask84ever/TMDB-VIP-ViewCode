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
        let id = presenter.movie.id
        service.fetchMoviesDetails(id, completion: { [weak self] result in
            switch result {
            case .success(let detail):
                self?.presenter.movieDetails = detail
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchTrailer() {
        
    }
}
