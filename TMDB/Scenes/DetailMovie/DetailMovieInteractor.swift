//
//  DetailMovieInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 23/05/23.
//

import Foundation

class DetailMovieInteractor: DetailMovieInteracting {
    var service: DetailMovieServicing
    var presenter: DetailMoviePresenting
    
    init(service: DetailMovieServicing,
         presenter: DetailMoviePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func fetchMovieTrailer() {
        service.fetchMovieTrailer(presenter.getMovieId()) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.fetchTrailer(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMovieDetails() {
        service.fetchMovieDetails(presenter.getMovieId()) { [weak self] result in
            switch result {
            case .success(let detailedMovie):
                print(detailedMovie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImageBackdrop() -> String {
        return presenter.getImageBackdrop()
    }
    
    func getOverview() -> String {
        return presenter.getOverview()
    }
    
    func getTitle() -> String {
        return presenter.getMovieTitle()
    }
    
    func getImagePoster() -> String {
        return presenter.getImagePoster()
    }
    
    func getReleaseYear() -> String {
        return presenter.getReleaseYear()
    }
}
