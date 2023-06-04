//
//  UpcomingMoviesRouting.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

enum UpcomingMovieAction {
    case detailMovie(Movie)
}

protocol UpcomingMoviesRouting {
    var viewController: UIViewController? { get set }
    
    func routeTo(_ action: UpcomingMovieAction)
}
