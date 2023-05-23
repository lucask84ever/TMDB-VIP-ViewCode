//
//  UpcomingMoviesService.swift
//  TMDB
//
//  Created by Lucas Lima on 22/05/23.
//

import Foundation

class UpcomingMoviesService: UpcomingMoviesServicing {
    func fetchUpcomingMovies(_ page: Int, completion: @escaping ((Result<Movies, Error>) -> Void)) {
        let session = URLSession.shared
        session.request(url: Endpoint.upcomingMovies.url, expecting: Movies.self) { result in
            completion(result)
        }
    }
}
