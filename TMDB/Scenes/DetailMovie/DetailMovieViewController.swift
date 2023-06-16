//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import UIKit

protocol DetailMovieDisplaying {
    func setMovieBackdrop(_ backdropPath: String?)
    func setMoviePoster(_ posterPath: String)
    func setMovieTitle(_ title: String)
    func setReleaseYear(_ releaseYear: String)
    func setMovieDuration(_ duration: String)
    func setGenre(_ genre: String)
    func setNote(_ note: String)
}

class DetailMovieViewController: BaseViewController<DetailMovieInteracting, DetailMovieView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TMDBStrings.Detail.navigationTitle
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = ""
        let attributes = [NSAttributedString.Key.foregroundColor: ColorName.textColor.color]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = TMDBStrings.Detail.navigationTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchMovieDetails()
        setInitialSelection()
    }
    
    private func setInitialSelection() {
        rootView.setInitialSelection()
    }
}

extension DetailMovieViewController: DetailMovieDisplaying {
    func setMovieBackdrop(_ backdropPath: String?) {
        if let backdropPath = backdropPath {
            rootView.setMovieBackdrop(backdropPath)
        }
    }
    
    func setMoviePoster(_ posterPath: String) {
        rootView.setMoviePoster(posterPath)
    }
    
    
    func setMovieTitle(_ title: String) {
        rootView.setMovieTitle(title)
    }
    
    func setReleaseYear(_ releaseYear: String) {
        rootView.setMovieReleaseYear(releaseYear)
    }
    
    func setMovieDuration(_ duration: String) {
        rootView.setMovieDuration(duration)
    }
    
    func setGenre(_ genre: String) {
        rootView.setGenre(genre)
    }
    
    func setNote(_ note: String) {
        rootView.setNote(note)
    }
}
