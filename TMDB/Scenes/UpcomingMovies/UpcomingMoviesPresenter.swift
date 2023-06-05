//
//  UpcomingMoviesPresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

final class UpcomingMoviesPresenter: UpcomingMoviesPresenting {
    var router: UpcomingMoviesRouting
    
    weak var viewController: UpcomingMoviesDisplaying?
    
    init(router: UpcomingMoviesRouting, viewController: UpcomingMoviesDisplaying? = nil) {
        self.router = router
        self.viewController = viewController
    }
    
    func fetchedMovies(_ movies: MoviesResponse) {
        viewController?.fetchedMovies(movies)
    }
    
    func detailedMovie(_ movie: Movie) {
        router.routeTo(.detailMovie(movie))
    }
}
