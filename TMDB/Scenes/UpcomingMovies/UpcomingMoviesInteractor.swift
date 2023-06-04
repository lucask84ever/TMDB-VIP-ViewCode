//
//  UpcomingMoviesInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

final class UpcomingMoviesInteractor: UpcomingMoviesInteracting {
    
    let service: UpcomingMoviesServicing
    let presenter: UpcomingMoviesPresenting
    
    init(presenter: UpcomingMoviesPresenting, service: UpcomingMoviesServicing) {
        self.presenter = presenter
        self.service = service
        fetchUpcomingMovies(1)
    }
     
    func fetchUpcomingMovies(_ page: Int) {
        service.fetchUpcomingMovies(page) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.presenter.fetchedMovies(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showDetailedMovie(_ movie: Movie) {
        presenter.detailedMovie(movie)
    }
}
