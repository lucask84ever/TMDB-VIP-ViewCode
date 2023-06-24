//
//  HomePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomePresenting {
    var viewController: HomeViewController? { get set }
    var router: HomeRouter? { get set }
    
    func fetchTopRatedMovies(_ movies: [Movie])
    func fetchUpcomingMovies(_ movies: [Movie])
    func fetchPopularMovies(_ movies: [Movie])
    func fetchPlayingNow(_ movies: [Movie])
    
    func presentMovieDetail(_ movie: Movie) 
    
}

final class HomePresenter: HomePresenting {
    weak var viewController: HomeViewController?
    var router: HomeRouter?
    
    func fetchTopRatedMovies(_ movies: [Movie]) {
        viewController?.fetchTopRatedMovie(movies)
    }
    
    func fetchUpcomingMovies(_ movies: [Movie]) {
        viewController?.fetchUpcoming(movies)
    }
    
    func fetchPopularMovies(_ movies: [Movie]) {
        viewController?.fetchPopular(movies)
    }
    
    func fetchPlayingNow(_ movies: [Movie]) {
        viewController?.fetchPlayingNow(movies)
    }
    
    func presentMovieDetail(_ movie: Movie) {
        router?.routeTo(.detail(movie))
    }
}
