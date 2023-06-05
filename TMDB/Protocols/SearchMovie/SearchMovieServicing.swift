//
//  SearchMovieServicing.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

protocol SearchMovieServicing {
    func fetchSearchMovie(_ textToSearch: String, completion: @escaping MoviesResult)
}
