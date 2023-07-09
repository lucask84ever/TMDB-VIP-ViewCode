//
//  SearchMovieViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

protocol SearchMovieDisplaying {
    func setMovies(_ movies: [Movie])
}

final class SearchMovieViewController: BaseViewController<SearchMovieInteracting, SearchMovieView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupClosure()
    }
    
    private func setupClosure() {
        rootView.searchMovieAction = { [weak self] textToSearch in
            self?.interactor.fetchSearchMovie(textToSearch)
        }
        
        rootView.selectMovieClosure = { [weak self] movie in
            self?.interactor.routeToDetailMovie(movie)
        }
    }
}

extension SearchMovieViewController: SearchMovieDisplaying {
    func setMovies(_ movies: [Movie]) {
        rootView.setMovies(movies)
    }
}
