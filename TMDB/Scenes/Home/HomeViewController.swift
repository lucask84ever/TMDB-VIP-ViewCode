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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.setInitialSelection()
    }
}

extension HomeViewController: HomeDisplaying {
    func fetchTopRatedMovie(_ movies: [Movie]) {
        rootView.setTopRated(movies)
    }
}
