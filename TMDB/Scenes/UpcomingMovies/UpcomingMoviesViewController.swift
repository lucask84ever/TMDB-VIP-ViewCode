//
//  UpcomingMoviesViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import UIKit

// MARK: - DisplayingProtocol
protocol UpcomingMoviesDisplaying: AnyObject {
    func fetchedMovies(_ movies: MoviesResponse)
}

// MARK: - ViewController
final class UpcomingMoviesViewController: BaseViewController<UpcomingMoviesInteracting, UpcomingMoviesView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TMDBStrings.tabbarUpcomingMovieTitle
        navigationController?.navigationBar.isHidden = true
        rootView.backgroundColor = .white
        setupClosure()
    }
    
    private func setupClosure() {
        rootView.selectedMovie = { [weak self] movie in
            self?.interactor.showDetailedMovie(movie)
        }
    }
}

// MARK: - Displaying
extension UpcomingMoviesViewController: UpcomingMoviesDisplaying{
    func fetchedMovies(_ movies: MoviesResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView.setupDatasource(movies.results)
        }
    }
}
