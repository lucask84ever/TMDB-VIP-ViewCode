//
//  DetailMovieService.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

class DetailMovieService: DetailMovieServicing {
    func fetchMovieTrailer(_ movieId: Int, completion: @escaping TrailerResult) {
        let session = URLSession.shared
        session.request(url: Endpoint.trailers(movieId).url, expecting: VideosResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchMovieDetails(_ movieId: Int, completion: @escaping MovieDetailsResult) {
        let session = URLSession.shared
        session.request(url: Endpoint.movieDetail(movieId).url, expecting: DetailedMovie.self) { result in
            completion(result)
        }
    }
}
