//
//  HomeViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

protocol HomeDisplaying {
    func fetchTopRatedMovie(_ movies: [Movie])
}

final class HomeViewController: BaseViewController<HomeInteracting, HomeView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        interactor.fetchTopRatedMovies()
    }
}

extension HomeViewController: HomeDisplaying {
    func fetchTopRatedMovie(_ movies: [Movie]) {
        rootView.setTopRated(movies)
    }
}
