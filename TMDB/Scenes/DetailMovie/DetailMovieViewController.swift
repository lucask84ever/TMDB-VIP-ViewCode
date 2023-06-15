//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import UIKit

protocol DetailMovieDisplaying {
    
}

class DetailMovieViewController: BaseViewController<DetailMovieInteracting, DetailMovieView> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchMovieDetails()
        getMovieBackdrop()
        getMoviePoster()
    }
}

extension DetailMovieViewController: DetailMovieDisplaying {
    func getMovieBackdrop() {
        if let backdrop = interactor.getMovieBackdrop() {
            rootView.setMovieBackdrop(backdrop)
        }
    }
    
    func getMoviePoster() {
        rootView.setMoviePoster(interactor.getMoviePosterPath())
    }
}
