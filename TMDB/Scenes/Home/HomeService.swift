//
//  HomeService.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomeServicing {
    func fetchMovies(_ endpoint: Endpoint, _ page: Int, completion: @escaping MoviesResult)
}

final class HomeService: HomeServicing {
    
    func fetchMovies(_ endpoint: Endpoint, _ page: Int = 1, completion: @escaping MoviesResult) {
        let session = URLSession.shared
        session.request(url: endpoint.url, expecting: MoviesResponse.self) { result in
            completion(result)
        }
    }
}
