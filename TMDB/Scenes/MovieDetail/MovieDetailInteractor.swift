//
//  DetailMovieInteractor.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

protocol DetailMovieInteracting {
    var service: DetailMovieServicing { get set }
    var presenter: DetailMoviePresenting { get set }
    var movieId: Int { get set }
    
    func fetchMovieDetails()
    func fetchTrailer()
    func fetchReviews()
    
    func showReviewDetails(_ review: UserReview)
}

final class MovieDetailInteractor: DetailMovieInteracting {
    var service: DetailMovieServicing
    
    var presenter: DetailMoviePresenting
    
    var movieId: Int
    
    init(service: DetailMovieServicing, presenter: DetailMoviePresenting, movieId: Int) {
        self.service = service
        self.presenter = presenter
        self.movieId = movieId
    }
    
    func fetchMovieDetails() {
        let id = presenter.movie.id
        service.fetchMovieDetails(id, completion: { [weak self] result in
            switch result {
            case .success(let detail):
                self?.presenter.movieDetails = detail
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchTrailer() {
        let id = presenter.movie.id
        service.fetchMovieTrailer(id) { [weak self] result in
            switch result {
            case .success(let videos):
                let video = videos.videos.filter { video in
                    return video.name.lowercased().contains("official trailer")
                }.first
                self?.presenter.trailer = video
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchReviews() {
        let id = presenter.movie.id
        service.fetchReviews(id) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.presenter.reviews = reviews
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showReviewDetails(_ review: UserReview) {
        presenter.showReviewDetails(review)
    }
}
