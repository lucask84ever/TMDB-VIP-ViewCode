//
//  DetailMoviePresenting.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

protocol DetailMoviePresenting {
    var viewController: DetailMovieDisplaying? { get set }
    var movie: Movie { get set }
    
    func getMovieTitle() -> String
    func getMovieId() -> Int
    func fetchTrailer(_ trailer: VideosResponse)
    func getImageBackdrop() -> String
    func getOverview() -> String
    func getImagePoster() -> String
    func getReleaseYear() -> String
}
