//
//  SearchMovieInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

class SearchMovieInteractor: SearchMovieInteracting {
    
    let presenter: SearchMoviePresenting
    let service: SearchMovieServicing
    
    init(presenter: SearchMoviePresenting, service: SearchMovieServicing) {
        self.presenter = presenter
        self.service = service
    }
}
