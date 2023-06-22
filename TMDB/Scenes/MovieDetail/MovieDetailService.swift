//
//  DetailMovieService.swift
//  TMDB
//
//  Created by Lucas on 14/06/23.
//

import Foundation

typealias movieId = Int
typealias DetailMovieResponse = (Result<DetailedMovie, Error>) -> Void
typealias TrailerMovieResponse = (Result<VideosResponse, Error>) -> Void
typealias MovieReviewResponse = (Result<Reviews, Error>) -> Void

protocol DetailMovieServicing {
    func fetchMovieDetails(_ id: movieId, completion: @escaping DetailMovieResponse)
    func fetchMovieTrailer(_ id: movieId, completion: @escaping TrailerMovieResponse)
    func fetchReviews(_ id: movieId, completion: @escaping MovieReviewResponse)
}

final class MovieDetailService: DetailMovieServicing {
    func fetchMovieDetails(_ id: movieId, completion: @escaping DetailMovieResponse) {
        let session = URLSession.shared
        session.request(url: Endpoint.movieDetail(id).url, expecting: DetailedMovie.self) { result in
            completion(result)
        }
    }
    
    func fetchMovieTrailer(_ id: movieId, completion: @escaping TrailerMovieResponse) {
        let session = URLSession.shared
        session.request(url: Endpoint.trailers(id).url, expecting: VideosResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchReviews(_ id: movieId, completion: @escaping MovieReviewResponse) {
        let session = URLSession.shared
        session.request(url: Endpoint.revies(id).url, expecting: Reviews.self) { result in
            completion(result)
        }
    }
}
