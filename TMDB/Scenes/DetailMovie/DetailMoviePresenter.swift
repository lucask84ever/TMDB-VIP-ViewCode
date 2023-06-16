//
//  DetailMoviePresenter.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

protocol DetailMoviePresenting {
    var viewController: DetailMovieDisplaying? { get set }
    var movie: Movie { get set }
    var movieDetails: DetailedMovie? { get set }
    
    func setMovieBackdrop(_ backdropPath: String?)
    func setMoviePoster(_ posterPath: String)
    func setMovieTitle(_ title: String)
    func setReleaseYear(_ year: String)
    func setDuration(_ duration: String)
    func setMainGenre(_ genre: String)
    func setNote(_ note: Double)
}

final class DetailMoviePresenter: DetailMoviePresenting {
    var viewController: DetailMovieDisplaying?
    var movie: Movie
    var movieDetails: DetailedMovie? {
        didSet {
            setMovieBackdrop(movie.backdropPath)
            setMoviePoster(movie.posterPath)
            setMovieTitle(movie.name)
            setReleaseYear(movie.releaseDate)
            setNote(movie.averageNote)
            if let details = movieDetails {
                setDuration("\(details.duration) Minutes")
            }
            
            if let mainGenre = movieDetails?.genres.first {
                setMainGenre(mainGenre.name)
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
    
    func setNote(_ note: Double) {
        let formated = String(format: "%.1f", note)
        viewController?.setNote(formated)
    }
}
