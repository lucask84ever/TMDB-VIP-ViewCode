//
//  UpcomingMoviesInteracting.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation
protocol UpcomingMoviesInteracting {
    func fetchUpcomingMovies(_ page: Int)
    func showDetailedMovie(_ movie: Movie)
}
