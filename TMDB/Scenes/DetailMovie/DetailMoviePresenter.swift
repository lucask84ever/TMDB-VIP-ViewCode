//
//  DetailMoviePresenter.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

final class DetailMoviePresenter: DetailMoviePresenting {
    
    var viewController: DetailMovieDisplaying?
    internal var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieTitle() -> String {
        return movie.name
    }
    
    func getMovieId() -> Int {
        return movie.id
    }
    
    func getMovieBackdrop() -> String {
        return movie.backdropPath
    }
    
    func fetchTrailer(_ trailer: VideosResponse) {
        viewController?.fetchMovieTrailer(trailer)
    }
    
    func getImageBackdrop() -> String {
        return movie.backdropPath
    }
    
    func getOverview() -> String {
        return movie.overview
    }
    
    func getImagePoster() -> String {
        return movie.posterPath
    }
    
    func getReleaseYear() -> String {
        let toDate = Date(string: movie.releaseDate, format: .yyyyMMddHyphen)
        let formatted = toDate?.asString(format: .ddMMyyyyBars)
        return formatted ?? ""
    }
}
