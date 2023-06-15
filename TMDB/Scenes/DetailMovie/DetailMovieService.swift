//
//  DetailMovieService.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

typealias movieId = Int
typealias DetailMovieResponse = (Result<DetailedMovie, Error>) -> Void

protocol DetailMovieServicing {
    func fetchMoviesDetails(_ id: movieId, completion: @escaping DetailMovieResponse)
}

final class DetailMovieService: DetailMovieServicing {
    func fetchMoviesDetails(_ id: movieId, completion: @escaping DetailMovieResponse) {
        let session = URLSession.shared
        session.request(url: Endpoint.movieDetail(id).url, expecting: DetailedMovie.self) { result in
            completion(result)
        }
    }
}
