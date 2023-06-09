//
//  HomeInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomeInteracting {
    var service: HomeServicing { get set }
    var presenter: HomePresenting { get set }
    
    func fetchNowPlayingMovies()
    func fetchUpcoming()
    func fetchTopRatedMovies()
    func fetchPopularMovies()
}

final class HomeInteractor: HomeInteracting {
    var service: HomeServicing
    
    var presenter: HomePresenting
    
    init(service: HomeServicing, presenter: HomePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func fetchNowPlayingMovies() {
        service.fetchMovies(.nowPlayingMovies, 1) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.presenter.fetchPlayingNow(movieResponse.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUpcoming() {
        service.fetchMovies(.upcomingMovies, 1) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.presenter.fetchUpcomingMovies(movieResponse.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopRatedMovies() {
        service.fetchMovies(.topRatedMovies, 1) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.presenter.fetchTopRatedMovies(movieResponse.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPopularMovies() {
        service.fetchMovies(.popularMovies, 1) { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.presenter.fetchPopularMovies(movieResponse.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
