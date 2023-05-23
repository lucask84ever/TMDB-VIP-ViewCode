//
//  UpcomingMoviesPresenting.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

protocol UpcomingMoviesPresenting {
    var viewController: UpcomingMoviesDisplaying? { get set }
    
    func fetchedMovies(_ movies: Movies)
}
