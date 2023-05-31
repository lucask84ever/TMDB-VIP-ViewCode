//
//  UpcomingMoviesServicing.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

typealias MoviesResult = ((Result<MoviesResponse, Error>) -> Void)

protocol UpcomingMoviesServicing {
    func fetchUpcomingMovies(_ page: Int, completion: @escaping MoviesResult)
}
