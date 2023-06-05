//
//  DetailMovieInteracting.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

protocol DetailMovieInteracting {
    var service: DetailMovieServicing { get set }
    var presenter: DetailMoviePresenting { get set }
    func fetchMovieTrailer()
    func fetchMovieDetails()
    func getImageBackdrop() -> String
    func getOverview() -> String
    func getTitle() -> String
    func getImagePoster() -> String
    func getReleaseYear() -> String
}
