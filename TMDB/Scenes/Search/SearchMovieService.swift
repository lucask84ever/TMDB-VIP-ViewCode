//
//  SearchMovieService.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

typealias MoviesResult = ((Result<MoviesResponse, Error>) -> Void)

protocol SearchMovieServicing {
    func fetchSearchMovie(_ textToSearch: String, completion: @escaping MoviesResult)
}

final class SearchMovieService: SearchMovieServicing {
    func fetchSearchMovie(_ textToSearch: String, completion: @escaping MoviesResult) {
        
    }
}
