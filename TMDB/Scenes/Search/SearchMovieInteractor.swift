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
    
    func fetchSearchMovie(_ searchText: String)
}

class SearchMovieInteractor: SearchMovieInteracting {
    
    var presenter: SearchMoviePresenting
    var service: SearchMovieServicing
    
    init(presenter: SearchMoviePresenting, service: SearchMovieServicing) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchSearchMovie(_ searchText: String) {
        service.fetchSearchMovie(searchText) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.setMovies(response.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
