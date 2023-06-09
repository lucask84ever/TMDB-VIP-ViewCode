//
//  SearchMovieInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 31/05/23.
//

import Foundation

protocol SearchMovieInteracting {
    var presenter: SearchMoviePresenting { get set }
    var service: SearchMovieServicing { get set }
}

class SearchMovieInteractor: SearchMovieInteracting {
    
    var presenter: SearchMoviePresenting
    var service: SearchMovieServicing
    
    init(presenter: SearchMoviePresenting, service: SearchMovieServicing) {
        self.presenter = presenter
        self.service = service
    }
}
