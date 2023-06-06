//
//  HomeService.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomeServicing {
    func fetchNowPlayingMovies()
    func fetchUpcomingMovies()
    func fetchTopRatedMovies()
    func fetchPopularMovies()
}

final class HomeService: HomeServicing {
    func fetchNowPlayingMovies() { }
    func fetchUpcomingMovies() { }
    func fetchTopRatedMovies() { }
    func fetchPopularMovies() { }
}
