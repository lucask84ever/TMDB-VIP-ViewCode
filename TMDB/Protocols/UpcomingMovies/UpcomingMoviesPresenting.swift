//
//  UpcomingMoviesPresenting.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

protocol UpcomingMoviesPresenting {
    var viewController: UpcomingMoviesDisplaying? { get set }
    var router: UpcomingMoviesRouting { get set }
    func fetchedMovies(_ movies: MoviesResponse)
    
    func detailedMovie(_ movie: Movie)
}
