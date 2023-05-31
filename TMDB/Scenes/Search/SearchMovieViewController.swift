//
//  SearchMovieViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

protocol SearchMovieDisplaying {
    func fetchedMovies(_ movies: MoviesResponse)
}

class SearchMovieViewController: BaseViewController<SearchMovieInteracting, SearchMovieView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
