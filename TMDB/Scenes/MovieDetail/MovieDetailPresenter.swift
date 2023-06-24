//
//  DetailMoviePresenter.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

protocol DetailMoviePresenting {
    var viewController: MovieDetailDisplaying? { get set }
    var router: MovieDetailRouting? { get set }
    var movie: Movie { get set }
    var movieDetails: DetailedMovie? { get set }
    var trailer: Video? { get set }
    var reviews: Reviews? { get set }
    var casting: Casting? { get set }
    
    func setMovieBackdrop(_ backdropPath: String?)
    func setMoviePoster(_ posterPath: String)
    func setMovieTitle(_ title: String)
    func setReleaseYear(_ year: String)
    func setDuration(_ duration: String)
    func setMainGenre(_ genre: String)
    func setNote(_ note: Float)
    func setOverview(_ overview: String)
    
    func setTrailer(_ url: String)
    
    func setReviews(_ reviews: [UserReview])
    
    func setCast(_ cast: [Cast])
    
    func showReviewDetails(_ review: UserReview)
}

final class MovieDetailPresenter: DetailMoviePresenting {
    var viewController: MovieDetailDisplaying?
    var router: MovieDetailRouting?
    var movie: Movie
    var movieDetails: DetailedMovie? {
        didSet {
            setMovieBackdrop(movie.backdropPath)
            setMoviePoster(movie.posterPath)
            setMovieTitle(movie.name)
            setReleaseYear(movie.releaseDate)
            setNote(movie.averageNote)
            setOverview(movie.overview)
            if let details = movieDetails {
                setDuration(TMDBStrings.Detail.Detail.durationFormat(details.duration))
            }
            
            if let mainGenre = movieDetails?.genres.first {
                setMainGenre(mainGenre.name)
            }
        }
    }
    
    var trailer: Video? {
        didSet {
            if let url = trailer?.urlEnd {
                setTrailer(url)
            }
        }
    }
    
    var reviews: Reviews? {
        didSet {
            if let reviews = reviews?.results {
                setReviews(reviews)
            }
        }
    }
    
    var casting: Casting? {
        didSet {
            if let casting = casting {
                setCast(casting.filterCast("Acting"))
            }
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func setMovieBackdrop(_ backdropPath: String?) {
        viewController?.setMovieBackdrop(backdropPath)
    }
    
    func setMoviePoster(_ posterPath: String) {
        viewController?.setMoviePoster(posterPath)
    }
    
    
    func setMovieTitle(_ title: String) {
        viewController?.setMovieTitle(title)
    }
    
    func setReleaseYear(_ year: String) {
        let date = Date(string: year, format: .yyyyMMddHyphen)
        if let date = date {
            viewController?.setReleaseYear(date.asString(format: .yyyy, timeZone: nil))
        }
    }
    
    func setDuration(_ duration: String) {
        viewController?.setMovieDuration(duration)
    }
    
    func setMainGenre(_ genre: String) {
        viewController?.setGenre(genre)
    }
    
    func setNote(_ note: Float) {
        let formated = TMDBStrings.Detail.Detail.averageNoteFormat(note)
        viewController?.setNote(formated)
    }
    
    func setOverview(_ overview: String) {
        viewController?.setOverview(overview)
    }
    
    func setTrailer(_ url: String) {
        viewController?.setTrailer(url)
    }
    
    func setReviews(_ reviews: [UserReview]) {
        viewController?.setReviews(reviews)
    }
    
    func setCast(_ cast: [Cast]) {
        viewController?.setCast(cast)
    }
    
    func showReviewDetails(_ review: UserReview) {
        router?.routeTo(.review(review))
    }
}
