//
//  SearchMovieViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import UIKit

protocol SearchMovieDisplaying {
    func fetchedMovies(_ searchedName: String,_ movies: MoviesResponse)
}

final class SearchMovieViewController: BaseViewController<SearchMovieInteracting, SearchMovieView> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
