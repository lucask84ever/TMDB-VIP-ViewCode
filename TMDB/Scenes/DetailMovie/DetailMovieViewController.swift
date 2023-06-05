//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import UIKit

protocol DetailMovieDisplaying {
    func setMovieDescription(_ description: String)
    func setMovieData(_ releaseDate: String)
    func fetchMovieTrailer(_ movieTrailer: VideosResponse)
}

class DetailMovieViewController: BaseViewController<DetailMovieInteracting, DetailMovieView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        rootView.backgroundColor = .white
        title = TMDBStrings.navigationBarDetailMovieTitle
        interactor.fetchMovieTrailer()
        interactor.fetchMovieDetails()
        setMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}

extension DetailMovieViewController {
    private func setMovieData() {
        rootView.setImageBackdrop(interactor.getImageBackdrop())
        rootView.setOverview(interactor.getOverview())
        rootView.setPosterImage(interactor.getImagePoster())
        rootView.setMovieTitle(interactor.getTitle())
        rootView.setMovieReleaseYear(interactor.getReleaseYear())
    }
}

// MARK: - Displaying protocol
extension DetailMovieViewController: DetailMovieDisplaying {
    func fetchMovieTrailer(_ movieTrailer: VideosResponse) {
        rootView.setupMovieTrailer(movieTrailer)
    }
    
    func setMovieDescription(_ description: String) {
        
    }
    
    func setMovieData(_ releaseDate: String) {
        
    }
}
