//
//  HomePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomePresenting {
    var viewController: HomeViewController? { get set }
    
    func fetchTopRatedMovies(_ movies: [Movie])
}

final class HomePresenter: HomePresenting {
    weak var viewController: HomeViewController?
    
    func fetchTopRatedMovies(_ movies: [Movie]) {
        viewController?.fetchTopRatedMovie(movies)
    }
}
