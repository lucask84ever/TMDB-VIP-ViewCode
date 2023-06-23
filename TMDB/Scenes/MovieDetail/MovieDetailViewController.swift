//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import UIKit

protocol MovieDetailDisplaying {
    func setMovieBackdrop(_ backdropPath: String?)
    func setMoviePoster(_ posterPath: String)
    func setMovieTitle(_ title: String)
    func setReleaseYear(_ releaseYear: String)
    func setMovieDuration(_ duration: String)
    func setGenre(_ genre: String)
    func setNote(_ note: String)
    func setOverview(_ overview: String)
    func setTrailer(_ url: String)
    func setReviews(_ reviews: [UserReview])
}

class MovieDetailViewController: BaseViewController<DetailMovieInteracting, DetailMovieView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setupClosure()
        interactor.fetchMovieDetails()
        setInitialSelection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = ""
        let attributes = [NSAttributedString.Key.foregroundColor: ColorName.textColor.color]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = TMDBStrings.Detail.navigationTitle
    }
    
    private func setInitialSelection() {
        rootView.setInitialSelection()
    }
    
    private func setupClosure() {
        rootView.selectDetailType = { [weak self] type in
            switch type {
            case .cast:
                print("Cast")
            case .trailer:
                self?.interactor.fetchTrailer()
            case .about:
                return
            case .reviews:
                self?.interactor.fetchReviews()
            }
        }
        
        rootView.selectDetailReview = { [weak self] review in
            self?.interactor.showReviewDetails(review)
        }
    }
}

extension MovieDetailViewController: MovieDetailDisplaying {
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
    
    func setOverview(_ overview: String) {
        rootView.setOverview(overview)
    }
    
    func setTrailer(_ url: String) {
        rootView.setTrailer(url)
    }
    
    func setReviews(_ reviews: [UserReview]) {
        rootView.setReviws(reviews)
    }
}
