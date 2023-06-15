//
//  HomeViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

protocol HomeDisplaying {
    func fetchTopRatedMovie(_ movies: [Movie])
    func fetchUpcoming(_ movies: [Movie])
    func fetchPlayingNow(_ movies: [Movie])
    func fetchPopular(_ movies: [Movie])
}

final class HomeViewController: BaseViewController<HomeInteracting, HomeView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.setInitialSelection()
        setupClosure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetchNowPlayingMovies()
    }
}

extension HomeViewController {
    private func setupClosure() {
        rootView.changeListType = { [weak self] type in
            switch type {
            case .nowPlaying:
                self?.interactor.fetchNowPlayingMovies()
            case .upcoming:
                self?.interactor.fetchUpcoming()
            case .topRated:
                self?.interactor.fetchTopRatedMovies()
            case .popular:
                self?.interactor.fetchPopularMovies()
            }
        }
        
        rootView.selectMovie = { [weak self] movie in
            self?.interactor.routeToDetailMovie(movie)
        }
    }
}

extension HomeViewController: HomeDisplaying {
    func fetchTopRatedMovie(_ movies: [Movie]) {
        rootView.setTopRated(movies)
    }
    
    func fetchUpcoming(_ movies: [Movie]) {
        rootView.setUpcoming(movies)
    }
    
    func fetchPlayingNow(_ movies: [Movie]) {
        rootView.setNowPlaying(movies)
    }
    
    func fetchPopular(_ movies: [Movie]) {
        rootView.setPopular(movies)
    }
}
