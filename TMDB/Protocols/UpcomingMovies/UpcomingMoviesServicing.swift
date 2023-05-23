//
//  UpcomingMoviesServicing.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

protocol UpcomingMoviesServicing {
    func fetchUpcomingMovies(_ page: Int, completion: @escaping ((Result<Movies, Error>) -> Void))
}
