//
//  UpcomingMoviesService.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

class UpcomingMoviesService: UpcomingMoviesServicing {
    func fetchUpcomingMovies(_ page: Int, completion: @escaping ((Result<MoviesResponse, Error>) -> Void)) {
        let session = URLSession.shared
        session.request(url: Endpoint.upcomingMovies.url, expecting: MoviesResponse.self) { result in
            completion(result)
        }
    }
}
