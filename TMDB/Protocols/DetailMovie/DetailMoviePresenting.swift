//
//  DetailMoviePresenting.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

protocol DetailMoviePresenting {
    var viewController: DetailMovieDisplaying? { get set }
    
    func fetchedMovieDetails(_ movie: Movie)
}
